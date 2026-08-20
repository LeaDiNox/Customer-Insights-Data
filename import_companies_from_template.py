"""
Featurebase — Import Companies + Users from CSV Template
----------------------------------------------------------
Reads companies_import_template.csv and for each row:
  1. Creates the company with all provided attributes
  2. Creates one user linked to that company
     - userId:  {company_id}-user
     - name:    {company_id}-user
     - email:   from the CSV (if provided)
     - MRR/monthlySpend: not set (can be updated later)

USAGE:
  1. Fill in companies_import_template.csv
  2. FEATUREBASE_API_KEY=sk_... python import_from_template.py

Flags:
  DRY_RUN = True  → prints what would happen, no changes made
"""

import json, time, os, csv, urllib.request, urllib.error

API_KEY      = os.getenv("FEATUREBASE_API_KEY", "sk_WGTDSHFxeu2VafB7oYIoB00KUO7wW2U_4a9fhQ7n6IEkOOsIY5bZ_LBhDWxR0UYl")
BASE         = "https://do.featurebase.app/v2"
HEADERS      = {
    "Authorization": f"Bearer {API_KEY}",
    "Content-Type":  "application/json",
    "Featurebase-Version": "2026-01-01.nova",
}
DELAY        = 0.3
DRY_RUN      = False   # ← set False to apply
TEMPLATE_CSV = os.path.join(os.path.dirname(__file__), "companies_import_template.csv")
# ──────────────────────────────────────────────────────────────────────────────


def request(method, path, body=None):
    url     = f"{BASE}{path}"
    payload = json.dumps(body).encode("utf-8") if body else None
    req     = urllib.request.Request(url, data=payload, headers=HEADERS, method=method)
    try:
        with urllib.request.urlopen(req) as resp:
            raw = resp.read().decode("utf-8")
            return resp.status, json.loads(raw) if raw else {}
    except urllib.error.HTTPError as e:
        raw = e.read().decode("utf-8", errors="replace")
        return e.code, raw
    except urllib.error.URLError as e:
        return 0, str(e.reason)


def load_csv(path):
    rows = []
    with open(path, newline="", encoding="utf-8-sig") as f:
        for row in csv.DictReader(f):
            # Skip blank rows
            if not row.get("company_name", "").strip():
                continue
            rows.append(row)
    return rows


def derive_company_id(name):
    """Derive a slug from the company name to use as companyId."""
    return name.strip().lower().replace(" ", "-").replace("_", "-")


def build_company_payload(row):
    name    = row["company_name"].strip()
    # Use company_id column if present, otherwise derive from name
    comp_id = row.get("company_id", "").strip() or derive_company_id(name)
    payload = {
        "companyId": comp_id,
        "name":      name,
    }
    if row.get("industry", "").strip():
        payload["industry"] = row["industry"].strip()
    if row.get("plan", "").strip():
        payload["plan"] = row["plan"].strip()
    if row.get("company_size", "").strip():
        try:
            payload["companySize"] = int(row["company_size"].strip())
        except ValueError:
            pass
    if row.get("website", "").strip():
        payload["website"] = row["website"].strip()
    if row.get("location", "").strip():
        payload["customFields"] = {"location": row["location"].strip()}
    return payload


def main():
    if API_KEY == "YOUR_API_KEY_HERE":
        print("⚠️  Set FEATUREBASE_API_KEY env var or edit API_KEY in the script.")
        return

    rows = load_csv(TEMPLATE_CSV)
    if not rows:
        print("⚠️  No rows found in the CSV — fill in companies_import_template.csv first.")
        return

    print(f"Found {len(rows)} companies in template.\n")

    if DRY_RUN:
        print("🔍 DRY RUN — no changes will be made. Set DRY_RUN = False to apply.\n")
        print(f"{'COMPANY':<35} {'USER ID':<30} {'EMAIL'}")
        print("─" * 90)
        for row in rows:
            comp_id  = row["company_id"].strip()
            name     = row["company_name"].strip()
            email    = row.get("user_email", "").strip()
            user_id  = f"{comp_id}-user"
            print(f"  {name:<33} {user_id:<30} {email or '(no email)'}")
        print("\nSet DRY_RUN = False to apply.")
        return

    ok_companies, ok_users = 0, 0
    fail_companies, fail_users = [], []

    for row in rows:
        name     = row["company_name"].strip()
        comp_id  = row.get("company_id", "").strip() or derive_company_id(name)
        email    = row.get("user_email", "").strip()
        user_id  = f"{comp_id}-user"

        # ── Create company ────────────────────────────────────────────────────
        company_payload = build_company_payload(row)
        status, resp    = request("POST", "/companies", company_payload)

        if status in (200, 201):
            internal_id = resp.get("id")
            ok_companies += 1
            print(f"  ✅  Company: {name} ({comp_id})")
        else:
            fail_companies.append((name, comp_id, f"{status}: {str(resp)[:100]}"))
            print(f"  ❌  Company: {name} ({comp_id}) → {status}: {str(resp)[:100]}")
            time.sleep(DELAY)
            continue

        # ── Create user ───────────────────────────────────────────────────────
        user_payload = {
            "userId":    user_id,
            "name":      user_id,
            "companies": [{"id": internal_id, "name": name}],
        }
        if email:
            user_payload["email"] = email

        status, resp = request("POST", "/contacts", user_payload)
        if status in (200, 201):
            ok_users += 1
            print(f"       👤  User:    {user_id}{' (' + email + ')' if email else ''}")
        else:
            fail_users.append((user_id, f"{status}: {str(resp)[:100]}"))
            print(f"       ❌  User:    {user_id} → {status}: {str(resp)[:100]}")

        print()
        time.sleep(DELAY)

    # ── Summary ───────────────────────────────────────────────────────────────
    print(f"{'─'*60}")
    print(f"Companies: {ok_companies}/{len(rows)} created")
    print(f"Users:     {ok_users}/{len(rows)} created")
    if fail_companies:
        print(f"\nFailed companies:")
        for name, cid, err in fail_companies:
            print(f"  • {name} ({cid}): {err}")
    if fail_users:
        print(f"\nFailed users:")
        for uid, err in fail_users:
            print(f"  • {uid}: {err}")


if __name__ == "__main__":
    main()