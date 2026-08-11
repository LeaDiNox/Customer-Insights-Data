#!/usr/bin/env python3
"""
backfill_qa_state.py — ONE-TIME reconciliation script.

Recovers the QA review state from the existing insights_review.html (which
has RAW_DATA embedded from a previous review pass: 323 insights already
reviewed, edits already merged into insights.json) and writes a persistent
`qa_reviewed` / `qa_reviewed_at` field onto insights.json so the Featurebase
push can gate on it.

Run once:
    python3 backfill_qa_state.py

What it does:
  1. Extracts RAW_DATA from insights_review.html (old review session).
  2. For every insight in insights.json whose id also appears in RAW_DATA
     with reviewed == true (and no deleteNote), sets qa_reviewed = true.
  3. Everything else (new insights added since, insights that were never
     reviewed, and the 2 ambiguous delete-note-but-still-present rows) is
     left qa_reviewed = false so they show up in the next review pass.
  4. Backs up insights.json before writing (same convention as
     featurebase_sync.py: insights.backup_<date>.json).

This script is not meant to be run again — after this, use
apply_qa_review.py to merge future review-tool exports.
"""

import json
import re
import shutil
import datetime
from pathlib import Path

HERE = Path(__file__).parent
INSIGHTS_JSON = HERE / "insights.json"
REVIEW_HTML = HERE / "insights_review.html"


def extract_raw_data(html_text: str):
    marker = "const RAW_DATA = "
    start = html_text.index(marker) + len(marker)
    end = html_text.index(";\n\nconst STATUSES", start)
    return json.loads(html_text[start:end])


def main():
    insights = json.loads(INSIGHTS_JSON.read_text(encoding="utf-8"))
    old = extract_raw_data(REVIEW_HTML.read_text(encoding="utf-8"))

    old_by_id = {d["id"]: d for d in old}
    today = datetime.date.today().isoformat()

    newly_marked = 0
    ambiguous = []
    for ins in insights:
        old_rec = old_by_id.get(ins["id"])
        if old_rec and old_rec.get("reviewed") and not old_rec.get("deleteNote"):
            if not ins.get("qa_reviewed"):
                ins["qa_reviewed"] = True
                ins["qa_reviewed_at"] = ins.get("qa_reviewed_at") or today
                newly_marked += 1
        else:
            ins.setdefault("qa_reviewed", False)
            ins.setdefault("qa_reviewed_at", None)
        if old_rec and old_rec.get("deleteNote"):
            ambiguous.append((ins["id"], old_rec.get("deleteNote")))

    backup_path = INSIGHTS_JSON.with_name(f"insights.backup_{today}_pre-qa-backfill.json")
    if not backup_path.exists():
        shutil.copy(INSIGHTS_JSON, backup_path)
        print(f"Backup saved: {backup_path.name}")

    INSIGHTS_JSON.write_text(
        json.dumps(insights, ensure_ascii=False, indent=2), encoding="utf-8"
    )

    total = len(insights)
    reviewed_total = sum(1 for i in insights if i.get("qa_reviewed"))
    print(f"insights.json updated: {total} records")
    print(f"  qa_reviewed = true : {reviewed_total} ({newly_marked} newly marked this run)")
    print(f"  qa_reviewed = false: {total - reviewed_total}  (need review)")
    if ambiguous:
        print(f"\n⚠ {len(ambiguous)} insight(s) had a stray deleteNote in the old review tool "
              f"but are still present in insights.json — left as qa_reviewed=false, "
              f"flagged for manual look:")
        for iid, note in ambiguous:
            print(f"    ID {iid}: {note}")


if __name__ == "__main__":
    main()
