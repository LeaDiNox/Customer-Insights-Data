#!/usr/bin/env python3
"""Build Confluence page bodies (HTML+) for roadmap x research pages,
mirroring the finalized reference page 'Implement UI language selector'."""
import html as H
import json

NONE = "— (none on file)"

def esc(s):
    return H.escape("" if s is None else str(s), quote=False)

def status(label, color):
    return '<span data-type="status" data-color="%s" data-status-style="bold">%s</span>' % (color, esc(label))

def link(url):
    return '<a href="%s" data-card-appearance="inline">%s</a>' % (url, url)

def table(headers, rows, widths=None):
    ths = []
    for i, h in enumerate(headers):
        w = ' data-colwidth="%s"' % widths[i] if widths else ''
        ths.append('<th%s><p>%s</p></th>' % (w, esc(h)))
    if rows:
        body = "".join("<tr>" + "".join("<td><p>%s</p></td>" % c for c in r) + "</tr>" for r in rows)
    else:
        body = ('<tr><td colspan="%d"><p><em>— nothing identified in this run —</em></p></td></tr>'
                % len(headers))
    return '<table data-width="760"><thead><tr>%s</tr></thead><tbody>%s</tbody></table>' % ("".join(ths), body)

def excerpt_open(name):
    params = json.dumps({"macroParams": {"name": {"value": name}}}, ensure_ascii=False)
    return ('<div data-type="bodied-extension" data-extension-key="excerpt"'
            ' data-extension-type="com.atlassian.confluence.macro.core"'
            ' data-parameters="%s">' % H.escape(params, quote=True))

def build(it):
    o = []
    o.append(excerpt_open("Roadmap Item %s" % it["excerpt_name"]))
    o.append('<div data-type="panel-custom" data-icon=":compass:" data-color="#F4F5F7"'
             ' data-icon-id="1f9ed" data-icon-text="\U0001F9ED">')
    o.append('<p><strong>📌 Roadmap item:</strong> %s · Insight ID %s · %d vote%s</p>'
             % (link(it["url"]), esc(it["insight_id"]), it["votes"], "" if it["votes"] == 1 else "s"))
    o.append('<p><strong>☑  Status:</strong> %s <em>(pulled live from the Featurebase API — status “%s”)</em></p>'
             % (status("Next up", "blue"), esc(it["api_status"])))
    o.append('<p><strong>👤Assignee (PM):</strong> %s</p>' % it["assignee"])
    o.append('<p><strong>📝 Description:</strong> “%s”</p>' % esc(it["description"]))
    o.append('<p><strong>🗺️ User journey moment(s):</strong> <span data-type="placeholder">to be added</span></p>')
    o.append('<p>🚥 <strong>Research Coverage &amp; Priority:</strong> %s / %s </p>'
             % (status(it["coverage"], it["coverage_color"]), status(it["priority"], it["priority_color"])))
    o.append('<p>⏭️ <strong>Next Research Step:</strong> %s</p>' % esc(it["next_step"]))
    o.append('</div><p></p></div>')

    o.append('<hr>')
    o.append('<h2>✅ SOLVES (will be merged)</h2>')
    o.append(table(["Insight ID", "Description", "Mentions (votes)", "Citation", "User group(s)"], it["solves"]))

    o.append('<hr>')
    o.append('<h2>🔗 RELATES TO (not merged)</h2>')
    o.append(table(["Insight ID", "Description", "Mentions (votes)", "Citation", "User group(s)", "Featurebase link"], it["relates"]))

    o.append('<hr>')
    o.append('<h2>🚩 NOT (YET) IN FEATUREBASE</h2>')
    o.append(table(["Insight ID", "Description", "Mentions", "Citation", "User group(s)", "Suggested action"], it["notyet"]))

    o.append('<hr>')
    o.append('<h2>🧾BROADER SCOPE IN LEGAL WORKFLOW</h2>')
    o.append('<p><em>In which legal workflow needs our solution to embedd into?</em></p>')
    for para in it["broader"]:
        o.append('<p>%s</p>' % para)

    o.append('<hr>')
    o.append('<h2>🔍 OPEN RESEARCH QUESTIONS</h2>')
    o.append('<p><em>Mirrored to the </em>%s<em> database — see note below on current sync limitations.</em>'
             % link("https://xainag.atlassian.net/wiki/spaces/Product/database/4843601928"))
    o.append('</p>')
    o.append(table(["Question", "Category", "Recommended Approach",
                    "Risk without/ Expected Impact with Research", "Status"],
                   it["questions"], widths=[195, 108, 152, 234, 69]))

    o.append('<hr>')
    o.append('<div data-type="panel-note"><p><strong>Review log:</strong> Drafted by Claude Code, %s → pending Lea’s review &amp; approval. '
             'No Featurebase merge and no FYI comment has been executed for this page yet.</p></div>' % it["date"])
    return "".join(o)
