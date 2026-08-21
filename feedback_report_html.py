#!/usr/bin/env python3
"""
feedback_report_html.py — render the feedback change report as a standalone page.

Imported by feedback_change_report.py (--out-html). Kept separate so the
analysis stays readable; this module only formats.
"""

import html


def esc(text):
    return html.escape(str(text if text is not None else ""), quote=True)


def link(title, url, width=None):
    label = str(title)
    if width and len(label) > width:
        label = label[: width - 1] + "…"
    if url:
        return f'<a href="{esc(url)}" target="_blank" rel="noopener">{esc(label)}</a>'
    return esc(label)


def pill(text, kind="neutral"):
    return f'<span class="pill pill--{kind}">{esc(text)}</span>'


def fb_status_kind(status):
    return {
        "Completed": "done", "In Progress": "active", "Coming Soon": "active",
        "Planned": "planned", "Reviewed": "neutral", "In Review": "quiet",
    }.get(status, "neutral")


def db_status_kind(status):
    if status.startswith("Implemented") or status.startswith("Well done"):
        return "done"
    if status.startswith("Planned"):
        return "active"
    if status.startswith("Identified"):
        return "planned"
    return "quiet"


def short_status(status):
    return {
        "New – Not yet discussed": "Not yet discussed",
        "Identified - JIRA ticket exists": "JIRA ticket exists",
        "Planned for development": "Planned",
        "Implemented - a solution is released": "Implemented",
        "Well done - positive feedback outweighs negative": "Well done",
    }.get(status, status)


def bar(base, gain, scale):
    """Baseline segment + gain segment, both proportional to the widest row."""
    total = max(scale, 1)
    return (
        '<span class="bar" role="img" '
        f'aria-label="{base} before, {gain} added">'
        f'<span class="bar__base" style="flex:{base / total:.4f}"></span>'
        f'<span class="bar__gain" style="flex:{gain / total:.4f}"></span>'
        f'<span class="bar__rest" style="flex:{max(0, total - base - gain) / total:.4f}"></span>'
        "</span>"
    )


def table(headers, rows, classes=""):
    if not rows:
        return '<p class="empty">Nothing in this window.</p>'
    head = "".join(f"<th>{h}</th>" for h in headers)
    body = "".join("<tr>" + "".join(f"<td>{c}</td>" for c in r) + "</tr>" for r in rows)
    return (f'<div class="scroll"><table class="{classes}">'
            f"<thead><tr>{head}</tr></thead><tbody>{body}</tbody></table></div>")


def section(num, eyebrow, title, lede, body):
    return f"""<section class="sec">
  <header class="sec__head">
    <p class="eyebrow"><span class="eyebrow__src">{esc(eyebrow)}</span></p>
    <h2>{esc(title)}</h2>
    {f'<p class="lede">{lede}</p>' if lede else ''}
  </header>
  {body}
</section>"""


CSS = """
:root {
  --ground: #f2f4f7;
  --surface: #ffffff;
  --surface-2: #fafbfc;
  --line: #dde2e9;
  --line-soft: #e9edf2;
  --ink: #151b24;
  --ink-2: #3d4756;
  --muted: #6b7583;
  --accent: #1d5fa8;
  --accent-soft: #e4ecf6;
  --gain: #14795e;
  --gain-soft: #e0f0ea;
  --warn: #9a5a12;
  --warn-soft: #f7ecdc;
  --quiet: #7a8494;
  --quiet-soft: #eceff3;
  --shadow: 0 1px 2px rgba(20, 27, 36, .05), 0 8px 24px -16px rgba(20, 27, 36, .18);
}
:root:not([data-theme="light"]) { }
@media (prefers-color-scheme: dark) {
  :root:not([data-theme="light"]) {
    --ground: #0f1319;
    --surface: #161c25;
    --surface-2: #1b222c;
    --line: #2a333f;
    --line-soft: #222a35;
    --ink: #e7ebf1;
    --ink-2: #bfc7d2;
    --muted: #929cab;
    --accent: #78aae4;
    --accent-soft: #1c2b3d;
    --gain: #5fc4a3;
    --gain-soft: #14302a;
    --warn: #d9a463;
    --warn-soft: #33270f;
    --quiet: #8d97a5;
    --quiet-soft: #212934;
    --shadow: 0 1px 2px rgba(0,0,0,.4), 0 10px 30px -18px rgba(0,0,0,.7);
  }
}
:root[data-theme="dark"] {
  --ground: #0f1319;
  --surface: #161c25;
  --surface-2: #1b222c;
  --line: #2a333f;
  --line-soft: #222a35;
  --ink: #e7ebf1;
  --ink-2: #bfc7d2;
  --muted: #929cab;
  --accent: #78aae4;
  --accent-soft: #1c2b3d;
  --gain: #5fc4a3;
  --gain-soft: #14302a;
  --warn: #d9a463;
  --warn-soft: #33270f;
  --quiet: #8d97a5;
  --quiet-soft: #212934;
  --shadow: 0 1px 2px rgba(0,0,0,.4), 0 10px 30px -18px rgba(0,0,0,.7);
}

* { box-sizing: border-box; }
body {
  margin: 0;
  background: var(--ground);
  color: var(--ink);
  font-family: "IBM Plex Sans", ui-sans-serif, system-ui, -apple-system, Segoe UI, sans-serif;
  font-size: 15px;
  line-height: 1.6;
  -webkit-font-smoothing: antialiased;
}
.wrap { max-width: 1080px; margin: 0 auto; padding: 0 20px 96px; }
a { color: var(--accent); text-decoration: none; border-bottom: 1px solid transparent; }
a:hover { border-bottom-color: currentColor; }
a:focus-visible, summary:focus-visible { outline: 2px solid var(--accent); outline-offset: 2px; border-radius: 2px; }

/* ---------- masthead ---------- */
.mast { padding: 56px 0 32px; border-bottom: 1px solid var(--line); }
.mast__kicker {
  font-family: "IBM Plex Mono", ui-monospace, monospace;
  font-size: 11px; letter-spacing: .14em; text-transform: uppercase;
  color: var(--muted); margin: 0 0 18px;
}
.mast h1 {
  font-family: Newsreader, ui-serif, Georgia, serif;
  font-weight: 400; font-size: clamp(2.1rem, 5.2vw, 3.3rem);
  line-height: 1.08; letter-spacing: -.015em; margin: 0 0 18px;
  text-wrap: balance;
}
.mast h1 em { font-style: italic; color: var(--accent); }
.mast__sub { color: var(--ink-2); max-width: 62ch; margin: 0 0 28px; font-size: 1.03rem; }
.sources { display: flex; flex-wrap: wrap; gap: 10px; }
.src {
  display: flex; flex-direction: column; gap: 2px;
  background: var(--surface); border: 1px solid var(--line);
  border-radius: 3px; padding: 10px 14px; box-shadow: var(--shadow);
}
.src__k {
  font-family: "IBM Plex Mono", monospace; font-size: 10px;
  letter-spacing: .12em; text-transform: uppercase; color: var(--muted);
}
.src__v { font-size: 13px; color: var(--ink-2); font-variant-numeric: tabular-nums; }

/* ---------- callout ---------- */
.note {
  margin: 32px 0 0; padding: 20px 22px;
  background: var(--warn-soft); border: 1px solid var(--warn);
  border-left-width: 3px; border-radius: 3px;
}
.note h3 {
  margin: 0 0 8px; font-family: "IBM Plex Sans", sans-serif;
  font-size: .78rem; letter-spacing: .1em; text-transform: uppercase; color: var(--warn);
}
.note p { margin: 0 0 10px; color: var(--ink-2); max-width: 74ch; }
.note p:last-child { margin-bottom: 0; }

/* ---------- kpi ---------- */
.kpis {
  display: grid; gap: 1px; margin: 40px 0 0;
  background: var(--line); border: 1px solid var(--line); border-radius: 3px;
  grid-template-columns: repeat(auto-fit, minmax(170px, 1fr)); overflow: hidden;
}
.kpi { background: var(--surface); padding: 18px 18px 16px; }
.kpi__n {
  font-family: "IBM Plex Mono", monospace; font-size: 1.85rem; line-height: 1.1;
  font-variant-numeric: tabular-nums; letter-spacing: -.02em; display: block;
}
.kpi__n small { font-size: .95rem; color: var(--muted); letter-spacing: 0; }
.kpi__l { font-size: 12.5px; color: var(--muted); margin-top: 6px; display: block; line-height: 1.45; }
.kpi--gain .kpi__n { color: var(--gain); }
.kpi--accent .kpi__n { color: var(--accent); }
.kpi--warn .kpi__n { color: var(--warn); }

/* ---------- sections ---------- */
.sec { margin-top: 64px; }
.sec__head { margin-bottom: 20px; }
.eyebrow { margin: 0 0 10px; }
.eyebrow__src {
  font-family: "IBM Plex Mono", monospace; font-size: 10.5px;
  letter-spacing: .13em; text-transform: uppercase;
  color: var(--accent); background: var(--accent-soft);
  padding: 4px 9px; border-radius: 2px;
}
.sec h2 {
  font-family: Newsreader, ui-serif, Georgia, serif; font-weight: 400;
  font-size: clamp(1.42rem, 3vw, 1.85rem); line-height: 1.2;
  letter-spacing: -.01em; margin: 0 0 10px; text-wrap: balance;
}
.lede { margin: 0; color: var(--ink-2); max-width: 74ch; }
.lede code, .note code, td code {
  font-family: "IBM Plex Mono", monospace; font-size: .88em;
  background: var(--quiet-soft); padding: 1px 5px; border-radius: 2px;
}
h3.sub {
  font-size: .78rem; letter-spacing: .1em; text-transform: uppercase;
  color: var(--muted); margin: 34px 0 12px; font-weight: 600;
}

/* ---------- tables ---------- */
.scroll { overflow-x: auto; border: 1px solid var(--line); border-radius: 3px; background: var(--surface); box-shadow: var(--shadow); }
table { width: 100%; border-collapse: collapse; font-size: 13.5px; }
thead th {
  text-align: left; font-weight: 600; font-size: 10.5px; letter-spacing: .1em;
  text-transform: uppercase; color: var(--muted); padding: 11px 14px;
  border-bottom: 1px solid var(--line); background: var(--surface-2);
  white-space: nowrap; position: sticky; top: 0;
}
tbody td { padding: 11px 14px; border-bottom: 1px solid var(--line-soft); vertical-align: top; color: var(--ink-2); }
tbody tr:last-child td { border-bottom: 0; }
tbody tr:hover td { background: var(--surface-2); }
td.num, th.num { text-align: right; font-family: "IBM Plex Mono", monospace; font-variant-numeric: tabular-nums; white-space: nowrap; }
td.delta { font-family: "IBM Plex Mono", monospace; color: var(--gain); font-weight: 600; white-space: nowrap; }
td.id { font-family: "IBM Plex Mono", monospace; color: var(--muted); white-space: nowrap; }
td.title { min-width: 260px; color: var(--ink); }
td.wide { min-width: 300px; }
td.nowrap { white-space: nowrap; }

/* ---------- bars ---------- */
.bar { display: flex; width: 108px; height: 8px; border-radius: 2px; overflow: hidden; background: var(--quiet-soft); margin-top: 5px; }
.bar__base { background: var(--quiet); opacity: .5; }
.bar__gain { background: var(--gain); }
.bar__rest { background: transparent; }

/* ---------- pills ---------- */
.pill {
  display: inline-block; font-size: 11px; letter-spacing: .02em;
  padding: 2px 8px; border-radius: 2px; white-space: nowrap;
  font-family: "IBM Plex Mono", monospace;
}
.pill--done { background: var(--gain-soft); color: var(--gain); }
.pill--active { background: var(--accent-soft); color: var(--accent); }
.pill--planned { background: var(--warn-soft); color: var(--warn); }
.pill--neutral { background: var(--quiet-soft); color: var(--ink-2); }
.pill--quiet { background: var(--quiet-soft); color: var(--quiet); }

/* ---------- misc ---------- */
.empty { color: var(--muted); font-style: italic; }
.dash { color: var(--quiet); }
.reconcile {
  margin: 20px 0 0; padding: 14px 18px; font-size: 13.5px; color: var(--ink-2);
  background: var(--surface); border: 1px solid var(--line); border-radius: 3px;
  max-width: none; box-shadow: var(--shadow);
}
.reconcile strong { font-family: "IBM Plex Mono", monospace; color: var(--ink); font-variant-numeric: tabular-nums; }
.reconcile span { color: var(--muted); padding: 0 2px; }
.sub-note { display: block; font-family: "IBM Plex Mono", monospace; font-size: 10px; color: var(--muted); margin-top: 2px; }
.split { display: grid; gap: 20px; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); }
.card { background: var(--surface); border: 1px solid var(--line); border-radius: 3px; padding: 20px; box-shadow: var(--shadow); }
.card h4 { margin: 0 0 12px; font-size: .78rem; letter-spacing: .1em; text-transform: uppercase; color: var(--muted); }
.card ul { margin: 0; padding-left: 18px; color: var(--ink-2); }
.card li { margin-bottom: 7px; }
.card li:last-child { margin-bottom: 0; }
.spark { display: flex; align-items: flex-end; gap: 3px; height: 44px; margin-top: 10px; }
.spark span { flex: 1; background: var(--accent); opacity: .8; border-radius: 1px 1px 0 0; min-height: 2px; }
.spark--legend { display: flex; justify-content: space-between; font-family: "IBM Plex Mono", monospace; font-size: 10px; color: var(--muted); margin-top: 6px; }
pre {
  margin: 0; padding: 14px 16px; overflow-x: auto;
  background: var(--surface-2); border: 1px solid var(--line); border-radius: 3px;
  font-family: "IBM Plex Mono", monospace; font-size: 12.5px; color: var(--ink-2);
}
footer.foot { margin-top: 72px; padding-top: 22px; border-top: 1px solid var(--line); color: var(--muted); font-size: 12.5px; }
footer.foot p { margin: 0 0 6px; }
@media (prefers-reduced-motion: reduce) { * { transition: none !important; animation: none !important; } }
"""


def render(fb, inter, since, until, cadence_rows=None):
    """Build the page body (no <html>/<head> wrapper — the host adds it)."""
    import datetime as _dt
    parts = []
    days_span = (_dt.date.fromisoformat(until) - _dt.date.fromisoformat(since)).days
    span = f"{days_span // 7} weeks" if days_span % 7 == 0 else f"{days_span} days"

    def mentions_cell(row):
        if row.get("mention_delta"):
            ids = ", ".join(f"#{i}" for i in row.get("insight_ids", []))
            return (f'<span class="delta">+{row["mention_delta"]}</span>'
                    f'<span class="sub-note">{esc(ids)}</span>')
        return '<span class="dash">—</span>'

    # ---------------------------------------------------------- masthead
    src_cards = [
        ("Baseline", f"{fb['baseline_date']} · {fb['baseline_post_count']} posts"),
        ("Now", f"{fb['current_date']} · {fb['current_post_count']} posts"),
        ("Window", f"{since} → {until} · {span}"),
        ("Pipeline", f"{fb['in_pipeline_count']} posts planned or in progress"),
    ]
    sources = "".join(
        f'<div class="src"><span class="src__k">{esc(k)}</span>'
        f'<span class="src__v">{esc(v)}</span></div>' for k, v in src_cards)

    parts.append(f"""<header class="mast">
  <p class="mast__kicker">Noxtua · Featurebase change report</p>
  <h1>What moved on the boards <em>since {esc(since)}</em></h1>
  <p class="mast__sub">Every item here is a Featurebase post, and its board status is the
  pipeline status. The insights database is the intermediary that feeds the boards: it
  contributes how often each need was voiced again, and the backlog of needs that never
  reached a board. Nothing else from it is reported.</p>
  <div class="sources">{sources}</div>
</header>""")

    # ---------------------------------------------------------- caveat
    notes = []
    if fb["transferred_count"]:
        days_txt = ", ".join(f"{esc(d)} ({n})" for d, n in fb["transferred_by_day"].items())
        notes.append(f"""<p><strong>{fb['transferred_count']} posts absent from the baseline are
    excluded from the intake numbers.</strong> They were created on {days_txt} — the bulk transfer
    of already-collected research onto the boards, which ran within hours of the baseline
    snapshot. Counting them as newly gathered feedback would overstate intake roughly
    fiftyfold. Everything from {esc(fb['new_since'])} onward is organic.</p>""")
    if not fb["baseline_has_status"]:
        notes.append(f"""<p>The {esc(fb['baseline_date'])} baseline stores no board status — the
    snapshot script read <code>postStatus</code> where the API returns <code>status</code>.
    Fixed now, so <strong>status moves cannot be diffed for this window</strong> and the
    pipeline below is a current-state read. Snapshots from {esc(fb['current_date'])} onward
    carry status, tags, ETA and post URLs.</p>""")
    notes.append("""<p>Upvote timing cannot be narrowed below the span between the two snapshots:
    a vote does not bump a post's <code>updatedAt</code>. The vote deltas below are exactly
    &ldquo;since the baseline&rdquo;, which is this window.</p>""")
    parts.append(f"""<div class="note">
  <h3>Read this before the numbers</h3>
  {''.join(notes)}
</div>""")

    # ---------------------------------------------------------- KPIs
    kpis = [
        ("accent", len(fb["new_posts"]), "", "newly gathered posts"),
        ("gain", len(fb["vote_gains"]), "", "posts gained upvotes"),
        ("gain", sum(r["delta"] for r in fb["vote_gains"]), "", "upvotes added"),
        ("gain", inter["posts_with_new_mentions"], "", "posts whose need was voiced again"),
        ("accent", fb["in_pipeline_count"], "", "posts planned or in progress"),
        ("warn", len(inter["backlog"]), "", "open needs not yet on any board"),
    ]
    parts.append('<div class="kpis">' + "".join(
        f'<div class="kpi kpi--{kind}"><span class="kpi__n">{n}</span>'
        f'<span class="kpi__l">{label}</span></div>'
        for kind, n, _sfx, label in kpis) + "</div>")

    parts.append(f"""<p class="reconcile"><strong>{fb['baseline_post_count']}</strong> at the
    baseline <span>+</span> <strong>{fb['transferred_count']}</strong> transferred
    <span>+</span> <strong>{len(fb['new_posts'])}</strong> newly gathered
    <span>=</span> <strong>{fb['current_post_count']}</strong> on the boards now. That is the
    only partition on this page. Every table below is a lens on the same posts, so one post can
    appear in several of them — Outlook Add-In gained 3 votes <em>and</em> 1 comment, and is in
    the pipeline. No table repeats a post within itself.</p>""")

    # ---------------------------------------------------------- 1. intake
    days = list(fb["new_by_day"].items())
    peak = max((n for _, n in days), default=1)
    spark = "".join(f'<span style="height:{max(6, round(100 * n / peak))}%" '
                    f'title="{esc(d)}: {n}"></span>' for d, n in days)
    board_rows = [(esc(b), f'<span class="num">{n}</span>')
                  for b, n in sorted(fb["new_by_board"].items(), key=lambda x: -x[1])]
    new_rows = [(esc(p["created"]), f'<span class="num">{p["votes"]}</span>',
                 esc(p["board"]), pill(p["status"] or "—", fb_status_kind(p["status"])),
                 link(p["title"], p["url"], 88), esc(", ".join(p["tags"]) or "—"))
                for p in fb["new_posts"]]
    body = f"""<div class="split">
  <div class="card">
    <h4>New posts per board</h4>
    {table(["Board", '<span class="num">Posts</span>'], board_rows)}
  </div>
  <div class="card">
    <h4>When they were created</h4>
    <div class="spark">{spark}</div>
    <div class="spark--legend"><span>{esc(days[0][0]) if days else ''}</span>
    <span>{esc(days[-1][0]) if days else ''}</span></div>
    <p class="lede" style="margin-top:12px;font-size:13px">Organic intake only — the
    {esc(fb['new_since'])} cut keeps the bulk transfer out.</p>
  </div>
</div>
<h3 class="sub">Every newly gathered post</h3>
{table(["Created", '<span class="num">Votes</span>', "Board", "Status", "Post", "Squad tags"], new_rows)}"""
    if fb["disappeared"]:
        body += ('<h3 class="sub">In the baseline, gone now</h3>'
                 + table(["Board", '<span class="num">Votes</span>', "Title"],
                         [(esc(p["board"]), f'<span class="num">{p["votes"]}</span>',
                           esc(p["title"])) for p in fb["disappeared"]])
                 + '<p class="lede" style="margin-top:10px;font-size:13px">Deleted, merged, or '
                   'moved to a board the snapshot does not cover.</p>')
    parts.append(section(1, "Intake", "What new feedback we gathered",
                         f"Posts created on the boards from {esc(fb['new_since'])} onward. "
                         f"{fb['transferred_count']} bulk-transferred posts are excluded.", body))

    # ---------------------------------------------------------- 2. weight
    scale = max((r["to"] for r in fb["vote_gains"]), default=1)
    rows = [(f'<span class="delta">+{r["delta"]}</span>',
             f'<span class="num">{r["from"]} → {r["to"]}</span>{bar(r["from"], r["delta"], scale)}',
             mentions_cell(r),
             pill(r["status"] or "—", fb_status_kind(r["status"])),
             esc(r["board"]), link(r["title"], r["url"], 70),
             esc(", ".join(r["tags"]) or "—"))
            for r in fb["vote_gains"]]
    body = table(['<span class="num">Δ votes</span>', '<span class="num">Votes</span>',
                  '<span class="num">Δ mentions</span>', "Status", "Board", "Post",
                  "Squad tags"], rows)
    seen = {r["id"] for r in fb["vote_gains"]} | {p["id"] for p in fb["new_posts"]}
    mention_only = sorted([v for pid, v in inter["by_post"].items() if pid not in seen],
                          key=lambda v: -v["delta"])
    if mention_only:
        body += ('<h3 class="sub">Gained mentions but no votes</h3>'
                 + table(['<span class="num">Δ mentions</span>', '<span class="num">Votes</span>',
                          "Status", "Board", "Post", "Insight IDs"],
                         [(f'<span class="delta">+{v["delta"]}</span>',
                           f'<span class="num">{v["votes"]}</span>',
                           pill(v["status"], fb_status_kind(v["status"])), esc(v["board"]),
                           link(v["title"], v["url"], 66),
                           f'<span class="id">'
                           + ", ".join(f"#{i}" for i in v["insight_ids"]) + "</span>")
                          for v in mention_only])
                 + '<p class="lede" style="margin-top:12px;font-size:13px">The need was voiced '
                   "again in research, but nobody upvoted it on the board.</p>")
    if fb["comment_gains"]:
        body += ('<h3 class="sub">New discussion — comments, not votes</h3>'
                 + table(['<span class="num">Δ comments</span>',
                          '<span class="num">Comments</span>', '<span class="num">Votes</span>',
                          "Board", "Post"],
                         [(f'<span class="delta">+{r["delta"]}</span>',
                           f'<span class="num">{r["from"]} → {r["to"]}</span>',
                           f'<span class="num">{r["votes"]}</span>', esc(r["board"]),
                           link(r["title"], r["url"], 74)) for r in fb["comment_gains"]]))
    parts.append(section(2, "Demand", "Which feedback gained weight",
                         f"{len(fb['vote_gains'])} of the {fb['baseline_post_count']} posts that "
                         "already existed at the baseline gained upvotes, and none lost any. The "
                         "bar shows the baseline count in grey, the gain in green. Δ mentions is "
                         "the intermediary's count of the same need being voiced again by a "
                         "separate customer.", body))

    # ---------------------------------------------------------- 3. pipeline
    body = table(["Board / status", '<span class="num">Posts</span>'],
                 [(esc(k), f'<span class="num">{v}</span>') for k, v in fb["pipeline_now"].items()])
    if fb["baseline_has_status"]:
        body += ('<h3 class="sub">Status moves in this window</h3>'
                 + table(["From", "To", "Advanced?", '<span class="num">Votes</span>', "Post"],
                         [(pill(m["from"] or "—", fb_status_kind(m["from"])),
                           pill(m["to"], fb_status_kind(m["to"])),
                           "yes" if m["advanced"] else "no",
                           f'<span class="num">{m["votes"]}</span>',
                           link(m["title"], m["url"], 70)) for m in fb["status_moves"]]))
    def gain_table(rows):
        return table(['<span class="num">Δ votes</span>', '<span class="num">Votes now</span>',
                      '<span class="num">Δ mentions</span>', "Status", "Post"],
                     [(f'<span class="delta">+{r["delta"]}</span>',
                       f'<span class="num">{r["to"]}</span>', mentions_cell(r),
                       pill(r["status"], fb_status_kind(r["status"])),
                       link(r["title"], r["url"], 72)) for r in rows])

    in_flight = [r for r in fb["vote_gains"]
                 if r["status_type"] in ("unstarted", "active")]
    if in_flight:
        body += ('<h3 class="sub">In the pipeline and gaining demand — delivery and demand agree</h3>'
                 + gain_table(in_flight))
    shipped = [r for r in fb["vote_gains"] if r["status_type"] == "completed"]
    if shipped:
        body += ('<h3 class="sub">Already shipped, still gaining votes</h3>'
                 + gain_table(shipped)
                 + '<p class="lede" style="margin-top:12px;font-size:13px">Demand kept arriving '
                   "after release — worth checking whether the shipped version covers it.</p>")
    promote = [r for r in fb["vote_gains"]
               if r["status_type"] == "reviewing" and r["to"] >= 10]
    if promote:
        body += ('<h3 class="sub">Gained votes, now ≥10, still in review — promotion candidates</h3>'
                 + gain_table(promote))
    parts.append(section(3, "Pipeline", "What is in development, and what should be",
                         "Board status is the pipeline status — nothing here is inferred from "
                         "the research database.", body))

    # ---------------------------------------------------------- 4. backlog
    rows = [(f'<span class="num">{r["mentions"]}</span>',
             (f'<span class="delta">+{r["delta"]}</span>' if r["delta"]
              else '<span class="dash">—</span>'),
             pill(short_status(r["status"]), db_status_kind(r["status"])),
             esc(r["insight"][:96] + ("…" if len(r["insight"]) > 96 else "")),
             esc(r["segment"]))
            for r in inter["backlog"]]
    body = table(['<span class="num">Mentions</span>', '<span class="num">Δ window</span>',
                  "Research status", "Need", "Segment"], rows)
    body += f"""<div class="split" style="margin-top:26px">
  <div class="card"><h4>Why {inter['not_on_board']} records are off-board</h4><ul>
    <li><strong>{len(inter['delivered_off_board'])}</strong> are marked implemented or well done —
    already delivered, so their absence is correct by the rule that implemented insights are never
    pushed. The five most-voiced needs in the whole database sit here, including
    &ldquo;a reliable data base as the source of the answers&rdquo; at 71 mentions.</li>
    <li><strong>{len(inter['backlog'])}</strong> are open and cannot collect votes — the table
    above.</li>
    <li>Resolution is by stored <code>featurebase_id</code> or exact post title, so a post
    retitled after being pushed shows up here as absent.</li>
  </ul></div>
  <div class="card"><h4>What to do with the open ones</h4><ul>
    <li>Seven carry a JIRA ticket already — they are being worked without a board post, so
    customers cannot see or vote on them.</li>
    <li>Five are the Vattenfall churn findings: pricing and competitive loss, which are
    commercial signal rather than feature requests and may not belong on a board at all.</li>
    <li>The rest are single-mention intake from the last two merges — the normal push queue.</li>
  </ul></div>
</div>"""
    parts.append(section(4, "Backlog", "Open needs not yet on a board",
                         f"{inter['not_on_board']} of the intermediary's "
                         f"{inter['record_count']} records have no board post, but most of that is "
                         f"expected: {len(inter['delivered_off_board'])} are already delivered. "
                         f"These {len(inter['backlog'])} are open and invisible to the pipeline.",
                         body))

    # ---------------------------------------------------------- 5. cadence
    if cadence_rows:
        body = table(["Cadence", "What runs", "Output", "Audience"],
                     [(esc(a), esc(b), esc(c), esc(d)) for a, b, c, d in cadence_rows]) + """
<h3 class="sub">The one command, every Tuesday morning</h3>
<pre>python3 featurebase_snapshot.py          # commit it — it is the baseline four weeks from now
python3 feedback_change_report.py \\
    --baseline featurebase_snapshot_&lt;four weeks ago&gt;.json \\
    --current  featurebase_snapshot_&lt;today&gt;.json \\
    --since    &lt;today minus 28 days&gt; \\
    --fb-new-since &lt;day after any bulk push in the window&gt;
# -&gt; reports/feedback_changes_&lt;today&gt;.md | .json | .html</pre>
<p class="lede" style="margin-top:14px">First run: <strong>Tuesday 2026-08-25</strong>, baselined
on the 2026-07-31 snapshot, so it covers a hair under four weeks. From 2026-09-22 every run has a
true four-week-old baseline to diff against.</p>
<div class="split" style="margin-top:26px">
  <div class="card"><h4>Rules that keep the numbers honest</h4><ul>
    <li><strong>Snapshot weekly, report four-weekly.</strong> A diff is only as old as the oldest
    snapshot kept — this report had to start at 2026-07-31 because that was the only one in the
    repo. Take one every Tuesday even in weeks nothing is reported.</li>
    <li><strong>Separate transfers from demand.</strong> Pass <code>--fb-new-since</code> for any
    window containing a bulk push; any day with more than ~20 new posts is a migration.</li>
    <li><strong>Read votes from the boards, never from the intermediary.</strong> The cached
    <code>featurebase_votes</code> in insights.json is frozen at push time.</li>
    <li><strong>Count mentions from history, not totals.</strong> <code>mentionHistory</code>
    stores cumulative counts; the delta is the step between entries.</li>
  </ul></div>
  <div class="card"><h4>What sprint review should see each time</h4><ul>
    <li>Newly gathered posts, with the bulk transfers called out separately.</li>
    <li>Vote and mention gains ranked by delta, not by total.</li>
    <li>Status moves in both directions — regressions matter as much as advances.</li>
    <li>Promotion candidates: gained votes, above threshold, still in review.</li>
    <li>The backlog of needs never pushed onto a board.</li>
  </ul></div>
</div>"""
        parts.append(section(5, "Proposal", "How this gets reported from now on",
                             "Four-week window, refreshed every Tuesday for sprint review, "
                             "starting 2026-08-25.", body))

    parts.append(f"""<footer class="foot">
  <p>Generated by <code>feedback_change_report.py</code> from
  <code>featurebase_snapshot_{esc(fb['current_date'])}.json</code>, diffed against
  <code>featurebase_snapshot_{esc(fb['baseline_date'])}.json</code>, with mention counts and
  backlog from <code>insights.json</code>. Window {esc(since)} → {esc(until)}.</p>
  <p>Boards: Feedback, Missing Feature (Feature Request), Product. Votes and statuses read live
  from the Featurebase API on {esc(until)}.</p>
</footer>""")

    head = ('<title>Noxtua Feedback Delta</title>\n'
            '<link rel="preconnect" href="https://fonts.googleapis.com">\n'
            '<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>\n'
            '<link rel="stylesheet" href="https://fonts.googleapis.com/css2?'
            'family=Newsreader:ital,opsz,wght@0,6..72,400;1,6..72,400&'
            'family=IBM+Plex+Sans:wght@400;600&family=IBM+Plex+Mono:wght@400;600&display=swap">\n'
            f"<style>{CSS}</style>")
    return head + '\n<div class="wrap">\n' + "\n".join(parts) + "\n</div>\n"
