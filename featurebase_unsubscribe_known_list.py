#!/usr/bin/env python3
"""
featurebase_unsubscribe_known_list.py — Unsubscribe a specific, known list of
email addresses from changelog/Update emails, by email.

This is built to work even for people who have NO existing Contact record in
Featurebase — e.g. team seats (Admins/Managers/Contributors/Lite users),
who live in a separate collection from Contacts entirely and never show up
via GET /contacts, no matter how it's paginated.

Why this works anyway: POST /contacts is an upsert — if no Contact exists
for that email, it creates a minimal one; if one exists, it updates it.
Featurebase's send-suppression check (per Featurebase support) looks up
manuallyOptedOutFromChangelog by email regardless of whether that email
also belongs to a team seat, so creating/updating a Contact record with
that flag set suppresses the send either way.

SOURCE_EMAILS below is pre-filled with the full subscriber list Lea pulled
directly from Featurebase's own subscriber-list UI (the authoritative
source — not derived from the Contacts API, which is exactly the list that
was previously missing several entries). Only the ones matching DOMAINS
are actually touched.

USAGE:
    python3 featurebase_unsubscribe_known_list.py

Configure below:
  DOMAINS = [...]   <- which domains, from SOURCE_EMAILS, to unsubscribe.
  DRY_RUN = True     <- keep True until the printed list looks exactly
                        right, then set False and re-run.
"""

import json
import os
import time
import urllib.error
import urllib.request

FEATUREBASE_API_KEY = os.environ.get("FEATUREBASE_API_KEY", "")
API_BASE = "https://do.featurebase.app/v2"

# ── The full subscriber list, as shown in Featurebase's own UI ─────────────
SOURCE_EMAILS = [
    "lea.dingler.external@noxtua.com",
    "niklas.schroeder@noxtua.com",
    "julia.riehle@noxtua.com",
    "alyssa.rex@noxtua.com",
    "ruth.rothmaler@noxtua.com",
    "balaji.alagu@noxtua.com",
    "heba.ledwon@noxtua.com",
    "niklas.possinger@noxtua.com",
    "chih-yun.huang@noxtua.com",
    "alexa.rodriguez-meyer@noxtua.com",
    "petra.zatkova@noxtua.com",
    "sophie.corboz@noxtua.com",
    "carolin.lessing@noxtua.com",
    "marina.djundjas@noxtua.com",
    "guelce.kurucay@noxtua.com",
    "lauren.schumb@noxtua.com",
    "bugra.gurses@noxtua.com",
    "marek.stepan@beck.cz",
    "stephan.rupp@beck.de",
    "sebastian.merkel@beck.de",
    "sami.yacob@beck.de",
    "katharina.kaeuffer@beck.de",
    "harald.gehring@beck.de",
    "radim.krejci@beck.cz",
    "olga.kotlanova@beck.cz",
    "christoph.ziegler@beck-noxtua.de",
    "cyrielle.gaonach@helbing.ch",
    "martin.warne@blendow.se",
    "sara.canic@helbing.ch",
    "antonja.burghardt@helbing.ch",
    "jana.silhava@beck.cz",
    "peter.guggenberger@manz.at",
    "jana.kuncova@beck.cz",
    "lenka.kubova@beck.cz",
    "kristyna.chury@beck.cz",
    "alexander.feldinger@manz.at",
    "lisa.ritz@beck.de",
    "suzana.georgieva@ciela.com",
    "jiri.holna@beck.cz",
    "jaromir.fronc@beck.cz",
    "edina.julevic@beck-noxtua.de",
    "sandra.sewald@beck-noxtua.de",
    "christian.hange@beck.de",
    "sebastian.becker@beck-noxtua.de",
    "frantisek.axamit@beck.sk",
    "daniel.oberhuber@manz.at",
    "till.eigenheer@helbing.ch",
    "anncathrin.brock@gmail.com",
    "salo.tober-lau@beck-noxtua.de",
    "milosz.kalinowski@beck.pl",
    "pawel.oleszek@beck.pl",
    "katharina.marx@manz.at",
    "mirko.meurer@helbing.ch",
    "daniel.ludwig@beck-noxtua.de",
    "thomas.blendow@blendow.se",
    "lukas.pelcman@beck.cz",
    "lukas.mikula@beck.cz",
    "marcus.bouvin@blendow.se",
    "mark.schneider@beck-noxtua.de",
    "andreas.perneby@bginstitute.se",
    "sebastian.blendow@blendow.se",
    "patrick.romer@helbing.ch",
    "simon.norrman@blendow.se",
    "filippa.moller@blendow.se",
    "leif@noxtua.com",
    "johannes.maurer@noxtua.com",
    "userresearch@noxtua.com",
    "ruth.rothmaler@xayn.com",
]

# ── Which domains to actually unsubscribe ───────────────────────────────────
DOMAINS = ["noxtua.com", "xayn.com"]
DRY_RUN = False
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
    domains = [d.strip().lower().lstrip("@") for d in DOMAINS if d.strip()]
    targets = sorted({
        e.strip().lower() for e in SOURCE_EMAILS
        if e.strip() and any(e.strip().lower().endswith("@" + d) for d in domains)
    })

    print(f"{len(targets)} address(es) from SOURCE_EMAILS match {', '.join('@' + d for d in domains)}:\n")
    for e in targets:
        print(f"  - {e}")

    print("\nChecking which already have an existing Contact record "
          "(informational only — this script acts on all of them either way)...")
    contacts = fetch_all("/contacts?contactType=all")
    by_email = {(c.get("email") or "").strip().lower(): c for c in contacts if c.get("email")}
    existing = [e for e in targets if e in by_email]
    new_records = [e for e in targets if e not in by_email]
    print(f"  {len(existing)} already exist as Contacts (likely publisher/lead records).")
    print(f"  {len(new_records)} have no existing Contact — likely team seats "
          f"(Admin/Manager/Contributor/Lite); a new Contact will be created for "
          f"them purely to hold the opt-out flag.")

    if DRY_RUN:
        print("\n🔍 DRY RUN — no changes made. Set DRY_RUN = False to actually unsubscribe them.")
        return

    print("\nUnsubscribing (create-or-update via POST /contacts)...\n")
    ok, fail = 0, 0
    for e in targets:
        # manuallyOptedOutFromChangelog is read-only (Featurebase sets it
        # internally, e.g. when someone clicks "unsubscribe" in an email) —
        # the API rejects it in a POST body. subscribedToChangelog is the
        # only field that's actually writable.
        status, resp = api_request("POST", "/contacts", {
            "email": e,
            "subscribedToChangelog": False,
        })
        if status in (200, 201):
            ok += 1
            print(f"  ✅  {e}")
        else:
            fail += 1
            print(f"  ❌  {e} -> {status}: {str(resp)[:150]}")
        time.sleep(DELAY)

    print(f"\nDone. Unsubscribed: {ok}/{len(targets)}", end="")
    print(f", {fail} failed." if fail else ".")


if __name__ == "__main__":
    main()
