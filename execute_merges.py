#!/usr/bin/env python3
"""
execute_merges.py — One-off script to execute the pending merge/split queue.

Handles:
  1. The 9 standard 1:1 merges flagged by apply_qa_review.py (source -> target):
     460->109, 473->107, 482->79, 488->514, 490->212, 493->487,
     494->476, 495->376, 508->78
  2. The special split of insight 478 ("project workspaces / collaboration,
     including editing two interdependent contracts together") into TWO
     targets, with mentions/quote rolled into BOTH:
       - 478 -> 205 (project spaces theme)
       - 478 -> 164 (collaboration theme)

For every merge: source.mentions is added to target.mentions, source's quote
is appended to target's quotes, a mentionHistory entry is added to the
target, and the source is marked qa_deleted=true with a note recording
where it went. Sources are excluded from featurebase push and from the next
review-tool refresh (already handled by qa_deleted logic).

Run once:
    python3 execute_merges.py
"""

import json
import shutil
import datetime
from pathlib import Path

HERE = Path(__file__).parent
INSIGHTS_JSON = HERE / "insights.json"

# (source_id, [target_id, ...])  -- list allows the 478 split into two targets
MERGES = [
    (121, [208]),  # Matrix upload cluster, consolidated in Featurebase under insight 208
    (128, [208]),
    (132, [208]),
]

# Sources whose OWN featurebase_id is now stale (their individual post was merged
# away into the target's post in Featurebase) — clear it locally so future
# --check-ids runs don't report a false "missing" for a post that's gone on purpose.
CLEAR_STALE_FEATUREBASE_ID = {121, 128, 132}


def append_quote(target, quote):
    if not quote:
        return
    existing = target.get("quotes", "") or ""
    if existing:
        target["quotes"] = existing + " | " + quote
    else:
        target["quotes"] = quote


def main():
    insights = json.loads(INSIGHTS_JSON.read_text(encoding="utf-8"))
    by_id = {ins["id"]: ins for ins in insights}
    today = datetime.date.today().isoformat()

    report = []
    for src_id, target_ids in MERGES:
        src = by_id.get(src_id)
        if not src:
            print(f"⚠ source ID {src_id} not found — skipped")
            continue
        src_mentions = src.get("mentions", 0)
        src_quote = src.get("quotes", "")

        for tgt_id in target_ids:
            tgt = by_id.get(tgt_id)
            if not tgt:
                print(f"⚠ target ID {tgt_id} not found — skipped (source {src_id})")
                continue
            before = tgt.get("mentions", 0)
            tgt["mentions"] = before + src_mentions
            tgt["mention_count"] = tgt["mentions"]
            append_quote(tgt, src_quote)
            tgt.setdefault("mentionHistory", []).append({
                "date": today,
                "count": src_mentions,
                "source": f"merged from ID {src_id}",
                "status": tgt.get("status", ""),
            })
            tgt["lastModified"] = today
            report.append((src_id, tgt_id, src_mentions, before, tgt["mentions"]))

        note = f"MERGED into ID {'+'.join(str(t) for t in target_ids)}"
        src["qa_deleted"] = True
        src["qa_delete_note"] = note
        src["qa_reviewed"] = True
        src["qa_reviewed_at"] = src.get("qa_reviewed_at") or today
        if src_id in CLEAR_STALE_FEATUREBASE_ID:
            src["featurebase_id_stale"] = src.get("featurebase_id")  # keep for reference
            src["featurebase_id"] = None
            src["featurebase_votes"] = None

    backup_path = INSIGHTS_JSON.with_name(f"insights.backup_{today}_pre-merges.json")
    n = 2
    while backup_path.exists():
        backup_path = INSIGHTS_JSON.with_name(f"insights.backup_{today}_pre-merges_{n}.json")
        n += 1
    shutil.copy(INSIGHTS_JSON, backup_path)
    print(f"Backup saved: {backup_path.name}")

    INSIGHTS_JSON.write_text(
        json.dumps(list(by_id.values()), ensure_ascii=False, indent=2), encoding="utf-8"
    )

    print(f"\n{len(MERGES)} merge operation(s) processed.\n")
    for src_id, tgt_id, src_mentions, before, after in report:
        print(f"  ID {src_id} (+{src_mentions} mentions) → ID {tgt_id}: {before} → {after} mentions")


if __name__ == "__main__":
    main()
