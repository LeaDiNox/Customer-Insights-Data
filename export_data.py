"""
export_data.py — Run this after every CSV merge session.

Usage:
    python export_data.py

What it does:
1. Finds the latest Customer_Insights_Data_*.csv in data/
2. Normalises all date fields to ISO 8601
3. Builds clean insights.json
4. Takes a timestamped snapshot → data/snapshots/
5. Updates changelog.json with any detected mention-count or status changes
"""

import os
import glob
import json
import csv
import re
from datetime import datetime, timezone
from pathlib import Path

DATA_DIR = Path("data")
SNAPSHOTS_DIR = DATA_DIR / "snapshots"
INSIGHTS_JSON = DATA_DIR / "insights.json"
CHANGELOG_JSON = DATA_DIR / "changelog.json"

SNAPSHOTS_DIR.mkdir(parents=True, exist_ok=True)


# ── Date normalisation ────────────────────────────────────────────────────────

def parse_date(raw):
    """Try multiple date formats, return ISO 8601 string or None."""
    if not raw or str(raw).strip() in ("", "nan", "NaT"):
        return None
    raw = str(raw).strip()
    formats = [
        "%m/%d/%Y %I:%M %p",
        "%m/%d/%Y %H:%M",
        "%m/%d/%Y",
        "%Y-%m-%dT%H:%M:%S",
        "%Y-%m-%d %H:%M:%S",
        "%Y-%m-%d",
        "%d.%m.%Y",
    ]
    for fmt in formats:
        try:
            return datetime.strptime(raw, fmt).strftime("%Y-%m-%d")
        except ValueError:
            continue
    # Try stripping time component and retrying
    raw_date_only = raw.split(" ")[0]
    for fmt in formats:
        try:
            return datetime.strptime(raw_date_only, fmt).strftime("%Y-%m-%d")
        except ValueError:
            continue
    return None


# ── Field parsers ─────────────────────────────────────────────────────────────

def parse_list_field(val):
    """Parse ["Squad A","Squad B"] style fields into a Python list."""
    if not val or str(val).strip() in ("", "nan", "[]", "NaN"):
        return []
    val = str(val).strip()
    try:
        result = json.loads(val)
        if isinstance(result, list):
            return [str(x).strip() for x in result]
    except Exception:
        pass
    # Fallback: strip brackets and split
    val = re.sub(r'[\[\]"\'`]', '', val)
    return [x.strip() for x in val.split(",") if x.strip()]


def parse_source_types(val):
    """Deduplicate semicolon-separated source type strings."""
    if not val or str(val).strip() in ("", "nan"):
        return []
    parts = [p.strip() for p in str(val).split(";") if p.strip()]
    return sorted(set(parts))


def infer_sentiment(row):
    """Infer sentiment from notes field or insight type."""
    notes = str(row.get("Additional Notes", "")).strip()
    if "Sentiment: Negative" in notes:
        return "Negative"
    if "Sentiment: Positive" in notes:
        return "Positive"
    if "Sentiment: Mixed" in notes:
        return "Mixed"
    itype = str(row.get("Insight Type", "")).strip()
    insight = str(row.get("Insight", "")).lower()
    if itype in ("Missing Feature", "Bug", "Improvement"):
        return "Negative"
    if itype == "Idea":
        return "Mixed"
    pos_words = ["appreciate", "intuitive", "good", "well", "positive",
                 "great", "excellent", "reliable", "simple", "no hallucination"]
    neg_words = ["needs", "missing", "lack", "not ", "slow", "error",
                 "broken", "incorrect", "wrong", "cannot", "can't"]
    pos = any(w in insight for w in pos_words)
    neg = any(w in insight for w in neg_words)
    if pos and not neg:
        return "Positive"
    if pos and neg:
        return "Mixed"
    return "Negative"


def infer_publisher(source_str):
    """Extract publisher label from source field."""
    s = str(source_str)
    if "Manz" in s:
        return "Manz"
    if "Swiss" in s or "Schulthess" in s:
        return "Swiss"
    if "PL" in s or "Poland" in s:
        return "Beck Poland"
    if "CZ" in s or "Czech" in s:
        return "Beck Czech"
    if "Beck" in s:
        return "Beck Germany"
    return ""


# ── Main export ───────────────────────────────────────────────────────────────

def find_latest_csv():
    pattern = str(DATA_DIR / "Customer_Insights_Data_*.csv")
    files = sorted(glob.glob(pattern))
    if not files:
        raise FileNotFoundError(f"No CSV found matching: {pattern}")
    latest = files[-1]
    print(f"  Using CSV: {latest}")
    return latest


def load_csv(path):
    rows = []
    with open(path, newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        for row in reader:
            rows.append(dict(row))
    return rows


def build_insight(row):
    squads = parse_list_field(row.get("Affected Squad(s)", ""))
    features = parse_list_field(row.get("Affected Feature(s)", ""))
    source = str(row.get("Insight Source", "")).strip()
    mentions_raw = row.get("Total %23 of mentions", "0")
    try:
        mentions = int(float(str(mentions_raw).strip()))
    except (ValueError, TypeError):
        mentions = 0

    return {
        "id": int(float(str(row.get("ID", 0)).strip() or 0)),
        "insight": str(row.get("Insight", "")).strip(),
        "type": str(row.get("Insight Type", "")).strip(),
        "sourceTypes": parse_source_types(row.get("Source Type (automatic)", "")),
        "source": source,
        "userGroup": str(row.get("Affected User Group (automatic)", "")).strip(),
        "squads": squads,
        "features": features,
        "country": str(row.get("Affected Country", "")).strip(),
        "status": str(row.get("Status", "")).strip(),
        "mentions": mentions,
        "quotes": str(row.get("Direct Quotes", "")).strip(),
        "notes": str(row.get("Additional Notes", "")).strip(),
        "created": parse_date(row.get("Created", "")),
        "lastModified": parse_date(row.get("Last Modified Update", "")),
        "sentiment": infer_sentiment(row),
        "publisher": infer_publisher(source),
        "jira": str(row.get("Related JIRA (backlog) ticket", "")).strip(),
        "isNew": "New" in str(row.get("Status", "")),
        "unclassified": len(squads) == 0 or len(features) == 0,
    }


def take_snapshot(insights):
    """Save a lightweight snapshot: id → {mentions, status, date}."""
    ts = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    snap = {
        str(i["id"]): {
            "mentions": i["mentions"],
            "status": i["status"],
            "date": ts,
        }
        for i in insights
    }
    snap_path = SNAPSHOTS_DIR / f"snapshot_{ts}.json"
    with open(snap_path, "w", encoding="utf-8") as f:
        json.dump(snap, f)
    print(f"  Snapshot saved: {snap_path.name}")
    return snap, ts


def find_snapshot_before(days=14):
    """Return the most recent snapshot older than `days` days."""
    files = sorted(glob.glob(str(SNAPSHOTS_DIR / "snapshot_*.json")))
    if not files:
        return None, None
    cutoff = datetime.now(timezone.utc).timestamp() - days * 86400
    candidates = [
        f for f in files
        if os.path.getmtime(f) < cutoff
    ]
    if not candidates:
        # No snapshot older than 14 days — use oldest available as fallback
        candidates = files
    latest_old = candidates[-1]
    with open(latest_old, encoding="utf-8") as f:
        data = json.load(f)
    return data, latest_old


def update_changelog(insights, current_snap, snap_ts):
    """Detect changes vs. previous snapshot and append to changelog."""
    changelog = []
    if CHANGELOG_JSON.exists():
        with open(CHANGELOG_JSON, encoding="utf-8") as f:
            try:
                changelog = json.load(f)
            except json.JSONDecodeError:
                changelog = []

    # Load the snapshot just before the current one
    all_snaps = sorted(glob.glob(str(SNAPSHOTS_DIR / "snapshot_*.json")))
    if len(all_snaps) < 2:
        # Nothing to diff against yet
        with open(CHANGELOG_JSON, "w", encoding="utf-8") as f:
            json.dump(changelog, f, indent=2)
        return

    prev_snap_path = all_snaps[-2]  # second-to-last = previous
    with open(prev_snap_path, encoding="utf-8") as f:
        prev_snap = json.load(f)

    for insight in insights:
        sid = str(insight["id"])
        prev = prev_snap.get(sid)
        if not prev:
            # New insight added
            changelog.append({
                "id": insight["id"],
                "type": "added",
                "date": snap_ts,
                "insight": insight["insight"][:80],
            })
            continue

        if insight["mentions"] != prev["mentions"]:
            changelog.append({
                "id": insight["id"],
                "type": "mentions_changed",
                "date": snap_ts,
                "from": prev["mentions"],
                "to": insight["mentions"],
                "insight": insight["insight"][:80],
            })

        if insight["status"] != prev["status"]:
            changelog.append({
                "id": insight["id"],
                "type": "status_changed",
                "date": snap_ts,
                "from": prev["status"],
                "to": insight["status"],
                "insight": insight["insight"][:80],
            })

    with open(CHANGELOG_JSON, "w", encoding="utf-8") as f:
        json.dump(changelog, f, indent=2, ensure_ascii=False)
    print(f"  Changelog updated: {len(changelog)} total entries")


def export():
    print("\n── Noxtua Insights · Data Export ───────────────────────────────")
    csv_path = find_latest_csv()
    rows = load_csv(csv_path)
    insights = [build_insight(r) for r in rows]
    print(f"  Processed {len(insights)} insights")

    # Write insights.json
    with open(INSIGHTS_JSON, "w", encoding="utf-8") as f:
        json.dump(insights, f, ensure_ascii=False, indent=2)
    print(f"  Written: {INSIGHTS_JSON}")

    # Snapshot + changelog
    current_snap, snap_ts = take_snapshot(insights)
    update_changelog(insights, current_snap, snap_ts)

    print("── Export complete ──────────────────────────────────────────────\n")
    return insights


if __name__ == "__main__":
    export()
