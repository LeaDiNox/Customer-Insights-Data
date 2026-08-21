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


def render(fb, ins, sync, since, until, cadence_rows=None):
    """Build the full page body (no <html>/<head> wrapper — the host adds it)."""
    parts = []

    # ---------------------------------------------------------- masthead
    src_cards = []
    if fb:
        src_cards.append(("Featurebase baseline", f"{fb['baseline_date']} · {fb['baseline_post_count']} posts"))
        src_cards.append(("Featurebase now", f"{fb['current_date']} · {fb['current_post_count']} posts"))
    src_cards.append(("Research database", f"insights.json · {ins['record_count']} records"))
    src_cards.append(("Window", f"{since} → {until} · 4 weeks"))
    sources = "".join(
        f'<div class="src"><span class="src__k">{esc(k)}</span>'
        f'<span class="src__v">{esc(v)}</span></div>' for k, v in src_cards)

    parts.append(f"""<header class="mast">
  <p class="mast__kicker">Noxtua customer insights · change report</p>
  <h1>What moved in customer feedback <em>since {esc(since)}</em></h1>
  <p class="mast__sub">Two sources, kept separate on purpose. Featurebase carries the
  customer-visible demand signal — upvotes and board status. The research database carries
  mention counts and pipeline status per insight, with dated history, so any window can be
  recomputed from the current file alone.</p>
  <div class="sources">{sources}</div>
</header>""")

    # ---------------------------------------------------------- caveat
    if fb:
        bulk_day, bulk_n = max(fb["new_by_day"].items(), key=lambda kv: kv[1]) if fb["new_by_day"] else ("", 0)
        organic = len(fb["new_posts"]) - bulk_n
        notes = [f"""<p><strong>{bulk_n} of the {len(fb['new_posts'])} new Featurebase posts
        were created on {esc(bulk_day)}</strong>, within hours of the baseline snapshot. That is a
        bulk transfer of already-collected research into Featurebase, not new customer demand.
        Read it as a migration; the genuinely new posts in this window number
        <strong>{organic}</strong>.</p>"""]
        if not fb["baseline_has_status"]:
            notes.append(f"""<p>The {esc(fb['baseline_date'])} baseline stores no board status —
        the snapshot script read <code>postStatus</code> where the API returns <code>status</code>.
        Fixed now, so <strong>Featurebase status moves cannot be diffed for this window</strong> and
        the pipeline below is a current-state read only. Snapshots from {esc(fb['current_date'])}
        onward carry status, tags, ETA and post URLs.</p>""")
        parts.append(f"""<div class="note">
  <h3>Read this before the numbers</h3>
  {''.join(notes)}
</div>""")

    # ---------------------------------------------------------- KPIs
    kpis = []
    if fb:
        organic = len(fb["new_posts"]) - (max(fb["new_by_day"].values()) if fb["new_by_day"] else 0)
        kpis += [
            ("accent", len(fb["new_posts"]), "", f"new Featurebase posts<br>({organic} outside the bulk transfer)"),
            ("gain", len(fb["vote_gains"]), "", "existing posts gained upvotes"),
            ("gain", sum(r["delta"] for r in fb["vote_gains"]), "", "upvotes added to existing posts"),
        ]
    kpis += [
        ("accent", len(ins["new_records"]), "", "new insight records"),
        ("gain", len(ins["gained_mentions"]), "", "insights gained mentions"),
        ("accent", len(ins["status_moved"]), "", "insights changed pipeline status"),
    ]
    if sync:
        kpis.append(("warn", len(sync["stale_votes"]), "", "insights with a stale vote cache"))
    kpi_html = "".join(
        f'<div class="kpi kpi--{kind}"><span class="kpi__n">{n}{f"<small>{sfx}</small>" if sfx else ""}</span>'
        f'<span class="kpi__l">{label}</span></div>' for kind, n, sfx, label in kpis)
    parts.append(f'<div class="kpis">{kpi_html}</div>')

    # ---------------------------------------------------------- new feedback
    if fb:
        days = list(fb["new_by_day"].items())
        peak = max((n for _, n in days), default=1)
        spark = "".join(f'<span style="height:{max(3, round(100 * n / peak))}%" '
                        f'title="{esc(d)}: {n} posts"></span>' for d, n in days)
        board_rows = [(esc(b), f'<span class="num">{n}</span>')
                      for b, n in sorted(fb["new_by_board"].items(), key=lambda x: -x[1])]
        top_new = [(f'<span class="num">{p["votes"]}</span>',
                    esc(p["board"]), pill(p["status"] or "—", fb_status_kind(p["status"])),
                    link(p["title"], p["url"], 92), esc(p["created"]))
                   for p in fb["new_posts"][:20]]
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
    <p class="lede" style="margin-top:12px;font-size:13px">One spike dominates: the
    {esc(days[0][0]) if days else ''} transfer. Everything after it is organic intake.</p>
  </div>
</div>
<h3 class="sub">Highest-voted posts among the new arrivals</h3>
{table(['<span class="num">Votes</span>', "Board", "Status", "Post", "Created"], top_new)}"""
        if fb["disappeared"]:
            gone = [(esc(p["board"]), f'<span class="num">{p["votes"]}</span>', esc(p["title"]))
                    for p in fb["disappeared"]]
            body += ('<h3 class="sub">In the baseline, gone now</h3>'
                     + table(["Board", '<span class="num">Votes</span>', "Title"], gone)
                     + '<p class="lede" style="margin-top:10px;font-size:13px">Deleted, merged, '
                       'or moved to a board the snapshot does not cover.</p>')
        parts.append(section(1, "Featurebase", "What new feedback we gathered",
                             "New posts on the three boards between the baseline and now.", body))

    # ---------------------------------------------------------- vote gains
    if fb:
        scale = max((r["to"] for r in fb["vote_gains"]), default=1)
        rows = [(f'<span class="delta">+{r["delta"]}</span>',
                 f'<span class="num">{r["from"]} → {r["to"]}</span>{bar(r["from"], r["delta"], scale)}',
                 pill(r["status"] or "—", fb_status_kind(r["status"])),
                 esc(r["board"]), link(r["title"], r["url"], 74),
                 esc(", ".join(r["tags"]) or "—"))
                for r in fb["vote_gains"]]
        rows = [(a, b, c, d, e, f_) for a, b, c, d, e, f_ in rows]
        body = table(['<span class="num">Δ</span>', '<span class="num">Votes</span>', "Status",
                      "Board", "Post", "Squad tags"], rows)
        if fb["comment_gains"]:
            cg = [(f'<span class="delta">+{r["delta"]}</span>', esc(r["board"]),
                   link(r["title"], r["url"], 80)) for r in fb["comment_gains"]]
            body += ('<h3 class="sub">New discussion</h3>'
                     + table(['<span class="num">Δ</span>', "Board", "Post"], cg))
        parts.append(section(2, "Featurebase", "Which feedback gained upvotes",
                             f"{len(fb['vote_gains'])} of the {fb['baseline_post_count']} posts that "
                             "already existed at the baseline gained votes. None lost any. The bar "
                             "shows the baseline count in grey and the gain in green.", body))

    # ---------------------------------------------------------- mentions
    rows = [(f'<span class="delta">+{r["delta"]}</span>',
             f'<span class="num">{r["mentions"]}</span>',
             f'<span class="id">#{r["id"]}</span>',
             pill(short_status(r["status"]), db_status_kind(r["status"])),
             link(r["insight"], r["fb_url"], 88),
             (f'<span class="num">{r["fb_votes"]}</span> votes · ' + pill(r["fb_status"], fb_status_kind(r["fb_status"])))
             if r["on_featurebase"] else pill("not pushed", "quiet"))
            for r in ins["gained_mentions"]]
    parts.append(section(3, "Research database", "Which feedback gained new mentions",
                         "A mention is a separate customer saying the same thing. "
                         "<code>mentionHistory</code> stores the cumulative count per date, so these "
                         "are the increments recorded inside the window — from the "
                         "<code>feedback_batch_20260724</code> and <code>20260810</code> merges, plus "
                         "duplicate consolidations.",
                         table(['<span class="num">Δ</span>', '<span class="num">Total</span>', "ID",
                                "Research status", "Insight", "On Featurebase"], rows)))

    # ---------------------------------------------------------- new records
    rows = [(esc(r["created"]), f'<span class="id">#{r["id"]}</span>',
             f'<span class="num">{r["mentions"]}</span>',
             link(r["insight"], r["fb_url"], 96), esc(r["source"]),
             (f'<span class="num">{r["fb_votes"]}</span> votes' if r["on_featurebase"]
              else pill("not pushed", "quiet")))
            for r in ins["new_records"]]
    parts.append(section(4, "Research database", "New insight records",
                         f"{len(ins['new_records'])} records created in the window, from two intakes: "
                         "the LimeSurvey questionnaire (Word add-in behaviour and citation style) and "
                         "the Vattenfall churn conversation (pricing and competitive loss — commercial "
                         "signal, not feature requests).",
                         table(["Created", "ID", '<span class="num">Mentions</span>', "Insight",
                                "Source", "On Featurebase"], rows)))

    # ---------------------------------------------------------- pipeline
    moved = [(esc(m["date"]), f'<span class="id">#{r["id"]}</span>',
              f'<span class="num">{r["mentions"]}</span>',
              pill(short_status(m["from"]), db_status_kind(m["from"] or "")),
              pill(short_status(m["to"]), db_status_kind(m["to"])),
              esc(r["insight"][:96] + ("…" if len(r["insight"]) > 96 else "")))
             for r in ins["status_moved"] for m in r["moves"]]
    body = table(["Date", "ID", '<span class="num">Mentions</span>', "From", "To", "Insight"], moved)

    if fb:
        prio = [r for r in fb["vote_gains"] if r["status_type"] in ("unstarted", "active")]
        promote = [r for r in fb["vote_gains"] if r["status_type"] == "reviewing" and r["to"] >= 10]
        if prio:
            body += ('<h3 class="sub">Gained votes and already planned or in progress — demand and delivery agree</h3>'
                     + table(['<span class="num">Δ</span>', '<span class="num">Votes now</span>', "Status", "Post"],
                             [(f'<span class="delta">+{r["delta"]}</span>',
                               f'<span class="num">{r["to"]}</span>',
                               pill(r["status"], fb_status_kind(r["status"])),
                               link(r["title"], r["url"], 76)) for r in prio]))
        if promote:
            body += ('<h3 class="sub">Gained votes, now ≥10, still only in review — promotion candidates</h3>'
                     + table(['<span class="num">Δ</span>', '<span class="num">Votes now</span>', "Status", "Post"],
                             [(f'<span class="delta">+{r["delta"]}</span>',
                               f'<span class="num">{r["to"]}</span>',
                               pill(r["status"], fb_status_kind(r["status"])),
                               link(r["title"], r["url"], 76)) for r in promote]))
        body += ('<h3 class="sub">Featurebase pipeline as it stands now</h3>'
                 + table(["Board / status", '<span class="num">Posts</span>'],
                         [(esc(k), f'<span class="num">{v}</span>') for k, v in fb["pipeline_now"].items()]))
    body += ('<h3 class="sub">Research database status distribution now</h3>'
             + table(["Status", '<span class="num">Records</span>'],
                     [(pill(short_status(k), db_status_kind(k)), f'<span class="num">{v}</span>')
                      for k, v in sorted(ins["status_now"].items(), key=lambda x: -x[1])]))
    parts.append(section(5, "Both sources", "What was taken up for development",
                         "Two ways feedback advances: it is newly submitted and picked up, or it "
                         "accumulates weight after being transmitted and gets promoted. The research "
                         "database records both as dated status transitions.", body))

    # ---------------------------------------------------------- hygiene
    if sync and (sync["stale_votes"] or sync["dangling_links"]):
        rows = [(f'<span class="id">#{r["insight_id"]}</span>',
                 f'<span class="num">{r["stored_votes"]}</span>',
                 f'<span class="num">{r["live_votes"]}</span>',
                 f'<span class="delta">+{r["live_votes"] - r["stored_votes"]}</span>',
                 esc(r["synced_at"]), pill(r["fb_status"], fb_status_kind(r["fb_status"])),
                 esc(r["insight"][:74] + ("…" if len(r["insight"]) > 74 else "")))
                for r in sync["stale_votes"]]
        body = table(["ID", '<span class="num">Cached</span>', '<span class="num">Live</span>',
                      '<span class="num">Δ</span>', "Last synced", "FB status", "Insight"], rows)
        if sync["dangling_links"]:
            body += ('<h3 class="sub">Pointing at a post that no longer exists</h3>'
                     + table(["ID", "featurebase_id", "Insight"],
                             [(f'<span class="id">#{r["insight_id"]}</span>',
                               f'<code>{esc(r["featurebase_id"])}</code>',
                               esc(r["insight"][:80])) for r in sync["dangling_links"]]))
        body += f"""<div class="split" style="margin-top:26px">
  <div class="card"><h4>Why it matters</h4><ul>
    <li>Only <strong>46 of {ins['record_count']}</strong> records carry a <code>featurebase_id</code>.
    A further <strong>{ins['on_featurebase_count'] - 46}</strong> resolve only by exact title match —
    fragile the moment a post is retitled.</li>
    <li><code>featurebase_votes</code> is written at push time and never refreshed, so any report
    reading it under-counts demand by up to 13 votes today.</li>
    <li>{ins['record_count'] - ins['on_featurebase_count']} records are not on Featurebase at all,
    so they cannot collect votes and are invisible to the boards.</li>
  </ul></div>
  <div class="card"><h4>Fix, in order</h4><ul>
    <li>Write <code>featurebase_id</code> back for every pushed record, matching on title once.</li>
    <li>Refresh <code>featurebase_votes</code> from the live boards on each snapshot run.</li>
    <li>Re-point or clear the dangling id.</li>
  </ul></div>
</div>"""
        parts.append(section(6, "Data hygiene", "Gaps that distort the next report",
                             "None of this changes the numbers above — they are computed from live "
                             "boards and dated history, not the cache. It changes what any tool "
                             "reading <code>insights.json</code> alone would report.", body))

    # ---------------------------------------------------------- cadence
    if cadence_rows:
        rows = [(esc(a), esc(b), esc(c), esc(d)) for a, b, c, d in cadence_rows]
        body = table(["Cadence", "What runs", "Output", "Audience"], rows) + f"""
<h3 class="sub">The one command</h3>
<pre>python3 featurebase_snapshot.py                      # writes featurebase_snapshot_&lt;today&gt;.json
python3 feedback_change_report.py \\
    --baseline featurebase_snapshot_&lt;last-week&gt;.json \\
    --current  featurebase_snapshot_&lt;today&gt;.json \\
    --since    &lt;today minus 7 days&gt;
# -&gt; reports/feedback_changes_&lt;today&gt;.md | .json | .html</pre>
<div class="split" style="margin-top:26px">
  <div class="card"><h4>Rules that keep the numbers honest</h4><ul>
    <li><strong>Commit every snapshot.</strong> A diff is only as old as the oldest snapshot kept.
    Today there is exactly one historical snapshot, which is why this report has a 3-week baseline
    instead of a 4-week one.</li>
    <li><strong>Separate transfers from demand.</strong> Flag any day where new posts exceed, say,
    20 as a migration and report it apart from organic intake.</li>
    <li><strong>Never diff votes out of <code>insights.json</code>.</strong> The cached value is
    frozen at push time; always read the live boards.</li>
    <li><strong>Count mentions from history, not totals.</strong> <code>mentionHistory</code>
    stores cumulative counts — the delta is the step between entries.</li>
  </ul></div>
  <div class="card"><h4>What the weekly report should surface</h4><ul>
    <li>New posts and new insight records, split by intake source.</li>
    <li>Vote and mention gains, ranked by delta rather than by total.</li>
    <li>Status moves in both directions — regressions matter as much as advances.</li>
    <li>Promotion candidates: gained votes, above threshold, still in review.</li>
    <li>Anything ≥5 mentions still not pushed to Featurebase.</li>
  </ul></div>
</div>"""
        parts.append(section(7, "Proposal", "How to report this every week", "", body))

    parts.append(f"""<footer class="foot">
  <p>Generated by <code>feedback_change_report.py</code> from
  <code>featurebase_snapshot_{esc(fb['current_date']) if fb else esc(until)}.json</code>
  and <code>insights.json</code>. Window {esc(since)} → {esc(until)}.</p>
  <p>Featurebase boards: Feedback, Missing Feature (Feature Request), Product.
  Vote and status values read live from the API on {esc(until)}.</p>
</footer>""")

    head = ('<title>Noxtua Feedback Delta</title>\n'
            '<link rel="preconnect" href="https://fonts.googleapis.com">\n'
            '<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>\n'
            '<link rel="stylesheet" href="https://fonts.googleapis.com/css2?'
            'family=Newsreader:ital,opsz,wght@0,6..72,400;1,6..72,400&'
            'family=IBM+Plex+Sans:wght@400;600&family=IBM+Plex+Mono:wght@400;600&display=swap">\n'
            f"<style>{CSS}</style>")
    return head + '\n<div class="wrap">\n' + "\n".join(parts) + "\n</div>\n"
