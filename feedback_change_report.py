#!/usr/bin/env python3
"""
feedback_change_report.py — What changed in customer feedback over a time window.

Answers three questions for a reporting period:

  1. What new feedback did we gather?          (new Featurebase posts + new insight records)
  2. What existing feedback gained weight?     (upvote deltas + mention-count deltas)
  3. What entered or advanced in development?  (Featurebase status moves + insight status moves)

Two independent sources, deliberately kept separate because they answer
different things:

  * Featurebase snapshots  -> customer-visible demand signal (votes, board status).
                              Requires a baseline snapshot; a diff is only as good
                              as the oldest snapshot you kept.
  * insights.json          -> the research database. Carries mentionHistory and
                              statusHistory per record, so any window can be
                              recomputed from the current file alone. No baseline
                              file needed.

Usage:
    # weekly report, Featurebase diffed against last week's snapshot
    python3 feedback_change_report.py \
        --baseline featurebase_snapshot_2026-08-14.json \
        --current  featurebase_snapshot_2026-08-21.json \
        --since    2026-07-24

    # insights-only (no Featurebase baseline available)
    python3 feedback_change_report.py --since 2026-07-24

Writes reports/feedback_changes_<current-date>.md and .json unless --out-md /
--out-json are given.
"""

import argparse
import collections
import datetime
import json
import os

import feedback_report_html

# Proposed reporting cadence, rendered into the HTML report so the proposal
# travels with the numbers it applies to.
CADENCE = [
    ("Every Monday 06:00", "featurebase_snapshot.py, committed",
     "featurebase_snapshot_<date>.json", "nobody — it is the baseline for next week"),
    ("Every Monday 06:05", "feedback_change_report.py, --since 7 days",
     "reports/feedback_changes_<date>.md / .json / .html", "product + squads, weekly"),
    ("First Monday of the month", "same script, --since 28 days",
     "monthly rollup, same three formats", "leadership / sprint review"),
    ("After each intake merge", "same script, --since the merge date",
     "delta of that batch only", "whoever ran the intake, as a QA check"),
    ("Weekly, already in place", "roadmap-feedback-review skill",
     "one Confluence page per Next-up item", "Lea, for per-page approval"),
]

STATUS_RANK = {
    # insights.json vocabulary, ordered by how far along the pipeline it is
    "New – Not yet discussed": 0,
    "New - Not yet discussed": 0,
    "Identified - JIRA ticket exists": 1,
    "Planned for development": 2,
    "Implemented - a solution is released": 3,
    "Well done - positive feedback outweighs negative": 3,
}

# Featurebase status_type, ordered the same way
FB_TYPE_RANK = {"reviewing": 0, "unstarted": 1, "active": 2, "completed": 3}


# ---------------------------------------------------------------- Featurebase

def load_snapshot(path):
    with open(path, encoding="utf-8") as f:
        snap = json.load(f)
    posts = {}
    for board in snap.get("boards", {}).values():
        for p in board.get("posts", []):
            posts[p["id"]] = p
    return snap, posts


def diff_featurebase(base_path, cur_path):
    base_snap, base = load_snapshot(base_path)
    cur_snap, cur = load_snapshot(cur_path)

    # Snapshots taken before the postStatus/status fix carry no status at all.
    base_has_status = any(p.get("status") for p in base.values())

    new_posts = [p for pid, p in cur.items() if pid not in base]
    disappeared = [p for pid, p in base.items() if pid not in cur]

    vote_gains, comment_gains, status_moves = [], [], []
    for pid, old in base.items():
        now = cur.get(pid)
        if not now:
            continue
        dv = now.get("votes", 0) - old.get("votes", 0)
        if dv:
            vote_gains.append({
                "id": pid, "board": now["board"], "title": now["title"],
                "from": old.get("votes", 0), "to": now.get("votes", 0), "delta": dv,
                "status": now.get("status", ""), "status_type": now.get("status_type", ""),
                "tags": now.get("tags", []), "url": now.get("postUrl", ""),
            })
        dc = now.get("commentCount", 0) - old.get("commentCount", 0)
        if dc:
            comment_gains.append({
                "id": pid, "board": now["board"], "title": now["title"],
                "from": old.get("commentCount", 0), "to": now.get("commentCount", 0),
                "delta": dc, "url": now.get("postUrl", ""),
            })
        if base_has_status and old.get("status") != now.get("status"):
            status_moves.append({
                "id": pid, "board": now["board"], "title": now["title"],
                "from": old.get("status", ""), "to": now.get("status", ""),
                "advanced": FB_TYPE_RANK.get(now.get("status_type", ""), 0)
                            > FB_TYPE_RANK.get(old.get("status_type", ""), 0),
                "votes": now.get("votes", 0), "url": now.get("postUrl", ""),
            })

    vote_gains.sort(key=lambda r: -r["delta"])
    comment_gains.sort(key=lambda r: -r["delta"])
    new_posts.sort(key=lambda p: -p.get("votes", 0))

    return {
        "baseline_date": base_snap.get("snapshot_date"),
        "current_date": cur_snap.get("snapshot_date"),
        "baseline_post_count": len(base),
        "current_post_count": len(cur),
        "baseline_has_status": base_has_status,
        "new_posts": [{
            "id": p["id"], "board": p["board"], "title": p["title"],
            "votes": p.get("votes", 0), "status": p.get("status", ""),
            "created": p.get("createdAt", "")[:10], "tags": p.get("tags", []),
            "url": p.get("postUrl", ""),
        } for p in new_posts],
        "new_by_board": dict(collections.Counter(p["board"] for p in new_posts)),
        "new_by_day": dict(sorted(collections.Counter(
            p.get("createdAt", "")[:10] for p in new_posts).items())),
        "disappeared": [{"id": p["id"], "board": p["board"], "title": p["title"],
                         "votes": p.get("votes", 0)} for p in disappeared],
        "vote_gains": vote_gains,
        "comment_gains": comment_gains,
        "status_moves": status_moves,
        "pipeline_now": dict(sorted(collections.Counter(
            f"{p['board']} / {p.get('status') or 'unset'}" for p in cur.values()).items())),
    }


def stale_synced_votes(insights, cur_path):
    """insights.json caches featurebase_votes at push time; flag where it drifted."""
    _, cur = load_snapshot(cur_path)
    stale, dangling = [], []
    for r in insights:
        fid = r.get("featurebase_id")
        if not fid:
            continue
        post = cur.get(fid)
        if not post:
            dangling.append({"insight_id": r["id"], "featurebase_id": fid,
                             "insight": r["insight"]})
            continue
        stored = r.get("featurebase_votes")
        if stored is not None and post.get("votes", 0) != stored:
            stale.append({
                "insight_id": r["id"], "insight": r["insight"],
                "stored_votes": stored, "live_votes": post.get("votes", 0),
                "synced_at": (r.get("featurebase_synced_at") or "")[:10],
                "fb_status": post.get("status", ""),
            })
    stale.sort(key=lambda r: -(r["live_votes"] - r["stored_votes"]))
    return {"stale_votes": stale, "dangling_links": dangling}


# ------------------------------------------------------------------- insights

def mention_delta(record, since):
    """mentionHistory stores the cumulative count at each date -> take steps."""
    history = sorted((record.get("mentionHistory") or []),
                     key=lambda e: e.get("date") or "")
    prev, delta, events = 0, 0, []
    for entry in history:
        count = entry.get("count") or 0
        step = count - prev
        if (entry.get("date") or "") >= since and step > 0:
            delta += step
            events.append({"date": entry.get("date"), "added": step,
                           "source": entry.get("source", "")})
        prev = max(prev, count)
    return delta, events


def status_transitions(record, since):
    history = sorted((record.get("statusHistory") or []),
                     key=lambda e: e.get("date") or "")
    out = []
    for i, entry in enumerate(history):
        if (entry.get("date") or "") < since:
            continue
        frm = history[i - 1].get("status") if i else None
        if frm == entry.get("status"):
            continue
        to = entry.get("status")
        out.append({
            "date": entry.get("date"), "from": frm, "to": to,
            "advanced": frm is not None
                        and STATUS_RANK.get(to, 0) > STATUS_RANK.get(frm, 0),
        })
    return out


def fb_index(cur_path):
    """Resolve insights -> Featurebase posts.

    Only 46 of the records carry a `featurebase_id`; the rest were pushed by
    earlier runs that did not write the id back. Titles on the boards are the
    verbatim insight text, so an exact normalised title match is a reliable
    second key.
    """
    if not cur_path:
        return {}, {}
    _, cur = load_snapshot(cur_path)
    by_title = {}
    for post in cur.values():
        by_title.setdefault(post["title"].strip().lower(), post)
    return cur, by_title


def resolve_post(record, by_id, by_title):
    post = by_id.get(record.get("featurebase_id") or "")
    if post:
        return post, "id"
    post = by_title.get((record.get("insight") or "").strip().lower())
    return (post, "title") if post else (None, None)


def diff_insights(path, since, by_id=None, by_title=None):
    with open(path, encoding="utf-8") as f:
        insights = json.load(f)
    by_id, by_title = by_id or {}, by_title or {}

    new_records, gained, moved = [], [], []
    for r in insights:
        is_new = (r.get("created") or "") >= since
        delta, events = mention_delta(r, since)
        moves = status_transitions(r, since)

        base = {"id": r["id"], "insight": r["insight"], "status": r.get("status", ""),
                "mentions": r.get("mentions", 0), "features": r.get("features", []),
                "squads": r.get("squads", []), "segment": r.get("userGroup", ""),
                "source": r.get("source", ""), "jira": r.get("jira", "")}
        post, how = resolve_post(r, by_id, by_title)
        base.update({
            "on_featurebase": bool(post),
            "fb_match": how or "",
            "fb_votes": post.get("votes") if post else None,
            "fb_status": post.get("status", "") if post else "",
            "fb_url": post.get("postUrl", "") if post else "",
        })

        if is_new:
            new_records.append({**base, "created": r.get("created")})
        elif delta > 0:
            gained.append({**base, "delta": delta, "events": events})

        real_moves = [m for m in moves if m["from"] is not None]
        if real_moves:
            moved.append({**base, "moves": real_moves})

    new_records.sort(key=lambda r: (r["created"], -r["mentions"]))
    gained.sort(key=lambda r: (-r["delta"], -r["mentions"]))
    moved.sort(key=lambda r: (r["moves"][-1]["date"], -r["mentions"]))

    return {
        "record_count": len(insights),
        "since": since,
        "new_records": new_records,
        "gained_mentions": gained,
        "status_moved": moved,
        "advanced": [r for r in moved if any(m["advanced"] for m in r["moves"])],
        "status_now": dict(collections.Counter(r.get("status", "") for r in insights)),
        "on_featurebase_count": sum(
            1 for r in insights if resolve_post(r, by_id, by_title)[0]),
        "insights": insights,
    }


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
    t = title if len(title) <= width else title[: width - 1] + "…"
    return f"[{t}]({url})" if url else t


def render_markdown(fb, ins, sync, since, until):
    L = [f"# Feedback change report — {since} → {until}", ""]

    L.append("## 1. Headline numbers")
    L.append("")
    rows = [
        ("New insight records (research DB)", len(ins["new_records"])),
        ("Existing insights that gained mentions", len(ins["gained_mentions"])),
        ("Insights whose status changed", len(ins["status_moved"])),
        ("…of which advanced toward development", len(ins["advanced"])),
        ("Insight records represented on Featurebase",
         f"{ins['on_featurebase_count']} / {ins['record_count']}"),
    ]
    if fb:
        rows = [
            (f"Featurebase posts (baseline {fb['baseline_date']} → {fb['current_date']})",
             f"{fb['baseline_post_count']} → {fb['current_post_count']}"),
            ("New Featurebase posts", len(fb["new_posts"])),
            ("Existing posts that gained upvotes", len(fb["vote_gains"])),
            ("Posts that gained comments", len(fb["comment_gains"])),
            ("Featurebase status moves", len(fb["status_moves"]) if fb["baseline_has_status"]
             else "n/a — baseline has no status data"),
        ] + rows
    L.append(_table(["Metric", "Value"], rows))

    if fb:
        L.append("## 2. New feedback on Featurebase")
        L.append("")
        L.append(_table(["Board", "New posts"],
                        sorted(fb["new_by_board"].items(), key=lambda x: -x[1])))
        L.append("")
        L.append("Created per day: " + ", ".join(
            f"`{d}` {n}" for d, n in fb["new_by_day"].items()) + "\n")
        L.append("Top new posts by upvotes:")
        L.append("")
        L.append(_table(["Votes", "Board", "Status", "Post", "Created"],
                        [(p["votes"], p["board"], p["status"] or "—",
                          _link(p["title"], p["url"]), p["created"])
                         for p in fb["new_posts"][:25]]))
        if fb["disappeared"]:
            L.append("Posts present in the baseline but gone now "
                     "(deleted, merged, or moved to a board outside the snapshot):")
            L.append("")
            L.append(_table(["Board", "Votes", "Title"],
                            [(p["board"], p["votes"], p["title"])
                             for p in fb["disappeared"]]))

        L.append("## 3. Existing feedback that gained upvotes")
        L.append("")
        L.append(_table(["Δ", "Votes", "Status", "Board", "Post", "Squad tags"],
                        [(f"+{r['delta']}", f"{r['from']} → {r['to']}",
                          r["status"] or "—", r["board"], _link(r["title"], r["url"]),
                          ", ".join(r["tags"]) or "—") for r in fb["vote_gains"]]))
        if fb["comment_gains"]:
            L.append("New discussion (comment count changed):")
            L.append("")
            L.append(_table(["Δ", "Board", "Post"],
                            [(f"+{r['delta']}", r["board"], _link(r["title"], r["url"]))
                             for r in fb["comment_gains"]]))

        L.append("## 4. Development pipeline on Featurebase (current state)")
        L.append("")
        L.append(_table(["Board / status", "Posts"], list(fb["pipeline_now"].items())))
        if fb["baseline_has_status"]:
            L.append("Status moves in this window:")
            L.append("")
            L.append(_table(["Date-of-diff", "From", "To", "Advanced?", "Votes", "Post"],
                            [("", m["from"] or "—", m["to"], "yes" if m["advanced"] else "no",
                              m["votes"], _link(m["title"], m["url"]))
                             for m in fb["status_moves"]]))
        else:
            L.append(f"> The baseline snapshot ({fb['baseline_date']}) carries no status "
                     "values, so Featurebase status moves cannot be diffed for this "
                     "window. Snapshots taken from 2026-08-21 onward do record status.\n")
        prio = [r for r in fb["vote_gains"]
                if r["status_type"] in ("unstarted", "active")]
        if prio:
            L.append("Items that gained votes **and** are already planned or in progress "
                     "— demand and delivery agree:")
            L.append("")
            L.append(_table(["Δ", "Votes now", "Status", "Post"],
                            [(f"+{r['delta']}", r["to"], r["status"],
                              _link(r["title"], r["url"])) for r in prio]))
        untouched = [r for r in fb["vote_gains"]
                     if r["status_type"] == "reviewing" and r["to"] >= 10]
        if untouched:
            L.append("Items that gained votes, now ≥10 votes, and are still only in "
                     "review — candidates to promote:")
            L.append("")
            L.append(_table(["Δ", "Votes now", "Status", "Post"],
                            [(f"+{r['delta']}", r["to"], r["status"],
                              _link(r["title"], r["url"])) for r in untouched]))

    L.append("## 5. New insight records in the research database")
    L.append("")
    L.append(_table(["Created", "ID", "Mentions", "Status", "Insight", "Source",
                     "On Featurebase"],
                    [(r["created"], r["id"], r["mentions"], r["status"],
                      _link(r["insight"], r["fb_url"], 90), r["source"],
                      f"{r['fb_votes']} votes" if r["on_featurebase"] else "not pushed")
                     for r in ins["new_records"]]))

    L.append("## 6. Existing insights that gained mentions")
    L.append("")
    L.append(_table(["Δ", "Mentions", "ID", "Status", "Insight", "On Featurebase"],
                    [(f"+{r['delta']}", r["mentions"], r["id"], r["status"],
                      _link(r["insight"], r["fb_url"], 80),
                      f"{r['fb_votes']} votes · {r['fb_status']}"
                      if r["on_featurebase"] else "not pushed")
                     for r in ins["gained_mentions"]]))

    L.append("## 7. Insights that entered or advanced in development")
    L.append("")
    L.append(_table(["Date", "ID", "Mentions", "From", "To", "Insight"],
                    [(m["date"], r["id"], r["mentions"], m["from"] or "—", m["to"],
                      r["insight"][:70])
                     for r in ins["status_moved"] for m in r["moves"]]))
    L.append("Research DB status distribution now:")
    L.append("")
    L.append(_table(["Status", "Records"],
                    sorted(ins["status_now"].items(), key=lambda x: -x[1])))

    if sync:
        L.append("## 8. Data hygiene")
        L.append("")
        if sync["stale_votes"]:
            L.append(f"{len(sync['stale_votes'])} insights carry a cached "
                     "`featurebase_votes` value that no longer matches the live post. "
                     "The cache is written at push time and never refreshed, so any "
                     "report that reads it under-counts demand:")
            L.append("")
            L.append(_table(["ID", "Stored", "Live", "Synced", "FB status", "Insight"],
                            [(r["insight_id"], r["stored_votes"], r["live_votes"],
                              r["synced_at"], r["fb_status"], r["insight"][:60])
                             for r in sync["stale_votes"]]))
        if sync["dangling_links"]:
            L.append("Insights pointing at a Featurebase post that no longer exists:")
            L.append("")
            L.append(_table(["ID", "featurebase_id", "Insight"],
                            [(r["insight_id"], r["featurebase_id"], r["insight"][:70])
                             for r in sync["dangling_links"]]))

    return "\n".join(L) + "\n"


# ----------------------------------------------------------------------- main

def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--baseline", help="older featurebase_snapshot_*.json")
    ap.add_argument("--current", help="newer featurebase_snapshot_*.json")
    ap.add_argument("--insights", default="insights.json")
    ap.add_argument("--since", help="window start, YYYY-MM-DD (default: 28 days back)")
    ap.add_argument("--out-md")
    ap.add_argument("--out-json")
    ap.add_argument("--out-html")
    ap.add_argument("--no-html", action="store_true",
                    help="skip the HTML render")
    args = ap.parse_args()

    until = datetime.date.today().isoformat()
    if args.current:
        with open(args.current, encoding="utf-8") as f:
            until = json.load(f).get("snapshot_date") or until
    since = args.since or (datetime.date.fromisoformat(until)
                           - datetime.timedelta(days=28)).isoformat()

    fb = None
    if args.baseline and args.current:
        fb = diff_featurebase(args.baseline, args.current)
    elif args.baseline or args.current:
        ap.error("--baseline and --current must be given together")

    by_id, by_title = fb_index(args.current)
    ins = diff_insights(args.insights, since, by_id, by_title)
    sync = stale_synced_votes(ins.pop("insights"), args.current) if args.current else None

    os.makedirs("reports", exist_ok=True)
    out_md = args.out_md or f"reports/feedback_changes_{until}.md"
    out_json = args.out_json or f"reports/feedback_changes_{until}.json"
    written = []

    with open(out_md, "w", encoding="utf-8") as f:
        f.write(render_markdown(fb, ins, sync, since, until))
    written.append(out_md)

    with open(out_json, "w", encoding="utf-8") as f:
        json.dump({"window": {"since": since, "until": until},
                   "featurebase": fb, "insights": ins, "sync_hygiene": sync},
                  f, ensure_ascii=False, indent=2)
    written.append(out_json)

    if not args.no_html:
        out_html = args.out_html or f"reports/feedback_changes_{until}.html"
        with open(out_html, "w", encoding="utf-8") as f:
            f.write(feedback_report_html.render(fb, ins, sync, since, until, CADENCE))
        written.append(out_html)

    print("\n".join(f"Wrote {p}" for p in written))


if __name__ == "__main__":
    main()
