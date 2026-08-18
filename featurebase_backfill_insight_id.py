#!/usr/bin/env python3
"""
featurebase_backfill_insight_id.py — Write the "Insight ID" custom field onto
Featurebase posts that are linked from insights.json but carry no ID on the
board.

Why: posts can be matched to insights two ways — the Insight ID custom field on
the post, or the featurebase_id back-link in insights.json. The custom field is
the more durable of the two (the back-links have been lost wholesale before),
but roadmap posts created directly in Featurebase never got one, so they match
only via the back-link. This fills the gap so the custom field alone is enough.

The source of truth is insights.json: for every insight holding a
featurebase_id, the referenced post gets that insight's id written into its
Insight ID field. Posts that already carry a value are never touched, so this
is safe to re-run and can never overwrite a human's correction.

Usage:
    python3 featurebase_backfill_insight_id.py --dry-run   Preview (default)
    python3 featurebase_backfill_insight_id.py --apply     Write to Featurebase
"""

import argparse
import sys
import time

import featurebase_sync as fs

INSIGHT_ID_FIELD = fs.CUSTOM_FIELD_IDS["insight_id"]

BOARDS = [
    ("Feature Request", fs.MISSING_FEATURE_BOARD),
    ("Feedback",        fs.FEEDBACK_BOARD),
    ("Product",         fs.PRODUCT_BOARD),
]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true",
                    help="Preview only (default when --apply is absent)")
    ap.add_argument("--apply", action="store_true",
                    help="Write the custom field values to Featurebase")
    args = ap.parse_args()

    if not fs.FEATUREBASE_API_KEY:
        sys.exit("✗ FEATUREBASE_API_KEY is not set.")

    insights = fs.load_insights()

    # Back-links, checked for ambiguity: two insights naming the same post
    # would make the correct value undecidable, so those are left alone.
    linked = {}
    for i in insights:
        fid = i.get("featurebase_id")
        if fid:
            linked.setdefault(fid, []).append(i["id"])
    ambiguous = {k: v for k, v in linked.items() if len(v) > 1}
    for fid, ids in ambiguous.items():
        print(f"  ! post {fid} is claimed by insights {ids} — skipping")

    todo, already = [], []
    for label, board_id in BOARDS:
        for post in fs.fetch_all_board_posts(board_id):
            ids = linked.get(post["id"])
            if not ids or len(ids) > 1:
                continue
            existing = (post.get("customFields") or {}).get(INSIGHT_ID_FIELD)
            if existing:
                already.append((label, post, existing, ids[0]))
            else:
                todo.append((label, post, str(ids[0])))

    conflicts = [a for a in already if str(a[2]).strip() != str(a[3])]
    if conflicts:
        print("\n! Insight ID on the post disagrees with the back-link "
              "(left untouched):")
        for label, post, existing, expected in conflicts:
            print(f"    [{label}] post says {existing}, insights.json says "
                  f"{expected} — {post['title'][:50]}")

    print(f"\n{len(already)} post(s) already carry an Insight ID"
          f" · {len(todo)} to backfill\n")
    for label, post, value in todo:
        status = (post.get("status") or {}).get("name", "?")
        print(f"  [{label:15}] → #{value:<4} {status:12} {post['title'][:52]}")

    if not todo:
        print("Nothing to do.")
        return

    if not args.apply:
        print(f"\nDry run — nothing written. Re-run with --apply to set "
              f"{len(todo)} field(s).")
        return

    print(f"\nWriting Insight ID to {len(todo)} post(s)...")
    ok = failed = 0
    for label, post, value in todo:
        try:
            fs.api_request("PATCH", f"/posts/{post['id']}",
                           {"customFields": {INSIGHT_ID_FIELD: value}})
            ok += 1
            time.sleep(0.2)
        except Exception as e:                          # noqa: BLE001
            print(f"  ✗ {post['id']} — {e}")
            failed += 1
    print(f"\n✓ Set {ok} field(s)" + (f", {failed} failed" if failed else ""))


if __name__ == "__main__":
    main()
