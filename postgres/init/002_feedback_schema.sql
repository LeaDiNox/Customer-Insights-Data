-- ============================================================
-- Noxtua Customer Feedback — Database Schema
-- Handles 4 questionnaire versions (v1/v2/v3-CSM/v3-SS)
-- and future versions without schema changes
-- ============================================================

-- ============================================================
-- LOOKUP TABLES
-- ============================================================

CREATE TABLE fb_questionnaire_versions (
  id               SMALLSERIAL PRIMARY KEY,
  version_key      VARCHAR(30) NOT NULL UNIQUE,  -- e.g. 'v1_CSM', 'v3_SS'
  display_name     VARCHAR(200) NOT NULL,
  segment          VARCHAR(50) NOT NULL,          -- 'CSM' or 'SelfService'
  country          VARCHAR(100) NOT NULL DEFAULT 'Germany',
  tool             VARCHAR(50),                   -- 'MicrosoftForms' or 'LimeSurvey'
  date_from        DATE,
  date_to          DATE,
  notes            TEXT
);

INSERT INTO fb_questionnaire_versions
  (version_key, display_name, segment, country, tool, date_from, date_to, notes)
VALUES
  ('v1_CSM',    'CSM Feedback Nov 2025',       'CSM',         'Germany', 'MicrosoftForms', '2025-07-14', '2025-11-30',
   'First version. Feature usage yes/no. No feature-level satisfaction. NPS included.'),
  ('v2_CSM',    'CSM Feedback Feb 2026',       'CSM',         'Germany', 'MicrosoftForms', '2025-10-18', '2026-02-28',
   'Second version. Research + Matrix + Chat Export (ignored). Frequency scale for research.'),
  ('v3_CSM',    'CSM Feedback May 2026',       'CSM',         'Germany', 'LimeSurvey',    '2026-03-01', NULL,
   'Third version. LimeSurvey. Research/Editor/Matrix/Templates. 1-5 Likert sub-metrics.'),
  ('v3_SS',     'Self-Service Feedback May 2026', 'SelfService', 'Germany', 'LimeSurvey', '2026-01-01', NULL,
   'Self-service segment Germany only. Adds Word Add-In, onboarding section, churn signal.');


CREATE TABLE fb_features (
  id    SMALLSERIAL PRIMARY KEY,
  key   VARCHAR(50) NOT NULL UNIQUE,   -- e.g. 'research', 'editor'
  name  VARCHAR(100) NOT NULL
);

INSERT INTO fb_features (key, name) VALUES
  ('research',   'Research (Chat)'),
  ('editor',     'Editor (Canvas)'),
  ('matrix',     'Matrix Analysis'),
  ('templates',  'Templates'),
  ('word_addin', 'Word Add-In');


-- ============================================================
-- RESPONSES
-- One row per respondent submission
-- ============================================================

CREATE TABLE fb_responses (
  id                    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  version_id            SMALLINT NOT NULL REFERENCES fb_questionnaire_versions(id),
  source_response_id    VARCHAR(50),              -- Original ID from the tool (dedup key)
  submitted_at          TIMESTAMPTZ,
  segment               VARCHAR(50),              -- Denormalised from version for easy filtering
  country               VARCHAR(100),             -- Denormalised from version

  -- Overall satisfaction (0–10)
  csat_overall          NUMERIC(4,1),

  -- NPS (v1 only, 0–10)
  nps_score             NUMERIC(4,1),

  -- UX metrics (0–10 in v1/v2, mapped from 1–5 Likert in v3)
  ux_ease_of_learning   NUMERIC(4,1),
  ux_discoverability    NUMERIC(4,1),
  ux_design             NUMERIC(4,1),
  ux_intuitiveness      NUMERIC(4,1),

  -- System transparency / answer quality (0–10 in v1/v2, mapped from 1–5 in v3)
  ueq_ease_of_use       NUMERIC(4,1),
  ueq_transparency      NUMERIC(4,1),
  ueq_answer_quality    NUMERIC(4,1),
  ueq_system_trust      NUMERIC(4,1),

  -- UEQ+ word pairs (v1/v2 only, 0–10)
  ueq_word1             NUMERIC(4,1),
  ueq_word2             NUMERIC(4,1),
  ueq_word3             NUMERIC(4,1),
  ueq_word4             NUMERIC(4,1),
  ueq_word5             NUMERIC(4,1),
  ueq_word6             NUMERIC(4,1),
  ueq_word7             NUMERIC(4,1),
  ueq_word8             NUMERIC(4,1),

  -- Workflow integration (v3 only, 0–10)
  csat_workflow_integration NUMERIC(4,1),

  -- Self-service specific
  churn_stays_user      BOOLEAN,                  -- "Bleiben Sie Nutzer*in?"
  onboarding_registration   NUMERIC(4,1),
  onboarding_information    NUMERIC(4,1),
  onboarding_resources      NUMERIC(4,1),
  onboarding_inapp          NUMERIC(4,1),
  academy_used          VARCHAR(10),              -- Ja / Nein / N.v.

  -- Demographics (stored as-is, normalised fields alongside)
  demo_gender           VARCHAR(50),
  demo_age_raw          VARCHAR(50),              -- Could be '34' or '41-50 Jahre'
  demo_age_group        VARCHAR(20),              -- Normalised bucket: '<30','30-40','41-50','51-60','60+'
  demo_role_raw         VARCHAR(255),
  demo_legal_area       VARCHAR(255),
  demo_firm_type        VARCHAR(100),
  demo_tech_affinity    NUMERIC(4,1),             -- 0-10 self-rating
  demo_ai_used_before   BOOLEAN,
  demo_ai_satisfaction  NUMERIC(4,1),

  -- Attention check (zebra question — used to flag inattentive respondents)
  attention_check_pass  BOOLEAN,

  created_at            TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_fb_responses_version    ON fb_responses(version_id);
CREATE INDEX idx_fb_responses_submitted  ON fb_responses(submitted_at);
CREATE INDEX idx_fb_responses_segment    ON fb_responses(segment);
CREATE INDEX idx_fb_responses_country    ON fb_responses(country);
CREATE INDEX idx_fb_responses_source_id  ON fb_responses(version_id, source_response_id);

COMMENT ON TABLE fb_responses IS
  'One row per questionnaire response across all versions. '
  'Numeric metrics are normalised to 0–10 scale throughout. '
  'source_response_id is the original tool ID — used for deduplication on re-import.';


-- ============================================================
-- FEATURE METRICS
-- One row per feature per response
-- Handles both yes/no and frequency scale versions
-- ============================================================

CREATE TABLE fb_feature_responses (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  response_id       UUID NOT NULL REFERENCES fb_responses(id) ON DELETE CASCADE,
  feature_id        SMALLINT NOT NULL REFERENCES fb_features(id),

  -- Usage
  frequency_raw     VARCHAR(50),                  -- Original value: 'Ja','Nie','Täglich' etc.
  frequency_score   SMALLINT,                     -- Normalised 0–5 (see mapping below)
  used_yn           BOOLEAN,                      -- Derived: score > 0

  -- Satisfaction (0–10, normalised from whatever scale was used)
  csat_overall      NUMERIC(4,1),
  csat_usability    NUMERIC(4,1),                 -- v3 only
  csat_accuracy     NUMERIC(4,1),                 -- v3 only
  csat_legal_precision NUMERIC(4,1),              -- v3 only
  csat_fluency      NUMERIC(4,1),                 -- v3 only
  csat_sources      NUMERIC(4,1),                 -- v3 only

  -- Matrix/Templates specific sub-metrics
  csat_creation_usability   NUMERIC(4,1),
  csat_application_usability NUMERIC(4,1),

  UNIQUE (response_id, feature_id)
);

CREATE INDEX idx_fb_feature_responses_response ON fb_feature_responses(response_id);
CREATE INDEX idx_fb_feature_responses_feature  ON fb_feature_responses(feature_id);

COMMENT ON TABLE fb_feature_responses IS
  'Feature-level metrics per response. '
  'frequency_score normalisation: Nie/Nein=0, Selten=1, Monatlich=2, Einmal pro Woche=3, '
  'Mehrmals pro Woche=4, Täglich=5, Ja=4. '
  'All CSAT scores normalised to 0–10 (Likert 1-5 multiplied by 2).';


-- ============================================================
-- OPEN TEXT RESPONSES
-- One row per open text field per response
-- ============================================================

CREATE TABLE fb_open_text (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  response_id     UUID NOT NULL REFERENCES fb_responses(id) ON DELETE CASCADE,
  field_key       VARCHAR(100) NOT NULL,          -- e.g. 'research:positive', 'general:improve'
  feature         VARCHAR(50),                    -- NULL if general, else feature key
  text_original   TEXT NOT NULL,                  -- Original German text
  categories      TEXT[],                         -- e.g. {'research:answer_quality','request:sources'}
  sentiment       VARCHAR(10),                    -- 'positive','negative','mixed','neutral'
  categorised_by  VARCHAR(10) DEFAULT 'pending',  -- 'ai','human','pending'
  categorised_at  TIMESTAMPTZ,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_fb_open_text_response   ON fb_open_text(response_id);
CREATE INDEX idx_fb_open_text_field      ON fb_open_text(field_key);
CREATE INDEX idx_fb_open_text_sentiment  ON fb_open_text(sentiment);
CREATE INDEX idx_fb_open_text_categories ON fb_open_text USING GIN(categories);

COMMENT ON TABLE fb_open_text IS
  'All open text responses stored with original German text. '
  'categories is a GIN-indexed array for efficient tag filtering. '
  'categorised_by tracks whether categorisation was AI-suggested or human-confirmed.';


-- ============================================================
-- ANALYTICS VIEWS
-- ============================================================

-- Overall CSAT trend over time
CREATE VIEW v_fb_csat_trend AS
SELECT
  DATE_TRUNC('month', r.submitted_at)   AS month,
  v.version_key,
  v.segment,
  v.country,
  COUNT(*)                               AS response_count,
  ROUND(AVG(r.csat_overall), 2)         AS avg_csat_overall,
  ROUND(AVG(r.ux_ease_of_learning), 2)  AS avg_ease_of_learning,
  ROUND(AVG(r.ux_discoverability), 2)   AS avg_discoverability,
  ROUND(AVG(r.ux_design), 2)            AS avg_design,
  ROUND(AVG(r.ux_intuitiveness), 2)     AS avg_intuitiveness,
  ROUND(AVG(r.ueq_ease_of_use), 2)      AS avg_ease_of_use,
  ROUND(AVG(r.ueq_transparency), 2)     AS avg_transparency,
  ROUND(AVG(r.ueq_answer_quality), 2)   AS avg_answer_quality
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE r.submitted_at IS NOT NULL
GROUP BY 1, 2, 3, 4
ORDER BY 1 DESC;


-- Feature satisfaction trend
CREATE VIEW v_fb_feature_trend AS
SELECT
  DATE_TRUNC('month', r.submitted_at)      AS month,
  v.segment,
  v.country,
  f.name                                   AS feature,
  COUNT(fr.id)                             AS response_count,
  ROUND(AVG(fr.csat_overall), 2)           AS avg_csat,
  ROUND(AVG(fr.csat_usability), 2)         AS avg_usability,
  ROUND(AVG(fr.csat_accuracy), 2)          AS avg_accuracy,
  ROUND(AVG(fr.csat_sources), 2)           AS avg_sources
FROM fb_feature_responses fr
JOIN fb_responses r          ON r.id  = fr.response_id
JOIN fb_questionnaire_versions v ON v.id = r.version_id
JOIN fb_features f           ON f.id  = fr.feature_id
WHERE r.submitted_at IS NOT NULL
GROUP BY 1, 2, 3, 4
ORDER BY 1 DESC, 4;


-- Feature usage trend (% users who used each feature per month)
CREATE VIEW v_fb_feature_usage AS
SELECT
  DATE_TRUNC('month', r.submitted_at)      AS month,
  v.segment,
  v.country,
  f.name                                   AS feature,
  COUNT(fr.id)                             AS total_responses,
  SUM(CASE WHEN fr.used_yn THEN 1 ELSE 0 END) AS used_count,
  ROUND(
    100.0 * SUM(CASE WHEN fr.used_yn THEN 1 ELSE 0 END) / NULLIF(COUNT(fr.id), 0),
    1
  )                                        AS pct_used,
  ROUND(AVG(fr.frequency_score), 2)        AS avg_frequency_score
FROM fb_feature_responses fr
JOIN fb_responses r              ON r.id  = fr.response_id
JOIN fb_questionnaire_versions v ON v.id  = r.version_id
JOIN fb_features f               ON f.id  = fr.feature_id
WHERE r.submitted_at IS NOT NULL
GROUP BY 1, 2, 3, 4
ORDER BY 1 DESC, 4;


-- NPS trend (v1 only)
CREATE VIEW v_fb_nps_trend AS
SELECT
  DATE_TRUNC('month', r.submitted_at)  AS month,
  COUNT(*)                             AS response_count,
  ROUND(AVG(r.nps_score), 2)           AS avg_nps,
  SUM(CASE WHEN r.nps_score >= 9 THEN 1 ELSE 0 END) AS promoters,
  SUM(CASE WHEN r.nps_score <= 6 THEN 1 ELSE 0 END) AS detractors,
  ROUND(
    100.0 * SUM(CASE WHEN r.nps_score >= 9 THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0) -
    100.0 * SUM(CASE WHEN r.nps_score <= 6 THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0),
    1
  )                                    AS nps_score_calc
FROM fb_responses r
WHERE r.nps_score IS NOT NULL
AND r.submitted_at IS NOT NULL
GROUP BY 1
ORDER BY 1 DESC;


-- Open text category frequency
CREATE VIEW v_fb_category_frequency AS
SELECT
  cat                                  AS category,
  COUNT(*)                             AS mention_count,
  SUM(CASE WHEN sentiment = 'positive' THEN 1 ELSE 0 END) AS positive_count,
  SUM(CASE WHEN sentiment = 'negative' THEN 1 ELSE 0 END) AS negative_count,
  SUM(CASE WHEN sentiment = 'mixed'    THEN 1 ELSE 0 END) AS mixed_count
FROM fb_open_text,
     UNNEST(categories) AS cat
WHERE categorised_by IN ('ai', 'human')
GROUP BY 1
ORDER BY mention_count DESC;


-- Self-service onboarding satisfaction
CREATE VIEW v_fb_onboarding AS
SELECT
  DATE_TRUNC('month', r.submitted_at)       AS month,
  COUNT(*)                                  AS response_count,
  ROUND(AVG(r.onboarding_registration), 2)  AS avg_registration,
  ROUND(AVG(r.onboarding_information), 2)   AS avg_information,
  ROUND(AVG(r.onboarding_resources), 2)     AS avg_resources,
  ROUND(AVG(r.onboarding_inapp), 2)         AS avg_inapp,
  SUM(CASE WHEN r.churn_stays_user = false THEN 1 ELSE 0 END) AS churned_count
FROM fb_responses r
WHERE r.segment = 'SelfService'
AND r.submitted_at IS NOT NULL
GROUP BY 1
ORDER BY 1 DESC;
