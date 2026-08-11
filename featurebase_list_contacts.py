#!/usr/bin/env python3
"""
featurebase_list_contacts.py — Read-only preview of every contact (user/lead)
currently in Featurebase, grouped by company, with their current
subscribedToChangelog status.

Run this locally (same folder/API key as featurebase_sync.py):
    python3 featurebase_list_contacts.py

Writes: featurebase_contacts_<date>.csv (one row per contact)
Prints: a company-by-company summary so you can tell at a glance which
        companies are real publishers vs. research/internal placeholders
        (e.g. "Internal User Research Insights", per-study companies)
        before subscribing anyone.

This script makes NO changes — it only reads.
"""

import csv
import datetime
import json
import os
import urllib.error
import urllib.request

FEATUREBASE_API_KEY = os.environ.get(
    "FEATUREBASE_API_KEY",
    "***REMOVED-ROTATED-FEATUREBASE-KEY***",
)
API_BASE = "https://do.featurebase.app/v2"


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
    with urllib.request.urlopen(req) as resp:
        return json.loads(resp.read())


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
        result = api_request("GET", path)
        batch = result.get("data", []) if isinstance(result, dict) else (result or [])
        if not batch:
            break
        items.extend(batch)
        cursor = result.get("nextCursor") if isinstance(result, dict) else None
        if not cursor:
            break
    return items


def main():
    print("Fetching companies...")
    companies = fetch_all("/companies")
    company_by_id = {c.get("id") or c.get("_id"): c for c in companies}
    print(f"  {len(companies)} companies found.\n")

    print("Fetching contacts (this paginates, may take a bit)...")
    # contactType=all — the API defaults to "customer" only, which would
    # silently skip any contact created as type "lead" (e.g. research
    # participants added via create_research_company.py).
    contacts = fetch_all("/contacts?contactType=all")
    print(f"  {len(contacts)} contacts found.\n")

    today = datetime.date.today().isoformat()
    out_path = f"featurebase_contacts_{today}.csv"

    rows = []
    per_company = {}
    with_email = 0
    already_subscribed = 0

    for c in contacts:
        email = c.get("email") or ""
        name = c.get("name") or ""
        contact_id = c.get("id") or c.get("_id") or ""
        subscribed = bool(c.get("subscribedToChangelog"))
        comp_names = []
        comp_ids = []
        for comp in c.get("companies", []) or []:
            cid = comp.get("id") or comp.get("companyId") or ""
            comp_names.append(comp.get("name") or company_by_id.get(cid, {}).get("name", cid))
            comp_ids.append(cid)

        if email:
            with_email += 1
        if subscribed:
            already_subscribed += 1

        key = "; ".join(comp_names) or "(no company)"
        per_company.setdefault(key, {"total": 0, "with_email": 0})
        per_company[key]["total"] += 1
        if email:
            per_company[key]["with_email"] += 1

        rows.append({
            "contact_id": contact_id,
            "name": name,
            "email": email,
            "companies": "; ".join(comp_names),
            "company_ids": "; ".join(comp_ids),
            "subscribedToChangelog": subscribed,
        })

    with open(out_path, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=list(rows[0].keys()) if rows else
                                 ["contact_id", "name", "email", "companies", "company_ids", "subscribedToChangelog"])
        writer.writeheader()
        writer.writerows(rows)

    print("=" * 70)
    print(f"TOTAL CONTACTS:            {len(contacts)}")
    print(f"  with an email address:   {with_email}")
    print(f"  already subscribed:      {already_subscribed}")
    print("=" * 70)
    print("\nBy company (total contacts / with email):\n")
    for name, stats in sorted(per_company.items(), key=lambda kv: -kv[1]["total"]):
        flag = ""
        lname = name.lower()
        if "research" in lname or "study" in lname or "participant" in lname or "internal" in lname:
            flag = "  <-- looks like a research/internal placeholder, probably NOT a publisher"
        print(f"  {stats['total']:4d} / {stats['with_email']:4d}  {name}{flag}")

    print(f"\nFull per-contact detail written to: {out_path}")
    print("\nNext step: decide which company name(s) above are actual publishers,")
    print("then use featurebase_subscribe_contacts.py with those company names/IDs.")


if __name__ == "__main__":
    main()
