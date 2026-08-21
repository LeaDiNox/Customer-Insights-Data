#!/usr/bin/env python3
"""
featurebase_sync.py — Sync qualifying Noxtua insights to/from Featurebase.

Usage:
    python3 featurebase_sync.py --dry-run          Preview posts that would be created/updated
    python3 featurebase_sync.py --push             Create/update posts in Featurebase
    python3 featurebase_sync.py --push --id 249    Push a single insight (by ID)
    python3 featurebase_sync.py --pull-votes       Pull upvote counts back into insights.json

Configuration (edit before running):
    FEATUREBASE_API_KEY   — your API key from Featurebase Settings → API
    MISSING_FEATURE_BOARD — board ID for Missing Feature posts (run --list-boards to find)
"""

import json
import os
import sys
import argparse
import datetime
import time
import shutil
import random
import re
import urllib.request
import urllib.error
from pathlib import Path

# ---------------------------------------------------------------------------
# CONFIGURATION — edit these before running
# ---------------------------------------------------------------------------

# Set FEATUREBASE_API_KEY as an environment variable. This file is committed
# to a public repo — never hardcode a key here, even as a fallback default.
FEATUREBASE_API_KEY = os.environ.get("FEATUREBASE_API_KEY", "")

# Run --list-boards to find this ID, then paste it here:
MISSING_FEATURE_BOARD = "6a2123630535f655cfaec3cb"  # e.g. "64a1b2c3d4e5f6a7b8c9d0e1"

# Board for everything that isn't a Missing Feature (General Feedback, Improvement,
# Idea, Bug) — the "Feedback Board" in Featurebase.
FEEDBACK_BOARD = "6a213f3998f1621c64f747fb"

# Product / roadmap board — NOT a push target (we never create/update posts here).
# Read-only: used by find_merged_posts() to detect posts that were merged out of
# the Missing Feature / Feedback boards into a combined roadmap item here.
PRODUCT_BOARD = "6a422f49728db77bced50b63"

# Voter seeding: ID of the Featurebase company whose contacts act as the voter pool.
# The script fetches all contacts from this company at push time and uses them as voters,
# adding up to min(insight.mentions, total_contacts) votes per post.
# Run --list-companies to find your company ID. Leave empty to skip voter seeding.
VOTER_COMPANY_ID = "6a511bc2c616721d0b80cba9"  # e.g. "64a1b2c3d4e5f6a7b8c9d0e1"

# Cached at runtime — do not edit
_voter_pool: list[str] = []

# ---------------------------------------------------------------------------
# CUSTOM FIELDS — populate after running --list-custom-fields
# ---------------------------------------------------------------------------
# Run:  python3 featurebase_sync.py --list-custom-fields
# Then paste the field IDs below. Leave empty string "" to skip that field.
# Format: {"field_id_from_featurebase": "..."}  — keys are ObjectId strings.
CUSTOM_FIELD_IDS = {
    "insight_id":        "6a5122786ae5db6317c6f29b",   # Featurebase field ID for "Insight ID"
    "user_need":         "6a51229aaa1b56234fed0d94",   # Featurebase field ID for "User Need"
    "quotes":            "6a5122b0a5ec4b37d5773b82",   # Featurebase field ID for "Quotes"
    "customer_segment":  "6a5122df97240c22e0375454",   # Featurebase field ID for "Affected Customer Segment"
}

# Path to insights.json (relative to this script)
INSIGHTS_JSON = Path(__file__).parent / "insights.json"

# Sync filter — QA review gate:
# An insight must be marked qa_reviewed=true in insights.json (via the QA
# review flow: insights_review.html -> apply_qa_review.py) before it can be
# pushed. All insight types qualify; Missing Feature routes to the feature
# request board, everything else routes to the feedback board.
EXCLUDED_STATUSES = {
    "Implemented - a solution is released",
    "Well done - positive feedback outweighs negative",
}
REQUIRE_QA_REVIEWED = True   # gate push on insights.json "qa_reviewed" == true
MIN_MENTIONS = 0             # no floor — push all qualifying feedback regardless of mention count


def board_for(ins):
    """
    Route an insight to the correct Featurebase board.

    For a brand-new post (no featurebase_id yet), route by type as usual.
    For an existing post, ALWAYS preserve whatever board it's actually on
    (featurebase_board_id, recorded at link/create time) rather than
    recomputing from type — otherwise a PATCH would silently move a post
    that lives on the Product/roadmap board back onto Feedback/Missing
    Feature. Older records without featurebase_board_id fall back to the
    type-based board (unchanged prior behavior).
    """
    if ins.get("featurebase_id") and ins.get("featurebase_board_id"):
        return ins["featurebase_board_id"]
    if ins.get("type") == "Missing Feature":
        return MISSING_FEATURE_BOARD
    return FEEDBACK_BOARD

# Featurebase API base URL
API_BASE = "https://do.featurebase.app/v2"

# Map Featurebase post statuses → insights.json statuses (for flagging)
FEATUREBASE_STATUS_MAP = {
    "Under Review":  "Identified - JIRA ticket exists",
    "Planned":       "Planned for development",
    "In Progress":   "In development",
    "Complete":      "Implemented - a solution is released",
    "Closed":        "Won't fix / Out of scope",
    "Won't Do":      "Won't fix / Out of scope",
}

# ---------------------------------------------------------------------------
# API helpers
# ---------------------------------------------------------------------------

def api_request(method, path, body=None):
    """Make a Featurebase API request. Returns parsed JSON or raises."""
    url = f"{API_BASE}{path}"
    data = json.dumps(body).encode() if body else None
    req = urllib.request.Request(
        url,
        data=data,
        method=method,
        headers={
            "Authorization": f"Bearer {FEATUREBASE_API_KEY}",
            "Content-Type": "application/json",
            "Accept": "application/json",
        },
    )
    try:
        with urllib.request.urlopen(req) as resp:
            return json.loads(resp.read())
    except urllib.error.HTTPError as e:
        body_text = e.read().decode()
        print(f"  ✗ HTTP {e.code} on {method} {path}: {body_text[:300]}")
        raise


# ---------------------------------------------------------------------------
# Insight filtering
# ---------------------------------------------------------------------------

def load_insights():
    with open(INSIGHTS_JSON, encoding="utf-8") as f:
        return json.load(f)


def save_insights(insights):
    backup_path = INSIGHTS_JSON.with_name(f"insights.backup_{datetime.date.today()}.json")
    if not backup_path.exists():
        shutil.copy(INSIGHTS_JSON, backup_path)
        print(f"  Backup saved: {backup_path.name}")
    with open(INSIGHTS_JSON, "w", encoding="utf-8") as f:
        json.dump(insights, f, ensure_ascii=False, indent=2)
    print(f"  insights.json updated.")


def qualifying_insights(insights, ids=None):
    """
    Return insights that pass the sync filter.
    If `ids` is a non-empty list, restrict to those IDs (bypasses the
    type/status/mentions filter so the caller can push any specific insight).
    """
    if ids:
        id_set = set(ids)
        return [ins for ins in insights if ins["id"] in id_set]
    results = []
    for ins in insights:
        if ins.get("status", "") in EXCLUDED_STATUSES:
            continue
        if REQUIRE_QA_REVIEWED and not ins.get("qa_reviewed"):
            continue
        if ins.get("qa_deleted"):
            continue
        if ins.get("mentions", 0) < MIN_MENTIONS:
            continue
        results.append(ins)
    return results


# ---------------------------------------------------------------------------
# Post content builder
# ---------------------------------------------------------------------------

def _dedupe_segments(raw: str) -> str:
    """Deduplicate semicolon-separated segment values, preserve order."""
    if not raw:
        return ""
    seen = []
    for part in raw.split(";"):
        part = part.strip()
        if part and part not in seen:
            seen.append(part)
    return "; ".join(seen)


def _format_quotes(raw) -> str:
    """Return a clean string of quotes from either a list or semicolon string."""
    if not raw:
        return ""
    if isinstance(raw, list):
        items = [q.strip() for q in raw if q and q.strip()]
    else:
        items = [q.strip() for q in str(raw).split(";") if q.strip()]
    return "\n".join(f'"{q}"' for q in items[:5])


def build_custom_fields(ins) -> dict:
    """
    Build the customFields map for a post payload.
    Keys are Featurebase field IDs from CUSTOM_FIELD_IDS.
    Only includes fields where the ID is configured (non-empty).
    """
    cf = {}
    mapping = {
        "insight_id":       str(ins.get("id", "")),
        "user_need":        ins.get("insight", ""),
        "quotes":           _format_quotes(ins.get("quotes")),
        "customer_segment": _dedupe_segments(ins.get("customer_segment", "") or ins.get("userGroup", "")),
    }
    for key, value in mapping.items():
        field_id = CUSTOM_FIELD_IDS.get(key, "").strip()
        if field_id and value:
            cf[field_id] = value
    return cf


def build_post_content(ins):
    """
    Markdown fallback body — used only when CUSTOM_FIELD_IDS are not configured.
    Once custom field IDs are filled in, the content field is cleared and
    all structured data moves to custom fields.
    """
    parts = [ins.get("insight", "")]
    quotes = ins.get("quotes") or []
    if isinstance(quotes, str):
        quotes = [q.strip() for q in quotes.split(";") if q.strip()]
    if quotes:
        parts.append("\n**User quotes:**")
        for q in quotes[:3]:
            parts.append(f'> "{q}"')
    parts.append(
        "\n---\n*This post was created from internal Noxtua user research. "
        "Upvote if this matches your needs.*"
    )
    return "\n".join(parts)


def build_post_payload(ins):
    """Build the full Featurebase post payload for create or update."""
    title = ins.get("featurebase_title") or ins.get("insight", "")
    custom_fields = build_custom_fields(ins)
    board_id = board_for(ins)

    if custom_fields:
        # Custom fields mode — send empty content to wipe the old markdown body
        return {
            "title": title[:255],
            "content": "",
            "boardId": board_id,
            "customFields": custom_fields,
        }
    else:
        # Fallback: markdown body (used before custom field IDs are configured)
        return {
            "title": title[:255],
            "content": build_post_content(ins),
            "boardId": board_id,
        }


# ---------------------------------------------------------------------------
# Company resolution — attribute votes to the company behind a source label
# ---------------------------------------------------------------------------

_companies = None          # [{"id","name","contacts":[contact_id,...]}]

# Documented name variants: source-label spelling -> stored company spelling.
# Keep in sync with the publisher list in the Database Management skill (Step 5).
COMPANY_ALIASES = {
    "beck germany": "c.h. beck germany",
    "publisher feedback - beck germany": "c.h. beck germany",
    "publisher feedback – beck germany": "c.h. beck germany",
}

_LEGAL_SUFFIXES = {"gmbh", "ag", "ltd", "limited", "inc", "llc", "plc", "sa", "se",
                   "kg", "ohg", "bv", "nv", "oy", "ab", "as", "spa", "srl"}
_SEP = "_-. ,/|"


def _norm_company(s):
    """Lowercase, drop punctuation and trailing legal suffixes."""
    toks = [t for t in re.split(r"[^0-9a-zA-Z]+", (s or "").lower()) if t]
    while toks and toks[-1] in _LEGAL_SUFFIXES:
        toks.pop()
    return "".join(toks)


def _segments(s):
    """Split a source label into whole segments (Direct_Feedback_Corp_002_08_2026 -> [...])."""
    out, cur = [], ""
    for ch in (s or ""):
        if ch in _SEP:
            if cur:
                out.append(cur.lower()); cur = ""
        else:
            cur += ch
    if cur:
        out.append(cur.lower())
    return out


def fetch_companies():
    """Fetch companies once, with the contact IDs linked to each."""
    global _companies
    if _companies is not None:
        return _companies
    result = api_request("GET", "/companies")
    raw = result.get("results") or result.get("data") or result.get("companies") or []
    if isinstance(result, list):
        raw = result
    companies = {}
    for c in raw:
        if not isinstance(c, dict):
            continue
        cid = c.get("id") or c.get("_id")
        if cid:
            companies[cid] = {"id": cid, "name": c.get("name") or "", "contacts": []}
    cursor = None
    while True:
        path = "/contacts" + (f"?cursor={cursor}" if cursor else "")
        page = api_request("GET", path)
        data = page.get("data", [])
        for contact in data:
            for co in contact.get("companies", []) or []:
                cid = co.get("companyId") or co.get("id")
                if cid in companies and contact.get("id"):
                    companies[cid]["contacts"].append(contact["id"])
        cursor = page.get("nextCursor")
        if not cursor or not data:
            break
    _companies = list(companies.values())
    return _companies


def _pick_company(matches):
    """Duplicate company records share a name. Prefer the one that is actually
    usable for voting: the record with linked contacts. Ambiguous only when
    several records with contacts share the name."""
    with_contacts = [m for m in matches if m["contacts"]]
    if len(with_contacts) == 1:
        return with_contacts[0], None
    if len(with_contacts) > 1:
        return None, ("ambiguous", with_contacts)
    return matches[0], ("no_contacts", matches)


def resolve_company(source_label):
    """Map a source label onto a stored Featurebase company.

    Cases, in order: exact name, normalised name, documented alias, and a
    whole-segment match anywhere in the label — 'Direct_Feedback_Corp_002_08_2026'
    resolves to 'Corp_002' even though the company token does not lead the label.
    Substring hits that are not whole segments never match ('Corp_02' vs 'Corp_002',
    'Beck' vs 'Beckman').

    Returns {"status", "company", "note", "candidates", "label"}.
    status: exact | normalised | alias | segment | ambiguous | no_contacts | none
    """
    companies = fetch_companies()
    parts = [p.strip() for p in (source_label or "").split(",") if p.strip()]
    for part in parts:
        low = part.lower().strip()
        for finder, status in (
            (lambda c: c["name"].lower().strip() == low, "exact"),
            (lambda c: _norm_company(c["name"]) == _norm_company(part), "normalised"),
            (lambda c: _norm_company(c["name"]) == _norm_company(COMPANY_ALIASES.get(low, "")), "alias"),
        ):
            hits = [c for c in companies if c["name"] and finder(c)]
            if hits:
                chosen, problem = _pick_company(hits)
                if problem and problem[0] == "ambiguous":
                    return {"status": "ambiguous", "company": None, "candidates": problem[1], "label": part, "note": ""}
                if problem and problem[0] == "no_contacts":
                    return {"status": "no_contacts", "company": chosen, "candidates": hits, "label": part, "note": ""}
                return {"status": status, "company": chosen, "candidates": hits, "label": part, "note": ""}
        segs = _segments(part)
        for c in companies:
            cs = _segments(c["name"])
            if not cs or len(cs) > len(segs):
                continue
            if any(segs[i:i + len(cs)] == cs for i in range(len(segs) - len(cs) + 1)):
                hits = [x for x in companies if x["name"].lower() == c["name"].lower()]
                chosen, problem = _pick_company(hits)
                if problem and problem[0] == "ambiguous":
                    return {"status": "ambiguous", "company": None, "candidates": problem[1], "label": part, "note": ""}
                if problem and problem[0] == "no_contacts":
                    return {"status": "no_contacts", "company": chosen, "candidates": hits, "label": part, "note": ""}
                return {"status": "segment", "company": chosen, "candidates": hits, "label": part, "note": ""}
    return {"status": "none", "company": None, "candidates": [], "label": source_label, "note": ""}


def unvote(post_id, contact_id):
    """Remove one voter from a post (maintenance path for a mis-attributed vote)."""
    result = api_request("DELETE", f"/posts/{post_id}/voters", {"id": contact_id})
    print(f"  ✓ Removed voter {contact_id} from post {post_id}: {result}")
    return result


def fetch_voter_pool():
    """
    Fetch all contacts belonging to VOTER_COMPANY_ID by paginating GET /contacts
    and filtering by companyId. Caches results in _voter_pool.
    """
    global _voter_pool
    if not VOTER_COMPANY_ID:
        return
    if _voter_pool:
        return  # already fetched this run
    company_id = VOTER_COMPANY_ID.strip()
    print(f"  Fetching voter pool (paginating /contacts, filtering by company {company_id})...")
    ids = []
    cursor = None
    page = 0
    while True:
        page += 1
        path = "/contacts"
        if cursor:
            path += f"?cursor={cursor}"
        result = api_request("GET", path)
        contacts = result.get("data", [])
        for c in contacts:
            # Check if this contact belongs to our company
            for company in c.get("companies", []):
                if company.get("companyId") == company_id or company.get("id") == company_id:
                    cid = c.get("id")
                    if cid:
                        ids.append(cid)
                    break
        cursor = result.get("nextCursor")
        if not cursor or not contacts:
            break
    random.shuffle(ids)  # shuffle once so each run assigns voters randomly but non-overlapping
    _voter_pool = ids
    print(f"  Voter pool: {len(_voter_pool)} contacts available (fetched {page} page(s))")


def fetch_post_voters(post_id):
    """Return the set of contact IDs who have ALREADY upvoted this specific post
    (live from Featurebase, via GET /posts/{id}/voters — the same nested resource
    we already POST to when adding a voter, using this API's standard cursor
    pagination). Used to make sure vote top-ups never re-target someone who's
    already voted on this post.

    NOTE: an earlier version of this called GET /posts/upvoters?submissionId=...,
    based on an unofficial third-party wrapper's README. That path doesn't exist
    in Featurebase's real v2 REST API — it was being matched by their generic
    GET /posts/{id} route with id="upvoters", hence the "Invalid post ID format"
    errors. Fixed to use the documented nested-resource + cursor pattern instead.
    """
    ids = set()
    cursor = None
    while True:
        path = f"/posts/{post_id}/voters?limit=100"
        if cursor:
            path += f"&cursor={cursor}"
        try:
            result = api_request("GET", path)
        except Exception as e:
            print(f"    ⚠ Could not fetch existing voters for post {post_id}: {e}")
            break
        data = result.get("data", []) if isinstance(result, dict) else (result or [])
        if not data:
            break
        for v in data:
            vid = v.get("id") or v.get("_id")
            if vid:
                ids.add(vid)
        cursor = result.get("nextCursor") if isinstance(result, dict) else None
        if not cursor:
            break
    return ids


def seed_voters(post_id, mentions, pool=None, pool_label="research pool"):
    """Add up to min(mentions, available contacts) voters to a post.

    `pool` overrides the generic research pool — used to vote as the contact
    linked to the company behind the insight's source label.

    Draws from the FULL voter pool every time (the same real research
    participants can legitimately upvote many different posts — there's no
    reason to ration a shared pool across posts). The only real constraint is
    never voting twice on the SAME post, which is enforced by fetching that
    post's actual current voters live and excluding them.
    Returns n_ok (number of voters successfully added)."""
    voters = list(pool) if pool else _voter_pool
    if not voters:
        print(f"    ⚠ Voter pool is empty — no voters seeded")
        return 0
    already_voted = fetch_post_voters(post_id)
    available = [c for c in voters if c not in already_voted]
    skipped = len(voters) - len(available)
    n_target = min(mentions, len(available))
    if n_target == 0:
        print(f"    ⚠ No unique voters left for this post ({skipped}/{len(voters)} already voted on it)")
        return 0
    note = f" ({skipped} already-voted contact(s) skipped)" if skipped else ""
    print(f"    Seeding {n_target} new voter(s) from the {pool_label} for post {post_id}{note}...")
    n_ok = 0
    for contact_id in available[:n_target]:
        try:
            api_request("POST", f"/posts/{post_id}/voters", {"id": contact_id})
            n_ok += 1
            time.sleep(0.15)
        except Exception as e:
            print(f"    ⚠ Could not add voter {contact_id}: {e}")
    print(f"    Voter seeding done: {n_ok}/{n_target} succeeded")
    return n_ok


# ---------------------------------------------------------------------------
# Outbound sync
# ---------------------------------------------------------------------------


def voter_context(ins, allow_generic=False, force_contact=None):
    """Decide who should cast this insight's votes.

    Returns (pool, label, blocked, message). A source that resolves to a stored
    company must vote as that company's linked contact — never as the generic
    research account. When the company resolves but cannot vote (no linked
    contact, or duplicate records with contacts), seeding is BLOCKED rather than
    silently falling back, unless --allow-generic-votes is passed.
    """
    if force_contact:
        return [force_contact], f"forced voter {force_contact}", False, ""
    res = resolve_company(ins.get("source") or ins.get("source_label") or "")
    st = res["status"]
    if st in ("exact", "normalised", "alias", "segment"):
        c = res["company"]
        return (list(c["contacts"]), f"company {c['name']} ({len(c['contacts'])} linked contact(s))",
                False, f"source '{res['label']}' → company {c['name']} [{st} match]")
    if st == "no_contacts":
        c = res["company"]
        msg = (f"source '{res['label']}' matches stored company {c['name']} ({c['id']}) but that "
               f"company has no linked contact to vote as")
        if allow_generic:
            return _voter_pool, "generic research pool (override)", False, msg + " — --allow-generic-votes given"
        return [], "", True, msg
    if st == "ambiguous":
        names = ", ".join(f"{c['name']} ({c['id']}, {len(c['contacts'])} contacts)" for c in res["candidates"])
        msg = f"source '{res['label']}' matches several stored companies with contacts: {names}"
        if allow_generic:
            return _voter_pool, "generic research pool (override)", False, msg + " — --allow-generic-votes given"
        return [], "", True, msg
    return _voter_pool, "generic research pool", False, ""


def push_insights(insights, dry_run=False, ids=None, no_save=False, allow_generic=False, vote_as=None):
    targets = qualifying_insights(insights, ids=ids)
    label = f"ID(s) {ids}" if ids else "qa_reviewed (all types, not Released/Well done)"
    print(f"\n{'DRY RUN — ' if dry_run else ''}{label} insights to push: {len(targets)}\n")
    if no_save:
        print("  ⚠ --push-no-save mode: insights.json will NOT be updated\n")

    by_id = {ins["id"]: ins for ins in insights}
    created, updated, errors = 0, 0, 0
    blocked_votes = []

    if not dry_run:
        fetch_voter_pool()
        fetch_companies()

    for ins in targets:
        fid = ins.get("featurebase_id")
        payload = build_post_payload(ins)
        board_id = payload["boardId"]
        if board_id == MISSING_FEATURE_BOARD:
            board_name = "Missing Feature board"
        elif board_id == PRODUCT_BOARD:
            board_name = "Product board"
        else:
            board_name = "Feedback board"

        if dry_run:
            votes_only = board_id == PRODUCT_BOARD and fid
            action = "VOTES-ONLY" if votes_only else ("UPDATE" if fid else "CREATE")
            votes_needed = max(0, ins.get("mentions", 0) - ins.get("featurebase_votes", 0))
            print(f"  [{action}] ID {ins['id']} — {ins['mentions']} mentions — type: {ins.get('type')} — board: {board_name}")
            print(f"    title: {payload['title'][:90]}")
            if fid:
                print(f"    featurebase_id: {fid}")
            if votes_needed:
                print(f"    votes to top up: +{votes_needed} (mentions {ins.get('mentions', 0)} vs featurebase_votes {ins.get('featurebase_votes', 0)})")
                _pool, _plabel, _blocked, _msg = voter_context(ins, allow_generic, vote_as)
                if _msg:
                    print(f"    company check: {_msg}")
                print(f"    voter source: {'BLOCKED — no vote would be seeded' if _blocked else _plabel}")
            if votes_only:
                print(f"    (Product board post — content/customFields untouched, votes only)")
            elif "customFields" in payload:
                print(f"    customFields ({len(payload['customFields'])} fields):")
                for k, v in payload["customFields"].items():
                    preview = str(v)[:70] + ("…" if len(str(v)) > 70 else "")
                    print(f"      {k}: {preview!r}")
            else:
                print(f"    content fallback (no custom field IDs configured)")
            continue

        if not MISSING_FEATURE_BOARD or not FEEDBACK_BOARD:
            print("Error: MISSING_FEATURE_BOARD or FEEDBACK_BOARD is not set. Run --list-boards to find your board IDs.")
            sys.exit(1)

        try:
            if fid:
                if board_id == PRODUCT_BOARD:
                    # Hand-curated roadmap post — never touch title/content/customFields,
                    # only top up votes.
                    print(f"  ✓ Skipped content update for ID {ins['id']} (Product board post {fid} — votes only)")
                else:
                    api_request("PATCH", f"/posts/{fid}", payload)
                    if not no_save:
                        by_id[ins["id"]]["featurebase_synced_at"] = _now()
                    print(f"  ✓ Updated ID {ins['id']} (featurebase: {fid}, board: {board_name})")
                # Top up votes if research mentions have grown past what's synced
                votes_needed = max(0, ins.get("mentions", 0) - ins.get("featurebase_votes", 0))
                pool, plabel, blocked, msg = voter_context(ins, allow_generic, vote_as)
                if msg:
                    print(f"    company check: {msg}")
                if votes_needed and blocked:
                    print(f"    ⛔ Votes NOT seeded for ID {ins['id']} — resolve the company voter, "
                          f"or re-run with --vote-as CONTACT_ID / --allow-generic-votes")
                    blocked_votes.append((ins["id"], msg))
                    n = 0
                elif pool and votes_needed:
                    n = seed_voters(fid, min(votes_needed, len(pool)), pool=pool, pool_label=plabel)
                    remainder = votes_needed - (n or 0)
                    if remainder > 0 and _voter_pool and pool is not _voter_pool:
                        print(f"    {remainder} vote(s) beyond this company's linked contact(s) "
                              f"come from the generic research pool")
                        n = (n or 0) + (seed_voters(fid, remainder, pool=_voter_pool,
                                                    pool_label="generic research pool") or 0)
                    if not no_save:
                        by_id[ins["id"]]["featurebase_votes"] = ins.get("featurebase_votes", 0) + (n or 0)
                        by_id[ins["id"]]["featurebase_synced_at"] = _now()
                    print(f"    → {n} vote(s) topped up")
                updated += 1
            elif board_id == PRODUCT_BOARD:
                # Should never happen (Product board posts are only ever linked,
                # never created by push) — guard against a bad board_for() result.
                print(f"  ⚠ Skipped ID {ins['id']}: would CREATE on Product board — refusing, check featurebase_board_id")
            else:
                result = api_request("POST", "/posts", payload)
                new_fid = result.get("_id") or result.get("id", "")
                if not no_save:
                    by_id[ins["id"]]["featurebase_id"] = new_fid
                    by_id[ins["id"]]["featurebase_board_id"] = board_id
                    by_id[ins["id"]]["featurebase_synced_at"] = _now()
                    by_id[ins["id"]]["featurebase_votes"] = 0
                print(f"  ✓ Created ID {ins['id']} → featurebase post {new_fid} (board: {board_name})")
                if no_save:
                    print(f"    ℹ Note the post ID above — paste it into insights.json when ready to link")
                # Seed upvotes from research mentions
                pool, plabel, blocked, msg = voter_context(ins, allow_generic, vote_as)
                if msg:
                    print(f"    company check: {msg}")
                if blocked:
                    print(f"    ⛔ Votes NOT seeded for ID {ins['id']} — resolve the company voter, "
                          f"or re-run with --vote-as CONTACT_ID / --allow-generic-votes")
                    blocked_votes.append((ins["id"], msg))
                    n = 0
                elif pool:
                    want = ins.get("mentions", 0)
                    n = seed_voters(new_fid, min(want, len(pool)), pool=pool, pool_label=plabel)
                    remainder = want - (n or 0)
                    if remainder > 0 and _voter_pool and pool is not _voter_pool:
                        print(f"    {remainder} vote(s) beyond this company's linked contact(s) "
                              f"come from the generic research pool")
                        n = (n or 0) + (seed_voters(new_fid, remainder, pool=_voter_pool,
                                                    pool_label="generic research pool") or 0)
                    if not no_save:
                        by_id[ins["id"]]["featurebase_votes"] = n or 0
                    print(f"    → {n} vote(s) seeded")
                created += 1
            time.sleep(0.3)
        except Exception:
            errors += 1

    if blocked_votes:
        print("\n⛔ Votes withheld — the source resolves to a company that cannot vote yet:")
        for iid, msg in blocked_votes:
            print(f"    ID {iid}: {msg}")

    if not dry_run and not no_save:
        save_insights(list(by_id.values()))
        print(f"\nDone. Created: {created}, Updated: {updated}, Errors: {errors}")
    elif not dry_run and no_save:
        print(f"\nDone (no-save). Created: {created}, Updated: {updated}, Errors: {errors}")
        print("insights.json was NOT modified.")
    else:
        print(f"\nDry run complete. Run --push to execute.")


# ---------------------------------------------------------------------------
# Inbound vote pull
# ---------------------------------------------------------------------------

def pull_votes(insights):
    """
    Pull current upvote counts from Featurebase.

    Delta logic: featurebase_votes stores the LAST KNOWN vote count from Featurebase.
    New votes since the last pull (delta) are added directly to mentions,
    because upvotes and internal research observations are the same signal
    from customers via different channels.
    """
    by_id = {ins["id"]: ins for ins in insights}
    targets = [ins for ins in insights if ins.get("featurebase_id")]
    print(f"\nPulling vote counts for {len(targets)} synced insights...\n")

    total_new_votes = 0
    status_flags = []
    errors = 0

    for ins in targets:
        fid = ins["featurebase_id"]
        try:
            post = api_request("GET", f"/posts/{fid}")
            new_votes = post.get("votesCount", 0)
            prev_votes = ins.get("featurebase_votes", 0)
            delta = max(0, new_votes - prev_votes)

            # Add new votes to mentions
            if delta > 0:
                by_id[ins["id"]]["mentions"] = ins.get("mentions", 0) + delta
                total_new_votes += delta
                print(f"  ID {ins['id']}: {prev_votes} → {new_votes} votes (+{delta} added to mentions)")
            else:
                print(f"  ID {ins['id']}: {new_votes} votes (no change)")

            # Always update the stored vote count
            by_id[ins["id"]]["featurebase_votes"] = new_votes
            by_id[ins["id"]]["featurebase_synced_at"] = _now()

            # Flag if Featurebase status diverges from insights.json status
            fb_status_name = post.get("postStatus", {}).get("name", "")
            mapped = FEATUREBASE_STATUS_MAP.get(fb_status_name)
            if mapped and mapped != ins.get("status", ""):
                status_flags.append({
                    "id": ins["id"],
                    "title": ins.get("insight", "")[:70],
                    "featurebase_status": fb_status_name,
                    "suggested_insights_status": mapped,
                    "current_insights_status": ins.get("status", ""),
                })

            time.sleep(0.2)
        except Exception:
            errors += 1

    save_insights(list(by_id.values()))
    print(f"\nDone. {total_new_votes} new votes added to mentions across {len(targets)} insights. Errors: {errors}")

    if status_flags:
        print(f"\n⚠  {len(status_flags)} status discrepancies to review manually:\n")
        for f in status_flags:
            print(f"  ID {f['id']}: Featurebase='{f['featurebase_status']}' → "
                  f"suggested insights status: '{f['suggested_insights_status']}'")
            print(f"    (current: '{f['current_insights_status']}')")
            print(f"    {f['title']}")
            print()


# ---------------------------------------------------------------------------
# Featurebase ID cross-check
# ---------------------------------------------------------------------------

def fetch_all_board_posts(board_id=None):
    """
    Paginate GET /posts?boardId=... and return a list of all post objects.
    Each post includes its customFields dict.
    """
    target_board = board_id or MISSING_FEATURE_BOARD
    posts = []
    cursor = None
    page = 0
    while True:
        page += 1
        path = f"/posts?boardId={target_board}&limit=50"
        if cursor:
            path += f"&cursor={cursor}"
        result = api_request("GET", path)
        batch = result.get("data", []) if isinstance(result, dict) else result
        posts.extend(batch)
        cursor = result.get("nextCursor") if isinstance(result, dict) else None
        if not cursor or not batch:
            break
    return posts


def check_ids(insights, target_ids=None, apply_links=False):
    """
    Scan all Featurebase posts in the board and cross-reference the
    'Insight ID' custom field against insights.json.

    Prints a report of:
      - Matches (local featurebase_id agrees with the post found in Featurebase)
      - Conflicts (post found in Featurebase by custom field but insights.json
        has a different or missing featurebase_id — e.g. after a reset)
      - Missing (insight has featurebase_id locally but no post found in Featurebase)
      - Unlinked (post found in Featurebase by custom field, but insights.json has
        no featurebase_id at all yet — e.g. you manually set the custom field on an
        existing post instead of pushing it from here)

    If target_ids is given, only reports on those insight IDs (required to catch
    insights that have NO featurebase_id locally yet, since those are otherwise
    excluded from the default check_set).

    If apply_links=True, every "unlinked" match gets written back into
    insights.json (featurebase_id + featurebase_votes from the live post) so
    future --push runs correctly UPDATE instead of CREATE. This never touches
    boardId/content — it's a pure local field fill, safe to run any time.
    """
    insight_id_field = CUSTOM_FIELD_IDS.get("insight_id", "").strip()
    if not insight_id_field:
        print("⚠  CUSTOM_FIELD_IDS['insight_id'] is not configured — cannot check by custom field.")
        print("   Will only check by featurebase_id stored in insights.json.")

    by_local_id = {ins["id"]: ins for ins in insights}
    if target_ids:
        check_set = set(target_ids)
    else:
        check_set = {ins["id"] for ins in insights if ins.get("featurebase_id")}

    boards_to_check = [b for b in {MISSING_FEATURE_BOARD, FEEDBACK_BOARD, PRODUCT_BOARD} if b]
    posts = []
    for b in boards_to_check:
        print(f"\nFetching all posts from board {b}...")
        board_posts = fetch_all_board_posts(board_id=b)
        print(f"  Found {len(board_posts)} posts.")
        for p in board_posts:
            p["_scanned_board"] = b
        posts.extend(board_posts)
    print(f"\nTotal posts across {len(boards_to_check)} board(s): {len(posts)}.\n")

    # Build lookup: featurebase_post_id → post, and insight_id_value → list of posts
    fb_by_post_id = {(p.get("_id") or p.get("id")): p for p in posts}
    fb_by_insight_id: dict[int, list] = {}   # int → list of posts (catches duplicates)
    if insight_id_field:
        for p in posts:
            cf = p.get("customFields") or {}
            iid = cf.get(insight_id_field)
            if iid is not None:
                try:
                    key = int(iid)
                    fb_by_insight_id.setdefault(key, []).append(p)
                except (ValueError, TypeError):
                    pass

    duplicates = []
    conflicts = []
    matches = []
    missing = []
    unlinked = []

    for iid in sorted(check_set):
        ins = by_local_id.get(iid)
        if not ins:
            continue
        local_fid = ins.get("featurebase_id")
        title = ins.get("featurebase_title") or ins.get("insight", "")[:60]

        fb_posts = fb_by_insight_id.get(iid, [])   # all posts with this Insight ID
        fb_post_by_id = fb_by_post_id.get(local_fid)  # post found via stored ID

        if len(fb_posts) > 1:
            # Multiple Featurebase posts share this Insight ID — definite duplicate
            post_ids = [p.get("_id") or p.get("id") for p in fb_posts]
            post_titles = [p.get("title", "")[:50] for p in fb_posts]
            duplicates.append((iid, local_fid, post_ids, post_titles, title))
        elif len(fb_posts) == 1:
            fb_post = fb_posts[0]
            found_id = fb_post.get("_id") or fb_post.get("id")
            if local_fid and found_id == local_fid:
                matches.append((iid, local_fid, title))
            elif local_fid and found_id != local_fid:
                conflicts.append((iid, local_fid, found_id, title, fb_post.get("upvotes", 0), fb_post.get("_scanned_board")))
            else:
                # Found in FB by custom field but no local featurebase_id
                unlinked.append((iid, found_id, title, fb_post.get("upvotes", 0), fb_post.get("_scanned_board")))
        else:
            # Not found in FB by custom field
            if local_fid:
                if fb_post_by_id:
                    matches.append((iid, local_fid, title + " [custom field not set in FB]"))
                else:
                    missing.append((iid, local_fid, title))
            # else: not synced at all — no action needed

    # Report
    if duplicates:
        print(f"\n🔴 {len(duplicates)} DUPLICATE(S) — multiple Featurebase posts share the same Insight ID:")
        for iid, local_fid, post_ids, post_titles, title in duplicates:
            print(f"    Insight {iid}: {len(post_ids)} posts in Featurebase")
            for pid, ptitle in zip(post_ids, post_titles):
                marker = " ← linked in insights.json" if pid == local_fid else ""
                print(f"      post {pid}  '{ptitle}'{marker}")
        print("  → Delete the unwanted duplicate(s) in Featurebase, then run --check-ids again.")
    if matches:
        print(f"\n✓ {len(matches)} in sync:")
        for iid, fid, title in matches:
            print(f"    ID {iid} → {fid}  {title[:60]}")
    if conflicts:
        print(f"\n⚠  {len(conflicts)} CONFLICT(S) — custom field ID differs from stored featurebase_id:")
        for iid, local_fid, found_id, title, upvotes, board in conflicts:
            board_note = " [PRODUCT BOARD]" if board == PRODUCT_BOARD else ""
            print(f"    ID {iid}: insights.json has {local_fid}, Featurebase post has ID {found_id} ({upvotes} upvotes){board_note}")
            print(f"      {title[:60]}")

        if apply_links:
            by_local_id_c = {ins["id"]: ins for ins in insights}
            for iid, local_fid, found_id, title, upvotes, board in conflicts:
                ins = by_local_id_c[iid]
                ins["featurebase_id"] = found_id
                ins["featurebase_board_id"] = board  # preserved on future updates — never moved
                ins["featurebase_votes"] = upvotes
                ins["featurebase_synced_at"] = _now()
            save_insights(list(by_local_id_c.values()))
            print(f"  ✓ Re-pointed {len(conflicts)} insight(s) to their new post ID "
                  f"(board recorded per-insight, so future updates stay on that board — Product board posts included).")
        else:
            print("  → Re-run with --apply-links to fix these automatically. Board is recorded per-insight, "
                  "so future updates (including vote top-ups) never move a post off the Product board.")
    if unlinked:
        print(f"\n⚠  {len(unlinked)} found in Featurebase by custom field but NOT linked in insights.json:")
        for iid, found_id, title, upvotes, board in unlinked:
            board_note = " [PRODUCT BOARD]" if board == PRODUCT_BOARD else ""
            print(f"    Insight {iid} → Featurebase post {found_id} ({upvotes} upvotes){board_note}  {title[:60]}")

        if apply_links:
            by_local_id_w = {ins["id"]: ins for ins in insights}
            for iid, found_id, title, upvotes, board in unlinked:
                ins = by_local_id_w[iid]
                ins["featurebase_id"] = found_id
                ins["featurebase_board_id"] = board  # preserved on future updates — never moved
                ins["featurebase_votes"] = upvotes
                ins["featurebase_synced_at"] = _now()
            save_insights(list(by_local_id_w.values()))
            print(f"  ✓ Linked {len(unlinked)} insight(s) into insights.json (featurebase_id + featurebase_votes filled in, "
                  f"board recorded per-insight so future updates — including vote top-ups — stay on that board).")
        else:
            print("  → Re-run with --check-ids --apply-links --id ... to write these into insights.json "
                  "(NOTE: --push would create a NEW duplicate post here, it does not auto-link by custom field).")
    if missing:
        print(f"\n✗  {len(missing)} have featurebase_id locally but post NOT found in Featurebase:")
        for iid, fid, title in missing:
            print(f"    ID {iid} (stored fid: {fid})  {title[:60]}")
        print("  → Post may have been deleted. Run --push to recreate.")

    print(f"\nSummary: {len(matches)} ok · {len(duplicates)} duplicates · "
          f"{len(conflicts)} conflicts · {len(unlinked)} unlinked · {len(missing)} missing")
    return {"matches": matches, "duplicates": duplicates, "conflicts": conflicts,
            "unlinked": unlinked, "missing": missing}


# ---------------------------------------------------------------------------
# Merged-post discovery
# ---------------------------------------------------------------------------

def find_merged_posts(insights):
    """
    Diagnostic: scan both boards for any sign that Featurebase's own "merge"
    feature was used on a post (merged posts are usually kept in the
    background so they can be un-merged later, per Featurebase's docs).

    We don't know Featurebase's exact field name for this relationship yet,
    so this prints two things:
      1. Any top-level field on any post whose key or value looks
         merge/duplicate-related (case-insensitive match on "merge" or
         "duplicate") — this is what should reveal the real field name.
      2. The raw JSON of the first 2 posts on each board, so we can see the
         full shape of a post object and spot the field manually if the
         keyword scan finds nothing.

    Once we know the real field, this function will be upgraded to
    automatically map merged-away posts back to their insight IDs via the
    "Insight ID" custom field, so qualifying_insights() can exclude them
    without you having to track IDs by hand.
    """
    insight_id_field = CUSTOM_FIELD_IDS.get("insight_id", "").strip()
    by_local_fid = {}
    for ins in insights:
        fid = ins.get("featurebase_id")
        if fid:
            by_local_fid[fid] = ins["id"]

    boards = [
        ("Missing Feature board", MISSING_FEATURE_BOARD),
        ("Feedback board", FEEDBACK_BOARD),
        ("Product board", PRODUCT_BOARD),
    ]
    found_any = False

    for name, board_id in boards:
        if not board_id:
            continue
        print(f"\n--- {name} ({board_id}) ---")
        posts = fetch_all_board_posts(board_id=board_id)
        print(f"  {len(posts)} posts fetched.")

        for post in posts:
            hits = {}
            for k, v in post.items():
                key_hit = "merge" in k.lower() or "duplicate" in k.lower()
                val_hit = isinstance(v, str) and ("merge" in v.lower() or "duplicate" in v.lower())
                if key_hit or val_hit:
                    hits[k] = v
            if hits:
                found_any = True
                pid = post.get("_id") or post.get("id")
                local_iid = by_local_fid.get(pid, "?")
                print(f"  ⚑ Post {pid} (insight {local_iid}) '{post.get('title','')[:50]}' — suspicious field(s):")
                for k, v in hits.items():
                    print(f"      {k}: {v!r}")

            # Separately: check if the "Insight ID" custom field is already populated
            # on this post (would mean someone manually linked it — direct evidence
            # of which insight(s) this combined post represents).
            if insight_id_field:
                cf_val = (post.get("customFields") or {}).get(insight_id_field)
                if cf_val:
                    found_any = True
                    pid = post.get("_id") or post.get("id")
                    print(f"  🔗 Post {pid} '{post.get('title','')[:50]}' has Insight ID custom field set: {cf_val!r}")

        if posts:
            print(f"\n  Raw shape of first post on {name} (for manual inspection):")
            print(json.dumps(posts[0], indent=2, ensure_ascii=False)[:2000])

    if not found_any:
        print("\nNo obviously merge/duplicate-named fields found via keyword scan.")
        print("Check the raw post JSON printed above for a field that records the merge "
              "(Featurebase's docs mention merged posts are kept, so it should be there — "
              "possibly under a different name, or only visible via the post's activity/history endpoint).")
        print("Share the raw JSON with Claude and it can wire up automatic exclusion from that.")


# ---------------------------------------------------------------------------
# Bulk field fill
# ---------------------------------------------------------------------------

def fill_field(field_id, values, board_id=None):
    """
    Patch all posts on the board with a preset custom field value.
    values should be a list of strings (multi-select).
    board_id overrides MISSING_FEATURE_BOARD if provided.
    """
    target_board = board_id or MISSING_FEATURE_BOARD
    print(f"\nFetching all posts from board {target_board}...")
    posts = fetch_all_board_posts(board_id=target_board)
    print(f"Found {len(posts)} posts. Patching field {field_id} → {values} on all...\n")
    ok, skipped, errors = 0, 0, 0
    for post in posts:
        pid = post.get("_id") or post.get("id", "")
        title = post.get("title", "")[:60]
        # Skip if field already has a value
        existing = (post.get("customFields") or {}).get(field_id)
        if existing:
            print(f"  — skipped (already set: {existing})  {title}")
            skipped += 1
            continue
        try:
            api_request("PATCH", f"/posts/{pid}", {"customFields": {field_id: values}})
            print(f"  ✓ {pid}  {title}")
            ok += 1
            time.sleep(0.2)
        except Exception as e:
            print(f"  ✗ {pid}  {title}  — {e}")
            errors += 1
    print(f"\nDone. {ok} updated · {skipped} already set (skipped) · {errors} errors.")


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def _now():
    return datetime.datetime.utcnow().isoformat() + "Z"


# ---------------------------------------------------------------------------
# Entrypoint
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(description="Featurebase sync for Noxtua insights")
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("--dry-run",           action="store_true", help="Preview without API calls")
    group.add_argument("--push",              action="store_true", help="Push qualifying Missing Feature insights")
    group.add_argument("--push-no-save",      action="store_true", help="Push to Featurebase but do NOT update insights.json (use when linking to a fix temporarily)")
    group.add_argument("--pull-votes",        action="store_true", help="Pull vote counts and add delta to mentions")
    group.add_argument("--list-boards",       action="store_true", help="List your Featurebase boards and IDs")
    group.add_argument("--list-companies",    action="store_true", help="List your Featurebase companies and IDs")
    group.add_argument("--resolve-company", metavar="LABEL", help="Show which stored company a source label resolves to, and who would vote")
    group.add_argument("--unvote", metavar="POST_ID", help="Remove one voter from a post (needs --contact)")
    group.add_argument("--list-custom-fields",action="store_true", help="List custom fields and IDs — paste IDs into CUSTOM_FIELD_IDS")
    group.add_argument("--check-ids",         action="store_true", help="Cross-check Featurebase posts against insights.json via the Insight ID custom field")
    parser.add_argument("--apply-links",      action="store_true", help="With --check-ids: write back featurebase_id/votes for any 'unlinked' matches found (safe, local-only field fill)")
    group.add_argument("--find-merged",       action="store_true", help="Scan both boards for signs of Featurebase's native merge feature (diagnostic, prints raw post shape)")
    group.add_argument("--inspect-post",      metavar="POST_ID",   help="Fetch a single post's full detail (GET /posts/ID) and print raw JSON — use to find fields not shown in the board list view (e.g. merged-post info)")
    group.add_argument("--debug-company",     action="store_true", help="Print raw API response for VOTER_COMPANY_ID contacts")
    group.add_argument("--seed-voters-for",   metavar="POST_ID",   help="Seed voters directly for a specific Featurebase post ID (use with --mentions N)")
    group.add_argument("--fill-field",        action="store_true", help="Set a custom field to a preset value on ALL board posts (use with --field-id and --field-value)")
    parser.add_argument("--id", type=int, nargs="+", metavar="ID",
                        help="One or more insight IDs to process (e.g. --id 151 162 203)")
    parser.add_argument("--mentions", type=int, default=10, metavar="N",
                        help="Number of votes to seed when using --seed-voters-for (default: 10)")
    parser.add_argument("--field-id",    metavar="ID",      help="Custom field ID for --fill-field")
    parser.add_argument("--field-value", metavar="VALUE", nargs="+", help="Value(s) to set for --fill-field (multi-select: pass multiple values separated by spaces)")
    parser.add_argument("--contact", help="Contact ID, for --unvote")
    parser.add_argument("--vote-as", metavar="CONTACT_ID", help="Force this contact as the voter for this run")
    parser.add_argument("--allow-generic-votes", action="store_true",
                        help="Permit generic research-pool votes even when the source resolves to a company that cannot vote")
    parser.add_argument("--board-id",    metavar="BOARD_ID", help="Override the default board ID (e.g. for --fill-field on a different board)")
    args = parser.parse_args()

    if not FEATUREBASE_API_KEY and not args.dry_run:
        print("Error: FEATUREBASE_API_KEY not set.")
        print("  Set it as an environment variable: export FEATUREBASE_API_KEY=your_key_here")
        sys.exit(1)

    if args.list_boards:
        boards = api_request("GET", "/boards")
        print("\nYour Featurebase boards:\n")
        board_list = boards if isinstance(boards, list) else boards.get("data", [])
        for b in board_list:
            print(f"  ID: {b.get('_id') or b.get('id')}   Name: {b.get('name')}")
        print("\nPaste the correct ID into MISSING_FEATURE_BOARD at the top of this script.")
        return

    if args.list_companies:
        companies = fetch_companies()
        print("\nYour Featurebase companies:\n")
        names = {}
        for c in sorted(companies, key=lambda x: x["name"].lower()):
            names.setdefault(c["name"].lower(), []).append(c)
            flag = "" if c["contacts"] else "   ⚠ no linked contact — cannot vote as this company"
            print(f"  ID: {c['id']}   Name: {c['name']}   contacts: {len(c['contacts'])}{flag}")
        dupes = {n: v for n, v in names.items() if len(v) > 1}
        if dupes:
            print("\n⚠ Duplicate company names — the record WITH linked contacts is the one used for voting:")
            for n, v in dupes.items():
                for c in v:
                    mark = " ← used" if c["contacts"] else " (empty duplicate)"
                    print(f"    {c['name']}: {c['id']} — {len(c['contacts'])} contact(s){mark}")
        print("\nPaste the correct ID into VOTER_COMPANY_ID at the top of this script.")
        return

    if args.resolve_company:
        res = resolve_company(args.resolve_company)
        print(f"\nSource label: {args.resolve_company!r}")
        print(f"  status      : {res['status']}")
        print(f"  matched part: {res['label']!r}")
        if res["company"]:
            c = res["company"]
            print(f"  company     : {c['name']} ({c['id']})")
            print(f"  contacts    : {len(c['contacts'])} → {c['contacts'][:5]}")
        for cand in res["candidates"]:
            print(f"    candidate : {cand['name']} ({cand['id']}) — {len(cand['contacts'])} contact(s)")
        if res["status"] == "none":
            print("  → no company match; votes would come from the generic research pool")
        elif res["status"] in ("ambiguous", "no_contacts"):
            print("  → BLOCKED: resolve the company voter before pushing (see --vote-as / --allow-generic-votes)")
        return

    if args.unvote:
        if not args.contact:
            print("Error: --unvote needs --contact CONTACT_ID"); sys.exit(1)
        unvote(args.unvote, args.contact)
        return

    if args.list_custom_fields:
        result = api_request("GET", "/custom_fields")
        fields = result if isinstance(result, list) else result.get("data", [])
        print("\nYour Featurebase custom fields:\n")
        for f in fields:
            fid   = f.get("id", "")
            label = f.get("label", "")
            ftype = f.get("type", "")
            print(f"  ID: {fid}   Label: {label!r}   Type: {ftype}")
        print("\nPaste the IDs into CUSTOM_FIELD_IDS at the top of this script.")
        print("The four fields you need: 'Insight ID', 'User Need', 'Quotes', 'Affected Customer Segment'")
        print("(Create them in Featurebase UI → Settings → Custom Fields if they don't exist yet.)")
        return

    if args.debug_company:
        company_id = VOTER_COMPANY_ID.strip()
        print(f"\n1) GET /companies/{company_id}/contacts:")
        result = api_request("GET", f"/companies/{company_id}/contacts")
        print(json.dumps(result, indent=2)[:1000])
        print(f"\n2) GET /contacts (first page):")
        result2 = api_request("GET", "/contacts")
        print(json.dumps(result2, indent=2)[:2000])
        return

    insights = load_insights()
    print(f"Loaded {len(insights)} insights from {INSIGHTS_JSON.name}")

    if args.dry_run:
        push_insights(insights, dry_run=True, ids=args.id, allow_generic=args.allow_generic_votes, vote_as=args.vote_as)
    elif args.push:
        push_insights(insights, dry_run=False, ids=args.id, allow_generic=args.allow_generic_votes, vote_as=args.vote_as)
    elif args.push_no_save:
        push_insights(insights, dry_run=False, ids=args.id, no_save=True, allow_generic=args.allow_generic_votes, vote_as=args.vote_as)
    elif args.pull_votes:
        pull_votes(insights)
    elif args.check_ids:
        check_ids(insights, target_ids=args.id, apply_links=args.apply_links)
    elif args.find_merged:
        find_merged_posts(insights)
    elif args.inspect_post:
        post = api_request("GET", f"/posts/{args.inspect_post.strip()}")
        print(json.dumps(post, indent=2, ensure_ascii=False))
    elif args.fill_field:
        if not args.field_id or not args.field_value:
            print("Error: --fill-field requires --field-id and --field-value")
            sys.exit(1)
        fill_field(args.field_id, args.field_value, board_id=args.board_id)
    elif args.seed_voters_for:
        post_id = args.seed_voters_for.strip()
        n_mentions = args.mentions
        print(f"\nSeeding up to {n_mentions} voter(s) for Featurebase post {post_id}...")
        fetch_voter_pool()
        if not _voter_pool:
            print("  ✗ Voter pool is empty — check VOTER_COMPANY_ID")
        else:
            n = seed_voters(post_id, n_mentions)
            print(f"\nDone. {n} vote(s) added to post {post_id}")


if __name__ == "__main__":
    main()
