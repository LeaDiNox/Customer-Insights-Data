"""Run this to see exactly what headers your CSV contains."""
import csv, os

TEMPLATE_CSV = os.path.join(os.path.dirname(__file__), "companies_import_template.csv")

with open(TEMPLATE_CSV, newline="", encoding="utf-8-sig") as f:
    reader = csv.DictReader(f)
    print("Headers found:")
    for i, h in enumerate(reader.fieldnames):
        print(f"  [{i}] repr: {repr(h)}")
    print()
    print("First row:")
    for row in reader:
        for k, v in row.items():
            print(f"  {repr(k)}: {repr(v)}")
        break