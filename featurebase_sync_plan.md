# Featurebase Sync Plan — Noxtua Insights
_Created 2026-07-09_

---

## Overview

**72 qualifying insights** are ready to sync to Featurebase:
- Types: Missing Feature (40), Improvement (27), Idea (5)
- Filter: mentions ≥ 3, status not "Implemented" or "Well done"

The sync has two directions:
1. **Outbound**: Push insights as feature request posts into Featurebase boards
2. **Inbound**: Pull Featurebase upvote counts back into insights.json

---

## Pre-requisites

Before running anything:

1. **Get your Featurebase API key** — Settings → API in your Featurebase dashboard
2. **Identify your board IDs** — run `GET https://api.featurebase.app/v2/boards` with your API key; map each insight type to a board:

| Insight type | Suggested Featurebase board |
|---|---|
| Missing Feature | "Feature Requests" board |
| Improvement | "Improvements" or same board with a tag |
| Idea | "Ideas" board or same board |

You can use one board for all three and rely on tags, or separate boards — your call (see Decision 1 below).

3. **Add two fields to insights.json** — the sync script adds these automatically on first run:
   - `featurebase_id`: the Featurebase post ID after creation
   - `featurebase_synced_at`: ISO timestamp of last sync
   - `featurebase_votes`: latest upvote count pulled from Featurebase

---

## Decision Points

Before running the sync, decide:

**Decision 1 — Board mapping:** One board for all 72 insights, or separate boards per type?
- One board is simpler; use tags (Missing Feature / Improvement / Idea) to differentiate
- Separate boards gives Featurebase users cleaner navigation

**Decision 2 — Featurebase votes vs internal mentions:** Keep separate (recommended)
- `mentions` in insights.json = research team observations (qualitative weight)
- `featurebase_votes` = direct customer upvotes (separate signal)
- Don't merge them — they mean different things

**Decision 3 — Status sync back:** Should status changes in Featurebase (e.g. "Planned", "In Progress") propagate back to insights.json?
- Nice to have, but requires a webhook server or manual step
- Recommended for now: do it manually via the dashboard when a status changes

**Decision 4 — Sync frequency for vote counts:** How often to pull updated vote counts?
- Weekly polling is sufficient (Cowork scheduled task)
- Real-time requires a webhook endpoint (needs a server you host)

---

## Part 1 — Outbound Sync (Insights → Featurebase)

### How it works

The script `featurebase_sync.py` reads insights.json, filters to the 72 qualifying insights, and for each:

- If `featurebase_id` is **not set** → creates a new Featurebase post (`POST /v2/posts`)
- If `featurebase_id` **is set** → updates the existing post (`PATCH /v2/posts/{id}`)

This makes re-runs safe — no duplicates.

### Field mapping (insight → Featurebase post)

| insights.json field | Featurebase post field | Notes |
|---|---|---|
| `insight` text | `title` | The main insight sentence |
| `mentions` count + quotes + notes | `content` (markdown) | Rich description for voters |
| `type` | tag or board assignment | Missing Feature / Improvement / Idea |
| `id` | stored in `featurebase_id` | Round-trip linkage |

**Example post content generated:**

```
**Internal research insight · ID 249 · 5 mentions**

The user needs to not be limited by context window size constraints when working with large documents or complex tasks. (Proposed solution: option to set context window to 250,000 tokens or higher.)

---
*This post was created from internal user research. Upvote if this matches your needs.*
```

### Running the outbound sync

```bash
# Dry run first — shows what would be created/updated without touching Featurebase
python3 featurebase_sync.py --dry-run

# Live run
python3 featurebase_sync.py --push

# Push only a specific insight (for testing)
python3 featurebase_sync.py --push --id 249
```

### What changes in insights.json after a push

Each synced insight gains:
```json
{
  "featurebase_id": "abc123xyz",
  "featurebase_synced_at": "2026-07-09T14:00:00Z",
  "featurebase_votes": 0
}
```

---

## Part 2 — Inbound Sync (Featurebase votes → insights.json)

### Option A — Weekly polling script (recommended, no server needed)

The script `featurebase_sync.py --pull-votes` iterates all insights that have a `featurebase_id`, calls `GET /v2/posts/{id}` for each, and writes the current `votesCount` back to `featurebase_votes` in insights.json.

This can be scheduled as a weekly Cowork task — just ask me to set that up and I'll configure it.

**No server required.** Slight delay (up to a week between upvotes and your database updating), which is fine for research purposes.

```bash
# Pull latest vote counts for all synced insights
python3 featurebase_sync.py --pull-votes
```

### Option B — Real-time webhooks (optional, requires a server)

Featurebase can call a URL you own whenever a vote is cast (`POST /v2/webhooks`, event type `post.upvoted`). Your server then updates insights.json.

This requires hosting a small endpoint (e.g. a Cloudflare Worker, Vercel function, or Render.com free tier). Only worth setting up if you need real-time vote counts. For a research database, polling weekly is simpler and sufficient.

---

## Part 3 — Status Sync Back (Optional)

When Featurebase moderators change a post status (e.g. to "Planned" or "Completed"), you might want that reflected in insights.json.

**Practical approach without a server:**
- The weekly `--pull-votes` run also checks the post status from Featurebase
- If a post status is "Completed" and the insight status is still "Planned for development", the script flags it in a report
- You review the report and update insights.json manually via the review app or a direct edit

**Mapping Featurebase statuses → insights.json statuses:**

| Featurebase status | insights.json status |
|---|---|
| Under Review | Identified - JIRA ticket exists |
| Planned | Planned for development |
| In Progress | In development |
| Complete | Implemented - a solution is released |
| Closed / Won't Do | Won't fix / Out of scope |

---

## Execution Steps

1. **Get API key** from Featurebase Settings
2. **Decide board structure** (one board vs. separate boards per type)
3. **Run** `python3 featurebase_sync.py --dry-run` to preview the 72 posts
4. **Review** the dry-run report — adjust any post content if needed
5. **Run** `python3 featurebase_sync.py --push` — creates 72 posts, writes `featurebase_id` back to insights.json
6. **Set up weekly vote pull** — ask me to schedule `python3 featurebase_sync.py --pull-votes` via Cowork

---

## Files

| File | Purpose |
|---|---|
| `featurebase_sync.py` | Main sync script (outbound push + inbound vote pull) |
| `featurebase_sync_plan.md` | This document |
| `insights.json` | Source of truth — gains `featurebase_id`, `featurebase_votes` fields after sync |
