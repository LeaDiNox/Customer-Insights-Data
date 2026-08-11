#!/usr/bin/env python3
"""
featurebase_debug_contacts.py — Diagnose why some contacts are
mis-categorized by the subscribe/unsubscribe scripts.

Fill in EXAMPLE_EMAILS below with 2-3 real addresses that are behaving
wrong, e.g.:
  - one person you know IS subscribed, but the unsubscribe script showed
    as "already unsubscribed"
  - one @noxtua.com person who didn't show up in EITHER list at all

Run:
    python3 featurebase_debug_contacts.py

This makes no changes. It prints:
  1) Total contacts fetched, and how many end in @noxtua.com / @xayn.com
     using a loose, case-insensitive substring check across every string
     field on the contact (not just "email") — this will reveal if some
     of these people are stored with the domain somewhere other than the
     top-level "email" field.
  2) The full raw JSON for each EXAMPLE_EMAILS entry, found by scanning
     every string field (not just "email") for a case-insensitive match —
     so it'll find the record even if the address lives in "userId" or a
     custom field instead of "email". If truly not found in the fetched
     list at all, that points to a pagination/contactType issue rather
     than a field-naming issue.
"""

import json
import os
import urllib.error
import urllib.request

FEATUREBASE_API_KEY = os.environ.get(
    "FEATUREBASE_API_KEY",
    "***REMOVED-ROTATED-FEATUREBASE-KEY***",
)
API_BASE = "https://do.featurebase.app/v2"

# ── Fill these in with real examples that are behaving wrong ───────────────
EXAMPLE_EMAILS = [
    # "someone@noxtua.com",
]
DOMAINS = ["noxtua.com", "xayn.com"]
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
    items = []
    cursor = None
    pages = 0
    while True:
        sep = "&" if "?" in path_base else "?"
        path = f"{path_base}{sep}limit=100"
        if cursor:
            path += f"&cursor={cursor}"
        status, result = api_request("GET", path)
        pages += 1
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
    print(f"  (fetched across {pages} page(s))")
    return items


def any_field_contains(obj, needle):
    """Recursively search all string values in a dict/list for `needle`
    (case-insensitive substring match)."""
    needle = needle.lower()
    if isinstance(obj, str):
        return needle in obj.lower()
    if isinstance(obj, dict):
        return any(any_field_contains(v, needle) for v in obj.values())
    if isinstance(obj, list):
        return any(any_field_contains(v, needle) for v in obj)
    return False


def main():
    print("Fetching all contacts (contactType=all)...")
    contacts = fetch_all("/contacts?contactType=all")
    print(f"  {len(contacts)} total contacts fetched.\n")

    print("=" * 70)
    print("PART 1 — domain match, checked loosely across ALL fields")
    print("=" * 70)
    for d in DOMAINS:
        loose_matches = [c for c in contacts if any_field_contains(c, f"@{d}")]
        strict_matches = [
            c for c in contacts
            if (c.get("email") or "").strip().lower().endswith(f"@{d}")
        ]
        print(f"\n@{d}:")
        print(f"  strict (top-level 'email' field ends with @{d}): {len(strict_matches)}")
        print(f"  loose  (appears anywhere in the record):          {len(loose_matches)}")
        if len(loose_matches) != len(strict_matches):
            only_loose = [c for c in loose_matches if c not in strict_matches]
            print(f"  -> {len(only_loose)} contact(s) match loosely but NOT via the "
                  f"top-level email field. First few, raw:")
            for c in only_loose[:3]:
                print(json.dumps(c, indent=2)[:1500])
                print("  ---")

    print("\nFetching all Admins/team seats (separate from Contacts)...")
    admins = fetch_all("/admins")
    print(f"  {len(admins)} total admins/team seats fetched.\n")

    if not EXAMPLE_EMAILS:
        print("(No EXAMPLE_EMAILS configured — add some and re-run for part 2.)")
        return

    print("=" * 70)
    print("PART 2 — specific example lookups (checked against BOTH collections)")
    print("=" * 70)
    for example in EXAMPLE_EMAILS:
        print(f"\nLooking for: {example}")
        hits = [c for c in contacts if any_field_contains(c, example)]
        admin_hits = [a for a in admins if any_field_contains(a, example)]

        if admin_hits:
            print(f"  -> FOUND as a TEAM SEAT (admin/manager/contributor/lite), "
                  f"{len(admin_hits)} match(es):")
            for a in admin_hits:
                print(json.dumps(a, indent=2)[:1000])
                print("  ---")
            print("     This is why it's untouched by the Contacts-based script: "
                  "team seats aren't Contacts and always receive Updates regardless "
                  "of subscribedToChangelog.")

        if not hits:
            print(f"  -> NOT FOUND in the {len(contacts)} fetched Contacts.")
            if not admin_hits:
                print("     Not a team seat either — suggests a pagination/contactType "
                      "issue with the Contacts fetch itself.")
            continue

        for c in hits:
            print("  -> FOUND as a CONTACT. Raw record:")
            print(json.dumps(c, indent=2))
            print(f"  subscribedToChangelog value: {c.get('subscribedToChangelog')!r} "
                  f"(type: {type(c.get('subscribedToChangelog')).__name__})")


if __name__ == "__main__":
    main()
