# Weekly Routine — setup values

The Routine that runs this skill every week. Created 2026-08-19 as
`trig_01E8uXKD4m31nqJBPqSwu19n` and left **disabled**, because a Routine created from
inside a Claude Code session cannot attach connectors or repository sources — so the
fired session would have had no Confluence access and no checkout.

Fix it in the claude.ai Routines UI. The end state must be:

| Setting | Value |
|---|---|
| Schedule | Weekly, **Friday 15:00 Europe/Berlin** (stored as cron `0 13 * * 5`, UTC) |
| Connector | **Atlassian** — required, this is what writes the Confluence pages |
| Repository / source | **LeaDiNox/Customer-Insights-Data** — required, provides the skill and `insights.json` |
| Environment | the same one the "Featurebase feedback sync" Routine uses |
| Notifications | push + email |
| Enabled | yes |

The existing **"Featurebase feedback sync"** Routine already has the right connector and
source attached — use it as the reference when filling these in.

Note: cron is evaluated in UTC, so `0 13 * * 5` is 15:00 Berlin during summer time and
14:00 Berlin once the clocks go back in late October. Adjust to `0 14 * * 5` then if the
15:00 slot matters.

## Prompt

Paste this as the Routine's message:

---

Run the weekly Roadmap ↔ Feedback review for Noxtua. Invoke the `roadmap-feedback-review` skill in the LeaDiNox/Customer-Insights-Data repo (`.claude/skills/roadmap-feedback-review/SKILL.md`) and follow it exactly.

In short:
1. Pull the Featurebase boards live via the API (never the local snapshot files). The "Next up" roadmap column is API status `Planned` on the Product Board.
2. For each Next-up item without a Confluence page yet, match it against the Feature Request board, the Feedback board, and the Product Board posts still in `In Review` / `Reviewed`, plus `insights.json`. Classify into Solves / Relates to / Not (yet) in Featurebase and build the page from the template, nested under the live parent of the reference page "Implement UI language selector" (re-derive the parent each run — it moves).
3. Refresh every page that already exists under that parent: live vote counts, status and assignee, posts created since the page was written, rows that have changed bucket — and say what the shift means, not just the new numbers. Add a short info panel at the top recording what changed.

Two hard rules:
- An insight whose status in insights.json is "Implemented - a solution is released" or "Well done - positive feedback outweighs negative" is deliberately absent from Featurebase. Never put it in the Not-yet-in-Featurebase table, never suggest pushing it, never merge it. List it under Relates to marked as already implemented. If such an insight's complaint still shows up in a recent Featurebase quote, flag that contradiction as a research question.
- This run produces drafts only. Do NOT execute any Featurebase merge, do NOT post any Featurebase comment, and do NOT post any Confluence comment. Those happen only after Lea has explicitly approved that specific page.

Report back to Lea with two lists — pages newly created and pages updated — each with links, plus the proposed merges and anything that looked off in the data (Next-up items with no assignee or no Insights ID, Featurebase Insight IDs missing from or contradicting the local insights.json).

---

## Checking it works

Trigger one run manually from the UI rather than waiting for Friday. A healthy run:

- reads the Featurebase boards (needs `FEATUREBASE_API_KEY`, already in `.claude/settings.json`),
- finds the "Roadmap x Research" parent page by looking up the reference page's `parentId`,
- creates or refreshes pages under it,
- reports back without having merged or commented anywhere.

If it reports that it cannot reach Confluence, the Atlassian connector did not attach.
If it cannot find the skill or `insights.json`, the repository source did not attach.
