CREATE TABLE insight_mention_snapshots (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  insight_id    UUID NOT NULL REFERENCES insights(id) ON DELETE CASCADE,
  legacy_id     INTEGER NOT NULL,
  mentions      INTEGER NOT NULL,
  snapshotted_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  snapshot_date  DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE INDEX idx_snapshots_insight    ON insight_mention_snapshots(insight_id);
CREATE INDEX idx_snapshots_date       ON insight_mention_snapshots(snapshot_date DESC);
CREATE INDEX idx_snapshots_legacy_id  ON insight_mention_snapshots(legacy_id);

-- View: top insights by mention growth over time
CREATE VIEW v_mention_trends AS
SELECT
  i.legacy_id,
  LEFT(i.insight, 80)                              AS insight,
  it.name                                          AS insight_type,
  s.name                                           AS status,
  snap.snapshot_date,
  snap.mentions,
  snap.mentions - LAG(snap.mentions) OVER (
    PARTITION BY snap.insight_id
    ORDER BY snap.snapshot_date
  )                                                AS mentions_delta,
  ROUND(100.0 * (snap.mentions - LAG(snap.mentions) OVER (
    PARTITION BY snap.insight_id
    ORDER BY snap.snapshot_date
  )) / NULLIF(LAG(snap.mentions) OVER (
    PARTITION BY snap.insight_id
    ORDER BY snap.snapshot_date
  ), 0), 1)                                        AS pct_change
FROM insight_mention_snapshots snap
JOIN insights i       ON i.id  = snap.insight_id
LEFT JOIN insight_types it ON it.id = i.insight_type_id
LEFT JOIN insight_statuses s ON s.id = i.status_id
ORDER BY snap.snapshot_date DESC, snap.mentions DESC;


-- View: current top insights by mentions (latest snapshot per insight)
CREATE VIEW v_top_insights_now AS
SELECT DISTINCT ON (snap.insight_id)
  i.legacy_id,
  LEFT(i.insight, 100)                             AS insight,
  it.name                                          AS insight_type,
  s.name                                           AS status,
  c.name                                           AS country,
  snap.mentions                                    AS current_mentions,
  snap.snapshot_date                               AS as_of
FROM insight_mention_snapshots snap
JOIN insights i            ON i.id  = snap.insight_id
LEFT JOIN insight_types it ON it.id = i.insight_type_id
LEFT JOIN insight_statuses s  ON s.id  = i.status_id
LEFT JOIN countries c         ON c.id  = i.country_id
ORDER BY snap.insight_id, snap.snapshot_date DESC, snap.mentions DESC;


-- View: fastest growing insights (comparing latest vs previous snapshot)
CREATE VIEW v_rising_insights AS
WITH ranked AS (
  SELECT
    snap.insight_id,
    snap.mentions,
    snap.snapshot_date,
    ROW_NUMBER() OVER (PARTITION BY snap.insight_id ORDER BY snap.snapshot_date DESC) AS rn
  FROM insight_mention_snapshots snap
)
SELECT
  i.legacy_id,
  LEFT(i.insight, 100)             AS insight,
  it.name                          AS insight_type,
  s.name                           AS status,
  latest.mentions                  AS current_mentions,
  prev.mentions                    AS previous_mentions,
  latest.mentions - prev.mentions  AS growth,
  ROUND(100.0 * (latest.mentions - prev.mentions)
    / NULLIF(prev.mentions, 0), 1) AS pct_growth
FROM ranked latest
JOIN ranked prev          ON prev.insight_id = latest.insight_id AND prev.rn = 2
JOIN insights i           ON i.id  = latest.insight_id
LEFT JOIN insight_types it ON it.id = i.insight_type_id
LEFT JOIN insight_statuses s ON s.id = i.status_id
WHERE latest.rn = 1
  AND latest.mentions > prev.mentions
ORDER BY growth DESC;

\q
