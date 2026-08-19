---
name: roadmap-feedback-review
description: Run the weekly Roadmap ↔ Feedback review — for every "Next up" roadmap item in Featurebase, match the feedback boards and the Noxtua insights database against it, classify into Solves / Relates to / Not yet in Featurebase, draft one Confluence page per item, and refresh the pages that already exist against current vote counts and newly created posts, for Lea's review. Use when Lea says "run the roadmap review", "weekly roadmap x research", "check Next up against feedback", or when the weekly Routine fires. Also use for a single item ("run the review for the DMS item"). Never merges or comments without Lea's explicit per-page approval.
---

# Weekly Roadmap ↔ Feedback Review

Produces one Confluence page per **Next up** roadmap item that shows which feedback
is solved by it, which merely relates, and which insights are still missing from
Featurebase — plus the open research questions the comparison surfaces.

**The review is a draft. Nothing is merged and no comment is posted until Lea
approves that specific page.** See [Strict review order](#strict-review-order).

## Verified environment (checked live 2026-08-19)

| Thing | Value |
|---|---|
| Featurebase API base | `https://do.featurebase.app/v2` |
| Auth | `Authorization: Bearer $FEATUREBASE_API_KEY` (set in `.claude/settings.json`) |
| Network policy | only `do.featurebase.app` is allowed outbound; Confluence must go through the Atlassian MCP tools |
| Confluence site | `xainag.atlassian.net`, space `Product` (spaceId `3926654984`) |
| Reference page | [Implement UI language selector](https://xainag.atlassian.net/wiki/spaces/Product/pages/4889313306) — the exact template to replicate |

Board IDs:

| Board | ID | Role in the review |
|---|---|---|
| Product Board | `6a422f49728db77bced50b63` | holds the roadmap items **and** incoming posts still in triage |
| Feature Request | `6a2123630535f655cfaec3cb` | match pool |
| Feedback | `6a213f3998f1621c64f747fb` | match pool |

Custom field IDs (`post.customFields`):

| Field | ID |
|---|---|
| Insights ID | `6a5122786ae5db6317c6f29b` |
| User Need | `6a51229aaa1b56234fed0d94` |
| Quotes | `6a5122b0a5ec4b37d5773b82` |
| Affected Customer Segment | `6a5122df97240c22e0375454` |

## Step 1 — fetch live

Never use `featurebase_snapshot_*.json`. Always pull fresh:

```
GET /v2/posts?boardId=<board>&limit=100[&cursor=<nextCursor>]   # paginate on data/nextCursor
GET /v2/admins                                                   # resolve post.assigneeId -> name
GET /v2/custom_fields                                            # re-verify the IDs above
```

Per post the API returns `status` (object with `name`), `assigneeId`, `upvotes`,
`postUrl`, `slug`, `content`, `customFields`.

**"Next up" is the roadmap column name for API status `Planned`.** The API has no
status literally called "Next up" — filter on `post.status.name == "Planned"` on the
Product Board. Re-check this mapping if the board columns are ever renamed; the
reference item (Implement UI language selector) is the anchor to check against.

Skip any Next-up item that already has a child page under the parent (Step 2) unless
Lea asks for a refresh.

## Step 2 — find the parent page live

The pages nest under the **current parent of the reference page**, which moves. Do
not hardcode it. As of 2026-08-19 it is **"Roadmap x Research"** (`4908154913`), not
"Hot Topics [WIP]". To re-derive it:

`getPagesInConfluenceSpace(spaceId 3926654984, limit 250)` → find the entry whose
`id` is `4889313306` → read its `parentId`. (`getConfluencePage` and CQL do *not*
return the parent.)

## Step 3 — matching

For each Next-up item, compare its **title + description** against:

- **Featurebase posts** on Feature Request, Feedback, **and Product Board posts whose
  status is `In Review` or `Reviewed`** — those are incoming asks, not roadmap items,
  and they are legitimate merge targets. (The reference page merged one: "Manual
  Language Selection".) Match on title, `content`, and the **User Need** custom field.
- **Insights** in `insights.json`, on `insight` / `core_insight`.

Semantic relevance is a judgment call — same topic is at least "related". Draft only;
Lea decides.

**Whether an insight is already in Featurebase** is determined by the posts' *Insights
ID* custom field, never by `insights.json`'s `featurebase_id` (only ~46 of 383 records
carry it). Build the set of IDs seen across all boards first.

⚠️ **Do not join Featurebase Insight IDs ≥ 497 to the local `insights.json`.** The repo
snapshot ends at ID 502 and its 498–502 records are *different* insights from the
Featurebase posts carrying those IDs; IDs 503–527 are absent entirely. For those rows
take description, quotes and segment from the Featurebase post's own custom fields and
render insights.json-only columns as "— (none on file)". Flag the staleness to Lea.

### Mentions column

Always use the Featurebase post's own `upvotes` as the mentions/votes figure — the
insights-DB mention counts are already synced into it. Never print `insights.json`'s
`mention_count` alongside it. Rows in the *Not (yet) in Featurebase* table have no
post, so those use `insights.json` `mentions`.

## Step 4 — classify (exactly three buckets)

1. **Solves** (will be merged) — a post that is the same ask, or that the roadmap item
   plainly resolves.
2. **Relates to** (not merged) — topically adjacent but a distinct ask. Stays
   standalone; its Featurebase link is recorded.
3. **Not (yet) in Featurebase** — an insight with no post. Each row gets a one-line
   action, e.g. "→ Push insight 214 to Featurebase" (Lea acts via the
   `featurebase-push` skill).

Mismatches are dropped silently — there is no "wrongly flagged" section.

### Never push or merge an insight that is already delivered

An insight whose `status` in `insights.json` is

- `Implemented - a solution is released`, or
- `Well done - positive feedback outweighs negative`

is **deliberately absent from Featurebase and must stay that way.** It never goes in
the *Not (yet) in Featurebase* table, it never gets a "→ Push insight X" action, and
it is never merged. (This is the same exclusion `featurebase_sync.py` applies on push —
`EXCLUDED_STATUSES`.)

Such an insight may still be listed under **Relates to** as context, with the last
column reading:

> ⚠️ Not in Featurebase — insight already marked implemented; do not push or merge

Check this *before* filling any table — on the first run it moved 8 of 9 rows off the
Word Add-in page and 3 of 4 off the Templates page.

**Where it gets interesting:** an insight marked implemented whose complaint still
appears in a *recent* Featurebase quote means the release did not land, or did not
cover the case. Say so in Broader scope and raise it as a research question — that
contradiction is usually the most valuable thing a run produces.

Insight IDs ≥ 497 carry no status in the local snapshot, so this check cannot be
applied to them; note that rather than assuming they are open.

When a bucket comes out empty, say so in the table rather than omitting it; an empty
Solves table is itself a finding about research coverage.

## Step 5 — build the page

Replicate the reference page exactly, in this order:

1. Excerpt macro wrapping a **compass custom panel**: 📌 Roadmap item (link · Insight
   ID · votes) · ☑ Status · 👤 Assignee (PM) · 📝 Description · 🗺️ User journey
   moment(s) *(placeholder)* · 🚥 Research Coverage & Priority (two status badges) ·
   ⏭️ Next Research Step.
2. `<hr>` — **✅ SOLVES** — Insight ID | Description | Mentions (votes) | Citation | User group(s)
3. `<hr>` — **🔗 RELATES TO** — same + Featurebase link
4. `<hr>` — **🚩 NOT (YET) IN FEATUREBASE** — same + Suggested action
5. `<hr>` — **🧾 BROADER SCOPE IN LEGAL WORKFLOW** — free text, but **derived from the
   insights database, not inferred** (see below)
6. `<hr>` — **🔍 OPEN RESEARCH QUESTIONS** — Question | Category | Recommended Approach | Risk without / Expected Impact with Research | Status
7. `<hr>` — **Review log** note panel

Horizontal rules between sections; **no expander macros** (Lea finds them harder to
read). Do not try to wrap tables in a Panel — Confluence rejects it.

Coverage and Priority are judged from how many open questions the topic raises and the
risk/impact of researching vs. not. Be honest: a topic with no feedback at all is
*Insufficient* coverage, not *Adequate*.

### Deriving Broader scope from the database

This section used to be written from judgment. Don't — the database answers it, and the
answer is usually wider than the roadmap item. For the topic of the item, run a keyword
sweep across `insight`, `core_insight`, `quotes` and `notes` (include German terms), then
aggregate over the hits:

| Field | What it tells you |
|---|---|
| `squads`, `features` | how many parts of the product the topic actually touches |
| `userGroup` / `customer_segment` | which segments carry the demand |
| `country` | jurisdiction-specific needs — a `Germany` or `Switzerland` value on a topic that is otherwise `All` is a signal, not noise |
| `mentions` | the weight of the topic as a whole vs. the roadmap item alone |
| `quotes` | the actual workflow moment, in the user's words — quote it |
| `type`, `sentiment` | whether the cluster is a missing feature, an improvement or a complaint |

Then write the section as **numbered workflow contexts**, each one carrying its insight
IDs, mention counts, segments and a verbatim quote, and close with what it implies for
the item's scope. Compare the topic total against the roadmap item's own mention count —
that contrast is usually the point.

Worked example: on the language-selector page the sweep returned 15 insights / 60
mentions / 4 squads / 8 features, against the roadmap item's own single mention with no
feature or squad assigned. That reframed the item from "a setting" to "four distinct
workflows", and produced two research questions that judgment alone had missed —
including that a UI language setting must not narrow retrieval for Swiss users, where a
French question needs German and Italian sources to be complete research.

Exclude false friends the keyword sweep drags in (e.g. "visual language", "voice input"
matching a language pattern) and say how many hits you kept.

`references/build_page.py` renders this markup; `references/api_recipes.md` holds the
request shapes.

## Step 6 — refresh the pages that already exist

The review is not only about new items. On every run, re-check each existing page under
the parent against live data and update it in place:

- **Counts and metadata** — the roadmap item's `upvotes`, `status`, `assigneeId`, and
  the votes on every post already listed. Vote counts move week to week.
- **New posts** — anything created since the page was written that now matches the item.
  Add it to Solves or Relates.
- **Rows that changed bucket** — an insight in *Not (yet) in Featurebase* that now has a
  post moves to Relates (or Solves) with its live vote count; one that has since been
  marked implemented moves to Relates with the warning marker above.
- **Implications** — do not just swap numbers. If the balance of evidence shifted, say
  what it means in Broader scope, adjust Coverage/Priority, and update or add research
  questions. On the 2026-08-19 refresh the reference page's related answer-language
  insights had grown to 33 votes against the selector's 6, which changes the scope
  question materially.

Put a short `panel-info` at the top of a refreshed page stating what changed and when,
keep the existing Review log line, and append the refresh to it. Use a
`versionMessage` on the update so the page history is readable.

Never silently drop a row Lea already reviewed — if it no longer belongs, move it and
say why.

## Strict review order

1. Draft the classification, the new pages, and the refreshes to existing pages.
2. **Lea reviews and approves or corrects each page.**
3. Only then, per approved page:
   - execute the merges — `POST /v2/posts/merge` with
     `{"sourcePostId": "<feedback post>", "destinationPostId": "<roadmap item>"}`
     (reversible via `POST /v2/posts/unmerge` with `{"postId": ...}`);
   - post the Featurebase FYI comment — `POST /v2/comment` with `{"postId", "content"}`,
     tagging the assignee;
   - post the Confluence FYI comment tagging the responsible PM
     (`createConfluenceFooterComment`, mention via
     `<span data-type="mention" data-user-id="ACCOUNT_ID">@Name</span>` — get the id
     from `lookupJiraAccountId`).

Update the Review log panel to "approved" when she signs off.

## Known gaps — current status

- **Heading highlight colours — still not possible.** Verified by probe: a
  `background-color` span in a heading survives, but the converter also rewrites the
  text colour to the *same* value, so the text renders invisible; an explicit
  contrasting `color` is overwritten too, and `background-color` on the `<h2>` itself is
  dropped. Plain text `color` works, and **status badges render correctly inside
  headings** — use a badge beside a plain heading instead of a highlight.
- **Research Question Backlog database — still not writable.** The Atlassian MCP
  connection holds only page/comment scopes (no database scope), and the network policy
  blocks direct calls to `xainag.atlassian.net`. Copy questions over by hand and keep
  the "mirrored to" line aspirational. Unblocking needs both a Confluence API token and
  `xainag.atlassian.net` added to `allowedHosts`.
- **Featurebase @mention notifications — untested.** The comment endpoint is confirmed
  working, but whether an @mention in the body actually notifies is unverified; it needs
  a real post, so ask Lea before testing.
- **`statusId` / `assigneeId` — confirmed present.** Posts return a full `status`
  object and an `assigneeId` resolvable through `/v2/admins`.
- **`insights.json` in this repo is stale** (ends at ID 502; Featurebase references up
  to 527). Refresh it before relying on the Not-yet-in-Featurebase bucket for recent
  insights.
