#!/usr/bin/env python3
"""
apply_qa_review.py — Merge an insights_review.html CSV export back into insights.json.

Workflow:
    1. Open insights_review.html in a browser (refresh it first with
       refresh_review_tool.py if insights.json has changed since).
    2. Review insights: fix the text if unclear, correct status/type,
       mark reviewed, mark merge/delete where needed.
    3. Click "Export CSV" -> downloads insights_review.csv.
    4. Move/save that CSV into this folder (overwriting the old one is fine).
    5. Run:  python3 apply_qa_review.py

What it does:
  - For every row where reviewed == true:
      * updates `insight`, `status`, `type`, `core_insight`, `insight_type`
        on the matching insights.json record (keeps legacy mirror fields
        in sync)
      * sets qa_reviewed = true, qa_reviewed_at = today (only if it was
        not already true, so re-running doesn't touch the timestamp)
  - For rows whose notes_for_reviewer starts with "DELETE":
      * sets qa_deleted = true and qa_delete_note = <note>
      * these are excluded from qualifying_insights() in featurebase_sync.py
        and from the next refresh_review_tool.py pass
      * mention/vote totals are NOT auto-merged into a target ID even if the
        note says "merged into ID X" — that's flagged in the report for you
        to apply by hand if you want the mentions rolled up
  - Rows where reviewed == false are left untouched.

Always backs up insights.json first (insights.backup_<date>.json).
"""

import csv
import json
import re
import shutil
import datetime
import sys
from pathlib import Path

HERE = Path(__file__).parent
INSIGHTS_JSON = HERE / "insights.json"
REVIEW_CSV = HERE / "insights_review.csv"


def main():
    if not REVIEW_CSV.exists():
        print(f"Error: {REVIEW_CSV.name} not found in {HERE}")
        sys.exit(1)

    insights = json.loads(INSIGHTS_JSON.read_text(encoding="utf-8"))
    by_id = {ins["id"]: ins for ins in insights}
    today = datetime.date.today().isoformat()

    updated, newly_reviewed, marked_deleted, merge_candidates, skipped_unreviewed = 0, 0, 0, [], 0

    with open(REVIEW_CSV, encoding="utf-8") as f:
        reader = csv.DictReader(f)
        for row in reader:
            try:
                rid = int(row["id"])
            except (KeyError, ValueError):
                continue
            ins = by_id.get(rid)
            if not ins:
                print(f"  ⚠ ID {rid} in CSV not found in insights.json — skipped")
                continue

            reviewed = row.get("reviewed", "").strip().lower() == "true"
            if not reviewed:
                skipped_unreviewed += 1
                continue

            changed = False
            if row.get("insight") and row["insight"] != ins.get("insight"):
                ins["insight"] = row["insight"]
                ins["core_insight"] = row["insight"]
                changed = True
            if row.get("status") and row["status"] != ins.get("status"):
                old_status = ins.get("status")
                ins["status"] = row["status"]
                ins.setdefault("statusHistory", []).append({"date": today, "status": row["status"]})
                changed = True
            if row.get("type") and row["type"] != ins.get("type"):
                ins["type"] = row["type"]
                ins["insight_type"] = row["type"]
                changed = True

            note = (row.get("notes_for_reviewer") or "").strip()
            if note.upper().startswith("DELETE"):
                ins["qa_deleted"] = True
                ins["qa_delete_note"] = note
                marked_deleted += 1
                m = re.search(r"(?:merged?|MERGE)\D*ID\s*(\d+)|MERGE\s*(\d+)", note, re.I)
                if m:
                    target = m.group(1) or m.group(2)
                    if target and int(target) != rid:
                        merge_candidates.append((rid, int(target)))

            if not ins.get("qa_reviewed"):
                ins["qa_reviewed"] = True
                ins["qa_reviewed_at"] = today
                newly_reviewed += 1
            if changed:
                ins["lastModified"] = today
                updated += 1

    backup_path = INSIGHTS_JSON.with_name(f"insights.backup_{today}_pre-qa-apply.json")
    if not backup_path.exists():
        shutil.copy(INSIGHTS_JSON, backup_path)
        print(f"Backup saved: {backup_path.name}")

    INSIGHTS_JSON.write_text(
        json.dumps(list(by_id.values()), ensure_ascii=False, indent=2), encoding="utf-8"
    )

    print(f"\ninsights.json updated.")
    print(f"  Newly marked qa_reviewed: {newly_reviewed}")
    print(f"  Field edits applied (text/status/type): {updated}")
    print(f"  Marked qa_deleted (excluded from push): {marked_deleted}")
    print(f"  Rows skipped (reviewed=false in CSV): {skipped_unreviewed}")
    if merge_candidates:
        print(f"\n  {len(merge_candidates)} merge note(s) detected — mentions were NOT auto-summed. "
              f"Review and merge manually if desired:")
        for src, tgt in merge_candidates:
            print(f"    ID {src} → merge into ID {tgt}")


if __name__ == "__main__":
    main()
