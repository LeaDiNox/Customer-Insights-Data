-- ============================================================
-- Noxtua Customer Insights — Database Schema
-- Source data: insights.json (381 records) + Research_Repository
-- ============================================================

CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ============================================================
-- LOOKUP TABLES
-- ============================================================

CREATE TABLE insight_types (
  id    SMALLSERIAL PRIMARY KEY,
  name  VARCHAR(100) NOT NULL UNIQUE
);
INSERT INTO insight_types (name) VALUES
  ('General Feedback'),
  ('Idea'),
  ('Improvement'),
  ('Missing Feature'),
  ('To be removed');


CREATE TABLE insight_statuses (
  id    SMALLSERIAL PRIMARY KEY,
  name  VARCHAR(150) NOT NULL UNIQUE
);
INSERT INTO insight_statuses (name) VALUES
  ('New - Not yet discussed'),
  ('Identified - JIRA ticket exists'),
  ('Planned for development'),
  ('Implemented - a solution is released'),
  ('Well done - positive feedback outweighs negative');


CREATE TABLE countries (
  id    SMALLSERIAL PRIMARY KEY,
  name  VARCHAR(100) NOT NULL UNIQUE
);
INSERT INTO countries (name) VALUES
  ('All'), ('Germany'), ('Austria'), ('Switzerland');


CREATE TABLE squads (
  id    SMALLSERIAL PRIMARY KEY,
  name  VARCHAR(100) NOT NULL UNIQUE
);
INSERT INTO squads (name) VALUES
  ('AI Squad'), ('Platform Squad'), ('Drafting Squad'),
  ('Workflow Squad'), ('Review Squad'), ('Design'),
  ('Marketing'), ('All');


CREATE TABLE features (
  id    SMALLSERIAL PRIMARY KEY,
  name  VARCHAR(150) NOT NULL UNIQUE
);
INSERT INTO features (name) VALUES
  ('Research'), ('Citations'), ('Sources'), ('Canvas'),
  ('Chat'), ('Word-Add-In'), ('Knowledge Base'),
  ('Document Upload'), ('Document Storage'), ('Document Download'),
  ('Workflows'), ('Chat Export'), ('Thinking Process'),
  ('Layout'), ('Customization'), ('Onboarding'),
  ('Billing'), ('User Management'), ('All');


CREATE TABLE user_groups (
  id    SMALLSERIAL PRIMARY KEY,
  name  VARCHAR(150) NOT NULL UNIQUE
);
INSERT INTO user_groups (name) VALUES
  ('Mixed'), ('Big Law Firm'), ('Small Law Firm'),
  ('Corporate Law Department'), ('Distribution Department'),
  ('Prosecution/ Judges'), ('Government Institutions'), ('Publisher');


CREATE TABLE sentiments (
  id    SMALLSERIAL PRIMARY KEY,
  name  VARCHAR(50) NOT NULL UNIQUE
);
INSERT INTO sentiments (name) VALUES
  ('Positive'), ('Negative'), ('Mixed'), ('Neutral');


CREATE TABLE study_types (
  id    SMALLSERIAL PRIMARY KEY,
  name  VARCHAR(100) NOT NULL UNIQUE
);
INSERT INTO study_types (name) VALUES
  ('Direct Feedback'), ('User Interview'), ('Usability Testing'),
  ('Interview Study'), ('Online Survey'), ('Hackathon');


-- ============================================================
-- RESEARCH STUDIES
-- Source: Research_Repository.csv
-- ============================================================

CREATE TABLE research_studies (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  research_id        VARCHAR(200) NOT NULL UNIQUE,
  title              VARCHAR(500) NOT NULL,
  study_type_id      SMALLINT REFERENCES study_types(id),
  date_of_conduction DATE,
  main_results       TEXT,
  related_materials  TEXT,
  full_report_url    TEXT,
  created_at         TIMESTAMPTZ,
  created_by         VARCHAR(255),
  modified_at        TIMESTAMPTZ,
  modified_by        VARCHAR(255)
);

CREATE INDEX idx_research_studies_slug ON research_studies(research_id);
CREATE INDEX idx_research_studies_type ON research_studies(study_type_id);


CREATE TABLE research_study_user_groups (
  research_study_id  UUID NOT NULL REFERENCES research_studies(id) ON DELETE CASCADE,
  user_group_id      SMALLINT NOT NULL REFERENCES user_groups(id),
  PRIMARY KEY (research_study_id, user_group_id)
);


-- ============================================================
-- INSIGHTS
-- Source: insights.json (381 records)
-- ============================================================

CREATE TABLE insights (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  legacy_id         INTEGER UNIQUE NOT NULL,
  insight           TEXT NOT NULL,
  insight_type_id   SMALLINT REFERENCES insight_types(id),
  status_id         SMALLINT REFERENCES insight_statuses(id),
  country_id        SMALLINT REFERENCES countries(id),
  sentiment_id      SMALLINT REFERENCES sentiments(id),
  user_group        VARCHAR(255),
  source            TEXT,
  mentions          INTEGER NOT NULL DEFAULT 0,
  quotes            TEXT,
  notes             TEXT,
  jira_tickets      TEXT,
  publisher         VARCHAR(255),
  is_new            BOOLEAN NOT NULL DEFAULT false,
  unclassified      BOOLEAN NOT NULL DEFAULT false,
  created_at        DATE,
  modified_at       DATE
);

CREATE INDEX idx_insights_legacy_id  ON insights(legacy_id);
CREATE INDEX idx_insights_type       ON insights(insight_type_id);
CREATE INDEX idx_insights_status     ON insights(status_id);
CREATE INDEX idx_insights_country    ON insights(country_id);
CREATE INDEX idx_insights_sentiment  ON insights(sentiment_id);
CREATE INDEX idx_insights_mentions   ON insights(mentions DESC);
CREATE INDEX idx_insights_is_new     ON insights(is_new);


-- ============================================================
-- JUNCTION TABLES (many-to-many relationships)
-- ============================================================

CREATE TABLE insight_sources (
  insight_id         UUID NOT NULL REFERENCES insights(id) ON DELETE CASCADE,
  research_study_id  UUID NOT NULL REFERENCES research_studies(id) ON DELETE CASCADE,
  PRIMARY KEY (insight_id, research_study_id)
);
CREATE INDEX idx_insight_sources_study ON insight_sources(research_study_id);


CREATE TABLE insight_squads (
  insight_id  UUID NOT NULL REFERENCES insights(id) ON DELETE CASCADE,
  squad_id    SMALLINT NOT NULL REFERENCES squads(id),
  PRIMARY KEY (insight_id, squad_id)
);
CREATE INDEX idx_insight_squads_squad ON insight_squads(squad_id);


CREATE TABLE insight_features (
  insight_id  UUID NOT NULL REFERENCES insights(id) ON DELETE CASCADE,
  feature_id  SMALLINT NOT NULL REFERENCES features(id),
  PRIMARY KEY (insight_id, feature_id)
);
CREATE INDEX idx_insight_features_feature ON insight_features(feature_id);


CREATE TABLE insight_source_types (
  insight_id     UUID NOT NULL REFERENCES insights(id) ON DELETE CASCADE,
  study_type_id  SMALLINT NOT NULL REFERENCES study_types(id),
  PRIMARY KEY (insight_id, study_type_id)
);


-- ============================================================
-- READ-ONLY USER FOR METABASE
-- Metabase connects with this user — it cannot modify any data
-- ============================================================

DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'insights_reader') THEN
    EXECUTE format(
      'CREATE USER insights_reader WITH PASSWORD %L',
      current_setting('app.readonly_password', true)
    );
  END IF;
END
$$;

GRANT CONNECT ON DATABASE noxtua_insights TO insights_reader;
GRANT USAGE ON SCHEMA public TO insights_reader;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO insights_reader;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT SELECT ON TABLES TO insights_reader;


-- ============================================================
-- ANALYTICS VIEWS
-- Pre-built for Metabase — stakeholders use these directly
-- ============================================================

-- Full insight list with all labels resolved
CREATE VIEW v_insights_full AS
SELECT
  i.legacy_id                           AS "ID",
  i.insight                             AS "Insight",
  it.name                               AS "Type",
  s.name                                AS "Status",
  c.name                                AS "Country",
  sen.name                              AS "Sentiment",
  i.user_group                          AS "User Group",
  i.mentions                            AS "Mentions",
  i.jira_tickets                        AS "JIRA Tickets",
  i.publisher                           AS "Publisher",
  i.is_new                              AS "Is New",
  i.unclassified                        AS "Unclassified",
  i.quotes                              AS "Direct Quotes",
  i.notes                               AS "Notes",
  i.created_at                          AS "Created",
  i.modified_at                         AS "Last Modified"
FROM insights i
LEFT JOIN insight_types    it  ON it.id  = i.insight_type_id
LEFT JOIN insight_statuses s   ON s.id   = i.status_id
LEFT JOIN countries        c   ON c.id   = i.country_id
LEFT JOIN sentiments       sen ON sen.id = i.sentiment_id
ORDER BY i.mentions DESC;


-- Insights by squad with totals
CREATE VIEW v_by_squad AS
SELECT
  sq.name                          AS "Squad",
  COUNT(DISTINCT i.id)             AS "Insight Count",
  SUM(i.mentions)                  AS "Total Mentions",
  ROUND(AVG(i.mentions), 1)        AS "Avg Mentions per Insight"
FROM squads sq
JOIN insight_squads isq ON isq.squad_id = sq.id
JOIN insights i         ON i.id = isq.insight_id
GROUP BY sq.name
ORDER BY "Total Mentions" DESC;


-- Insights by feature with totals
CREATE VIEW v_by_feature AS
SELECT
  f.name                           AS "Feature",
  COUNT(DISTINCT i.id)             AS "Insight Count",
  SUM(i.mentions)                  AS "Total Mentions",
  ROUND(AVG(i.mentions), 1)        AS "Avg Mentions per Insight"
FROM features f
JOIN insight_features inf ON inf.feature_id = f.id
JOIN insights i           ON i.id = inf.insight_id
GROUP BY f.name
ORDER BY "Total Mentions" DESC;


-- Insights by status
CREATE VIEW v_by_status AS
SELECT
  s.name                           AS "Status",
  COUNT(*)                         AS "Insight Count",
  SUM(i.mentions)                  AS "Total Mentions"
FROM insight_statuses s
LEFT JOIN insights i ON i.status_id = s.id
GROUP BY s.name
ORDER BY "Insight Count" DESC;


-- Insights by type
CREATE VIEW v_by_type AS
SELECT
  it.name                          AS "Type",
  COUNT(*)                         AS "Insight Count",
  SUM(i.mentions)                  AS "Total Mentions"
FROM insight_types it
LEFT JOIN insights i ON i.insight_type_id = it.id
GROUP BY it.name
ORDER BY "Insight Count" DESC;


-- Insights by sentiment
CREATE VIEW v_by_sentiment AS
SELECT
  sen.name                         AS "Sentiment",
  COUNT(*)                         AS "Insight Count",
  SUM(i.mentions)                  AS "Total Mentions"
FROM sentiments sen
LEFT JOIN insights i ON i.sentiment_id = sen.id
GROUP BY sen.name
ORDER BY "Insight Count" DESC;


-- Research study coverage
CREATE VIEW v_study_coverage AS
SELECT
  rs.research_id                   AS "Study ID",
  rs.title                         AS "Study Title",
  st.name                          AS "Study Type",
  rs.date_of_conduction            AS "Date",
  COUNT(DISTINCT ins_src.insight_id) AS "Insights Generated"
FROM research_studies rs
LEFT JOIN study_types st            ON st.id = rs.study_type_id
LEFT JOIN insight_sources ins_src   ON ins_src.research_study_id = rs.id
GROUP BY rs.id, rs.research_id, rs.title, st.name, rs.date_of_conduction
ORDER BY "Insights Generated" DESC;


-- New and unclassified insights (action list)
CREATE VIEW v_needs_attention AS
SELECT
  i.legacy_id   AS "ID",
  i.insight     AS "Insight",
  it.name       AS "Type",
  i.mentions    AS "Mentions",
  i.is_new      AS "Is New",
  i.unclassified AS "Unclassified",
  i.created_at  AS "Created"
FROM insights i
LEFT JOIN insight_types it ON it.id = i.insight_type_id
WHERE i.is_new = true OR i.unclassified = true
ORDER BY i.mentions DESC;


-- Audit log
CREATE TABLE audit_log (
  id           BIGSERIAL PRIMARY KEY,
  action       VARCHAR(100) NOT NULL,
  actor        VARCHAR(255),
  target_table VARCHAR(100),
  target_id    UUID,
  payload      JSONB,
  occurred_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX idx_audit_occurred ON audit_log(occurred_at DESC);
