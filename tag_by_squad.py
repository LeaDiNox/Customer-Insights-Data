#!/usr/bin/env python3
"""
tag_by_squad.py — Add Featurebase tags to posts based on each insight's
Affected Squad(s) in insights.json.

For every insight that already has a featurebase_id (i.e. it's been pushed),
this adds one tag per squad listed in its `affected_squads` field (e.g.
"AI Squad", "Platform Squad"). Existing tags on the post — including ones
added manually in the Featurebase UI — are preserved; squad tags are merged
in, never replacing what's already there.

Works across all boards, including Product board posts (tags are metadata,
not content — this never touches title/content/customFields, unlike the
main push script's Product-board safeguard).

Usage:
    python3 tag_by_squad.py --dry-run              Preview tag changes
    python3 tag_by_squad.py --push                 Apply tag changes
    python3 tag_by_squad.py --push --id 162 208    Only these insight IDs
"""

import sys
import time
import argparse
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from featurebase_sync import api_request, load_insights  # reuse auth/config from the main script

# Squad values that shouldn't become a tag (too generic to be useful for filtering)
SKIP_SQUAD_VALUES = {"", "All"}


def squads_for(ins):
    """Return the list of squad names to tag this insight's post with."""
    raw = ins.get("affected_squads") or ""
    if not raw and ins.get("squads"):
        raw = ";".join(ins.get("squads") or [])
    values = [s.strip() for s in raw.split(";") if s.strip()]
    return [v for v in values if v not in SKIP_SQUAD_VALUES]


def main():
    parser = argparse.ArgumentParser(description="Tag Featurebase posts by Affected Squad")
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("--dry-run", action="store_true", help="Preview without making changes")
    group.add_argument("--push", action="store_true", help="Apply tag changes")
    parser.add_argument("--id", type=int, nargs="+", metavar="ID",
                        help="Only process these insight IDs (default: all with a featurebase_id)")
    args = parser.parse_args()

    insights = load_insights()
    if args.id:
        id_set = set(args.id)
        insights = [i for i in insights if i["id"] in id_set]

    targets = [i for i in insights if i.get("featurebase_id") and not i.get("qa_deleted")]
    print(f"{'DRY RUN — ' if args.dry_run else ''}{len(targets)} insight(s) with a Featurebase post to check.\n")

    tagged, unchanged, no_squad, errors = 0, 0, 0, 0
    for ins in targets:
        squad_tags = squads_for(ins)
        if not squad_tags:
            no_squad += 1
            continue

        fid = ins["featurebase_id"]
        try:
            post = api_request("GET", f"/posts/{fid}")
        except Exception as e:
            print(f"  ✗ ID {ins['id']}: could not fetch post {fid}: {e}")
            errors += 1
            continue

        existing_tags = [t.get("name") for t in (post.get("tags") or []) if t.get("name")]
        new_tags = [t for t in squad_tags if t not in existing_tags]
        if not new_tags:
            unchanged += 1
            continue

        merged = existing_tags + new_tags  # preserve existing, append only what's missing
        print(f"  ID {ins['id']} (post {fid}): +{new_tags}  (existing: {existing_tags or 'none'})")

        if args.push:
            try:
                api_request("PATCH", f"/posts/{fid}", {"tags": merged})
                tagged += 1
                time.sleep(0.2)
            except Exception as e:
                print(f"    ✗ Failed to update tags: {e}")
                errors += 1
        else:
            tagged += 1

    print(f"\n{'Would tag' if args.dry_run else 'Tagged'}: {tagged} · "
          f"Already up to date: {unchanged} · No squad set: {no_squad} · Errors: {errors}")
    if args.dry_run:
        print("Run --push to apply.")


if __name__ == "__main__":
    main()
