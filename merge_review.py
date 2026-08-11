#!/usr/bin/env python3
"""
merge_review.py
---------------
Merges an edited review CSV back into the live insights.json.

What it does:
  - Reads the live insights.json (which teammates may have updated)
  - Reads your edited insights_review.csv
  - For each insight in the CSV, applies ONLY changed fields:
      • insight (description text)
      • status
  - Leaves mentions/mentionHistory on surviving insights untouched — the
    review CSV's mentions column is a snapshot, not something you edit here,
    so it is never used to overwrite the live count.
  - For rows marked as deletions (notes_for_reviewer starting with "DELETE")
    that name a merge target ("... merge into ID 151", "... ID 223", etc.),
    the deleted insight's live mention count is ADDED onto the target
    insight's mentions (with a mentionHistory entry), then the row is removed.
    Plain deletions with no target ("delete entirely", "plain delete") just
    remove the row — nothing to transfer.
  - Handles the reversed phrasing "MERGE <other id> into this one": that
    note lives on the *target* row and must NOT cause the target itself to
    be deleted (the other row's own "DELETE ... into ID <this id>" note is
    the authoritative deletion instruction).
  - Flags self-referencing merge notes (target ID == the row's own ID) and
    merge targets that don't exist in live data as anomalies for manual
    review — nothing is auto-applied for those rows.
  - Flags conflicts where a teammate also changed status on the same insight
  - Writes the merged result to insights.json (with a backup first)

Usage:
  python3 merge_review.py
  python3 merge_review.py --review-file insights_review.csv --insights-file insights.json --dry-run
"""

import argparse
import csv
import json
import re
import shutil
from datetime import date
from pathlib import Path


def load_args():
    p = argparse.ArgumentParser()
    p.add_argument("--review-file", default="insights_review.csv")
    p.add_argument("--insights-file", default="insights.json")
    p.add_argument("--dry-run", action="store_true",
                   help="Print what would change without writing anything")
    return p.parse_args()


def parse_deletion(note, own_id):
    """
    Decide whether a row should be deleted based on notes_for_reviewer, and
    if so, whether it names a merge target.

    Returns (should_delete, target_id, anomaly_reason).
      - should_delete=False, target_id=None, anomaly_reason=None
            -> not a deletion row at all (process insight/status normally)
      - should_delete=True, target_id=<int or None>, anomaly_reason=None
            -> delete this row; if target_id is set, transfer its mentions there
      - should_delete=False, target_id=None, anomaly_reason=<str>
            -> something is off (self-reference); leave row untouched, flag it
    """
    note_upper = note.upper()

    # Reversed phrasing lives on the *target* row ("MERGE 382 into this one").
    # That row itself must not be deleted - the other row's own DELETE note
    # is what actually removes it.
    if "INTO THIS ONE" in note_upper:
        return False, None, None

    if not note_upper.startswith("DELETE"):
        return False, None, None

    m = re.search(r'INTO\s+ID\s*(\d+)', note_upper)
    if not m:
        m = re.search(r'\bID\s*(\d+)\b', note_upper)
    target_id = int(m.group(1)) if m else None

    if target_id == own_id:
        return False, None, f"self-referencing merge target (note points ID {own_id} at itself)"

    return True, target_id, None


def main():
    args = load_args()
    review_path = Path(args.review_file)
    insights_path = Path(args.insights_file)
    today = date.today().isoformat()

    # --- Load live insights.json ---
    with open(insights_path, encoding="utf-8") as f:
        live_data = json.load(f)
    live_by_id = {d["id"]: d for d in live_data}

    # --- Load review CSV ---
    review_rows = []
    with open(review_path, encoding="utf-8") as f:
        reader = csv.DictReader(f)
        for row in reader:
            review_rows.append(row)

    print(f"Live insights: {len(live_data)}")
    print(f"Review CSV rows: {len(review_rows)}")

    changes = []
    conflicts = []
    deletions = []
    anomalies = []
    skipped_missing = []

    for row in review_rows:
        rid = int(row["id"])
        if rid not in live_by_id:
            skipped_missing.append(rid)
            continue

        live = live_by_id[rid]
        notes = row.get("notes_for_reviewer", "").strip()

        should_delete, target_id, anomaly_reason = parse_deletion(notes, rid)

        if anomaly_reason:
            anomalies.append({
                "id": rid, "insight": live["insight"], "note": notes,
                "reason": anomaly_reason,
            })
            continue  # leave this row completely untouched

        if should_delete:
            if target_id is not None and target_id not in live_by_id:
                anomalies.append({
                    "id": rid, "insight": live["insight"], "note": notes,
                    "reason": f"merge target ID {target_id} not found in live data",
                })
                continue

            transferred_mentions = live["mentions"] if target_id is not None else 0
            deletions.append({
                "id": rid, "insight": live["insight"], "note": notes,
                "target_id": target_id, "transferred_mentions": transferred_mentions,
            })

            if not args.dry_run:
                if target_id is not None:
                    target = live_by_id[target_id]
                    target["mentions"] = target.get("mentions", 0) + transferred_mentions
                    target["mention_count"] = target["mentions"]
                    if "mentionHistory" not in target:
                        target["mentionHistory"] = []
                    target["mentionHistory"].append({
                        "date": today,
                        "count": target["mentions"],
                        "source": f"merged from ID {rid} (+{transferred_mentions})",
                    })
                    target["lastModified"] = today
                del live_by_id[rid]
            continue

        # --- Normal row: apply only insight text / status. Mentions on
        # surviving rows are never touched here. ---
        new_insight = row["insight"].strip()
        new_status = row["status"].strip()

        insight_changed = new_insight != live["insight"]
        status_changed = new_status != live["status"]

        # Conflict detection: did a teammate already update the status in the
        # live file to something different from what the snapshot recorded?
        # We approximate the snapshot status as the earliest statusHistory
        # entry (or the current live status if history is missing).
        history = live.get("statusHistory", [])
        snapshot_status = history[0]["status"] if history else live["status"]
        teammate_changed_status = live["status"] != snapshot_status

        if status_changed and teammate_changed_status:
            conflicts.append({
                "id": rid,
                "insight": live["insight"],
                "snapshot_status": snapshot_status,
                "live_status": live["status"],
                "your_status": new_status,
            })
            continue  # Don't apply automatically — leave for manual resolution

        if not insight_changed and not status_changed:
            continue  # nothing to do

        changes.append({
            "id": rid,
            "insight_changed": insight_changed,
            "old_insight": live["insight"],
            "new_insight": new_insight,
            "status_changed": status_changed,
            "old_status": live["status"],
            "new_status": new_status,
        })

        if not args.dry_run:
            if insight_changed:
                live["insight"] = new_insight
                live["core_insight"] = new_insight
                live["lastModified"] = today

            if status_changed:
                live["status"] = new_status
                live["lastModified"] = today
                if "statusHistory" not in live:
                    live["statusHistory"] = []
                live["statusHistory"].append({"date": today, "status": new_status})

    # Insights teammates added that never appeared in the review CSV. These
    # are only for the summary count below — live_by_id already contains
    # them (it was built from the full live insights.json), so they must
    # NOT be concatenated again or every one of them gets duplicated.
    review_ids = {int(r["id"]) for r in review_rows}
    new_teammate_insight_count = sum(1 for d in live_data if d["id"] not in review_ids)

    # Rebuild list (respects deletions and mention transfers, both already
    # applied in-place on live_by_id)
    merged_data = list(live_by_id.values())

    # --- Report ---
    print(f"\n{'[DRY RUN] ' if args.dry_run else ''}Summary")
    print(f"  Changes to apply:         {len(changes)}")
    print(f"  Deletions (merges):       {len(deletions)}")
    print(f"  Conflicts (manual):       {len(conflicts)}")
    print(f"  Anomalies (manual):       {len(anomalies)}")
    print(f"  New teammate insights:    {new_teammate_insight_count} (already present in live data, not duplicated)")
    print(f"  IDs in CSV not in live:   {len(skipped_missing)}")

    if changes:
        print("\nChanges:")
        for c in changes:
            if c["insight_changed"]:
                print(f"  [{c['id']}] description updated")
                print(f"        Before: {c['old_insight'][:80]}")
                print(f"        After:  {c['new_insight'][:80]}")
            if c["status_changed"]:
                print(f"  [{c['id']}] status: {c['old_status']} → {c['new_status']}")

    if deletions:
        print("\nDeletions (merged into other insights):")
        for d in deletions:
            print(f"  [{d['id']}] {d['insight'][:70]}")
            if d["target_id"] is not None:
                print(f"        Merged into ID {d['target_id']} (+{d['transferred_mentions']} mentions)")
            else:
                print(f"        Plain delete (no mentions transferred)")
            print(f"        Note: {d['note']}")

    if conflicts:
        print("\n⚠️  Conflicts (not applied — resolve manually):")
        for c in conflicts:
            print(f"  [{c['id']}] {c['insight'][:60]}")
            print(f"        Snapshot: {c['snapshot_status']}")
            print(f"        Live now: {c['live_status']}")
            print(f"        Your edit:{c['your_status']}")

    if anomalies:
        print("\n⚠️  Anomalies (not applied — resolve manually):")
        for a in anomalies:
            print(f"  [{a['id']}] {a['insight'][:60]}")
            print(f"        Note: {a['note']}")
            print(f"        Reason: {a['reason']}")

    if skipped_missing:
        print(f"\nSkipped IDs not found in live file: {skipped_missing}")

    # --- Write ---
    if not args.dry_run and (changes or deletions):
        backup_path = insights_path.with_suffix(f".backup_{today}.json")
        shutil.copy2(insights_path, backup_path)
        print(f"\nBackup saved to: {backup_path.name}")

        with open(insights_path, "w", encoding="utf-8") as f:
            json.dump(merged_data, f, ensure_ascii=False, indent=2)
        print(f"insights.json updated: {len(changes)} changes, {len(deletions)} deletions.")
    elif args.dry_run:
        print("\nDry run — nothing written.")
    else:
        print("\nNo changes to apply.")


if __name__ == "__main__":
    main()
