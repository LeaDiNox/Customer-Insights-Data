#!/usr/bin/env python3
"""
restore_lost_insights.py — Restore the insights that disappeared from
insights.json between the 2026-08-07 and 2026-08-10 snapshots.

Background:
    insights.backup_2026-08-07.json holds 409 insights (max id 528).
    insights.backup_2026-08-10.json — which the live insights.json matches
    exactly — holds 383 (max id 502). IDs 503-528 vanished, along with the
    Featurebase posts pushed from them, which now carry Insight IDs that no
    longer resolve.

This script copies those records back out of the 08-07 snapshot and appends
them to insights.json, projected onto the CURRENT schema:
    - keeps the 29 core fields plus featurebase_title / featurebase_id /
      featurebase_synced_at / featurebase_votes (re-linking the orphaned posts)
    - drops fields the current schema no longer carries: qa_reviewed,
      qa_reviewed_at, featurebase_board_id, featurebase_id_stale

ID 508 is deliberately NOT restored: the QA pass marked it
"MERGED into ID 78", so bringing it back would re-introduce a duplicate.

Usage:
    python3 restore_lost_insights.py --dry-run   Preview (default)
    python3 restore_lost_insights.py --apply     Write insights.json
"""

import argparse
import datetime
import json
import shutil
import sys
from pathlib import Path

HERE = Path(__file__).parent
TARGET = HERE / "insights.json"
SOURCE = HERE / "insights.backup_2026-08-07.json"

# Restore everything the 08-07 snapshot had that the current file lacks,
# except 508 (already merged into 78 during the QA pass).
EXCLUDE = {508}

# Fields carried by the current schema. Anything else in the old record is
# dropped so the restored entries match their neighbours exactly.
KEEP_EXTRA = {
    "featurebase_title",
    "featurebase_id",
    "featurebase_synced_at",
    "featurebase_votes",
}


def detect_style(raw):
    """
    Match the formatting insights.json already uses, so a restore shows up as
    the records it added and nothing else. The repo is not consistent here —
    featurebase_sync.save_insights() writes indent=2 while the committed file
    is indent=1 — and re-indenting the whole file buries the diff.
    """
    second = raw.split("\n", 2)[1] if "\n" in raw else " {"
    return {
        "indent": len(second) - len(second.lstrip(" ")) or 1,
        "trailing": "\n" if raw.endswith("\n") else "",
    }


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true",
                    help="Preview only (default when --apply is absent)")
    ap.add_argument("--apply", action="store_true",
                    help="Write the restored records into insights.json")
    args = ap.parse_args()

    raw = TARGET.read_text(encoding="utf-8")
    current = json.loads(raw)
    style = detect_style(raw)
    source = {i["id"]: i for i in json.loads(SOURCE.read_text(encoding="utf-8"))}

    have = {i["id"] for i in current}
    # The current schema, as the union of fields actually in use today.
    schema = {k for i in current for k in i} | KEEP_EXTRA

    missing = sorted(set(source) - have - EXCLUDE)
    if not missing:
        print("Nothing to restore — insights.json already has every record.")
        return

    restored = []
    for iid in missing:
        rec = {k: v for k, v in source[iid].items() if k in schema}
        dropped = [k for k in source[iid] if k not in schema]
        restored.append(rec)
        link = rec.get("featurebase_id", "—")
        print(f"  #{iid:>3}  {rec['status'][:24]:24} fb:{link:>24}  "
              f"{rec['insight'][:56]}")
        if dropped:
            print(f"        dropped fields: {', '.join(dropped)}")

    skipped = sorted(set(source) - have - set(missing))
    if skipped:
        print("\nDeliberately not restored:")
        for iid in skipped:
            print(f"  #{iid}  {source[iid].get('qa_delete_note', 'excluded')}"
                  f"  — {source[iid]['insight'][:52]}")

    print(f"\n{len(current)} insights now → {len(current) + len(restored)} "
          f"after restoring {len(restored)}")

    if not args.apply:
        print("\nDry run — insights.json untouched. Re-run with --apply.")
        return

    stamp = datetime.date.today().isoformat()
    backup = HERE / f"insights.backup_{stamp}_pre-restore.json"
    shutil.copy2(TARGET, backup)
    print(f"\nBacked up to {backup.name}")

    merged = sorted(current + restored, key=lambda i: i["id"])
    TARGET.write_text(
        json.dumps(merged, indent=style["indent"], ensure_ascii=False)
        + style["trailing"],
        encoding="utf-8",
    )
    print(f"✓ Wrote {len(merged)} insights to {TARGET.name}")


if __name__ == "__main__":
    main()
