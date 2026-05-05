# ── Noxtua Insights · Configuration ──────────────────────────────────────────
# Auth is fully wired but disabled. To enable:
#   1. Set AUTH_ENABLED = True
#   2. Change AUTH_USERNAME and AUTH_PASSWORD
#   3. Set a strong SECRET_KEY
# No other code changes needed.

AUTH_ENABLED = False
AUTH_USERNAME = "noxtua"
AUTH_PASSWORD = "changeme"
SECRET_KEY = "dev-secret-key-replace-before-hosting"

# Data directory (relative to app.py)
DATA_DIR = "data"
SNAPSHOTS_DIR = "data/snapshots"

# Status options (ordered for dropdown)
STATUS_OPTIONS = [
    "New - Not yet discussed",
    "Identified - JIRA ticket exists",
    "Planned for development",
    "Implemented - a solution is released",
    "Well done - positive feedback outweighs negative",
]

# Snapshot: also called on data reload.
# Future: set SNAPSHOT_INTERVAL_HOURS to enable scheduled nightly snapshots
# (requires APScheduler — pip install apscheduler — and one call in app.py).
SNAPSHOT_ON_RELOAD = True
SNAPSHOT_INTERVAL_HOURS = None  # None = disabled; set to 24 for nightly
