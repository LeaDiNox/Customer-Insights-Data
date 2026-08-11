#!/usr/bin/env python3
"""
refresh_review_tool.py — Regenerate insights_review.html from current insights.json.

Run this whenever insights.json has changed (new insights added, database
merged) and you want to QA-review the new/unreviewed entries in the browser
tool. Carries forward `qa_reviewed` from insights.json as the tool's
`reviewed` flag, so previously-reviewed insights stay marked and only new /
unreviewed ones need attention.

Usage:
    python3 refresh_review_tool.py
"""

import json
import re
from pathlib import Path

HERE = Path(__file__).parent
INSIGHTS_JSON = HERE / "insights.json"
REVIEW_HTML = HERE / "insights_review.html"


def build_review_records(insights):
    records = []
    for ins in insights:
        note = ins.get("qa_delete_note", "") if ins.get("qa_deleted") else ""
        record = {
            "id": ins["id"],
            "originalInsight": ins.get("insight", ""),
            "originalStatus": ins.get("status", ""),
            "originalType": ins.get("type", ""),
            "originalMentions": ins.get("mentions", 0),
            "insight": ins.get("insight", ""),
            "status": ins.get("status", ""),
            "type": ins.get("type", ""),
            "mentions": ins.get("mentions", 0),
            "notes_for_reviewer": note,
            "reviewed": bool(ins.get("qa_reviewed", False)),
            "features": ins.get("features") or (
                [f.strip() for f in (ins.get("affected_features") or "").split(";") if f.strip()]
            ),
            "sourceTypes": ins.get("sourceTypes") or [],
            "notes": ins.get("notes", ""),
            "quotes": ins.get("quotes", "") if isinstance(ins.get("quotes"), str) else "; ".join(ins.get("quotes") or []),
            "jira": ins.get("jira", ""),
            "sentiment": ins.get("sentiment", ""),
        }
        if ins.get("qa_deleted"):
            record["deleteNote"] = note or "DELETE"
        records.append(record)
    return records


def main():
    insights = json.loads(INSIGHTS_JSON.read_text(encoding="utf-8"))
    records = build_review_records(insights)

    html = REVIEW_HTML.read_text(encoding="utf-8")
    marker = "const RAW_DATA = "
    start = html.index(marker) + len(marker)
    end = html.index(";\n\nconst STATUSES", start)

    new_json = json.dumps(records, ensure_ascii=False)
    new_html = html[:start] + new_json + html[end:]
    REVIEW_HTML.write_text(new_html, encoding="utf-8")

    reviewed = sum(1 for r in records if r["reviewed"])
    print(f"insights_review.html refreshed with {len(records)} records "
          f"({reviewed} already reviewed, {len(records) - reviewed} need review).")


if __name__ == "__main__":
    main()
