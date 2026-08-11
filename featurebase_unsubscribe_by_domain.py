#!/usr/bin/env python3
"""
featurebase_unsubscribe_by_domain.py — Unsubscribe every Featurebase contact
whose email ends in one of DOMAINS (default: your own internal domains,
@noxtua.com and @xayn.com) from changelog/Update emails.

This is for internal/team accounts that ended up on the contact list (e.g.
via testing, admin-created records, etc.) and shouldn't be receiving your
own product changelog emails as if they were external subscribers.

USAGE:
    python3 featurebase_unsubscribe_by_domain.py

Configure below:
  DOMAINS = [...]     <- email domains (without the "@") to match.
  DRY_RUN = True       <- keep True until the printed list looks exactly
                          right, then set False and re-run.

Matches case-insensitively on the domain suffix, checking the "email" field
first and falling back to "name" for contacts whose email came back null
but whose address is stored there instead (this happens for some records —
run featurebase_debug_contacts.py if you're not sure).

"Already unsubscribed" is judged by manuallyOptedOutFromChangelog, NOT
subscribedToChangelog — the latter is often just false by default (never
explicitly toggled) even for people who are actively receiving Updates,
since Featurebase auto-subscribes anyone with an email. Treating that as
"already unsubscribed" was the bug in the previous version.

Identifies each contact for the write by email if it has one, otherwise by
userId (never by the internal "id" — see featurebase_subscribe_contacts.py
for why that field is rejected).
"""

import json
import os
import time
import urllib.error
import urllib.request

FEATUREBASE_API_KEY = os.environ.get("FEATUREBASE_API_KEY", "")
API_BASE = "https://do.featurebase.app/v2"

# ── Configure ────────────────────────────────────────────────────────────
DOMAINS = ["noxtua.com", "xayn.com"]
DRY_RUN = True
DELAY = 0.2
# ─────────────────────────────────────────────────────────────────────────


def api_request(method, path, body=None):
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
            raw = resp.read().decode("utf-8")
            return resp.status, (json.loads(raw) if raw else {})
    except urllib.error.HTTPError as e:
        raw = e.read().decode("utf-8", errors="replace")
        return e.code, raw


def fetch_all(path_base):
    """Paginate a list endpoint using Featurebase's cursor-based pagination
    (limit + cursor in, data + nextCursor out)."""
    items = []
    cursor = None
    while True:
        sep = "&" if "?" in path_base else "?"
        path = f"{path_base}{sep}limit=100"
        if cursor:
            path += f"&cursor={cursor}"
        status, result = api_request("GET", path)
        if status != 200:
            print(f"  Error fetching {path}: {status} {result}")
            break
        batch = result.get("data", []) if isinstance(result, dict) else (result or [])
        if not batch:
            break
        items.extend(batch)
        cursor = result.get("nextCursor") if isinstance(result, dict) else None
        if not cursor:
            break
    return items


def effective_email(c):
    """Prefer the real 'email' field; fall back to 'name' when email is null
    but the name field actually holds an address (seen in some records)."""
    email = (c.get("email") or "").strip().lower()
    if email and "@" in email:
        return email
    name = (c.get("name") or "").strip().lower()
    if "@" in name:
        return name
    return ""


def main():
    domains = [d.strip().lower().lstrip("@") for d in DOMAINS if d.strip()]
    if not domains:
        print("⚠️  DOMAINS is empty — add at least one domain (e.g. 'noxtua.com').")
        return

    print(f"Matching emails ending in: {', '.join('@' + d for d in domains)}\n")
    print("Fetching all contacts...")
    contacts = fetch_all("/contacts?contactType=all")
    print(f"  {len(contacts)} total contacts fetched.\n")

    targets = []
    already = []
    for c in contacts:
        addr = effective_email(c)
        if not addr:
            continue
        if not any(addr.endswith("@" + d) for d in domains):
            continue
        if c.get("manuallyOptedOutFromChangelog") is True:
            already.append(addr)
            continue
        targets.append(c)

    print(f"Matched {len(targets)} contact(s) to unsubscribe:\n")
    for c in targets:
        via_name = not (c.get("email") or "").strip()
        tag = "  [address from 'name', email field is null]" if via_name else ""
        print(f"  - {c.get('name') or '(no name)'} <{effective_email(c)}>{tag}")

    if already:
        print(f"\nAlready opted out (manuallyOptedOutFromChangelog=True), skipping ({len(already)}):")
        for e in already:
            print(f"  - {e}")

    if DRY_RUN:
        print("\n🔍 DRY RUN — no changes made. Set DRY_RUN = False to actually unsubscribe them.")
        return

    print("\nUnsubscribing...\n")
    ok, fail = 0, 0
    for c in targets:
        addr = effective_email(c)
        real_email = (c.get("email") or "").strip()
        # manuallyOptedOutFromChangelog is read-only (rejected on POST) —
        # subscribedToChangelog is the only field the API lets you write.
        body = {
            "subscribedToChangelog": False,
        }
        if real_email:
            body["email"] = real_email
        elif c.get("userId"):
            body["userId"] = c["userId"]
        else:
            fail += 1
            print(f"  ❌  {addr} -> no email or userId to identify this contact by, skipped.")
            continue

        status, resp = api_request("POST", "/contacts", body)
        if status in (200, 201):
            ok += 1
            print(f"  ✅  {addr}")
        else:
            fail += 1
            print(f"  ❌  {addr} -> {status}: {str(resp)[:150]}")
        time.sleep(DELAY)

    print(f"\nDone. Unsubscribed: {ok}/{len(targets)}", end="")
    print(f", {fail} failed." if fail else ".")


if __name__ == "__main__":
    main()
