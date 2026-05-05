# Noxtua Customer Insights · Local Webapp

## Setup (first time only)

```bash
pip install flask
```

## Every session

**Step 1 — After merging a new CSV batch**, run the export:
```bash
cd noxtua_insights
python export_data.py
```
This finds the latest `Customer_Insights_Data_*.csv` in `data/`, builds `data/insights.json`, saves a snapshot, and updates the changelog.

**Step 2 — Start the app:**
```bash
python app.py
```

**Step 3 — Open in browser:**
```
http://localhost:5000
```

That's it. Leave the terminal open while using the dashboard.

---

## File structure

```
noxtua_insights/
├── app.py              # Flask app
├── export_data.py      # CSV → JSON pipeline (run each session)
├── config.py           # Settings (auth, paths)
├── data/
│   ├── Customer_Insights_Data_*.csv   # Master CSV (always drop latest here)
│   ├── insights.json                  # Generated — do not edit manually
│   ├── changelog.json                 # Auto-maintained change history
│   └── snapshots/                     # Auto-saved snapshots for diffing
├── static/
│   ├── style.css
│   ├── dashboard.js
│   └── charts.js
└── templates/
    ├── index.html
    └── login.html
```

---

## Enabling authentication

When ready to share via a URL, open `config.py` and set:
```python
AUTH_ENABLED = True
AUTH_USERNAME = "noxtua"        # change this
AUTH_PASSWORD = "your-password" # change this
SECRET_KEY = "a-long-random-string"
```
No other changes needed. All routes are already protected.

---

## Future: nightly snapshots (when hosted)

In `config.py`, set:
```python
SNAPSHOT_INTERVAL_HOURS = 24
```
Then install APScheduler and add to `app.py`:
```python
from apscheduler.schedulers.background import BackgroundScheduler
from export_data import export
scheduler = BackgroundScheduler()
scheduler.add_job(export, 'interval', hours=config.SNAPSHOT_INTERVAL_HOURS)
scheduler.start()
```

---

## Deploying to a server (when ready)

1. Copy the entire `noxtua_insights/` folder to the server
2. `pip install flask gunicorn`
3. `gunicorn -w 2 -b 0.0.0.0:5000 app:app`
4. Point a reverse proxy (nginx/Caddy) at port 5000
5. Enable auth in `config.py`
