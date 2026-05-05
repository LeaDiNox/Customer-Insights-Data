"""
app.py — Noxtua Customer Insights · Flask webapp

Run locally:
    pip install flask
    python export_data.py   # generate data/insights.json first
    python app.py
    → open http://localhost:5000
"""

import os
import csv
import json
import glob
import functools
from datetime import datetime, timezone
from pathlib import Path

from flask_cors import CORS
from flask import (
    Flask, render_template, jsonify, request,
    session, redirect, url_for, abort
)

import config
from export_data import export

app = Flask(__name__)
app.secret_key = config.SECRET_KEY
CORS(app, resources={r"/api/*": {"origins": "*", "methods": ["GET","POST","PATCH","OPTIONS"], "allow_headers": ["Content-Type"]}})



DATA_DIR = Path(config.DATA_DIR)
INSIGHTS_JSON = DATA_DIR / "insights.json"
CHANGELOG_JSON = DATA_DIR / "changelog.json"


# ── Auth helpers ──────────────────────────────────────────────────────────────
# Auth is fully implemented but bypassed when AUTH_ENABLED = False in config.py.
# To enable: set AUTH_ENABLED = True and update credentials.

def login_required(f):
    @functools.wraps(f)
    def decorated(*args, **kwargs):
        if request.method == "OPTIONS":
            return f(*args, **kwargs)
        if not config.AUTH_ENABLED:
            return f(*args, **kwargs)
        if not session.get("logged_in"):
            return redirect(url_for("login"))
        return f(*args, **kwargs)
    return decorated


@app.route("/login", methods=["GET", "POST"])
def login():
    if not config.AUTH_ENABLED:
        return redirect(url_for("index"))
    error = None
    if request.method == "POST":
        if (request.form.get("username") == config.AUTH_USERNAME and
                request.form.get("password") == config.AUTH_PASSWORD):
            session["logged_in"] = True
            return redirect(url_for("index"))
        error = "Invalid credentials."
    return render_template("login.html", error=error)


@app.route("/logout")
def logout():
    session.clear()
    return redirect(url_for("login"))


# ── Main page ─────────────────────────────────────────────────────────────────

@app.route("/")
@login_required
def index():
    return render_template(
        "index.html",
        status_options=config.STATUS_OPTIONS,
        auth_enabled=config.AUTH_ENABLED,
    )


# ── API: data ─────────────────────────────────────────────────────────────────

@app.route("/api/data")
@login_required
def api_data():
    if not INSIGHTS_JSON.exists():
        return jsonify({"error": "insights.json not found. Run export_data.py first."}), 404
    with open(INSIGHTS_JSON, encoding="utf-8") as f:
        data = json.load(f)
    return jsonify(data)


@app.route("/api/changelog")
@login_required
def api_changelog():
    if not CHANGELOG_JSON.exists():
        return jsonify([])
    with open(CHANGELOG_JSON, encoding="utf-8") as f:
        try:
            data = json.load(f)
        except json.JSONDecodeError:
            data = []
    return jsonify(data)


@app.route("/api/status_options")
@login_required
def api_status_options():
    return jsonify(config.STATUS_OPTIONS)


# ── API: status update ────────────────────────────────────────────────────────

@app.route("/api/status", methods=["POST"])
def api_update_status():
    body = request.get_json(force=True)
    try:
        insight_id = int(body.get("id"))
    except (TypeError, ValueError):
        return jsonify({"error": "Invalid id"}), 400
    new_status = body.get("status")

    if not insight_id or not new_status:
        return jsonify({"error": "Missing id or status"}), 400
    if new_status not in config.STATUS_OPTIONS:
        return jsonify({"error": "Invalid status value"}), 400

    # 1. Update insights.json
    if not INSIGHTS_JSON.exists():
        return jsonify({"error": "insights.json not found"}), 404

    with open(INSIGHTS_JSON, encoding="utf-8") as f:
        insights = json.load(f)

    updated = False
    old_status = None
    for ins in insights:
        if ins["id"] == insight_id:
            old_status = ins["status"]
            ins["status"] = new_status
            ins["isNew"] = "New" in new_status
            ins["lastModified"] = datetime.now(timezone.utc).strftime("%Y-%m-%d")
            updated = True
            break

    if not updated:
        return jsonify({"error": f"Insight {insight_id} not found"}), 404

    with open(INSIGHTS_JSON, "w", encoding="utf-8") as f:
        json.dump(insights, f, ensure_ascii=False, indent=2)

    # 2. Update master CSV
    _update_csv_status(insight_id, new_status)

    # 3. Log to changelog
    _log_status_change(insight_id, old_status, new_status, insights)

    return jsonify({"ok": True, "id": insight_id, "status": new_status})


def _update_csv_status(insight_id, new_status):
    """Write new status back to the master CSV."""
    pattern = str(DATA_DIR / "Customer_Insights_Data_*.csv")
    files = sorted(glob.glob(pattern))
    if not files:
        return
    csv_path = files[-1]
    today = datetime.now().strftime("%d/%m/%Y")

    rows = []
    with open(csv_path, newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        fieldnames = reader.fieldnames
        for row in reader:
            try:
                row_id = int(float(str(row.get("ID", "")).strip() or 0))
            except (ValueError, TypeError):
                row_id = -1
            if row_id == insight_id:
                row["Status"] = new_status
                row["Last Modified Update"] = today
                row["Modified By"] = "Dashboard edit"
            rows.append(row)

    with open(csv_path, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(
            f, fieldnames=fieldnames,
            quoting=csv.QUOTE_NONNUMERIC
        )
        writer.writeheader()
        writer.writerows(rows)


def _log_status_change(insight_id, old_status, new_status, insights):
    """Append a status change entry to changelog.json."""
    changelog = []
    if CHANGELOG_JSON.exists():
        with open(CHANGELOG_JSON, encoding="utf-8") as f:
            try:
                changelog = json.load(f)
            except json.JSONDecodeError:
                changelog = []

    insight_text = next(
        (i["insight"][:80] for i in insights if i["id"] == insight_id), ""
    )
    ts = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
    changelog.append({
        "id": insight_id,
        "type": "status_changed",
        "date": ts,
        "from": old_status,
        "to": new_status,
        "insight": insight_text,
        "source": "dashboard_edit",
    })

    with open(CHANGELOG_JSON, "w", encoding="utf-8") as f:
        json.dump(changelog, f, indent=2, ensure_ascii=False)


# ── API: reload data ──────────────────────────────────────────────────────────

@app.route("/api/reload", methods=["POST"])
@login_required
def api_reload():
    """Re-run the export pipeline (find latest CSV → rebuild JSON + snapshot)."""
    try:
        insights = export()
        return jsonify({"ok": True, "count": len(insights)})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# ── API: edit fields ─────────────────────────────────────────────────────────

@app.route("/api/edit", methods=["POST"])
def api_edit_fields():
    """Update notes, mentions (+/-1), squads, userGroup for a single insight."""
    app.logger.info(f"api_edit_fields called, method={request.method}, data={request.data}")
    body = request.get_json(force=True)
    app.logger.info(f"body={body}")
    try:
        insight_id = int(body.get("id"))
    except (TypeError, ValueError):
        return jsonify({"error": "Invalid id"}), 400

    allowed = {"notes", "mentions_delta", "squads", "userGroup"}
    updates = {k: v for k, v in body.items() if k in allowed}
    if not updates:
        return jsonify({"error": "No valid fields to update"}), 400

    if not INSIGHTS_JSON.exists():
        return jsonify({"error": "insights.json not found"}), 404

    with open(INSIGHTS_JSON, encoding="utf-8") as f:
        insights = json.load(f)

    updated_row = None
    for ins in insights:
        if ins["id"] == insight_id:
            if "notes" in updates:
                ins["notes"] = str(updates["notes"]).strip()
            if "mentions_delta" in updates:
                delta = int(updates["mentions_delta"])
                ins["mentions"] = max(0, ins["mentions"] + delta)
            if "squads" in updates:
                ins["squads"] = [s.strip() for s in updates["squads"] if s.strip()]
                ins["unclassified"] = len(ins["squads"]) == 0 or len(ins.get("features", [])) == 0
            if "userGroup" in updates:
                ins["userGroup"] = str(updates["userGroup"]).strip()
            ins["lastModified"] = datetime.now(timezone.utc).strftime("%Y-%m-%d")
            updated_row = ins
            break

    if not updated_row:
        return jsonify({"error": f"Insight {insight_id} not found"}), 404

    with open(INSIGHTS_JSON, "w", encoding="utf-8") as f:
        json.dump(insights, f, ensure_ascii=False, indent=2)

    _update_csv_fields(insight_id, updates, updated_row)
    return jsonify({"ok": True, "id": insight_id, "row": updated_row})


def _update_csv_fields(insight_id, updates, updated_row):
    """Write updated fields back to master CSV."""
    pattern = str(DATA_DIR / "Customer_Insights_Data_*.csv")
    files = sorted(glob.glob(pattern))
    if not files:
        return
    csv_path = files[-1]
    today = datetime.now().strftime("%m/%d/%Y")

    rows = []
    with open(csv_path, newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        fieldnames = reader.fieldnames
        for row in reader:
            try:
                row_id = int(float(str(row.get("ID", "")).strip() or 0))
            except (ValueError, TypeError):
                row_id = -1
            if row_id == insight_id:
                if "notes" in updates:
                    row["Additional Notes"] = updates["notes"]
                if "mentions_delta" in updates:
                    try:
                        cur = int(float(str(row.get("Total %23 of mentions", "0")).strip() or 0))
                    except (ValueError, TypeError):
                        cur = 0
                    row["Total %23 of mentions"] = max(0, cur + int(updates["mentions_delta"]))
                if "squads" in updates:
                    row["Affected Squad(s)"] = json.dumps(updated_row["squads"])
                if "userGroup" in updates:
                    row["Affected User Group (automatic)"] = updates["userGroup"]
                row["Last Modified Update"] = today
                row["Modified By"] = "Dashboard edit"
            rows.append(row)

    with open(csv_path, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames, quoting=csv.QUOTE_NONNUMERIC)
        writer.writeheader()
        writer.writerows(rows)


# ── Run ───────────────────────────────────────────────────────────────────────

if __name__ == "__main__":
    # Auto-export on startup if insights.json doesn't exist yet
    if not INSIGHTS_JSON.exists():
        print("insights.json not found — running export_data.py on startup…")
        try:
            export()
        except Exception as e:
            print(f"  Warning: export failed: {e}")
            print("  Start the app anyway — run export_data.py manually.")

    app.run(debug=True, use_reloader=False, host="0.0.0.0", port=5001)
