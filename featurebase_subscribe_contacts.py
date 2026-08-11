#!/usr/bin/env python3
"""
featurebase_subscribe_contacts.py — Subscribe a specific, named list of
Featurebase contacts to changelog (Update) emails, by contact ID.

PUBLISHER_CONTACT_IDS below is pre-filled from Lea's Contacts.xlsx export
(the "contact_id" column, 49 rows). Double-check the count printed at the
top of the run matches what you expect before setting DRY_RUN = False.

USAGE:
    python3 featurebase_subscribe_contacts.py

Configure below:
  PUBLISHER_CONTACT_IDS = [...]   <- the Featurebase contact IDs to subscribe.
  PUBLISHER_EMAILS = [...]        <- optionally ALSO subscribe by email
                                     instead of/in addition to IDs.
  PUBLISHER_EMAILS_FILE = None    <- OR a path to a text/CSV file with one
                                     email per line, merged with the above.
  DRY_RUN = True                  <- keep True until the printed list looks
                                     exactly right, then set False and re-run.

This only ever touches contacts matching the IDs/emails above. It will NOT
touch anyone else, and will skip any listed contact that can't be found, or
is already subscribed.
"""

import csv
import json
import os
import time
import urllib.error
import urllib.request

FEATUREBASE_API_KEY = os.environ.get("FEATUREBASE_API_KEY", "")
API_BASE = "https://do.featurebase.app/v2"

# ── Pre-filled from Contacts.xlsx (49 contact_id rows) ──────────────────────
PUBLISHER_CONTACT_IDS = [
    "6a7473a6317c242ff909685f",
    "6a7453eb2b27a7dc7c21b380",
    "6a7355f60c1291accac2e0ed",
    "6a732db32aa65a000a1f4434",
    "6a732592aad091b73cf903c7",
    "6a730a24677d8d01aa1e462c",
    "6a72ea1f29f02a82c5a2be31",
    "6a71a82a638046aeb672ef98",
    "6a70a03341b702ffea90e931",
    "6a703bfb40d91439538f7ab6",
    "6a6e0cd9936cf16491674971",
    "6a6c9c4331c5c954819a8c48",
    "6a6c98ed560cbe556cf6c5d2",
    "6a6c80acfd41e6351c3663db",
    "6a6c6d727ec7c8f761456d82",
    "6a6c67b0df76c3cfba0e78c6",
    "6a6c66fb9d961b3192c7f76d",
    "6a6c66f61e4c3ce845ffe3f1",
    "6a6c5a2849d08afbc7c523a7",
    "6a6c56971ca84352259e79d2",
    "6a6c36d01e4c3ce8459109ad",
    "6a6b7b28560f6566e31e42b7",
    "6a6b66bc3c21415159d5cf48",
    "6a6b5024a65dffd3eac145a4",
    "6a6b21946d595ed72e5a3607",
    "6a6aed376366ab44f993ee9e",
    "6a6a95aa76533f2ce1430eff",
    "6a69ffddb63b68689cd6e0d2",
    "6a69d1d87a645c302d3d4c32",
    "6a69b80f5b3af3f335b7c8be",
    "6a69b31d7a645c302df929bc",
    "6a69b29907fbe03b0ae67a97",
    "6a699e8f8eb18d19f6b17836",
    "6a6866adbcd7f6defc69209a",
    "6a685a10ac95c9bc010a630e",
    "6a676c050cb97fbd252c70bb",
    "6a675364286320500cc12cf5",
    "6a6728428bfed4cd2dd6e80c",
    "6a6717bb4c1b4e3457620d65",
    "6a670adab1392250de401775",
    "6a66e375be7919f87e3bdbe5",
    "6a66559044361320e7c21cd4",
    "6a663e66a5f44927997c5f72",
    "6a65eebbf114eabc101e56ab",
    "6a63726ef3a0b7c6f3e87228",
    "6a636bfa331f803c3c12bcfb",
    "6a63689ff3f807c0168e0450",
    "6a61cd30caee5704c357a11b",
    "6a61b29df45c4d93a6538148",
]

# ── Optional: also/instead target by email ──────────────────────────────────
PUBLISHER_EMAILS = [
    # "jane@publisher-example.com",
]
PUBLISHER_EMAILS_FILE = None  # e.g. "publisher_emails.txt"
DRY_RUN = False
DELAY = 0.2
# ─────────────────────────────────────────────────────────────────────────


def load_publisher_emails():
    emails = set(e.strip().lower() for e in PUBLISHER_EMAILS if e.strip())
    if PUBLISHER_EMAILS_FILE and os.path.exists(PUBLISHER_EMAILS_FILE):
        with open(PUBLISHER_EMAILS_FILE, newline="", encoding="utf-8") as f:
            sample = f.read(2048)
            f.seek(0)
            if "," in sample and "@" in sample.split(",")[0] is False:
                # looks like a CSV with an "email" column
                reader = csv.DictReader(f)
                for row in reader:
                    val = (row.get("email") or "").strip().lower()
                    if val:
                        emails.add(val)
            else:
                for line in f:
                    val = line.strip().strip(",").lower()
                    if val and "@" in val:
                        emails.add(val)
    return emails


def load_publisher_ids():
    return set(i.strip() for i in PUBLISHER_CONTACT_IDS if i.strip())


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


def main():
    publisher_ids = load_publisher_ids()
    publisher_emails = load_publisher_emails()
    if not publisher_ids and not publisher_emails:
        print("⚠️  No publisher contact IDs or emails configured — fill in")
        print("    PUBLISHER_CONTACT_IDS, PUBLISHER_EMAILS, or PUBLISHER_EMAILS_FILE.")
        return

    print(f"Looking for {len(publisher_ids)} contact ID(s) and "
          f"{len(publisher_emails)} email(s)...")
    print("Fetching all contacts...")
    contacts = fetch_all("/contacts?contactType=all")
    print(f"  {len(contacts)} total contacts fetched.\n")

    by_id = {}
    by_email = {}
    for c in contacts:
        cid = c.get("id") or c.get("_id")
        if cid:
            by_id[str(cid)] = c
        email = (c.get("email") or "").strip().lower()
        if email:
            by_email[email] = c

    matched = {}   # id -> contact, dedupe if same contact hit by both id and email
    not_found_ids = []
    not_found_emails = []
    already = []

    # "Already subscribed" is judged by manuallyOptedOutFromChangelog being
    # false/absent, NOT by subscribedToChangelog being true — that field is
    # often just false by default even for people actively receiving
    # Updates (Featurebase auto-subscribes anyone with an email; the real
    # suppression flag is manuallyOptedOutFromChangelog).
    for cid in sorted(publisher_ids):
        c = by_id.get(cid)
        if not c:
            not_found_ids.append(cid)
            continue
        if not c.get("manuallyOptedOutFromChangelog"):
            already.append(c.get("email") or c.get("name") or cid)
            continue
        matched[str(c.get("id") or c.get("_id"))] = c

    for email in sorted(publisher_emails):
        c = by_email.get(email)
        if not c:
            not_found_emails.append(email)
            continue
        if not c.get("manuallyOptedOutFromChangelog"):
            already.append(email)
            continue
        matched[str(c.get("id") or c.get("_id"))] = c

    targets = list(matched.values())

    print(f"Matched {len(targets)} contact(s) to subscribe:\n")
    for c in targets:
        print(f"  - {c.get('name') or '(no name)'} <{c.get('email') or '(no email)'}>  id={c.get('id') or c.get('_id')}")

    if already:
        print(f"\nAlready subscribed, skipping ({len(already)}):")
        for e in already:
            print(f"  - {e}")

    if not_found_ids:
        print(f"\n⚠️  No contact found for these IDs ({len(not_found_ids)}) — check they're correct:")
        for i in not_found_ids:
            print(f"  - {i}")

    if not_found_emails:
        print(f"\n⚠️  No matching contact found for these emails ({len(not_found_emails)}) — check spelling/typos:")
        for e in not_found_emails:
            print(f"  - {e}")

    if DRY_RUN:
        print("\n🔍 DRY RUN — no changes made. Set DRY_RUN = False to actually subscribe them.")
        return

    # POST /contacts has no "update by internal id" option — it upserts by
    # email or userId only. So identify each contact by whichever of those
    # it actually has (using the record we already fetched), not by "id".
    skipped_no_identifier = []
    print("\nSubscribing...\n")
    ok, fail = 0, 0
    for c in targets:
        # manuallyOptedOutFromChangelog is read-only (rejected on POST) —
        # subscribedToChangelog is the only field the API lets you write.
        body = {"subscribedToChangelog": True}
        label = c.get("email") or c.get("userId") or c.get("id") or c.get("_id")
        if c.get("email"):
            body["email"] = c["email"]
        elif c.get("userId"):
            body["userId"] = c["userId"]
        else:
            skipped_no_identifier.append(label)
            print(f"  ⚠️  {label} has no email or userId — POST /contacts can't "
                  f"target it, skipping.")
            continue

        status, resp = api_request("POST", "/contacts", body)
        if status in (200, 201):
            ok += 1
            print(f"  ✅  {label}")
        else:
            fail += 1
            print(f"  ❌  {label} -> {status}: {str(resp)[:150]}")
        time.sleep(DELAY)

    attempted = len(targets) - len(skipped_no_identifier)
    print(f"\nDone. Subscribed: {ok}/{attempted}", end="")
    print(f", {fail} failed." if fail else ".")
    if skipped_no_identifier:
        print(f"{len(skipped_no_identifier)} skipped (no email/userId on record).")


if __name__ == "__main__":
    main()
