# Featurebase User Segments — API Capability & Rework Blueprint

_Created 2026-08-19 · verified against the live Noxtua Featurebase org via `https://do.featurebase.app/v2`_

---

## 1. Short answer: can segments be managed via API?

**No — not the segment definitions themselves. Yes — everything they depend on and almost everywhere they are applied.**

Verified by probing the live API with our org key:

| What | Endpoint | Result |
|---|---|---|
| List segments | `GET /v2/segments` | **404** |
| List segments (alt paths) | `/v2/user-segments`, `/v2/users/segments`, `/v2/segments/{id}` | **404** |
| Segment rules (create/edit) | — | **no endpoint exists** |

There is no `segments` resource in the REST API. A segment's **name and its matching rules are UI-only** (Featurebase dashboard → Users → Segments). That part of a rework has to be clicked once.

**What *is* API-manageable:**

| Capability | Endpoint | Status |
|---|---|---|
| Write the user attributes segments match on | `POST /v2/organization/identifyUser` | ✅ works (email, name, userId, `companies`, `customFields`, `roles`, locale) |
| Create/patch contacts | `POST /v2/contacts`, `GET /v2/contacts` | ✅ works |
| Create/patch companies + their custom fields | `POST /v2/companies`, `GET /v2/companies` | ✅ works |
| Read which segments gate a board | `GET /v2/boards` → `access.segments[]` | ✅ read-only |
| Read/write which segments gate a changelog | `GET /v2/changelogs` → `allowedSegmentIds[]`, `PATCH /v2/changelogs/{id}` | ✅ read + write |
| Read which segments target a survey | `GET /v2/surveys` → `targeting.segmentIds[]` | ✅ read |
| Change board → segment assignment | `PATCH /v2/boards/{id}` | **404 — route does not exist (UI-only)** |
| Admin roles (not end-user segments) | `GET /v2/admins`, `GET /v2/admins/roles` | ✅ read-only |

### What this means for the rework

The work splits cleanly in two, and the big half is automatable:

- **Clicked once in the UI (small, one-off):** creating each segment and attaching it to boards. ~15 minutes for the whole model below.
- **Driven by API/script (the ongoing part):** every attribute that decides *who lands in which segment*. Once the attribute schema is right, membership maintains itself — no one ever has to hand-add a user to a segment again.

So the plan below is worth writing precisely: the segment rules are cheap to click, but only if the attributes underneath them are designed first. **Design the attributes, not the segments.**

---

## 2. Current state (live audit, 2026-08-19)

### Segments in use — 4 distinct IDs

| Segment ID | Applied to |
|---|---|
| `6a43f42b701b185bc54bb9df` | Board **Feature Request**, Board **Product Board** |
| `6a424c9705975b99492edfc0` | Board **Feedback**, Board **Setup Board: Germany**, Board **Product Board** |
| `6a68ebdc76533f2ce1aee88f` | Board **Product Board** only |
| `6a56b50a830bb94948cdf3d9` | Changelog *"Internal Featurebase RELEASE NOTE TEST"* |

Names aren't exposed by the API — match the IDs in the UI to see what each is currently called and what rules it carries.

### Boards and their gating

| Board | ID | adminOnly | Segments | Roles |
|---|---|---|---|---|
| Feature Request | `6a2123630535f655cfaec3cb` | false | 1 | none |
| Feedback | `6a213f3998f1621c64f747fb` | false | 1 | none |
| Product Board | `6a422f49728db77bced50b63` | false | 3 | none |
| Setup Board: Germany | `6a8309024756697e119ddcf9` | false | 1 | none |

`allowedRoles` / `deniedRoles` are empty everywhere — user roles are unused (they're an Enterprise-plan feature aimed at separating unrelated products; segments are the right tool for us either way).

Surveys: `CSAT Survey` and `Customer Feedback` both have `targeting.segmentIds: []` — ungated, shown to everyone.

### The actual blocker — the attribute layer is empty

| Metric | Value | Consequence |
|---|---|---|
| Contacts | 183 | — |
| Contacts with **any** `customFields` | **0** | no attribute can be used in a segment rule today |
| Contacts linked to a company | 102 of 183 | company-based rules cover ~56% |
| Contacts with no email | 100 | can't be matched by domain either |
| Companies | 4 | Noxtua, Addas, and **"Internal User Research Insights" twice (duplicate)** |
| Subscribed to changelog | 50 of 183 | — |

**This is the finding that matters.** Zero custom fields means today's segments can only be built on email domain or manual membership — which is exactly why the current setup feels like it needs reworking. Any new segment model will be just as brittle unless the attribute sync is built first.

### Real customer distribution (by email domain)

| Domain | Contacts | Reading |
|---|---|---|
| noxtua.com | 23 | internal |
| beck.de | 11 | Beck DE |
| beck.cz | 11 | Beck CZ |
| beck-noxtua.de | 9 | Beck joint venture |
| helbing.ch | 7 | Helbing CH |
| blendow.se | 6 | Blendow SE |
| manz.at | 4 | Manz AT |
| gmail.com | 3 | individual |
| ciela.com | 2 | Ciela BG |
| beck.pl | 2 | Beck PL |
| beck.sk, bginstitute.se, ruth.me, xayn.com, featurebase.app | 1 each | — |
| *(no email)* | 100 | imported research contacts |

---

## 3. Proposed model

### Layer 1 — Attribute schema (API-managed, the foundation)

Set on each contact via `POST /v2/organization/identifyUser`, on each company via `POST /v2/companies`. These are the only things segment rules should ever match on.

**On the contact:**

| Field | Values | Purpose |
|---|---|---|
| `account_type` | `internal` · `customer` · `partner` · `prospect` · `research` | top-level split; gates everything else |
| `customer_segment` | `big_law` · `corporate_legal` · `small_law` · `publisher` · `public_sector` · `distribution` | mirrors the `customer_segment` vocabulary already in `insights.json` |
| `market` | `DE` · `AT` · `CH` · `CZ` · `PL` · `SK` · `SE` · `BG` | drives market-specific boards (e.g. Setup Board: Germany) |
| `roadmap_access` | `none` · `standard` · `strategic` | who may see forward-looking content; keyed to NDA/contract, not to company size |
| `lifecycle` | `pilot` · `active` · `churned` | suppress churned accounts without deleting them |
| `research_participant` | `true` / `false` | the 100 imported no-email contacts; keeps them out of customer-facing surfaces |

**On the company:** `customer_segment`, `market`, `roadmap_access`, `lifecycle`, `plan` — same vocabulary. Company-level is the default; the contact-level value overrides it for individuals.

Deliberately **not** attributes: anything derived (headcount tiers, "is VIP"), and anything Featurebase already tracks natively (`monthlySpend`, `lastActivity`) — segment on those directly.

### Layer 2 — Segments (created once in the UI, from Layer 1 only)

| # | Segment | Rule | Approx. size today |
|---|---|---|---|
| 1 | **Internal — Noxtua** | `account_type = internal` | 24 (noxtua.com + xayn.com) |
| 2 | **All Customers** | `account_type = customer` AND `lifecycle ≠ churned` | ~59 |
| 3 | **Strategic Partners** | `roadmap_access = strategic` | Beck group, Helbing, Manz, Blendow |
| 4 | **Market: DACH** | `account_type = customer` AND `market ∈ {DE, AT, CH}` | ~31 |
| 5 | **Market: CEE** | `account_type = customer` AND `market ∈ {CZ, PL, SK, BG}` | ~16 |
| 6 | **Market: Nordics** | `account_type = customer` AND `market ∈ {SE}` | ~7 |
| 7 | **Big Law & Corporate Legal** | `customer_segment ∈ {big_law, corporate_legal}` | primary feedback audience |
| 8 | **Publishers** | `customer_segment = publisher` | Beck, Manz, Helbing, Blendow as publishers |
| 9 | **Research Panel** | `research_participant = true` | 100 |

Nine segments, each one rule deep, each derived from one attribute. That's the point: when the rule is a single attribute lookup, the rule never has to change again — only the attribute does, and that's the API's job.

### Layer 3 — Access matrix (boards in UI, changelogs via API)

| Surface | Internal | All Customers | Strategic Partners | Research Panel |
|---|---|---|---|---|
| **Feedback** (report problems) | ✅ | ✅ | ✅ | ❌ |
| **Feature Request** (ask + vote) | ✅ | ✅ | ✅ | ❌ |
| **Product Board** (roadmap) | ✅ | ❌ | ✅ | ❌ |
| **Setup Board: Germany** | ✅ | Market: DACH only | ✅ | ❌ |
| **Changelog — general** | ✅ | ✅ | ✅ | ❌ |
| **Changelog — internal/test** | ✅ | ❌ | ❌ | ❌ |
| **Surveys — CSAT** | ❌ | ✅ | ✅ | ❌ |
| **Surveys — research recruitment** | ❌ | ✅ | ✅ | ✅ |

Two rules to keep it coherent:

1. **Roadmap-type content is gated by `roadmap_access`, never by market or segment.** Mixing "who they are" with "what they're allowed to see" is what makes access models rot.
2. **Market segments narrow, they never grant.** A board gated by *Market: DACH* should also carry *All Customers* logic, so market is a filter on an already-entitled group.

Note the deviation from today: *Product Board* currently carries three segments including the general one, so the roadmap is broader than a roadmap usually should be. Worth an explicit decision during the rework rather than inheriting it.

---

## 4. Implementation path

1. **Confirm the vocabulary** — the Layer 1 values above are drawn from `insights.json`'s `customer_segment` field. Adjust before anything is written.
2. **Assign attributes to the 183 contacts** — mostly derivable from email domain; the 100 no-email research contacts all get `account_type = research`, `research_participant = true`.
3. **Backfill via script** — `identifyUser` per contact, `POST /v2/companies` per company. Dry-run first, same pattern as `featurebase_sync.py`. Fixes the duplicate "Internal User Research Insights" company at the same time.
4. **Create the 9 segments in the UI** — one rule each, ~15 minutes.
5. **Attach segments to boards in the UI** — per the access matrix (no API route for this).
6. **Attach segments to changelogs via `PATCH /v2/changelogs/{id}`** — scriptable.
7. **Keep it current** — re-run the attribute sync weekly (alongside the existing `--pull-votes` job) so new signups get classified automatically.

Steps 2, 3, 6 and 7 are scripted; 4 and 5 are the only manual ones, and they're one-off.

## 5. Open decisions

1. **Product Board audience** — keep it open to all customers, or restrict to `roadmap_access = strategic`?
2. **`roadmap_access` assignment** — driven by contract/NDA status. Needs a source of truth; there isn't one in Featurebase today.
3. **The 100 no-email research contacts** — keep them in Featurebase as a research panel, or are they only there as insight authors and better held outside the portal?
4. **Market granularity** — three market segments (DACH/CEE/Nordics) or per-country? Per-country is 8 segments and only pays off if country-specific boards multiply beyond Germany.
5. **Beck group** — one entity or separate per country (beck.de / beck.cz / beck.pl / beck.sk / beck-noxtua.de)? Affects whether `market` or company is the primary axis.

---

## 6. Security note

`FEATUREBASE_API_KEY` is committed in plaintext in `.claude/settings.json`. It's a live key with write access to the org. Worth rotating and moving to an untracked local settings file or environment secret.
