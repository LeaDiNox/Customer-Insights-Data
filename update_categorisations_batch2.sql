BEGIN;
UPDATE fb_open_text ot
SET categories     = ARRAY['editor:editing','editor:changecontrol','editor:contractwork','editor:chatinteraction'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v3_CSM'
  AND r.source_response_id   = '49'
  AND ot.field_key            = 'editor:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['editor:export','request:pptx_export'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v3_CSM'
  AND r.source_response_id   = '56'
  AND ot.field_key            = 'editor:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['general:errorhandling','editor:stability','research:speed','editor:documentupload'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v3_CSM'
  AND r.source_response_id   = '68'
  AND ot.field_key            = 'editor:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['editor:usability','editor:quality','editor:structure','request:templatesbeckonline'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v3_CSM'
  AND r.source_response_id   = '95'
  AND ot.field_key            = 'editor:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['editor:stability','general:errorhandling'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v3_SS'
  AND r.source_response_id   = '9'
  AND ot.field_key            = 'editor:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['general:positive','editor:initialdraft'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v3_CSM'
  AND r.source_response_id   = '56'
  AND ot.field_key            = 'editor:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['editor:editing','research:documentupload','general:positive'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v3_CSM'
  AND r.source_response_id   = '68'
  AND ot.field_key            = 'editor:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['editor:export'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v3_CSM'
  AND r.source_response_id   = '95'
  AND ot.field_key            = 'editor:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['editor:stability','general:errorhandling'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v3_SS'
  AND r.source_response_id   = '19'
  AND ot.field_key            = 'editor:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['request:single_license','request:pricing_flexibility'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v3_SS'
  AND r.source_response_id   = '37'
  AND ot.field_key            = 'general:churn_reason';

UPDATE fb_open_text ot
SET categories     = ARRAY['request:single_license','request:pricing_flexibility'],
    sentiment      = 'mixed',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v3_SS'
  AND r.source_response_id   = '44'
  AND ot.field_key            = 'general:churn_reason';

UPDATE fb_open_text ot
SET categories     = ARRAY['request:single_license','request:pricing_flexibility'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v3_SS'
  AND r.source_response_id   = '52'
  AND ot.field_key            = 'general:churn_reason';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:answer_quality','research:consistency'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '8'
  AND ot.field_key            = 'general:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:answer_quality'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '9'
  AND ot.field_key            = 'general:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:answerstructure','research:citationsmismatch'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '10'
  AND ot.field_key            = 'general:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:sources','research:answer_quality'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '11'
  AND ot.field_key            = 'general:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:answer_quality','request:jurisintegration','research:oldsources'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '12'
  AND ot.field_key            = 'general:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:answer_quality'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v3_CSM'
  AND r.source_response_id   = '57'
  AND ot.field_key            = 'general:integrate';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:answer_quality','research:consistency'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v3_CSM'
  AND r.source_response_id   = '74'
  AND ot.field_key            = 'general:integrate';

UPDATE fb_open_text ot
SET categories     = ARRAY['request:personalisation','request:knowledge_base'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v3_CSM'
  AND r.source_response_id   = '76'
  AND ot.field_key            = 'general:integrate';

UPDATE fb_open_text ot
SET categories     = ARRAY['request:personalisation','request:knowledge_base','general:security'],
    sentiment      = 'mixed',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v3_CSM'
  AND r.source_response_id   = '78'
  AND ot.field_key            = 'general:integrate';

UPDATE fb_open_text ot
SET categories     = ARRAY['request:personalisation','request:knowledge_base'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v3_CSM'
  AND r.source_response_id   = '85'
  AND ot.field_key            = 'general:integrate';

UPDATE fb_open_text ot
SET categories     = ARRAY['general:positive','research:sources'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '23'
  AND ot.field_key            = 'general:other';

UPDATE fb_open_text ot
SET categories     = ARRAY['general:positive'],
    sentiment      = 'mixed',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '36'
  AND ot.field_key            = 'general:other';

UPDATE fb_open_text ot
SET categories     = ARRAY['general:positive','research:sources','research:answerquality'],
    sentiment      = 'mixed',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '50'
  AND ot.field_key            = 'general:other';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:sources','transparency:source_visibility','general:positive'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '8'
  AND ot.field_key            = 'general:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:speed','research:sources','general:positive'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '9'
  AND ot.field_key            = 'general:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:answerstructure','research:sources','general:positive'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '10'
  AND ot.field_key            = 'general:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:answer_quality','research:speed','general:positive','research:answerstructure'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '11'
  AND ot.field_key            = 'general:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['editor:editing','general:positive'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '12'
  AND ot.field_key            = 'general:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:answerquality'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '10'
  AND ot.field_key            = 'general:request';

UPDATE fb_open_text ot
SET categories     = ARRAY['transparency:source_visibility','request:source_highlighting'],
    sentiment      = 'neutral',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '11'
  AND ot.field_key            = 'general:request';

UPDATE fb_open_text ot
SET categories     = ARRAY['request:jurisintegration','research:sources'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '12'
  AND ot.field_key            = 'general:request';

UPDATE fb_open_text ot
SET categories     = ARRAY['request:word_addin','request:workflow_feature','request:editor'],
    sentiment      = 'neutral',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '14'
  AND ot.field_key            = 'general:request';

UPDATE fb_open_text ot
SET categories     = ARRAY['matrix:usability','ui:layout'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v2_CSM'
  AND r.source_response_id   = '91'
  AND ot.field_key            = 'matrix:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['matrix:accuracy','matrix:documentupload'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v2_CSM'
  AND r.source_response_id   = '126'
  AND ot.field_key            = 'matrix:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['matrix:uploadlimit'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v3_SS'
  AND r.source_response_id   = '36'
  AND ot.field_key            = 'matrix:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['matrix:usage'],
    sentiment      = 'mixed',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v2_CSM'
  AND r.source_response_id   = '89'
  AND ot.field_key            = 'matrix:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['matrix:usage','general:positive'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v2_CSM'
  AND r.source_response_id   = '91'
  AND ot.field_key            = 'matrix:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['general:positive'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v2_CSM'
  AND r.source_response_id   = '126'
  AND ot.field_key            = 'matrix:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['matrix:functionality','request:matrix_chat_followup'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v3_CSM'
  AND r.source_response_id   = '21'
  AND ot.field_key            = 'matrix:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['matrix:usability','general:positive'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v3_CSM'
  AND r.source_response_id   = '65'
  AND ot.field_key            = 'matrix:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:answer_quality','general:positive'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '18'
  AND ot.field_key            = 'nps:main_reason';

UPDATE fb_open_text ot
SET categories     = ARRAY['general:positive','research:oldsources'],
    sentiment      = 'mixed',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '23'
  AND ot.field_key            = 'nps:main_reason';

UPDATE fb_open_text ot
SET categories     = ARRAY['general:positive','general:stability'],
    sentiment      = 'mixed',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '26'
  AND ot.field_key            = 'nps:main_reason';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:speed','research:answer_quality','general:positive'],
    sentiment      = 'mixed',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '11'
  AND ot.field_key            = 'nps:reason';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:speed','general:positive'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '15'
  AND ot.field_key            = 'nps:reason';

UPDATE fb_open_text ot
SET categories     = ARRAY['general:positive','research:answerquality'],
    sentiment      = 'mixed',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '18'
  AND ot.field_key            = 'nps:reason';

UPDATE fb_open_text ot
SET categories     = ARRAY['general:security','general:positive'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '20'
  AND ot.field_key            = 'nps:reason';

UPDATE fb_open_text ot
SET categories     = ARRAY['general:positive','research:answer_quality'],
    sentiment      = 'mixed',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '22'
  AND ot.field_key            = 'nps:reason';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:hallucination','research:sources','request:personalisation','research:referencinganswers','research:agents'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v2_CSM'
  AND r.source_response_id   = '8'
  AND ot.field_key            = 'research:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:citations','research:hallucination','research:sources'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v2_CSM'
  AND r.source_response_id   = '9'
  AND ot.field_key            = 'research:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:hallucination','research:answer_quality'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v2_CSM'
  AND r.source_response_id   = '10'
  AND ot.field_key            = 'research:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:answer_quality','research:sources'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v2_CSM'
  AND r.source_response_id   = '11'
  AND ot.field_key            = 'research:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:answer_quality','transparency:thinking_process','transparency:introspection'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v2_CSM'
  AND r.source_response_id   = '12'
  AND ot.field_key            = 'research:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:sources','research:answer_quality','general:positive'],
    sentiment      = 'mixed',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v2_CSM'
  AND r.source_response_id   = '8'
  AND ot.field_key            = 'research:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:answerstructure','research:answer_quality','general:positive'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v2_CSM'
  AND r.source_response_id   = '9'
  AND ot.field_key            = 'research:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:sources','transparency:source_visibility','research:chathistory'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v2_CSM'
  AND r.source_response_id   = '10'
  AND ot.field_key            = 'research:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:answer_quality','research:usability','general:positive'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v2_CSM'
  AND r.source_response_id   = '11'
  AND ot.field_key            = 'research:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:answerstructure','general:positive'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v2_CSM'
  AND r.source_response_id   = '12'
  AND ot.field_key            = 'research:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['general:errorhandling','research:speed','general:stability'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '25'
  AND ot.field_key            = 'ux:notes';

UPDATE fb_open_text ot
SET categories     = ARRAY['general:errorhandling','onboarding:getting_started','request:modes'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '26'
  AND ot.field_key            = 'ux:notes';

UPDATE fb_open_text ot
SET categories     = ARRAY['transparency:source_visibility','request:source_highlighting'],
    sentiment      = 'mixed',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '43'
  AND ot.field_key            = 'ux:notes';

UPDATE fb_open_text ot
SET categories     = ARRAY['transparency:source_visibility','ui:design'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id         = r.id
  AND v.version_key          = 'v1_CSM'
  AND r.source_response_id   = '47'
  AND ot.field_key            = 'ux:notes';

SELECT categorised_by, COUNT(*) FROM fb_open_text GROUP BY categorised_by ORDER BY categorised_by;
COMMIT;
