#!/usr/bin/env python3
"""
featurebase_snapshot.py — Take a full point-in-time snapshot of all Featurebase
boards (Missing Feature, Feedback, Product) for later comparison.

Run this locally (same folder as featurebase_sync.py, same API key):
    python3 featurebase_snapshot.py

Writes: featurebase_snapshot_<date>.json (in this folder)

Re-run at end of quarter and diff the two JSON files (e.g. by post id) to see:
  - which posts existed on the snapshot date and what status/votes they had then
  - which posts are new since the snapshot
  - how status/votes changed for posts that already existed
"""

import json
import os
import datetime
import urllib.request
import urllib.error

FEATUREBASE_API_KEY = os.environ.get("FEATUREBASE_API_KEY", "")
API_BASE = "https://do.featurebase.app/v2"

# Boards are discovered from the API rather than hardcoded: a board added later
# (Setup Board: Germany, created 2026-08-17) would otherwise be invisible to
# every snapshot and every report built on one. Names come from the API and are
# stripped — one board is literally named " Feedback".
FALLBACK_BOARDS = {
    "Feature Request": "6a2123630535f655cfaec3cb",
    "Feedback": "6a213f3998f1621c64f747fb",
    "Product Board": "6a422f49728db77bced50b63",
}


def fetch_boards():
    try:
        boards = api_request("GET", "/boards")
    except Exception as exc:                      # noqa: BLE001 - keep snapshotting
        print(f"  ! /boards failed ({exc}); falling back to the known board list")
        return dict(FALLBACK_BOARDS)
    found = {(b.get("name") or "").strip(): b.get("id") for b in boards if b.get("id")}
    return found or dict(FALLBACK_BOARDS)


def api_request(method, path, body=None):
    url = f"{API_BASE}{path}"
    data = json.dumps(body).encode() if body else None
    req = urllib.request.Request(
        url,
        data=data,
        method=method,
        headers={
            "Authorization": f"Bearer {FEATUREBASE_API_KEY}",
            "Content-Type": "application/json",
            "Accept": "application/json",
        },
    )
    with urllib.request.urlopen(req) as resp:
        return json.loads(resp.read())


def fetch_all_board_posts(board_id):
    posts = []
    cursor = None
    page = 0
    while True:
        page += 1
        path = f"/posts?boardId={board_id}&limit=50"
        if cursor:
            path += f"&cursor={cursor}"
        result = api_request("GET", path)
        batch = result.get("data", []) if isinstance(result, dict) else result
        posts.extend(batch)
        cursor = result.get("nextCursor") if isinstance(result, dict) else None
        if not cursor or not batch:
            break
    return posts


def slim(post, board_name):
    # NOTE: the Featurebase v2 API returns the workflow status under "status"
    # (an object), not "postStatus". Snapshots taken before 2026-08-21 have
    # empty status/status_type for that reason.
    status = post.get("status") or post.get("postStatus") or {}
    if not isinstance(status, dict):
        status = {"name": status}
    tags = post.get("tags") or []
    return {
        "id": post.get("_id") or post.get("id"),
        "board": board_name,
        "title": post.get("title", ""),
        "content": post.get("content", ""),
        "status": status.get("name", ""),
        "status_type": status.get("type", ""),
        "votes": post.get("upvotes", post.get("votesCount", 0)),
        "commentCount": post.get("commentCount", 0),
        "category": (post.get("category") or {}).get("name", "") if isinstance(post.get("category"), dict) else post.get("category", ""),
        "tags": [t.get("name", "") for t in tags if isinstance(t, dict)],
        "eta": post.get("eta"),
        "assigneeId": post.get("assigneeId"),
        "createdAt": post.get("createdAt", ""),
        "updatedAt": post.get("updatedAt", ""),
        "lastActivityAt": post.get("lastActivityAt") or post.get("lastModified", ""),
        "customFields": post.get("customFields", {}),
        "author": (post.get("author") or {}).get("name", ""),
        "postUrl": post.get("postUrl", ""),
        "slug": post.get("slug", ""),
    }


def main():
    today = datetime.date.today().isoformat()
    snapshot = {
        "snapshot_date": today,
        "boards": {},
    }
    boards = fetch_boards()
    print(f"Boards discovered: {', '.join(boards)}")
    total = 0
    for name, board_id in boards.items():
        print(f"Fetching board '{name}' ({board_id})...")
        raw_posts = fetch_all_board_posts(board_id)
        print(f"  {len(raw_posts)} posts fetched.")
        snapshot["boards"][name] = {
            "board_id": board_id,
            "post_count": len(raw_posts),
            "posts": [slim(p, name) for p in raw_posts],
        }
        total += len(raw_posts)

    snapshot["total_posts"] = total

    out_path = f"featurebase_snapshot_{today}.json"
    with open(out_path, "w", encoding="utf-8") as f:
        json.dump(snapshot, f, ensure_ascii=False, indent=2)
    print(f"\nSaved {total} posts across {len(boards)} boards to {out_path}")


if __name__ == "__main__":
    main()
