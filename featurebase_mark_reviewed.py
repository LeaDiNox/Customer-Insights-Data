#!/usr/bin/env python3
"""
featurebase_mark_reviewed.py — Flip Featurebase posts from "In Review" to
"Reviewed" when the matching insight in insights.json has already been
discussed with the product team.

"Already discussed" means the insight's status in insights.json is one of:
    - Planned for development
    - Identified - JIRA ticket exists

Posts are matched to insights in this order:
    1. insights.json "featurebase_id" -> post id
    2. the post's "Insight ID" custom field -> insights.json "id"

Usage:
    python3 featurebase_mark_reviewed.py --dry-run    Preview (default)
    python3 featurebase_mark_reviewed.py --apply      Write to Featurebase
    python3 featurebase_mark_reviewed.py --apply --boards missing,feedback

Requires FEATUREBASE_API_KEY in the environment (see featurebase_sync.py).
"""

import argparse
import csv
import json
import sys
from pathlib import Path

import featurebase_sync as fs

# Statuses in insights.json that mean "the product team has already talked
# about this" — these are what we surface as Reviewed on the board.
DISCUSSED_STATUSES = {
    "Planned for development",
    "Identified - JIRA ticket exists",
}

SOURCE_STATUS_NAME = "In Review"
TARGET_STATUS_NAME = "Reviewed"

INSIGHT_ID_FIELD = fs.CUSTOM_FIELD_IDS["insight_id"]

BOARDS = {
    "missing":  ("Feature Request", fs.MISSING_FEATURE_BOARD),
    "feedback": ("Feedback",        fs.FEEDBACK_BOARD),
    "product":  ("Product",         fs.PRODUCT_BOARD),
}

REPORT_CSV = Path(__file__).parent / "featurebase_reviewed_report.csv"


def status_id(name):
    """Resolve a post-status name to its Featurebase id."""
    for st in fs.api_request("GET", "/post_statuses"):
        if st.get("name") == name:
            return st["id"]
    sys.exit(f"✗ No post status named {name!r} exists in this Featurebase workspace.")


def collect_posts(board_keys):
    posts = []
    for key in board_keys:
        label, board_id = BOARDS[key]
        batch = fs.fetch_all_board_posts(board_id)
        for p in batch:
            p["_board"] = label
        print(f"  {label}: {len(batch)} posts")
        posts.extend(batch)
    return posts


def match_insight(post, by_fb_id, by_insight_id):
    """Return (insight, how_matched) or (None, None)."""
    hit = by_fb_id.get(post["id"])
    if hit:
        return hit, "featurebase_id"
    raw = (post.get("customFields") or {}).get(INSIGHT_ID_FIELD)
    if raw:
        try:
            return by_insight_id[int(str(raw).strip())], "insight_id_field"
        except (ValueError, KeyError):
            pass
    return None, None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true",
                    help="Preview only (default when --apply is absent)")
    ap.add_argument("--apply", action="store_true",
                    help="Write the status changes (default is a dry run)")
    ap.add_argument("--boards", default="missing,feedback,product",
                    help="Comma-separated subset of: missing, feedback, product")
    args = ap.parse_args()

    if not fs.FEATUREBASE_API_KEY:
        sys.exit("✗ FEATUREBASE_API_KEY is not set.")

    board_keys = [b.strip() for b in args.boards.split(",") if b.strip()]
    unknown = [b for b in board_keys if b not in BOARDS]
    if unknown:
        sys.exit(f"✗ Unknown board(s): {', '.join(unknown)}")

    insights = fs.load_insights()
    by_fb_id = {i["featurebase_id"]: i for i in insights if i.get("featurebase_id")}
    by_insight_id = {i["id"]: i for i in insights}

    print(f"Fetching posts from {len(board_keys)} board(s)...")
    posts = collect_posts(board_keys)

    target_id = status_id(TARGET_STATUS_NAME)

    selected, skipped_status, unmatched = [], [], []
    for p in posts:
        if (p.get("status") or {}).get("name") != SOURCE_STATUS_NAME:
            continue
        ins, how = match_insight(p, by_fb_id, by_insight_id)
        if ins is None:
            unmatched.append(p)
        elif ins["status"] in DISCUSSED_STATUSES:
            selected.append((p, ins, how))
        else:
            skipped_status.append((p, ins))

    print(f"\n{SOURCE_STATUS_NAME} posts: "
          f"{len(selected) + len(skipped_status) + len(unmatched)}")
    print(f"  → to mark {TARGET_STATUS_NAME}: {len(selected)}")
    print(f"  → left alone (insight not yet discussed): {len(skipped_status)}")
    print(f"  → left alone (no insight match): {len(unmatched)}\n")

    rows = []
    for p, ins, how in selected:
        rows.append({
            "post_id": p["id"],
            "board": p["_board"],
            "post_title": p["title"],
            "post_url": p.get("postUrl", ""),
            "insight_id": ins["id"],
            "insight_status": ins["status"],
            "matched_via": how,
            "action": "pending",
        })

    for r in rows:
        print(f"  [{r['board']:15}] #{r['insight_id']:>3}  "
              f"{r['insight_status'][:34]:34}  {r['post_title'][:60]}")

    if not args.apply:
        print(f"\nDry run — nothing written. Re-run with --apply to update "
              f"{len(rows)} post(s).")
    else:
        print(f"\nApplying {TARGET_STATUS_NAME} to {len(rows)} post(s)...")
        ok = failed = 0
        for r in rows:
            try:
                fs.api_request("PATCH", f"/posts/{r['post_id']}",
                               {"statusId": target_id})
                r["action"] = "updated"
                ok += 1
            except Exception as e:                      # noqa: BLE001
                r["action"] = f"failed: {e}"
                failed += 1
            if (ok + failed) % 25 == 0:
                print(f"  ...{ok + failed}/{len(rows)}")
        print(f"\n✓ Updated {ok} post(s)"
              + (f", {failed} failed" if failed else ""))

    if rows:
        with open(REPORT_CSV, "w", newline="", encoding="utf-8") as f:
            w = csv.DictWriter(f, fieldnames=list(rows[0].keys()))
            w.writeheader()
            w.writerows(rows)
        print(f"Report written to {REPORT_CSV.name}")


if __name__ == "__main__":
    main()
