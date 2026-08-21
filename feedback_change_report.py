#!/usr/bin/env python3
"""
feedback_change_report.py — what changed on the Featurebase boards in a window.

Featurebase is the system of record. Every reported item is a board post, and
its **board status is the pipeline status**. The insights database
(insights.json) is an intermediary: it collects raw feedback, counts how often
each need is voiced, and pushes posts onto the boards. It contributes two
things here and nothing else:

  * mention deltas, annotated onto the post they were pushed as
  * the backlog of needs that never reached a board at all

Answers, for a window:
  1. What new feedback did we gather?         (posts created in the window)
  2. Which feedback gained weight?            (upvote deltas, plus new mentions)
  3. What is in development, and what should be?  (board status, promotions)

Usage:
    python3 featurebase_snapshot.py          # commit it — it is a future baseline
    python3 feedback_change_report.py \
        --baseline featurebase_snapshot_2026-07-31.json \
        --current  featurebase_snapshot_2026-08-21.json \
        --since    2026-07-31 \
        --fb-new-since 2026-08-01            # keep a bulk push out of intake

Writes reports/feedback_changes_<current-date>.{md,json,html}.
"""

import argparse
import collections
import datetime
import json
import os

import feedback_report_html

# Board status is the pipeline status. Ranked by how far along it is.
FB_RANK = {"In Review": 0, "Reviewed": 0, "Planned": 1,
           "In Progress": 2, "Coming Soon": 2, "Completed": 3}
FB_TYPE_RANK = {"reviewing": 0, "unstarted": 1, "active": 2, "completed": 3}

# A post with this many votes that is still in review is worth promoting.
PROMOTE_AT = 10
# A need voiced this often that never reached a board is worth pushing.
BACKLOG_AT = 3

# Proposed cadence, rendered into the report so the proposal travels with the
# numbers it applies to.
CADENCE = [
    ("Every Tuesday, before sprint review", "featurebase_snapshot.py, committed",
     "featurebase_snapshot_<date>.json",
     "nobody — it is the baseline four weeks from now"),
    ("Every Tuesday, in sprint review",
     "feedback_change_report.py, --since 28 days, baseline four weeks back",
     "reports/feedback_changes_<date>.md / .json / .html",
     "sprint review: product + squads"),
    ("First run, Tuesday 2026-08-25", "baseline featurebase_snapshot_2026-07-31.json",
     "a hair under four weeks; a true four-week baseline exists from 2026-09-22",
     "sprint review"),
    ("After each intake merge", "same script, --since the merge date",
     "the delta of that batch only", "whoever ran the intake, as a QA check"),
    ("Weekly, already in place", "roadmap-feedback-review skill",
     "one Confluence page per Next-up item", "Lea, for per-page approval"),
]


# ---------------------------------------------------------------- Featurebase

def load_snapshot(path):
    with open(path, encoding="utf-8") as f:
        snap = json.load(f)
    posts = {}
    for board in snap.get("boards", {}).values():
        for post in board.get("posts", []):
            posts[post["id"]] = post
    return snap, posts


def diff_featurebase(base_path, cur_path, new_since=None):
    """new_since: posts created before it are counted as transferred onto the
    boards rather than as newly gathered feedback."""
    base_snap, base = load_snapshot(base_path)
    cur_snap, cur = load_snapshot(cur_path)

    # Snapshots taken before the postStatus/status fix carry no status at all.
    base_has_status = any(p.get("status") for p in base.values())

    absent = [p for pid, p in cur.items() if pid not in base]
    if new_since:
        new_posts = [p for p in absent if (p.get("createdAt") or "")[:10] >= new_since]
        transferred = [p for p in absent if (p.get("createdAt") or "")[:10] < new_since]
    else:
        new_posts, transferred = absent, []

    vote_gains, comment_gains, status_moves = [], [], []
    for pid, old in base.items():
        now = cur.get(pid)
        if not now:
            continue
        row = {"id": pid, "board": now["board"], "title": now["title"],
               "status": now.get("status", ""), "status_type": now.get("status_type", ""),
               "tags": now.get("tags", []), "url": now.get("postUrl", ""),
               "votes": now.get("votes", 0)}
        dv = now.get("votes", 0) - old.get("votes", 0)
        if dv:
            vote_gains.append({**row, "from": old.get("votes", 0),
                               "to": now.get("votes", 0), "delta": dv})
        dc = now.get("commentCount", 0) - old.get("commentCount", 0)
        if dc:
            comment_gains.append({**row, "from": old.get("commentCount", 0),
                                  "to": now.get("commentCount", 0), "delta": dc})
        if base_has_status and old.get("status") != now.get("status"):
            status_moves.append({
                **row, "from": old.get("status", ""), "to": now.get("status", ""),
                "advanced": FB_TYPE_RANK.get(now.get("status_type", ""), 0)
                            > FB_TYPE_RANK.get(old.get("status_type", ""), 0)})

    vote_gains.sort(key=lambda r: -r["delta"])
    comment_gains.sort(key=lambda r: -r["delta"])
    new_posts.sort(key=lambda p: -p.get("votes", 0))

    return {
        "baseline_date": base_snap.get("snapshot_date"),
        "current_date": cur_snap.get("snapshot_date"),
        "baseline_post_count": len(base),
        "current_post_count": len(cur),
        "baseline_has_status": base_has_status,
        "new_since": new_since,
        "new_posts": [{
            "id": p["id"], "board": p["board"], "title": p["title"],
            "votes": p.get("votes", 0), "status": p.get("status", ""),
            "status_type": p.get("status_type", ""),
            "created": p.get("createdAt", "")[:10], "tags": p.get("tags", []),
            "url": p.get("postUrl", ""),
        } for p in new_posts],
        "new_by_board": dict(collections.Counter(p["board"] for p in new_posts)),
        "new_by_day": dict(sorted(collections.Counter(
            p.get("createdAt", "")[:10] for p in new_posts).items())),
        "transferred_count": len(transferred),
        "transferred_by_day": dict(sorted(collections.Counter(
            p.get("createdAt", "")[:10] for p in transferred).items())),
        "disappeared": [{"id": p["id"], "board": p["board"], "title": p["title"],
                         "votes": p.get("votes", 0)}
                        for pid, p in base.items() if pid not in cur],
        "vote_gains": vote_gains,
        "comment_gains": comment_gains,
        "status_moves": status_moves,
        "pipeline_now": dict(sorted(collections.Counter(
            f"{p['board']} / {p.get('status') or 'unset'}" for p in cur.values()).items())),
        "in_pipeline_count": sum(1 for p in cur.values()
                                 if p.get("status_type") in ("unstarted", "active")),
    }


# ------------------------------------------------- the insights intermediary

def resolve_post(record, by_id, by_title):
    """Only 46 records carry a `featurebase_id`; the boards title posts with the
    verbatim insight text, so an exact normalised title match is a reliable
    second key."""
    post = by_id.get(record.get("featurebase_id") or "")
    if post:
        return post
    return by_title.get((record.get("insight") or "").strip().lower())


def mention_delta(record, since):
    """mentionHistory stores the cumulative count at each date -> take steps."""
    history = sorted((record.get("mentionHistory") or []),
                     key=lambda e: e.get("date") or "")
    prev, delta, sources = 0, 0, []
    for entry in history:
        count = entry.get("count") or 0
        step = count - prev
        if (entry.get("date") or "") >= since and step > 0:
            delta += step
            sources.append(entry.get("source", ""))
        prev = max(prev, count)
    return delta, sources


def read_intermediary(path, since, cur_path):
    """Mention deltas keyed by board post id, plus needs that never reached a
    board. Nothing else from insights.json is reported."""
    with open(path, encoding="utf-8") as f:
        records = json.load(f)
    _, cur = load_snapshot(cur_path)
    by_title = {}
    for post in cur.values():
        by_title.setdefault(post["title"].strip().lower(), post)

    by_post, backlog, on_board = {}, [], 0
    for r in records:
        post = resolve_post(r, cur, by_title)
        delta, sources = mention_delta(r, since)
        if post:
            on_board += 1
            if delta > 0:
                # Several records can feed one post; accumulate.
                slot = by_post.setdefault(post["id"], {
                    "insight_ids": [], "mentions": 0, "delta": 0, "sources": []})
                slot["insight_ids"].append(r["id"])
                slot["mentions"] += r.get("mentions", 0)
                slot["delta"] += delta
                slot["sources"] += sources
        elif r.get("mentions", 0) >= BACKLOG_AT or delta > 0:
            backlog.append({"id": r["id"], "insight": r["insight"],
                            "mentions": r.get("mentions", 0), "delta": delta,
                            "created": r.get("created", ""),
                            "segment": r.get("userGroup", "")})

    backlog.sort(key=lambda r: (-r["mentions"], -r["delta"]))
    return {
        "since": since,
        "record_count": len(records),
        "on_board": on_board,
        "not_on_board": len(records) - on_board,
        "by_post": by_post,
        "mention_delta_total": sum(v["delta"] for v in by_post.values()),
        "posts_with_new_mentions": len(by_post),
        "backlog": backlog,
        "backlog_new_mentions": [r for r in backlog if r["delta"] > 0],
    }


def annotate(rows, inter):
    """Attach the intermediary's mention delta to each board post row."""
    for row in rows:
        hit = inter["by_post"].get(row["id"])
        row["mention_delta"] = hit["delta"] if hit else 0
        row["mentions"] = hit["mentions"] if hit else None
        row["insight_ids"] = hit["insight_ids"] if hit else []
    return rows


# --------------------------------------------------------------------- render

def _row(*cells):
    return "| " + " | ".join(str(c).replace("|", "\\|") for c in cells) + " |"


def _table(headers, rows):
    if not rows:
        return "_None._\n"
    out = [_row(*headers), "|" + "|".join(["---"] * len(headers)) + "|"]
    out += [_row(*r) for r in rows]
    return "\n".join(out) + "\n"


def _link(title, url, width=70):
    text = title if len(title) <= width else title[: width - 1] + "…"
    return f"[{text}]({url})" if url else text


def _mentions(row):
    return f"+{row['mention_delta']}" if row["mention_delta"] else "—"


def render_markdown(fb, inter, since, until):
    L = [f"# Featurebase change report — {since} → {until}", "",
         "Every item below is a Featurebase post; the board status is the pipeline "
         "status. The insights database is the intermediary that feeds the boards — it "
         "contributes mention counts and the backlog of needs not yet pushed, nothing else.",
         ""]

    L.append("## 1. Headline numbers")
    L.append("")
    rows = [
        (f"Posts on the boards (baseline {fb['baseline_date']} → {fb['current_date']})",
         f"{fb['baseline_post_count']} → {fb['current_post_count']}"),
        ("Newly gathered posts", len(fb["new_posts"])),
        ("Posts that gained upvotes", len(fb["vote_gains"])),
        ("Upvotes added", sum(r["delta"] for r in fb["vote_gains"])),
        ("Posts whose need was voiced again (new mentions)",
         inter["posts_with_new_mentions"]),
        ("Posts that gained comments", len(fb["comment_gains"])),
        ("Posts planned or in progress right now", fb["in_pipeline_count"]),
        ("Status moves on the boards",
         len(fb["status_moves"]) if fb["baseline_has_status"]
         else "n/a — baseline has no status data"),
        ("Needs not yet on any board", inter["not_on_board"]),
    ]
    if fb["transferred_count"]:
        rows.insert(2, (f"Posts transferred onto the boards before {fb['new_since']} "
                        "(excluded from intake)", fb["transferred_count"]))
    L.append(_table(["Metric", "Value"], rows))

    L.append("## 2. What new feedback we gathered")
    L.append("")
    if fb["transferred_count"]:
        L.append(f"> {fb['transferred_count']} posts absent from the baseline were created "
                 f"before `{fb['new_since']}` — the bulk transfer of already-collected "
                 "research onto the boards. Excluded from every count in this section: "
                 + ", ".join(f"`{d}` {n}" for d, n in fb["transferred_by_day"].items())
                 + ".\n")
    L.append(_table(["Board", "New posts"],
                    sorted(fb["new_by_board"].items(), key=lambda x: -x[1])))
    L.append("")
    L.append(_table(["Created", "Votes", "Board", "Status", "Post", "Squad tags"],
                    [(p["created"], p["votes"], p["board"], p["status"] or "—",
                      _link(p["title"], p["url"]),
                      ", ".join(p["tags"]) or "—") for p in fb["new_posts"]]))
    if fb["disappeared"]:
        L.append("Present in the baseline, gone now — deleted, merged, or moved to a "
                 "board the snapshot does not cover:")
        L.append("")
        L.append(_table(["Board", "Votes", "Title"],
                        [(p["board"], p["votes"], p["title"]) for p in fb["disappeared"]]))

    L.append("## 3. Which feedback gained weight")
    L.append("")
    L.append(f"{len(fb['vote_gains'])} of the {fb['baseline_post_count']} posts that already "
             "existed at the baseline gained upvotes. None lost any. A vote does not bump a "
             "post's `updatedAt`, so vote timing cannot be narrowed below the span between "
             "the two snapshots — which is this window. The mentions column is the "
             "intermediary's count of the same need being voiced again by a separate customer.")
    L.append("")
    L.append(_table(["Δ votes", "Votes", "Δ mentions", "Status", "Board", "Post", "Squad tags"],
                    [(f"+{r['delta']}", f"{r['from']} → {r['to']}", _mentions(r),
                      r["status"] or "—", r["board"], _link(r["title"], r["url"]),
                      ", ".join(r["tags"]) or "—") for r in fb["vote_gains"]]))
    mention_only = [pid for pid in inter["by_post"]
                    if pid not in {r["id"] for r in fb["vote_gains"]}
                    and pid not in {p["id"] for p in fb["new_posts"]}]
    if mention_only:
        L.append(f"{len(mention_only)} posts gained mentions without gaining a vote — the need "
                 "was voiced again in research, but no customer upvoted it on the board.")
        L.append("")
    if fb["comment_gains"]:
        L.append("New discussion:")
        L.append("")
        L.append(_table(["Δ", "Board", "Post"],
                        [(f"+{r['delta']}", r["board"], _link(r["title"], r["url"]))
                         for r in fb["comment_gains"]]))

    L.append("## 4. What is in development, and what should be")
    L.append("")
    L.append(_table(["Board / status", "Posts"], list(fb["pipeline_now"].items())))
    L.append("")
    if fb["baseline_has_status"]:
        L.append("Status moves in this window:")
        L.append("")
        L.append(_table(["From", "To", "Advanced?", "Votes", "Post"],
                        [(m["from"] or "—", m["to"], "yes" if m["advanced"] else "no",
                          m["votes"], _link(m["title"], m["url"]))
                         for m in fb["status_moves"]]))
    else:
        L.append(f"> The {fb['baseline_date']} baseline carries no status values, so status "
                 "moves cannot be diffed for this window and the pipeline above is a "
                 f"current-state read. Snapshots from {fb['current_date']} onward record status.\n")

    prio = [r for r in fb["vote_gains"] if r["status_type"] != "reviewing"]
    if prio:
        L.append("### In the pipeline and gaining demand")
        L.append("")
        L.append(_table(["Δ votes", "Votes now", "Δ mentions", "Status", "Post"],
                        [(f"+{r['delta']}", r["to"], _mentions(r), r["status"],
                          _link(r["title"], r["url"])) for r in prio]))
    promote = [r for r in fb["vote_gains"]
               if r["status_type"] == "reviewing" and r["to"] >= PROMOTE_AT]
    if promote:
        L.append(f"### Gained votes, now ≥{PROMOTE_AT}, still in review — promotion candidates")
        L.append("")
        L.append(_table(["Δ votes", "Votes now", "Δ mentions", "Status", "Post"],
                        [(f"+{r['delta']}", r["to"], _mentions(r), r["status"],
                          _link(r["title"], r["url"])) for r in promote]))

    L.append("## 5. Needs not yet on a board")
    L.append("")
    L.append(f"{inter['not_on_board']} of the intermediary's {inter['record_count']} records "
             "have no board post, so they cannot collect votes and are invisible to the "
             f"pipeline. Those voiced at least {BACKLOG_AT} times, or voiced again in this "
             "window:")
    L.append("")
    L.append(_table(["Mentions", "Δ in window", "Insight", "Segment"],
                    [(r["mentions"], f"+{r['delta']}" if r["delta"] else "—",
                      r["insight"][:88], r["segment"]) for r in inter["backlog"][:40]]))

    L.append("## 6. How this gets reported from now on")
    L.append("")
    L.append(_table(["Cadence", "What runs", "Output", "Audience"], CADENCE))
    return "\n".join(L) + "\n"


# ----------------------------------------------------------------------- main

def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--baseline", required=True, help="older featurebase_snapshot_*.json")
    ap.add_argument("--current", required=True, help="newer featurebase_snapshot_*.json")
    ap.add_argument("--insights", default="insights.json",
                    help="the intermediary; supplies mention counts and the backlog")
    ap.add_argument("--since", help="window start, YYYY-MM-DD (default: 28 days back)")
    ap.add_argument("--fb-new-since",
                    help="count posts as newly gathered only from this date; earlier ones "
                         "absent from the baseline are reported as transferred. Use it to "
                         "keep a bulk push out of intake. Defaults to --since.")
    ap.add_argument("--out-md")
    ap.add_argument("--out-json")
    ap.add_argument("--out-html")
    ap.add_argument("--no-html", action="store_true", help="skip the HTML render")
    args = ap.parse_args()

    with open(args.current, encoding="utf-8") as f:
        until = json.load(f).get("snapshot_date") or datetime.date.today().isoformat()
    since = args.since or (datetime.date.fromisoformat(until)
                           - datetime.timedelta(days=28)).isoformat()

    fb = diff_featurebase(args.baseline, args.current, args.fb_new_since or since)
    inter = read_intermediary(args.insights, since, args.current)
    annotate(fb["vote_gains"], inter)
    annotate(fb["new_posts"], inter)
    annotate(fb["comment_gains"], inter)
    annotate(fb["status_moves"], inter)

    os.makedirs("reports", exist_ok=True)
    out_md = args.out_md or f"reports/feedback_changes_{until}.md"
    out_json = args.out_json or f"reports/feedback_changes_{until}.json"
    written = []

    with open(out_md, "w", encoding="utf-8") as f:
        f.write(render_markdown(fb, inter, since, until))
    written.append(out_md)

    with open(out_json, "w", encoding="utf-8") as f:
        json.dump({"window": {"since": since, "until": until},
                   "featurebase": fb, "intermediary": inter}, f,
                  ensure_ascii=False, indent=2)
    written.append(out_json)

    if not args.no_html:
        out_html = args.out_html or f"reports/feedback_changes_{until}.html"
        with open(out_html, "w", encoding="utf-8") as f:
            f.write(feedback_report_html.render(fb, inter, since, until, CADENCE))
        written.append(out_html)

    print("\n".join(f"Wrote {p}" for p in written))


if __name__ == "__main__":
    main()
