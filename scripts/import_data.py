#!/usr/bin/env python3
"""
One-time data import script.
Loads insights.json into the noxtua_insights PostgreSQL database.

Usage:
  pip3 install psycopg2-binary --break-system-packages
  python3 /opt/noxtua-insights/scripts/import_data.py
"""

import json
import psycopg2
from datetime import datetime

# ── Configuration ─────────────────────────────────────────────
# Read password from environment or set directly here
import os

DB = {
    "host": "127.0.0.1",
    "port": 5432,
    "dbname": "noxtua_insights",
    "user": "insights_admin",
    "password": "UR@NoxtuaInsightsdata2026"
}

INSIGHTS_JSON = "/opt/noxtua-insights/insights.json"


# ── Helpers ───────────────────────────────────────────────────

def lookup(cur, table, name_col, value):
    """Return the id of a lookup row by name, or None."""
    if not value or str(value).strip() == "":
        return None
    cur.execute(
        f"SELECT id FROM {table} WHERE {name_col} = %s",
        (str(value).strip(),)
    )
    row = cur.fetchone()
    return row[0] if row else None


def parse_date(val):
    if not val or str(val).strip() == "":
        return None
    for fmt in ("%Y-%m-%d", "%m/%d/%Y", "%d/%m/%Y"):
        try:
            return datetime.strptime(str(val).strip(), fmt).date()
        except ValueError:
            continue
    return None


def ensure_lookup(cur, table, name_col, value):
    """
    Get id for a lookup value, inserting it if it doesn't exist yet.
    Used for values that may not be in the seed data.
    """
    if not value or str(value).strip() == "":
        return None
    name = str(value).strip()
    cur.execute(f"SELECT id FROM {table} WHERE {name_col} = %s", (name,))
    row = cur.fetchone()
    if row:
        return row[0]
    cur.execute(
        f"INSERT INTO {table} ({name_col}) VALUES (%s) RETURNING id",
        (name,)
    )
    return cur.fetchone()[0]


# ── Main import ───────────────────────────────────────────────

def import_insights(conn, cur):
    with open(INSIGHTS_JSON, "r", encoding="utf-8") as f:
        data = json.load(f)

    print(f"Loaded {len(data)} insights from JSON.")
    imported = 0
    skipped = 0

    for item in data:
        try:
            # Resolve lookup IDs
            type_id      = lookup(cur, "insight_types",    "name", item.get("type"))
            status_id    = lookup(cur, "insight_statuses", "name", item.get("status"))
            country_id   = lookup(cur, "countries",        "name", item.get("country"))
            sentiment_id = ensure_lookup(cur, "sentiments", "name", item.get("sentiment"))

            created_at  = parse_date(item.get("created"))
            modified_at = parse_date(item.get("lastModified"))

            # Insert or update insight
            cur.execute("""
                INSERT INTO insights (
                    legacy_id, insight, insight_type_id, status_id,
                    country_id, sentiment_id, user_group, source,
                    mentions, quotes, notes, jira_tickets, publisher,
                    is_new, unclassified, created_at, modified_at
                ) VALUES (
                    %s, %s, %s, %s,
                    %s, %s, %s, %s,
                    %s, %s, %s, %s, %s,
                    %s, %s, %s, %s
                )
                ON CONFLICT (legacy_id) DO UPDATE SET
                    insight         = EXCLUDED.insight,
                    insight_type_id = EXCLUDED.insight_type_id,
                    status_id       = EXCLUDED.status_id,
                    sentiment_id    = EXCLUDED.sentiment_id,
                    mentions        = EXCLUDED.mentions,
                    modified_at     = EXCLUDED.modified_at,
                    is_new          = EXCLUDED.is_new,
                    unclassified    = EXCLUDED.unclassified
                RETURNING id
            """, (
                int(item["id"]),
                str(item.get("insight", "")),
                type_id,
                status_id,
                country_id,
                sentiment_id,
                str(item.get("userGroup", "") or ""),
                str(item.get("source", "") or ""),
                int(item.get("mentions", 0) or 0),
                str(item.get("quotes", "") or ""),
                str(item.get("notes", "") or ""),
                str(item.get("jira", "") or ""),
                str(item.get("publisher", "") or ""),
                bool(item.get("isNew", False)),
                bool(item.get("unclassified", False)),
                created_at,
                modified_at,
            ))
            insight_db_id = cur.fetchone()[0]

            # Link squads
            squads = item.get("squads", [])
            if isinstance(squads, list):
                for squad_name in squads:
                    sq_id = lookup(cur, "squads", "name", squad_name)
                    if sq_id:
                        cur.execute("""
                            INSERT INTO insight_squads (insight_id, squad_id)
                            VALUES (%s, %s) ON CONFLICT DO NOTHING
                        """, (insight_db_id, sq_id))

            # Link features
            features = item.get("features", [])
            if isinstance(features, list):
                for feature_name in features:
                    f_id = ensure_lookup(cur, "features", "name", feature_name)
                    if f_id:
                        cur.execute("""
                            INSERT INTO insight_features (insight_id, feature_id)
                            VALUES (%s, %s) ON CONFLICT DO NOTHING
                        """, (insight_db_id, f_id))

            # Link source types
            source_types = item.get("sourceTypes", [])
            if isinstance(source_types, list):
                for st_name in source_types:
                    st_id = lookup(cur, "study_types", "name", st_name)
                    if st_id:
                        cur.execute("""
                            INSERT INTO insight_source_types (insight_id, study_type_id)
                            VALUES (%s, %s) ON CONFLICT DO NOTHING
                        """, (insight_db_id, st_id))

            imported += 1

        except Exception as e:
            print(f"  ✗ Error on insight id={item.get('id')}: {e}")
            skipped += 1
            conn.rollback()
            continue

        conn.commit()

    print(f"\n✓ Import complete: {imported} imported, {skipped} skipped.")


def set_readonly_password(conn, cur, password):
    """Set the password for the read-only Metabase user."""
    cur.execute(
        "ALTER USER insights_reader WITH PASSWORD %s",
        (password,)
    )
    conn.commit()
    print("✓ Read-only user password set.")


def verify(cur):
    print("\n── Verification ─────────────────────────────────────")
    tables = [
        "insights", "insight_squads", "insight_features",
        "insight_source_types", "research_studies"
    ]
    for t in tables:
        cur.execute(f"SELECT COUNT(*) FROM {t}")
        print(f"  {t}: {cur.fetchone()[0]} rows")

    print("\n── Top 5 insights by mentions ───────────────────────")
    cur.execute("""
        SELECT legacy_id, mentions, LEFT(insight, 70) AS preview
        FROM insights ORDER BY mentions DESC LIMIT 5
    """)
    for row in cur.fetchall():
        print(f"  [{row[0]}] {row[1]} mentions — {row[2]}...")


if __name__ == "__main__":
    readonly_pw = os.environ.get("READONLY_PASSWORD", "")
    if not readonly_pw:
        print("WARNING: READONLY_PASSWORD env var not set. "
              "Metabase read-only user will need password set manually.")

    conn = psycopg2.connect(**DB)
    cur = conn.cursor()

    print("── Importing insights ───────────────────────────────")
    import_insights(conn, cur)

    if readonly_pw:
        set_readonly_password(conn, cur, readonly_pw)

    verify(cur)
# Take a mention snapshot after every import
    print("\n── Taking mention snapshot ──────────────────────────")
    cur.execute("""
        INSERT INTO insight_mention_snapshots (insight_id, legacy_id, mentions)
        SELECT id, legacy_id, mentions FROM insights
    """)
    conn.commit()
    cur.execute("SELECT COUNT(*) FROM insight_mention_snapshots")
    total_snaps = cur.fetchone()[0]
    cur.execute("SELECT COUNT(DISTINCT snapshot_date) FROM insight_mention_snapshots")
    total_dates = cur.fetchone()[0]
    print(f"  Snapshot taken. Total snapshots: {total_snaps} across {total_dates} import dates.")
    cur.close()
    conn.close()
