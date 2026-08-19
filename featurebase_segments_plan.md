# Featurebase Publisher Segments — Rework Blueprint

_Created 2026-08-19 · verified against the live Noxtua Featurebase org via `https://do.featurebase.app/v2`_

**Scope:** the publisher segments only. Splitting the existing broad publisher whitelist into eight per-market segments nested underneath it. Nothing here touches the insights database or the non-publisher audiences.

---

## 1. Can this be done via API?

**Partly — and the part that can't is the smaller part.**

Probed against the live org:

| Action | Endpoint | Result |
|---|---|---|
| Read/create/edit a segment and its whitelist | `GET/POST /v2/segments` and every variant | **404 — no segments resource exists** |
| Attach a segment to a board | `PATCH /v2/boards/{id}` | **404 — route does not exist** |
| Read which segments gate a board | `GET /v2/boards` → `access.segments[]` | ✅ read-only |
| Read/write which segments gate a changelog | `GET /v2/changelogs`, `PATCH /v2/changelogs/{id}` → `allowedSegmentIds[]` | ✅ read + write |
| Read which segments target a survey | `GET /v2/surveys` → `targeting.segmentIds[]` | ✅ read-only |

So the **whitelists have to be entered in the UI** (Users → Segments), and boards wired up there too. This document is therefore the build sheet: everything below is written to be pasted straight in.

The good news for maintenance: Featurebase segment rules match on **email domain**, not just individual addresses. Eight of the nine rules below are pure domain rules, which means **new publisher staff are picked up automatically on signup** — no one has to maintain a per-person list. That's the main thing the rework buys you.

---

## 2. ⚠️ One limitation to check before building

I derived the domain list from the **183 contacts who have actually signed up**. The API cannot read your current segment whitelists, so:

> **A domain that is whitelisted today but has no contacts yet is invisible to me and is missing from this document.**

Before building, open the current publisher segment in the UI and diff its whitelist against the ten domains in §3. Anything extra there is either a publisher not yet onboarded (add it to the right market) or dead weight (drop it).

---

## 3. Current publisher population

54 of 183 contacts sit on publisher domains, across ten domains:

| Domain | Publisher | Contacts | Unverified |
|---|---|---|---|
| beck.de | C.H. Beck (DE) | 11 | 0 |
| beck.cz | Beck CZ | 11 | 1 |
| beck-noxtua.de | Beck-Noxtua JV | 9 | 1 |
| helbing.ch | Helbing (CH) | 7 | 0 |
| blendow.se | Blendow (SE) | 6 | 3 |
| manz.at | Manz (AT) | 4 | 0 |
| beck.pl | Beck PL | 2 | 0 |
| ciela.com | Ciela (BG) | 2 | 2 |
| beck.sk | Beck SK | 1 | 0 |
| bginstitute.se | BG Institute (SE) | 1 | 0 |

Non-publisher, for completeness: 100 contacts with no email (imported research contacts), 23 `noxtua.com` (internal), 1 `xayn.com` (internal), 3 `gmail.com` + 1 `ruth.me` (individuals), 1 `featurebase.app` (vendor).

---

## 4. The structure

### Level 0 — umbrella (keep, unchanged)

**`Publishers — All`** · the existing broad segment, whitelist left as it is.

Used for the boards every publisher shares. Nothing below replaces it — the market segments only gate market-specific surfaces.

**Invariant to hold:** every domain in a market segment must also be in the umbrella. The market segments are strict subsets — never a way in, only a way to narrow. If a domain is in a market segment but not the umbrella, that publisher gets the market board but not the shared ones, which will look like a bug.

### Level 1 — eight market segments (new)

Each is a **single domain rule**. No individual email addresses needed.

| # | Segment name | Rule: email domain is any of | Contacts today |
|---|---|---|---|
| 1 | **Publishers — DE** | `beck.de`, `beck-noxtua.de` | 20 |
| 2 | **Publishers — AT** | `manz.at` | 4 |
| 3 | **Publishers — CH** | `helbing.ch` | 7 |
| 4 | **Publishers — CZ** | `beck.cz` | 11 |
| 5 | **Publishers — PL** | `beck.pl` | 2 |
| 6 | **Publishers — SK** | `beck.sk` | 1 |
| 7 | **Publishers — SE** | `blendow.se`, `bginstitute.se` | 7 |
| 8 | **Publishers — BG** | `ciela.com` | 2 |

Naming them all `Publishers — XX` keeps them sorted together in the segment picker and makes the umbrella relationship obvious at a glance.

### Members today, for verification

Paste-ready if you'd rather whitelist addresses than domains, but mainly here so you can confirm each rule catches the right people.

**DE (20)** — `beck.de`: chris.eckert, christian.hange, christopher.mueck, harald.gehring, katharina.kaeuffer, konstantin.mueller, lisa.ritz, sami.yacob, sarah.schopf, sebastian.merkel, stephan.rupp · `beck-noxtua.de`: christoph.ziegler ⚠, daniel.ludwig, edina.julevic, gabor.csizman, mark.schneider, mirjam.weng, salo.tober-lau, sandra.sewald, sebastian.becker

**AT (4)** — `manz.at`: alexander.feldinger, daniel.oberhuber, katharina.marx, peter.guggenberger

**CH (7)** — `helbing.ch`: antonja.burghardt, cyrielle.gaonach, mirko.meurer, pascal.decourten, patrick.romer, sara.canic, till.eigenheer

**CZ (11)** — `beck.cz`: jana.kuncova, jana.silhava, jaromir.fronc, jiri.holna, kristyna.chury, lenka.kubova, lukas.mikula, lukas.pelcman, marek.stepan ⚠, olga.kotlanova, radim.krejci

**PL (2)** — `beck.pl`: milosz.kalinowski, pawel.oleszek

**SK (1)** — `beck.sk`: frantisek.axamit

**SE (7)** — `blendow.se`: filippa.moller ⚠, marcus.bouvin, martin.warne, sebastian.blendow, simon.norrman, thomas.blendow ⚠ · `bginstitute.se`: andreas.perneby

**BG (2)** — `ciela.com`: suzana.georgieva ⚠, vtodorov ⚠

⚠ = unverified email (7 total). Domain rules match them anyway; worth a nudge since unverified users can't be reached by changelog email.

---

## 5. Access matrix

| Surface | Publishers — All | Market segment | Note |
|---|---|---|---|
| **Feedback** | ✅ | — | shared, umbrella only |
| **Feature Request** | ✅ | — | shared, umbrella only |
| **Product Board** | current setup | — | see open decision 1 |
| **Setup Board: Germany** | ❌ | **Publishers — DE** only | replaces the current broad gating |
| **Setup Board: \<other markets\>** | ❌ | matching market segment | as each is created |
| **Changelog — market-specific** | ❌ | matching market segment | via `PATCH /v2/changelogs/{id}` |
| **Changelog — general** | ✅ | — | shared |

**The one change to make immediately:** *Setup Board: Germany* is currently gated by segment `6a424c9705975b99492edfc0` — the same segment that gates *Feedback*. So a German setup board is presently visible to the whole audience of the Feedback board, not just DE publishers. Re-gating it to **Publishers — DE** is the concrete win and the reason the rest of this structure is worth building.

---

## 6. Current state, for reference

Four segment IDs in use. Names aren't exposed by the API — match by ID in the UI.

| Segment ID | Currently gates |
|---|---|
| `6a43f42b701b185bc54bb9df` | Feature Request, Product Board |
| `6a424c9705975b99492edfc0` | Feedback, **Setup Board: Germany**, Product Board |
| `6a68ebdc76533f2ce1aee88f` | Product Board only |
| `6a56b50a830bb94948cdf3d9` | Changelog "Internal Featurebase RELEASE NOTE TEST" |

Boards: Feature Request `6a2123630535f655cfaec3cb` · Feedback `6a213f3998f1621c64f747fb` · Product Board `6a422f49728db77bced50b63` · Setup Board: Germany `6a8309024756697e119ddcf9`. All have `adminOnly: false` and empty `allowedRoles`/`deniedRoles` — user roles are unused, and segments remain the right mechanism.

---

## 7. Build order

1. **Diff** the current publisher whitelist against the ten domains in §3 (see §2).
2. **Create** the eight market segments — one domain rule each, ~10 minutes.
3. **Re-gate Setup Board: Germany** to *Publishers — DE*, removing `6a424c9705975b99492edfc0`.
4. **Verify** with the member lists in §4 — each segment's count should match.
5. **Leave the umbrella and the shared boards untouched.**
6. **Repeat step 3** for each new market setup board as it launches.

Steps 2–3 are the only manual work and they're one-off. After that, a new publisher employee signing up with a company address lands in the right market segment on their own.

## 8. Open decisions

1. **Product Board** currently carries three segments, so the roadmap is roughly as widely visible as the feedback board. Intentional, or should it narrow to specific markets or a strategic subset?
2. **Individual addresses** — the 3 gmail.com and 1 ruth.me contacts. If any is a publisher contact using a personal address, they need an explicit email entry in the relevant market segment, since no domain rule will catch them.
3. **Beck group** is spread across five domains and four market segments. If Beck ever needs addressing as one audience, that's a ninth segment (`beck.de`, `beck.cz`, `beck.pl`, `beck.sk`, `beck-noxtua.de`) rather than a change to the market split.
4. **`beck-noxtua.de`** is grouped into DE. Correct if the JV is treated as a German entity; if it's a joint audience with its own board, it should be its own segment.

---

## 9. Security note

`FEATUREBASE_API_KEY` is committed in plaintext in `.claude/settings.json`. It's a live key with org write access — worth rotating and moving to an untracked local settings file.
