"""
Featurebase — Create Research Company + 100 Participants
----------------------------------------------------------
1. Creates "Internal User Research Insights" company
2. Creates Participant_1 through Participant_100 linked to it

USAGE:
  FEATUREBASE_API_KEY=sk_... python create_research_company.py

Flags:
  DRY_RUN = True  → prints what would happen, no changes made
"""

import json, time, os, urllib.request, urllib.error

API_KEY = os.getenv("FEATUREBASE_API_KEY", "***REMOVED-ROTATED-FEATUREBASE-KEY***")
BASE    = "https://do.featurebase.app/v2"
HEADERS = {
    "Authorization": f"Bearer {API_KEY}",
    "Content-Type":  "application/json",
    "Featurebase-Version": "2026-01-01.nova",
}
DELAY   = 0.2
DRY_RUN = False  # ← set False to apply

COMPANY_NAME       = "Internal User Research Insights"
COMPANY_EXTERNAL_ID = "internal-user-research-insights"
PARTICIPANT_COUNT  = 100
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


def main():
    if API_KEY == "YOUR_API_KEY_HERE":
        print("⚠️  Set FEATUREBASE_API_KEY env var or edit API_KEY in the script.")
        return

    if DRY_RUN:
        print("🔍 DRY RUN — no changes will be made. Set DRY_RUN = False to apply.\n")
        print(f"Would create company:")
        print(f"  name:        {COMPANY_NAME}")
        print(f"  companyId:   {COMPANY_EXTERNAL_ID}")
        print(f"  companySize: {PARTICIPANT_COUNT}")
        print(f"\nWould create {PARTICIPANT_COUNT} participants: Participant_1 … Participant_{PARTICIPANT_COUNT}")
        print("\nSet DRY_RUN = False to apply.")
        return

    # ── Step 1: create company ────────────────────────────────────────────────
    print(f"Step 1: Creating company \"{COMPANY_NAME}\"...\n")
    status, resp = request("POST", "/companies", {
        "companyId":   COMPANY_EXTERNAL_ID,
        "name":        COMPANY_NAME,
        "companySize": PARTICIPANT_COUNT,
    })

    if status in (200, 201):
        internal_id = resp.get("id")
        print(f"  ✅  Created. Internal ID: {internal_id}\n")
    else:
        print(f"  ❌  Failed: {status} {resp}")
        return

    # ── Step 2: create 100 participants ───────────────────────────────────────
    print(f"Step 2: Creating {PARTICIPANT_COUNT} participants...\n")
    ok_count, fail_count = 0, 0

    for n in range(1, PARTICIPANT_COUNT + 1):
        user_id = f"Participant_{n}"
        status, resp = request("POST", "/contacts", {
            "userId":    user_id,
            "name":      user_id,
            "companies": [{"id": internal_id, "name": COMPANY_NAME}],
        })
        if status in (200, 201):
            ok_count += 1
            print(f"  ✅  {user_id}")
        else:
            fail_count += 1
            print(f"  ❌  {user_id}  →  {status}: {str(resp)[:120]}")
        time.sleep(DELAY)

    # ── Summary ───────────────────────────────────────────────────────────────
    print(f"\n{'─'*60}")
    print(f"Done. Company created ✅ | Participants: {ok_count}/{PARTICIPANT_COUNT} created", end="")
    print(f", {fail_count} failed." if fail_count else ".")


if __name__ == "__main__":
    main()
