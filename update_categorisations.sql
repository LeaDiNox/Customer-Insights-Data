BEGIN;

UPDATE fb_open_text ot
SET categories     = ARRAY['editor:editing','editor:changecontrol'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v3_CSM'
  AND r.source_response_id = '14'
  AND ot.field_key         = 'editor:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['editor:usability','transparency:thinking_process','editor:versioning'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v3_CSM'
  AND r.source_response_id = '15'
  AND ot.field_key         = 'editor:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['editor:usage'],
    sentiment      = 'neutral',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v3_CSM'
  AND r.source_response_id = '18'
  AND ot.field_key         = 'editor:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['editor:editing','research:answer_quality','editor:reload','editor:quality'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v3_CSM'
  AND r.source_response_id = '29'
  AND ot.field_key         = 'editor:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['editor:usability','ui:navigation','editro:whenused'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v3_CSM'
  AND r.source_response_id = '45'
  AND ot.field_key         = 'editor:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['editor:usage','editor:workflow'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v3_CSM'
  AND r.source_response_id = '15'
  AND ot.field_key         = 'editor:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['editor:editing','editor:intextprompting'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v3_CSM'
  AND r.source_response_id = '29'
  AND ot.field_key         = 'editor:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['editor:editing'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v3_CSM'
  AND r.source_response_id = '45'
  AND ot.field_key         = 'editor:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['editor:editing','editor:intextprompting'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v3_CSM'
  AND r.source_response_id = '49'
  AND ot.field_key         = 'editor:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:answer_quality','general:negative','research:prompting'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v3_SS'
  AND r.source_response_id = '8'
  AND ot.field_key         = 'general:churn_reason';

UPDATE fb_open_text ot
SET categories     = ARRAY['request:single_license'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v3_SS'
  AND r.source_response_id = '20'
  AND ot.field_key         = 'general:churn_reason';

UPDATE fb_open_text ot
SET categories     = ARRAY['general:negative','support:experience'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v3_SS'
  AND r.source_response_id = '25'
  AND ot.field_key         = 'general:churn_reason';

UPDATE fb_open_text ot
SET categories     = ARRAY['request:single_license'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v3_SS'
  AND r.source_response_id = '33'
  AND ot.field_key         = 'general:churn_reason';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:answer_quality'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '3'
  AND ot.field_key         = 'general:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:answer_quality','ui:design','onboarding:getting_started','matrix:usage','general:errorhandling','onboarding:matrix'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '4'
  AND ot.field_key         = 'general:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['ui:design','research:documentupload','general:errorhandling'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '5'
  AND ot.field_key         = 'general:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['request:chat_history'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '6'
  AND ot.field_key         = 'general:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:answer_quality','research:answerstructure'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '7'
  AND ot.field_key         = 'general:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['request:word_addin'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v3_CSM'
  AND r.source_response_id = '27'
  AND ot.field_key         = 'general:integrate';

UPDATE fb_open_text ot
SET categories     = ARRAY['request:third_party_integration'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v3_CSM'
  AND r.source_response_id = '29'
  AND ot.field_key         = 'general:integrate';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:citations'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v3_CSM'
  AND r.source_response_id = '43'
  AND ot.field_key         = 'general:integrate';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:answer_quality','transparency:thinking_process','research:conversationalinteraction'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v3_CSM'
  AND r.source_response_id = '55'
  AND ot.field_key         = 'general:integrate';

UPDATE fb_open_text ot
SET categories     = ARRAY['general:positive'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '6'
  AND ot.field_key         = 'general:other';

UPDATE fb_open_text ot
SET categories     = ARRAY['general:positive'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '7'
  AND ot.field_key         = 'general:other';

UPDATE fb_open_text ot
SET categories     = ARRAY['request:sources_additional_databases','request:jurisintegration'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '12'
  AND ot.field_key         = 'general:other';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:speed','general:positive'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '3'
  AND ot.field_key         = 'general:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['ui:design','general:positive'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '4'
  AND ot.field_key         = 'general:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['matrix:usage','matrix:crosscolumnlogic'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '5'
  AND ot.field_key         = 'general:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:sources','research:answer_quality','research:citations','research:answerstructure'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '6'
  AND ot.field_key         = 'general:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:sources','transparency:source_visibility','research:citations'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '7'
  AND ot.field_key         = 'general:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['request:document_upload'],
    sentiment      = 'neutral',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '4'
  AND ot.field_key         = 'general:request';

UPDATE fb_open_text ot
SET categories     = ARRAY['request:voice_input','request:voiceconversation'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '5'
  AND ot.field_key         = 'general:request';

UPDATE fb_open_text ot
SET categories     = ARRAY['request:chat_history'],
    sentiment      = 'neutral',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '6'
  AND ot.field_key         = 'general:request';

UPDATE fb_open_text ot
SET categories     = ARRAY['request:chat_history'],
    sentiment      = 'neutral',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '7'
  AND ot.field_key         = 'general:request';

UPDATE fb_open_text ot
SET categories     = ARRAY['request:personalisation','request:word_addin'],
    sentiment      = 'neutral',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '8'
  AND ot.field_key         = 'general:request';

UPDATE fb_open_text ot
SET categories     = ARRAY['matrix:usage','matrix:usability','matrix:uploadlimit'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v2_CSM'
  AND r.source_response_id = '16'
  AND ot.field_key         = 'matrix:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['matrix:usability','ui:design','matrix:errorhandling'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v2_CSM'
  AND r.source_response_id = '82'
  AND ot.field_key         = 'matrix:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['matrix:accuracy'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v2_CSM'
  AND r.source_response_id = '84'
  AND ot.field_key         = 'matrix:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['matrix:accuracy','matrix:functionality'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v2_CSM'
  AND r.source_response_id = '88'
  AND ot.field_key         = 'matrix:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['matrix:usability','ui:layout'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v2_CSM'
  AND r.source_response_id = '89'
  AND ot.field_key         = 'matrix:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['matrix:usage','matrix:outputoptions'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v2_CSM'
  AND r.source_response_id = '16'
  AND ot.field_key         = 'matrix:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['matrix:accuracy','matrix:usability'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v2_CSM'
  AND r.source_response_id = '67'
  AND ot.field_key         = 'matrix:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['matrix:usage'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v2_CSM'
  AND r.source_response_id = '77'
  AND ot.field_key         = 'matrix:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['matrix:usability'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v2_CSM'
  AND r.source_response_id = '88'
  AND ot.field_key         = 'matrix:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['general:positive'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '5'
  AND ot.field_key         = 'nps:main_reason';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:usability','general:negative','general:functionality'],
    sentiment      = 'mixed',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '7'
  AND ot.field_key         = 'nps:main_reason';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:speed','general:positive'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '9'
  AND ot.field_key         = 'nps:main_reason';

UPDATE fb_open_text ot
SET categories     = ARRAY['general:positive'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '4'
  AND ot.field_key         = 'nps:reason';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:answer_quality','research:contractwork'],
    sentiment      = 'mixed',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '5'
  AND ot.field_key         = 'nps:reason';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:speed','general:positive'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '6'
  AND ot.field_key         = 'nps:reason';

UPDATE fb_open_text ot
SET categories     = ARRAY['onboarding:getting_started','general:positive','general:security'],
    sentiment      = 'mixed',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '7'
  AND ot.field_key         = 'nps:reason';

UPDATE fb_open_text ot
SET categories     = ARRAY['general:positive'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '9'
  AND ot.field_key         = 'nps:reason';

UPDATE fb_open_text ot
SET categories     = ARRAY['onboarding:getting_started','request:user_management'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v3_SS'
  AND r.source_response_id = '20'
  AND ot.field_key         = 'onboarding:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['request:support','onboarding:getting_started'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v3_SS'
  AND r.source_response_id = '21'
  AND ot.field_key         = 'onboarding:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['general:negative','request:support'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v3_SS'
  AND r.source_response_id = '36'
  AND ot.field_key         = 'onboarding:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['request:mobile_app'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v3_SS'
  AND r.source_response_id = '52'
  AND ot.field_key         = 'onboarding:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['onboarding:getting_started'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v3_SS'
  AND r.source_response_id = '52'
  AND ot.field_key         = 'onboarding:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['request:sources_beck_online','research:paywall'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v2_CSM'
  AND r.source_response_id = '2'
  AND ot.field_key         = 'research:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:sources','research:answer_quality'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v2_CSM'
  AND r.source_response_id = '3'
  AND ot.field_key         = 'research:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:answer_quality'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v2_CSM'
  AND r.source_response_id = '4'
  AND ot.field_key         = 'research:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:answer_quality','onboarding:getting_started'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v2_CSM'
  AND r.source_response_id = '6'
  AND ot.field_key         = 'research:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:answer_quality'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v2_CSM'
  AND r.source_response_id = '7'
  AND ot.field_key         = 'research:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:speed','general:positive'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v2_CSM'
  AND r.source_response_id = '2'
  AND ot.field_key         = 'research:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['transparency:source_visibility','general:positive','transparency:citations','research:answerstructure'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v2_CSM'
  AND r.source_response_id = '3'
  AND ot.field_key         = 'research:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:sources','research:answer_quality','research:sourcequantity'],
    sentiment      = 'mixed',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v2_CSM'
  AND r.source_response_id = '4'
  AND ot.field_key         = 'research:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:answer_quality','general:positive'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v2_CSM'
  AND r.source_response_id = '6'
  AND ot.field_key         = 'research:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:sources','transparency:thinking_process','transparency:source_visibility','research:answerstructure'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v2_CSM'
  AND r.source_response_id = '7'
  AND ot.field_key         = 'research:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['templates:reproducability'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v3_CSM'
  AND r.source_response_id = '85'
  AND ot.field_key         = 'templates:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['templates:usage','templates:documentupload'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v3_SS'
  AND r.source_response_id = '21'
  AND ot.field_key         = 'templates:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['templates:usage','general:positive'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v3_CSM'
  AND r.source_response_id = '85'
  AND ot.field_key         = 'templates:positive';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:usage','research:answerstructure'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '15'
  AND ot.field_key         = 'ux:notes';

UPDATE fb_open_text ot
SET categories     = ARRAY['research:sources','transparency:source_visibility'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v1_CSM'
  AND r.source_response_id = '23'
  AND ot.field_key         = 'ux:notes';

UPDATE fb_open_text ot
SET categories     = ARRAY['word_addin:usability','ui:navigation','word_addin:login'],
    sentiment      = 'negative',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v3_SS'
  AND r.source_response_id = '52'
  AND ot.field_key         = 'word_addin:improve';

UPDATE fb_open_text ot
SET categories     = ARRAY['word_addin:usage','general:positive'],
    sentiment      = 'positive',
    categorised_by = 'human',
    categorised_at = NOW()
FROM fb_responses r
JOIN fb_questionnaire_versions v ON v.id = r.version_id
WHERE ot.response_id       = r.id
  AND v.version_key        = 'v3_SS'
  AND r.source_response_id = '52'
  AND ot.field_key         = 'word_addin:positive';

-- Verification
SELECT categorised_by, COUNT(*) FROM fb_open_text GROUP BY categorised_by ORDER BY categorised_by;

COMMIT;