BEGIN;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    30,
    'The user doesn''t understand how to use the workflows.',
    (SELECT id FROM insight_types WHERE name = 'Idea'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Mixed' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 1, '', '', '',
    '', true, true,
    '2025-10-08',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 30 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 30 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    41,
    'The user needs support in writing successful prompts.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Planned for development'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department; Mixed; Big Law Firm; Big Law Firm', 'Continous_Direct_Feedback_corporate,202510-Canvas-Interview_Testing,Continous_Direct_Feedback_big_law_firm,2025_11_Personas_M_B_Lawfirms', 10, '', '', '',
    '', false, false,
    '2025-10-08',
    '2026-02-12'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 41 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 41 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 41 AND f.name = 'Chat'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 41 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 41 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 41 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    42,
    'The user needs a choice between different versions of the LLM.',
    (SELECT id FROM insight_types WHERE name = 'Idea'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Mixed' LIMIT 1),
    'Corporate Law Department; Big Law Firm', 'Continous_Direct_Feedback_corporate,2025_11_Personas_M_B_Lawfirms', 2, '', '', '',
    '', true, true,
    '2025-10-08',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 42 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 42 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    43,
    'The non-native speaker needs help in translating the results of a search.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 3, '', '', '',
    '', true, true,
    '2025-10-08',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 43 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 43 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    44,
    'The user needs the the answers and citations to be matching.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department; Mixed; Mixed', 'Continous_Direct_Feedback_corporate,2025_11_Beck_Feedback_Survey_2,2025_10_Beck_Feedback_Survey', 25, '', 'Improved with release of Beck Noxtua and is reported to be: The initial test results look very good. The insertion of citations is now largely correct. In the Feedback Survey for the post-agentic release only 5 out of 70 participants mention mistmatches.

December 2025: +1

', '',
    'Beck Germany', false, true,
    '2025-10-08',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 44 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 44 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    45,
    'The user needs the tool to take over at least parts of his task reliably so that he has the biggest benefit of using the tool.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_10_Beck_Feedback_Survey', 2, 'Perspektive/Effizienz: Die „Wunschvorstellung“ ist, dass man wissenschaftliche Mitarbeiter „jedenfalls in Teilen sparen“ kann, wenn Agenten die Recherche auf ähnlichem Niveau übernehmen.

„Das ist wie wenn man auf den Pool von wissenschaftlichen Mitarbeitern zugreift. Da kann man mal Glück haben und manchmal hat man Pech … und wenn man richtig Pech hat, dann kriegt man … einen renitenten wissenschaftlichen Mitarbeiter…“
', '', '',
    'Beck Germany', true, false,
    '2025-10-08',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 45 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 45 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 45 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    46,
    'The user needs the answers to be precise and on point so that his time is efficiently used.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Mixed; Big Law Firm', '2025_10_Beck_Feedback_Survey,2025_11_Beck_Feedback_Survey_2,Continous_Direct_Feedback_big_law_firm', 18, '', 'Since Release:
1 good
1 bad', '',
    'Beck Germany', false, true,
    '2025-10-08',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 46 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 46 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    47,
    'The user needs also information for very specific topics to be available so that he can use the tool for their tasks.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Small Law Firm', 'Continous_Direct_Feedback_small_law_firm', 0, '', '', '',
    '', true, true,
    '2025-10-08',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 47 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 47 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    48,
    'The user needs the AI generated template to have a high quality.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Small Law Firm', 'Continous_Direct_Feedback_small_law_firm', 1, '"Das könnte so viel besser sein, wenn es eben mit den Mustern trainiert wäre und dann das Beste, wenn drei oder vier Muster, die es ja durchaus gibt für bestimmte Bereiche"', '', '',
    '', true, false,
    '2025-10-09',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 48 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 48 AND f.name = 'Templates'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 48 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    50,
    'The user needs to know which data is available in the system so that they can be sure that the right sources can be used.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Small Law Firm; Mixed; Corporate Law Department', 'Continous_Direct_Feedback_small_law_firm,2025_11_Beck_Feedback_Survey_2,Continous_Direct_Feedback_corporate', 4, '', '', '',
    'Beck Germany', true, false,
    '2025-10-09',
    '2026-02-17'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 50 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 50 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 50 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 50 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    52,
    'The user needs the answers to be adapted their role, so that they can use the information best.',
    (SELECT id FROM insight_types WHERE name = 'Idea'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Mixed' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 0, '"Das Sprachmodell sich das Beste aus allen Welten suchen (z.B. BeckOFs) und vielleicht sogar schon auf den Prompt eingehen und sagen: „Ich lege einen besonderen Schwerpunkt auf oder ich könnte dann sogar schreiben: „Bitte schreib das aus Sicht des Bestellers oder schreib das aus Sicht des Anbieters (anwenderfreundlich)"', '', '',
    '', true, true,
    '2025-10-09',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 52 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 52 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    53,
    'The user needs the answers to be adapted to their level of expertise, that they can work best with the answers.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Small Law Firm; Corporate Law Department', 'Continous_Direct_Feedback_small_law_firm,2025_11_Zalando_Hackathon', 2, '', '', '',
    '', true, true,
    '2025-10-09',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 53 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 53 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 53 AND st.name = 'Hackathon'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    54,
    'The user needs to be enabled to quickly gain an overview of a legal topic in order to work efficiently on that topic.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm; Corporate Law Department; Government Institutions; Prosecution/ Judges', 'Continous_Direct_Feedback_big_law_firm,2025_11_Zalando_Hackathon,Continous_Direct_Feedback_GovernmentInstitutions,2026_03_Personas_Judiciary', 4, '"super Zusammenfassung"
"What works well: getting at least a usable overview of unfamiliar legal areas in very short time, becoming somewhat speaking-fluent" (Judiciary Personas)', '', '',
    '', false, true,
    '2025-10-09',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 54 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 54 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 54 AND st.name = 'Hackathon'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 54 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    55,
    'The user needs to be able to use the tool to draft text snippets so that they can save time.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm; Small Law Firm; Government Institutions', 'Continous_Direct_Feedback_big_law_firm,Continous_Direct_Feedback_small_law_firm,Continous_Direct_Feedback_GovernmentInstitutions', 3, '', '', '',
    '', false, true,
    '2025-10-09',
    '2026-03-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 55 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 55 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    57,
    'The application runs mostly quickly and smoothly. Saves a lot of work.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department; Small Law Firm', 'Continous_Direct_Feedback_corporate,Continous_Direct_Feedback_small_law_firm', 2, '“Hätte nicht gedacht, dass so eine Anwendung heute schon möglich sei” ', '', '',
    '', false, true,
    '2025-10-10',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 57 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    58,
    'The user needs the tool to be transparent if it does not have any sources available.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Small Law Firm; Mixed', 'Continous_Direct_Feedback_small_law_firm,2025_11_Beck_Feedback_Survey_2', 4, '', '', '',
    'Beck Germany', true, false,
    '2025-10-10',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 58 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 58 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 58 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    59,
    'Citations are often inaccurate (e.g., bibliography instead of text passage) 
Primary sources are missing: Judgments were cited almost exclusively via secondary sources.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Small Law Firm', 'Continous_Direct_Feedback_small_law_firm', 1, '', '', '',
    '', true, false,
    '2025-10-10',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 59 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 59 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 59 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    60,
    'Formularhandbücher used as a substitute source: unsuitable for doctrinal questions',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Small Law Firm', 'Continous_Direct_Feedback_small_law_firm', 1, '', '', '',
    '', true, false,
    '2025-10-10',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 60 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 60 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 60 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    61,
    'The citation system should differentiate between primary and secondary sources.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Small Law Firm', 'Continous_Direct_Feedback_small_law_firm', 1, '', '', '',
    '', true, false,
    '2025-10-10',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 61 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 61 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 61 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    62,
    'The user needs a complete list of the sources additionally to synthesized results.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Small Law Firm; Mixed', 'Continous_Direct_Feedback_small_law_firm,2026_01_Workflow_Expectations_Interview', 3, '', '', '',
    '', true, false,
    '2025-10-10',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 62 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 62 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 62 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 62 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 62 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    64,
    'The user wants a consistent citation format with Pin Cites.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Small Law Firm; Corporate Law Department', 'Continous_Direct_Feedback_small_law_firm,2026_02_Personas_Corporate', 2, '"Source citations don''t follow the standard citation style used in briefs - I always have to go into Beck Online again to fix them" (Corporate Personas)', '', '',
    '', true, true,
    '2025-10-10',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 64 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 64 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 64 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    66,
    'Added value compared to GPT not always evident',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate,Bayrische_Landesbank_042026', 3, '', '', '',
    '', true, true,
    '2025-10-13',
    '2026-04-23'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 66 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    69,
    'The user needs the direct citations and no indirect ones of a secondary source.',
    (SELECT id FROM insight_types WHERE name = 'To be removed'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department; Big Law Firm', 'Continous_Direct_Feedback_corporate,Continous_Direct_Feedback_big_law_firm', 3, '', '', '',
    '', true, false,
    '2025-10-13',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 69 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 69 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 69 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    70,
    'The user needs to be able to give feedback regarding the quality of the task fulfillment.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 2, '', '', '',
    '', true, false,
    '2025-10-13',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 70 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 70 AND f.name = 'All'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 70 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    71,
    'The user needs the tool to make own deductions beyond the provision and integration of feedback.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department; Big Law Firm', 'Continous_Direct_Feedback_corporate,2025_11_Personas_M_B_Lawfirms', 4, '', '', '',
    '', true, false,
    '2025-10-13',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 71 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 71 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 71 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 71 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    72,
    'The user needs the tool to also provide them with alternative perspectives not only e.g. with the predominant one.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department; Corporate Law Department; Prosecution/ Judges', 'Continous_Direct_Feedback_corporate,2026_02_Personas_Corporate,2026_03_Personas_Judiciary', 5, '"Even positive hallucination leads to a new thought you wouldn''t have had alone (Corp6); AI helps me take other perspectives - you only ever think from your own (Justice6)" (Corporate / Judiciary Personas)', '', '',
    '', true, false,
    '2025-10-13',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 72 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 72 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 72 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 72 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    74,
    'The user wants to be able to add additional (e.g. internal) data and cases to the tool, so that it can integrate this data as well.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department; Big Law Firm; Mixed', 'Continous_Direct_Feedback_corporate,Continous_Direct_Feedback_big_law_firm,2025_12_KnowledgeBase_UCs_Interviews', 21, '', '', '',
    '', false, false,
    '2025-10-13',
    '2026-04-17'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 74 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 74 AND f.name = 'Document Storage'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 74 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 74 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 74 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    75,
    'The user needs to be able to customize the tool to fit to their individual or company internal policies or preferences.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department; Mixed; Mixed; Mixed; Big Law Firm', 'Continous_Direct_Feedback_corporate,202510-Canvas-Interview_Testing,2025_11_Beck_Feedback_Survey_2,2025_10_Beck_Feedback_Survey,2025_11_Personas_M_B_Lawfirms', 9, '', '', '',
    'Beck Germany', false, false,
    '2025-10-13',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 75 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 75 AND f.name = 'User Profile'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 75 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 75 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 75 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    76,
    'The user needs to have insights into the sources of the provided answer in order to verify results easier.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm; Mixed; Corporate Law Department; Big Law Firm; Government Institutions; Corporate Law Department', 'Continous_Direct_Feedback_big_law_firm,2025_11_Beck_Feedback_Survey_2,2025_11_Zalando_Hackathon,2025_11_Personas_M_B_Lawfirms,Continous_Direct_Feedback_GovernmentInstitutions,Continous_Direct_Feedback_corporate,Bayrische_Landesbank_042026', 65, '', '', '',
    'Beck Germany', false, false,
    '2025-10-14',
    '2026-04-23'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 76 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 76 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 76 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 76 AND st.name = 'Hackathon'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 76 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    77,
    'The users have different needs for the level of detail of the answer.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm; Corporate Law Department; Corporate Law Department', 'Continous_Direct_Feedback_big_law_firm,2025_11_Zalando_Hackathon,2026_02_Personas_Corporate', 7, '“Wäre toll, wenn man einstellen könnte, wie ausführlich die Antworten sind”
"I want to prompt that I want a topic detailed, or simply broken down" (Corporate Personas)', 'Should be looked at holistically as a topic of user/ answer preferences. > should monitored!', '',
    '', false, false,
    '2025-10-14',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 77 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 77 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 77 AND f.name = 'Personalization'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 77 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 77 AND st.name = 'Hackathon'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 77 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    78,
    'The user would like to be able to see exactly from which part of a source the model derived the answer.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm; Mixed; Mixed; Publisher', 'Continous_Direct_Feedback_big_law_firm,2026_01_Workflow_Expectations_Interview,2025_12_KnowledgeBase_UCs_Interviews,Continous_Publisher_Swiss_Noxtua', 9, '“Direkt Quellen an der Seite einzusehen wäre natürlich noch besser.”', 'Study to be planned', '',
    'Swiss', false, false,
    '2025-10-14',
    '2026-04-17'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 78 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 78 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 78 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 78 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 78 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    79,
    'The user needs to be able to understand which steps the AI takes to derive the results.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm; Corporate Law Department; Mixed; Corporate Law Department; Small Law Firm; Big Law Firm; Government Institutions', 'Continous_Direct_Feedback_big_law_firm,202510-Canvas-Interview,2025_11_Beck_Feedback_Survey_2,Continous_Direct_Feedback_corporate,Continous_Direct_Feedback_small_law_firm,2025_11_Personas_M_B_Lawfirms,Continous_Direct_Feedback_GovernmentInstitutions', 28, '', '', '',
    'Beck Germany', false, false,
    '2025-10-14',
    '2026-03-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 79 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 79 AND f.name = 'Thinking Process'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 79 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 79 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 79 AND st.name = 'User Interview'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    80,
    'The user would like to be able to integrate their thoughts with the official information from the provided sources.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 2, '', '', '',
    '', true, true,
    '2025-10-14',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 80 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 80 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    81,
    'The user needs transparency about data security measures to be sure that their data is being treated confidentially and is not distributed, but only locally on their machine.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm; Small Law Firm', 'Continous_Direct_Feedback_big_law_firm,Continous_Direct_Feedback_small_law_firm', 6, '“Ist das jetzt wirklich lokal oder wird das auf einen Server hochgeladen?”

es reicht, dass ihr versichert und uns überzeugt, dass ihr das auch einhaltet  „glaubhaft machen“, z.B. Verschlüsselungsprozess erklären', '3 People mention in the Beck Feedback Survey, that this is already a good thing. However, in the sales call the user still didn''t seem to be sure.

Shared in Marketing, Onepager for Sales is build. Recheck if that reduces uncertainty.', '',
    '', false, false,
    '2025-10-14',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 81 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 81 AND f.name = 'All'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 81 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    82,
    'The user wants to be able to share generated matrixes with their colleagues.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 1, '', '', '',
    '', true, true,
    '2025-10-14',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 82 AND f.name = 'Matrix-Analysis'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 82 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    83,
    'The user needs to be able to generate customized workflows in order to handle complex tasks.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm; Corporate Law Department; Big Law Firm; Government Institutions', 'Continous_Direct_Feedback_big_law_firm,Continous_Direct_Feedback_corporate,2025_11_Personas_M_B_Lawfirms,Continous_Direct_Feedback_GovernmentInstitutions', 13, '', '', '',
    '', false, false,
    '2025-10-14',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 83 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 83 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 83 AND f.name = 'To-Do-List'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 83 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 83 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    84,
    'The user needs to be able to import on Matrixes to provide the system with more information.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 1, '', '', '',
    '', true, true,
    '2025-10-14',
    '2026-03-31'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 84 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    85,
    'The user needs to be able to work within their document in one place to work seamlessly and to minimize window/context switching.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', '202510-Canvas-Interview', 0, '"und dann wäre es natürlich cool, wenn Noxtua direkt im Dokument auch Gegenvorschläge machen könnte, entweder um die Nachteile abzuschwächen oder die Klausel halt auch mal zu meinen Gunsten umzudrehen."', '', '',
    '', true, false,
    '2025-10-15',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 85 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 85 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 85 AND st.name = 'User Interview'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    86,
    'The user needs to be able to access templates from the word-add-in in order to have everything in one place.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', '202510-Canvas-Interview', 1, '', '', '',
    '', true, true,
    '2025-10-15',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 86 AND f.name = 'Templates'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 86 AND st.name = 'User Interview'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    87,
    'The user needs help in optimizing the content of a document regarding their needs.',
    (SELECT id FROM insight_types WHERE name = 'Idea'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Mixed' LIMIT 1),
    'Corporate Law Department; Big Law Firm', '202510-Canvas-Interview,2025_11_Personas_M_B_Lawfirms', 2, '', '', '',
    '', true, false,
    '2025-10-15',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 87 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 87 AND f.name = 'Document Review'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 87 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 87 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 87 AND st.name = 'User Interview'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    88,
    'The user wants to be able to see and decide on proposed changes in order to stay in control.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', '202510-Canvas-Interview', 2, 'Mhm Nein, in Word gibt es ja diesen Überprüfungsmodus Markup Modus, wenn die Änderungen alle im im Markup wären, dann kann man da ja relativ schnell sich dann durchklicken und entweder annehmen oder ablehnen, oder?', '', '',
    '', true, true,
    '2025-10-15',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 88 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 88 AND st.name = 'User Interview'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    89,
    'The user needs to be able to use their own templates.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', '202510-Canvas-Interview', 1, '', '', '',
    '', true, true,
    '2025-10-15',
    '2026-03-04'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 89 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 89 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 89 AND st.name = 'User Interview'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    90,
    'The user wants to be supported in taking the right measures to a request.',
    (SELECT id FROM insight_types WHERE name = 'Idea'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Mixed' LIMIT 1),
    'Corporate Law Department; Corporate Law Department', '202510-Canvas-Interview,2026_02_Personas_Corporate', 2, '"The tool does an initial check - is it in the right area, are documents complete; simple questions it could answer directly" (Corporate Personas)', '', '',
    '', true, true,
    '2025-10-15',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 90 AND f.name = 'Document Review'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 90 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 90 AND st.name = 'User Interview'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    92,
    'The user needs to be supported in comparing two different versions of a document.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department; Corporate Law Department', '202510-Canvas-Interview,2026_02_Personas_Corporate', 3, '"Lay our concern standard against another document and tell me where it deviates - red flag, OK or equal" (Corporate Personas)', '', '',
    '', true, true,
    '2025-10-15',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 92 AND f.name = 'Document Review'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 92 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 92 AND st.name = 'User Interview'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    93,
    'The less technical-affine user needs to be enabled to use the tool within their known environment.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department; Big Law Firm', '202510-Canvas-Interview,2025_11_Personas_M_B_Lawfirms', 8, '', '', '',
    '', false, true,
    '2025-10-15',
    '2026-02-23'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 93 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 93 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 93 AND st.name = 'User Interview'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    94,
    'The user needs to be able to stick with their custom formatting and fonts, in order not having to reformat their document.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department; Big Law Firm', '202510-Canvas-Interview,2025_11_Personas_M_B_Lawfirms', 3, '', '', '',
    '', true, false,
    '2025-10-15',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 94 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 94 AND f.name = 'All'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 94 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 94 AND st.name = 'User Interview'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    96,
    'The user needs a general workflow to check the different types of documents.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', '202510-Canvas-Interview', 1, '"Aber ja kommt wie gesagt auf Vertrag an ich hab ein prompt ein Template hinterlegt, das mehr oder weniger lautet fass mir den Vertrag zusammen erklär mir jede einzelne Klausel hebe hervor, wenn es nachteilig für mich ist, also völlig unabhängig von der Vertragsart funktioniert auch schon ganz passabel."', '', '',
    '', true, true,
    '2025-10-15',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 96 AND f.name = 'Templates'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 96 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 96 AND st.name = 'User Interview'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    97,
    'The user needs the AI to support him to be quicker with their task.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_10_Beck_Feedback_Survey', 12, '', '', '',
    'Beck Germany', false, true,
    '2025-10-15',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 97 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    98,
    'The user needs help in gaining an initial overview of a (complex) topic.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Mixed; Corporate Law Department; Big Law Firm; Corporate Law Department; Big Law Firm', '2025_10_Beck_Feedback_Survey,2025_11_Beck_Feedback_Survey_2,2025_11_Zalando_Hackathon,Continous_Direct_Feedback_big_law_firm,Continous_Direct_Feedback_corporate,2025_11_Personas_M_B_Lawfirms', 21, '“Man muss nur noch 1 Minute für den Prompt investieren und hat dann schon, was man erstmal braucht.”', '', '',
    'Beck Germany', false, false,
    '2025-10-15',
    '2026-02-17'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 98 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 98 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 98 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 98 AND st.name = 'Hackathon'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 98 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    99,
    'The user needs a clear structure of answers in order to easily understand it.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Mixed; Big Law Firm; Corporate Law Department; Big Law Firm', '2025_10_Beck_Feedback_Survey,2025_11_Beck_Feedback_Survey_2,Continous_Direct_Feedback_big_law_firm,Continous_Direct_Feedback_corporate,2025_11_Personas_M_B_Lawfirms', 37, '', '5 participant mentions lacking structure
', '',
    'Beck Germany', false, false,
    '2025-10-15',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 99 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 99 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 99 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 99 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 99 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    101,
    'The user needs the system to provide answers in appropriate language.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Corporate Law Department; Small Law Firm; Big Law Firm; Big Law Firm', '2025_10_Beck_Feedback_Survey,2025_11_Zalando_Hackathon,Continous_Direct_Feedback_small_law_firm,Continous_Direct_Feedback_big_law_firm,2025_11_Personas_M_B_Lawfirms', 13, '', '', '',
    'Beck Germany', false, true,
    '2025-10-15',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 101 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 101 AND st.name = 'Hackathon'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 101 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    102,
    'The user needs the answers to have a high accuracy to be beneficial to him.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Corporate Law Department; Big Law Firm; Government Institutions; Prosecution/ Judges; Publisher', '2025_10_Beck_Feedback_Survey,2025_11_Zalando_Hackathon,Continous_Direct_Feedback_big_law_firm,Continous_Direct_Feedback_GovernmentInstitutions,Continous_Direct_Feedback_Prosecution_Judges,Publisher Feedback - Swiss,Publisher Feedback - Beck Germany', 60, 'Grds. sind wir von der KI angetan. Man bekommt im Researchbereich Antworten, die juristisch auf viel hoeherem Niveau als bei Konkurrenten sein duerften. ... Teilweise fantasieren die Antworten aber ziemlich.', 'In Beck Survey before agentic release
20 say its good
39 say it needs improvement

In Beck Survey after agentic release
13 say its good
22 say it needs improvement

67 (bad) - 34 (good) = 32

Accuracy after release: 
2 good 9 bad', 'CS-1073; CS-1074; CS-1075; CS-1076; CS-1077; CS-1078; CS-1079; CS-1080; CS-1081; CS-1082; CS-1083; CS-1084; CS-1085; CS-1086; CS-1087; CS-1088; CS-1089; CS-1090; CS-1091; CS-1092; CS-1106; CS-1107',
    'Beck Germany', false, true,
    '2025-10-15',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 102 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 102 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 102 AND f.name = 'Sources'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 102 AND f.name = 'Citations'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 102 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 102 AND st.name = 'Hackathon'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    103,
    'The users need to have a reliable data base as the source of the answers.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Positive' LIMIT 1),
    'Mixed; Mixed; Corporate Law Department; Big Law Firm; Government Institutions; Big Law Firm', '2025_10_Beck_Feedback_Survey,2025_11_Beck_Feedback_Survey_2,Continous_Direct_Feedback_corporate,Continous_Direct_Feedback_big_law_firm,Continous_Direct_Feedback_GovernmentInstitutions,2025_11_Personas_M_B_Lawfirms,Bayrische_Landesbank_042026', 63, '', '', '',
    'Beck Germany', false, false,
    '2025-10-15',
    '2026-04-23'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 103 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 103 AND f.name = 'Citations'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 103 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 103 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    104,
    'The user wants to be able to work with their own (existing) documents.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Mixed', '2025_10_Beck_Feedback_Survey,2025_11_Beck_Feedback_Survey_2', 5, '', '', '',
    'Beck Germany', false, true,
    '2025-10-15',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 104 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    105,
    'The user needs to be able to get a summary in order to get a quick overview.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Mixed; Mixed; Prosecution/ Judges; Corporate Law Department', '2025_10_Beck_Feedback_Survey,2025_11_Beck_Feedback_Survey_2,202510-Canvas-Interview_Testing,2026_03_Personas_Judiciary,2026_02_Personas_Corporate', 9, '"Click on a case, ''give me a quick overview of the facts and dispute'' - that would be great before reading 180 pages" (Judiciary Personas)
"I get an email with 20 attachments and I''m supposed to fish out the facts - I''d love a chronological fact summary" (Corporate Personas)', '', '',
    'Beck Germany', false, true,
    '2025-10-15',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 105 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 105 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 105 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    106,
    'Language settings in the app- currently, it is not possible to set up the language of the app in Noxtua. It is set by the browser language.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 1, '', '', '',
    '', true, true,
    '2025-10-15',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 106 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    107,
    'Customer would like to have an option to upload a files bigger than 10 MB',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department; Big Law Firm; Publisher', 'Continous_Direct_Feedback_corporate,Continous_Direct_Feedback_big_law_firm,Publisher Feedback - Beck Germany', 8, 'I’m currently using CoPilot. It can evaluate the document and help me compile the information for third-party procurement management. Unfortunately, I don’t have a PDF smaller than 10 MB available for Noxtua that I could meaningfully analyze. Therefore, I won’t be continuing this topic with Noxtua’s AI; I simply don’t have the time.” || Grds. sind wir von der KI angetan. Man bekommt im Researchbereich Antworten, die juristisch auf viel höherem Niveau als bei Konkurrenten sein dürften. Das ist sicherlich mit dem Zugriff auf Ihre Datenbank ein USP. Teilweise fantasieren die Antworten aber ziemlich.', '', 'CS-1107',
    '', false, false,
    '2025-10-15',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 107 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 107 AND f.name = 'Document Upload'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 107 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    108,
    'The user expects to get (in itself and for the same request) consistent answers.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Mixed', '2025_10_Beck_Feedback_Survey,2025_11_Beck_Feedback_Survey_2,Sparkasse_2026_04', 8, '', '', '',
    'Beck Germany', false, true,
    '2025-10-15',
    '2026-04-23'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 108 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 108 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    109,
    'The user needs all relevant sources to be available and used for the answer.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Mixed; Corporate Law Department; Big Law Firm', '2025_10_Beck_Feedback_Survey,2025_11_Beck_Feedback_Survey_2,Continous_Direct_Feedback_corporate,2025_11_Personas_M_B_Lawfirms', 15, '', '', '',
    'Beck Germany', false, false,
    '2025-10-15',
    '2026-03-16'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 109 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 109 AND f.name = 'all'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 109 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 109 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    110,
    'The user needs to get feedback regarding the completion of the file upload.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'Planned for development'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_10_Beck_Feedback_Survey', 5, '"Teilweise erfolgt gar keine Rückmeldung. Man kann dann nur vermuten, dass die hochgeladene Datei wohl zu groß war. "', '', '',
    'Beck Germany', false, false,
    '2025-10-15',
    '2026-03-23'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 110 AND s.name = 'Design'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 110 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 110 AND f.name = 'Document Upload'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 110 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    111,
    'The user expects the answer to be updated with the information from follow-up prompting instead of just appending it at the end.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_10_Beck_Feedback_Survey', 1, '', '', '',
    'Beck Germany', true, true,
    '2025-10-15',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 111 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 111 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    112,
    'The user doesn''t want to see the interim results but only the final result.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_10_Beck_Feedback_Survey', 1, '"Was mir nicht gefällt ist, dass beim generieren des Ergebnisses bereits Textbausteine angezeigt werden. Ich fände es besser, wenn erst ein Text angezeigt wird, wenn das finale Ergebnis feststeht."', '', '',
    'Beck Germany', true, true,
    '2025-10-15',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 112 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    113,
    'The user needs the most recent version of a source to be used instead of an outdated version.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Mixed; Small Law Firm; Government Institutions', '2025_10_Beck_Feedback_Survey,2025_11_Beck_Feedback_Survey_2,Continous_Direct_Feedback_small_law_firm,Continous_Direct_Feedback_GovernmentInstitutions,Bayrische_Landesbank_042026', 15, '', '', '',
    'Beck Germany', false, true,
    '2025-10-15',
    '2026-04-23'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 113 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 113 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    114,
    'The user needs to be able to compare different legislations easily.',
    (SELECT id FROM insight_types WHERE name = 'Idea'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Mixed' LIMIT 1),
    'Mixed; Corporate Law Department', '2025_10_Beck_Feedback_Survey,2026_02_Personas_Corporate', 2, '"Automated evaluation of how old laws match the wording of the new one" (Corporate Personas)', '', '',
    'Beck Germany', true, true,
    '2025-10-15',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 114 AND f.name = 'Document Review'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 114 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 114 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    115,
    'The user needs to be able to continue the chat even after longer times of inactivity.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_10_Beck_Feedback_Survey', 2, '', '', '',
    'Beck Germany', true, true,
    '2025-10-15',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 115 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    116,
    'The user needs guidance in case of occuring errors in order to be able to understand what is going wrong.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Mixed; Big Law Firm; Corporate Law Department; Big Law Firm; Corporate Law Department', '2025_10_Beck_Feedback_Survey,202510-Canvas-Interview_Testing,Continous_Direct_Feedback_big_law_firm,2025_11_Zalando_Hackathon,2025_11_Personas_M_B_Lawfirms,Continous_Direct_Feedback_corporate', 13, '', '', '',
    'Beck Germany', false, false,
    '2025-10-15',
    '2026-02-17'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 116 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 116 AND f.name = 'Error Handling'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 116 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 116 AND st.name = 'Hackathon'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 116 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 116 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    118,
    'The user would like to be informed by AI immediately about the most recent versions of regulations and not upon another prompt/request.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 3, 'Ich konnte auch aufklären, was es mit § 16 Abs. 1 Nr. VgV auf sich hatte. Es handelt sich um eine veraltete Fassung der Verordnung. Noxtua hat hier 2 kleine Entscheidungen aus 2008 gefunden, in der diese Norm rezitiert wurde und ist davon ausgegangen, dass es sich um die relevante Fassung handelt. Auf Nachfrage stellt die KI jedoch fest, dass es aktuellere Gesetzesfassungen gibt (Dies sollte meines Erachtens jedoch sofort geschehen). ', '', '',
    '', true, false,
    '2025-10-16',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 118 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 118 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 118 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    119,
    'The user needs to be able to see which chat was about which topic in order to easily navigate to the right chat.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Implemented - a solution is released'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department; Mixed; Big Law Firm', 'Continous_Direct_Feedback_corporate,2025_11_Beck_Feedback_Survey_2,Continous_Direct_Feedback_big_law_firm', 4, '', '', '',
    'Beck Germany', false, true,
    '2025-10-16',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 119 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 119 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    120,
    'Date/time tracker for the product',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department; Big Law Firm; Corporate Law Department', 'Continous_Direct_Feedback_corporate,Continous_Direct_Feedback_big_law_firm,2026_02_Personas_Corporate', 3, '"It should know today is 19.2.26 and assume the question refers to today''s legal situation" (Corporate Personas)', '', '',
    '', true, true,
    '2025-10-17',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 120 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 120 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 120 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    121,
    'User wants to upload a whole folder with many documents in it - into the Matrix Analysis',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 2, '', '', '',
    '', true, true,
    '2025-10-20',
    '2026-04-08'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 121 AND f.name = 'Matrix-Analysis'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 121 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    122,
    'User wants to chat with the Matrix',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm; Corporate Law Department; Mixed', 'Continous_Direct_Feedback_big_law_firm,Continous_Direct_Feedback_corporate,2026_Feedback_Survey_3', 5, '', '', '',
    '', false, true,
    '2025-10-20',
    '2026-04-20'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 122 AND f.name = 'Matrix-Analysis'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 122 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 122 AND st.name = 'Online Survey'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    124,
    'Easy creation of new criteria or matrices in the Matrix Analysis',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_10_Beck_Feedback_Survey', 2, '', 'before Agentic', '',
    'Beck Germany', false, true,
    '2025-10-20',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 124 AND f.name = 'Matrix-Analysis'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 124 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    125,
    'Good overview and structured layout in Matrix Analysis',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Positive' LIMIT 1),
    'Mixed; Mixed', '2025_10_Beck_Feedback_Survey,2025_11_Beck_Feedback_Survey_2', 4, '', 'before Agentic', '',
    'Beck Germany', false, true,
    '2025-10-20',
    '2026-03-31'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 125 AND f.name = 'Matrix-Analysis'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 125 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    126,
    'Speed and efficiency of matrix analysis: evaluation of large amounts of data simultaneously',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_10_Beck_Feedback_Survey', 5, 'You can easily put together evaluation criteria for contracts and then evaluate contracts en masse. The nice thing is that you can create self-explanatory criteria.', '', '',
    'Beck Germany', false, true,
    '2025-10-20',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 126 AND f.name = 'Matrix-Analysis'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 126 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    127,
    'The user expects an easy to understand interface for the Matrix. UX Design of Matrix Analysis- too sparse',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Corporate Law Department; Mixed', '2025_10_Beck_Feedback_Survey,Continous_Direct_Feedback_corporate,2025_11_Beck_Feedback_Survey_2', 6, ' "Die Eingabe der Aufgaben-Stellung ist nicht komfortabel. Das Fenster hierfür ist einfach zu klein gestaltet. Die Matrix-Funktion empfand ich als nicht ansprechend gestaltet."

"Eindeutig nicht gelungen ist die geringe Übersichtlichkeit. Die Eingabefenster haben "SMS-Größe". Das Feature an sich ist gut durchdacht, muss aber optisch noch deutlich aufgebessert werden. Stichwort Benutzeroberfläche."', 'before Agentic', '',
    'Beck Germany', false, true,
    '2025-10-20',
    '2026-04-13'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 127 AND f.name = 'Matrix-Analysis'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 127 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    128,
    'Slow upload times in matrix analysis:  Sometimes no result is obtained',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_10_Beck_Feedback_Survey', 2, '', 'before Agentic', '',
    'Beck Germany', true, true,
    '2025-10-20',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 128 AND f.name = 'Matrix-Analysis'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 128 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    129,
    'No reliability in matrix analysis; there is no clear handling of law updates- User has to work through everything thoroughly',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_10_Beck_Feedback_Survey', 2, '', 'before Agentic', '',
    'Beck Germany', true, true,
    '2025-10-20',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 129 AND f.name = 'Matrix-Analysis'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 129 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    130,
    'Missing logic between columns and across rows',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_10_Beck_Feedback_Survey', 1, '', '', '',
    'Beck Germany', true, true,
    '2025-10-20',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 130 AND f.name = 'Matrix-Analysis'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 130 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    132,
    'User wants higher recognition rate of relevant information',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Mixed', '2025_10_Beck_Feedback_Survey,2025_11_Beck_Feedback_Survey_2', 5, 'Recognition rate of relevant information and processing speed below the competition (especially Legora) and our internal system', 'preAgentic', '',
    'Beck Germany', false, true,
    '2025-10-20',
    '2026-04-13'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 132 AND f.name = 'Matrix-Analysis'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 132 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    133,
    'The user wants to be able to set up a workflow that compares a document in the Canvas with an uploaded document and trigger changes so that both of them are matching.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department; Corporate Law Department', 'Continous_Direct_Feedback_corporate,2026_02_Personas_Corporate', 5, '"Compare and produce Word/PDF markup directly in one file with the changes visible" (Corporate Personas)', '', '',
    '', true, false,
    '2025-10-24',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 133 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 133 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 133 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 133 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    134,
    'The user doesn''t want to have to differentiate beforehand between Canvas and Chat, but being able to open the canvas retrospectively for interactive editing, when they want to change sections and or do manual editing.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 1, '', '', '',
    '', true, false,
    '2025-10-29',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 134 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 134 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 134 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    135,
    'User want to be able to insert line breaks in prompts easily with one click.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '202510-Canvas-Interview_Testing', 2, '', '', '',
    '', true, false,
    '2025-11-03',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 135 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 135 AND f.name = 'Prompting'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 135 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    136,
    'Users want to be able to ask questions to specific sections & prompt changes based on specific sections.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Implemented - a solution is released'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '202510-Canvas-Interview_Testing', 12, '', '', '',
    '', false, false,
    '2025-11-04',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 136 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 136 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 136 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    137,
    'The feature of comparing changes needs to be more intuitive: Icon is not self-explanatory.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '202510-Canvas-Interview_Testing', 2, '', '', '',
    '', true, false,
    '2025-11-04',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 137 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 137 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 137 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    138,
    'Users want the ability to turn on/off numbering in a document.',
    (SELECT id FROM insight_types WHERE name = 'Idea'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Mixed' LIMIT 1),
    'Mixed', '202510-Canvas-Interview_Testing', 1, '', '', '',
    '', true, false,
    '2025-11-04',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 138 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 138 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 138 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 138 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    139,
    'Users want to be able to mark up (color highlights) documents for clarity and emphasis.',
    (SELECT id FROM insight_types WHERE name = 'Idea'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Mixed' LIMIT 1),
    'Mixed', '202510-Canvas-Interview_Testing', 2, '', '', '',
    '', true, false,
    '2025-11-04',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 139 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 139 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 139 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 139 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    140,
    'Users expect the Canvas to open automatically when a draft is prompted.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'Implemented - a solution is released'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Corporate Law Department; Big Law Firm', '202510-Canvas-Interview_Testing,Continous_Direct_Feedback_corporate,Continous_Direct_Feedback_big_law_firm', 8, 'Oh, so I have to open Canvas here first, or does it happen automatically? 
', '', '',
    '', false, false,
    '2025-11-04',
    '2026-03-16'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 140 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 140 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 140 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 140 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 140 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    141,
    'The users struggle and wish for help when interacting with the canvas.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Mixed; Mixed; Corporate Law Department', '202510-Canvas-Interview_Testing,2025_11_Beck_Feedback_Survey_2,2025_10_Beck_Feedback_Survey,Continous_Direct_Feedback_corporate', 15, '', '', '',
    'Beck Germany', false, false,
    '2025-11-04',
    '2026-02-17'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 141 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 141 AND s.name = 'Marketing'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 141 AND f.name = 'Onboarding'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 141 AND f.name = 'Academy'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 141 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 141 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    142,
    'User highlight that, familiar document editing and review features (like e.g. tracked changes) are important for adoption of the Canvas.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '202510-Canvas-Interview_Testing', 4, '', '', '',
    '', false, false,
    '2025-11-04',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 142 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 142 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 142 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    143,
    'The users would like to be able to store prompts and share with other users for usage.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Planned for development'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Big Law Firm; Distribution Department', '202510-Canvas-Interview_Testing,Continous_Direct_Feedback_big_law_firm,Continous_Direct_Feedback_Distribution', 8, '', '', '',
    '', false, false,
    '2025-11-04',
    '2026-03-09'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 143 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 143 AND f.name = 'Templates'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 143 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 143 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    144,
    'The users expect the tool to seamlessly integrate into their current text editing tools (i.e. word).',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'Implemented - a solution is released'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Corporate Law Department; Big Law Firm', '202510-Canvas-Interview_Testing,Continous_Direct_Feedback_corporate,2025_11_Personas_M_B_Lawfirms', 25, '', '', '',
    '', false, false,
    '2025-11-04',
    '2026-02-17'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 144 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 144 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 144 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 144 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 144 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    145,
    'The users would like to see the content mapped to specific pages, i.e. page breaks and page numbering.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '202510-Canvas-Interview_Testing', 2, '', '', '',
    '', true, false,
    '2025-11-04',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 145 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 145 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 145 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    146,
    'The users appreciate that the export keeps the tracked changes just like in word.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Positive' LIMIT 1),
    'Mixed', '202510-Canvas-Interview_Testing', 7, '', '', '',
    '', false, false,
    '2025-11-04',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 146 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 146 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 146 AND f.name = 'Document Download'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 146 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    147,
    'The users would like the tool to prioritize accuracy over convenience, i.e. they rather prefer an "I don''t know" or "I''m not sure" over a false response or incorrect sources.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Corporate Law Department', '202510-Canvas-Interview_Testing,Continous_Direct_Feedback_corporate', 4, '“Then we canceled Libra again, and that was the deciding factor for us... We saw that this [in terms of features] was less well developed or even further behind. But Noxtua is more faithful to the original text because of its connection to Beck-Online and the fact that quoting from it is becoming increasingly important.”
(Laywer for Civil and Coporate Law, Mid-size Law Firm, 51-60 years)
', 'Noxtua is actually also feed backing if it doesn’t know or if results are ambiguous --> once mentioned', '',
    '', true, false,
    '2025-11-04',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 147 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 147 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 147 AND f.name = 'Chat'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 147 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 147 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    148,
    'The users would like to interact with the system more conversation like, getting questions and hints back from the system.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Corporate Law Department; Big Law Firm', '202510-Canvas-Interview_Testing,Continous_Direct_Feedback_corporate,2025_11_Personas_M_B_Lawfirms', 14, 'Als säße jemand neben einem und führe mal meine Arbeit', '', '',
    '', false, false,
    '2025-11-04',
    '2026-03-16'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 148 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 148 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 148 AND f.name = 'Chat'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 148 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 148 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 148 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    149,
    'User want a customizable layout in order to not need multiple displays when interacting with the tool.',
    (SELECT id FROM insight_types WHERE name = 'Idea'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Mixed' LIMIT 1),
    'Mixed', '202510-Canvas-Interview_Testing', 7, '', 'in case this reaches 15 people, we should recheck this.

Starting with optimizing in Editor Context', '',
    '', false, false,
    '2025-11-04',
    '2026-03-03'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 149 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 149 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 149 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 149 AND f.name = 'Layout'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 149 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    150,
    'The users wish to store their own standard snippets (clauses, as a “Baukasten”) that can be accessed through the system.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Mixed', '202510-Canvas-Interview_Testing,2025_12_KnowledgeBase_UCs_Interviews', 10, '', '', '',
    '', false, false,
    '2025-11-04',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 150 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 150 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 150 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 150 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 150 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 150 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 150 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    151,
    'The users would like to be able to use content templates, that can be accessed to draft documents.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Mixed; Mixed; Big Law Firm; Corporate Law Department; Mixed; Big Law Firm', '202510-Canvas-Interview_Testing,2025_10_Beck_Feedback_Survey,2025_11_Beck_Feedback_Survey_2,Continous_Direct_Feedback_big_law_firm,Continous_Direct_Feedback_corporate,2025_12_KnowledgeBase_UCs_Interviews,2025_11_Personas_M_B_Lawfirms', 30, '', '', '',
    'Beck Germany', false, false,
    '2025-11-04',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 151 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 151 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 151 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 151 AND f.name = 'Document Storage'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 151 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 151 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 151 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 151 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    153,
    'The user needs the tool to differentiate between document content and annotations and only add the content into their document.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Corporate Law Department', '202510-Canvas-Interview_Testing,202510-Canvas-Interview', 7, '"Weil manchmal kann ich auch das, was als prompt Ergebnis oder als Antwort rauskommt, nicht 1 zu 1 übertragen, weil noch 23 einführende Sätze und noch eine Überlegung dabei steht und dann die Klausel, die ich eigentlich will und das hilft mir natürlich nicht, das dann zu übertragen mit einem Klick, weil ich dann die ganze Überlegung dazu die nox Tour angestellt hat auch."', 'in case it reaches 15 recheck.', '',
    '', false, false,
    '2025-11-04',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 153 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 153 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 153 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 153 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 153 AND st.name = 'User Interview'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    154,
    'Prompts are typically simple and resemble Google searches. complex, multi-step prompts are rarely used and often overwhelming for most users.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Positive' LIMIT 1),
    'Mixed; Corporate Law Department', '202510-Canvas-Interview_Testing,2026_02_Personas_Corporate', 4, '"The better the AI, the worse my prompts can be - even better is when it makes good output from a bad prompt" (Corporate Personas)', '', '',
    '', true, false,
    '2025-11-04',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 154 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 154 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 154 AND f.name = 'To-Do-List'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 154 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 154 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    155,
    'The users want the tool to be able to handle tables and diagrams within their documents.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '202510-Canvas-Interview_Testing', 3, '', '', '',
    '', true, false,
    '2025-11-04',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 155 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 155 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 155 AND f.name = 'Word-Add-Inn'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 155 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    156,
    'The Canvas interface is described as intuitive, with a layout and button design similar to familiar document processing tools.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Positive' LIMIT 1),
    'Mixed', '202510-Canvas-Interview_Testing', 10, '', '', '',
    '', false, false,
    '2025-11-04',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 156 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 156 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 156 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    157,
    'The user wants to be able to only get a high-level overview of the thinking process and only dig deeper on demand.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'Implemented - a solution is released'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Mixed; Corporate Law Department; Big Law Firm', '202510-Canvas-Interview_Testing,2025_11_Beck_Feedback_Survey_2,Continous_Direct_Feedback_corporate,Continous_Direct_Feedback_big_law_firm', 15, '"[To the question, what does not work well yet:] die vorangestellten Überlegungen der KI. Ich würde vorziehen, dass diese nur bei Bedarf "ausgeklappt" werden können."', '', '',
    'Beck Germany', false, false,
    '2025-11-04',
    '2026-03-05'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 157 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 157 AND f.name = 'Thinking Process'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 157 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 157 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    158,
    'The users would like to be able to revert changes that they or the tool made.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Corporate Law Department', '202510-Canvas-Interview_Testing,Continous_Direct_Feedback_corporate', 4, '', '', '',
    '', false, false,
    '2025-11-04',
    '2026-04-17'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 158 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 158 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 158 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 158 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    159,
    'The user would like documents in noxtua to have a version history in order to be able to revert to specific state in time.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Corporate Law Department', '202510-Canvas-Interview_Testing,Continous_Direct_Feedback_corporate', 4, '', '', '',
    '', true, false,
    '2025-11-04',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 159 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 159 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 159 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 159 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 159 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    160,
    'The users want to have granular control over which changes they accept, by seeing which part is the currently accepted part.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '202510-Canvas-Interview_Testing', 3, '', '', '',
    '', true, false,
    '2025-11-04',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 160 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 160 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 160 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    161,
    'The users expect the tool to stick to the language of an uploaded document and not to e.g. switch to German just because the prompt was German.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '202510-Canvas-Interview_Testing', 2, '', '', '',
    '', true, false,
    '2025-11-04',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 161 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 161 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 161 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    162,
    'The users would like to be able to seamlessly use the tool with their email program.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Corporate Law Department; Mixed; Big Law Firm; Mixed; Corporate Law Department', '202510-Canvas-Interview_Testing,Continous_Direct_Feedback_corporate,2026_01_Workflow_Expectations_Interview,2025_11_Personas_M_B_Lawfirms,2025_12_Word_Expectations_Usability,2026_02_Personas_Corporate', 20, '"A mini-assistant in the background that drafts emails - handles basic queries, flags complex ones" (Corporate Personas)', '', '',
    '', false, false,
    '2025-11-04',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 162 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 162 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 162 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 162 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 162 AND f.name = 'Outlook-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 162 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 162 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 162 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    163,
    'The users have trouble differentiating the upload function in the Canvas from the one in the chat.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Implemented - a solution is released'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '202510-Canvas-Interview_Testing', 4, '', '', '',
    '', false, false,
    '2025-11-04',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 163 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 163 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 163 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 163 AND f.name = 'Chat'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 163 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    164,
    'The users expect the tool to offer a collaborative environment in which they can comment and work at the same time  in order to exchange with colleagues.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Corporate Law Department; Corporate Law Department; Big Law Firm; Big Law Firm', '202510-Canvas-Interview_Testing,202510-Canvas-Interview,Continous_Direct_Feedback_corporate,Continous_Direct_Feedback_big_law_firm,2025_11_Personas_M_B_Lawfirms', 13, '', '', '',
    '', false, false,
    '2025-11-04',
    '2026-04-13'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 164 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 164 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 164 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 164 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 164 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 164 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 164 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 164 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 164 AND st.name = 'User Interview'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    165,
    'The users expect the tool to ask questions back if the input provided is ambiguous.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Corporate Law Department; Big Law Firm', '202510-Canvas-Interview_Testing,Continous_Direct_Feedback_corporate,2025_11_Personas_M_B_Lawfirms', 7, '', '', '',
    '', false, false,
    '2025-11-04',
    '2026-03-03'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 165 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 165 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 165 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 165 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 165 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    166,
    'The users wish for the possibility to customize the drafting style.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Big Law Firm', '202510-Canvas-Interview_Testing,2025_11_Personas_M_B_Lawfirms', 3, '', '', '',
    '', true, false,
    '2025-11-04',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 166 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 166 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 166 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 166 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    167,
    'Users wanna be able to customize the layout particularly for having an Canvas only view.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '202510-Canvas-Interview_Testing', 6, '', '', '',
    '', false, false,
    '2025-11-04',
    '2026-03-03'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 167 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 167 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 167 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    168,
    'Users want to replace prompting by filling Dropdowns in order to avoid having to write prompts.',
    (SELECT id FROM insight_types WHERE name = 'Idea'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Mixed' LIMIT 1),
    'Mixed', '202510-Canvas-Interview_Testing', 1, '', '', '',
    '', true, false,
    '2025-11-04',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 168 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 168 AND f.name = 'Chat'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 168 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    169,
    'The user expects the tool to identify non-lawful clauses and clauses that could be to their disadvantage automatically after upload, without the user needed to prompt it.',
    (SELECT id FROM insight_types WHERE name = 'Idea'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Mixed' LIMIT 1),
    'Mixed', '202510-Canvas-Interview_Testing', 3, '', '', '',
    '', true, false,
    '2025-11-05',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 169 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 169 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 169 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 169 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 169 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    170,
    'The users would like to be able to interact with the tool via voice input, in order to work more efficiently.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Planned for development'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Big Law Firm; Big Law Firm; Government Institutions; Publisher', '202510-Canvas-Interview_Testing,Continous_Direct_Feedback_big_law_firm,2025_11_Personas_M_B_Lawfirms,Continous_Direct_Feedback_GovernmentInstitutions,Publisher Feedback - Beck Germany', 14, 'Clients often ask whether Noxtua could add a voice recognition feature to allow users to dictate prompts rather than type them. Would save them time.', '', 'CS-1028',
    '', false, false,
    '2025-11-05',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 170 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 170 AND f.name = 'Voice Control'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 170 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 170 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 170 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    171,
    'The users expect the tool to do automatic consistency checks across the document.',
    (SELECT id FROM insight_types WHERE name = 'Idea'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Mixed' LIMIT 1),
    'Mixed; Corporate Law Department', '202510-Canvas-Interview_Testing,2026_02_Personas_Corporate', 3, '"Real consistency checks across the whole document - §3 and §7 contradict each other, or §8 references §3" (Corporate Personas)', '', '',
    '', true, false,
    '2025-11-05',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 171 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 171 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 171 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 171 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 171 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    172,
    'The user expects the tool to offer both structured (decision-tree-like) and flexible (more creative) editing of documents to accommodate both standard but also exceptional cases.',
    (SELECT id FROM insight_types WHERE name = 'Idea'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Mixed' LIMIT 1),
    'Mixed', '202510-Canvas-Interview_Testing', 2, '', '', '',
    '', true, false,
    '2025-11-05',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 172 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 172 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 172 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 172 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    173,
    'The users would like to be able to intervene if they see the modal is thinking in a wrong direction in order to adjust the result to what they actually need.',
    (SELECT id FROM insight_types WHERE name = 'Idea'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Mixed' LIMIT 1),
    'Mixed; Big Law Firm; Government Institutions', '202510-Canvas-Interview_Testing,Continous_Direct_Feedback_big_law_firm,Continous_Direct_Feedback_GovernmentInstitutions', 4, '', '', '',
    '', true, false,
    '2025-11-05',
    '2026-02-24'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 173 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 173 AND f.name = 'Thinking Process'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 173 AND f.name = 'To-Do-List'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 173 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 173 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    174,
    'The user wants the tool to highlight significant changes to them in order to easier navigate especially big edits that the tool makes to documents.',
    (SELECT id FROM insight_types WHERE name = 'Idea'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Mixed' LIMIT 1),
    'Mixed', '202510-Canvas-Interview_Testing', 1, '', '', '',
    '', true, false,
    '2025-11-05',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 174 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 174 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 174 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 174 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    175,
    'The users find the presence of change buttons before any edits were made confusing.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '202510-Canvas-Interview_Testing', 2, '', '', '',
    '', true, false,
    '2025-11-05',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 175 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 175 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 175 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    176,
    'The users don''t want the citation panel to pop-up automatically, particularly when Canvas is open.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Mixed', '202510-Canvas-Interview_Testing,2025_11_Beck_Feedback_Survey_2', 3, '', '', '',
    'Beck Germany', true, false,
    '2025-11-05',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 176 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 176 AND f.name = 'Citations'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 176 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 176 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    187,
    'The users expect an intuitive handling and interface.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Positive' LIMIT 1),
    'Small Law Firm; Mixed; Mixed; Government Institutions; Big Law Firm; Corporate Law Department', 'Continous_Direct_Feedback_small_law_firm,2025_11_Beck_Feedback_Survey_2,2025_10_Beck_Feedback_Survey,Continous_Direct_Feedback_GovernmentInstitutions,Continous_Direct_Feedback_big_law_firm,Continous_Direct_Feedback_corporate', 36, '', '40 positive
4 negative', '',
    'Beck Germany', false, false,
    '2025-11-07',
    '2026-02-17'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 187 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 187 AND f.name = 'all'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 187 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    188,
    'No hallucinations, displayed results actually exist',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Positive' LIMIT 1),
    'Small Law Firm', 'Continous_Direct_Feedback_small_law_firm', 1, '', 'customer has not tested Noxtua enough tho', '',
    '', false, true,
    '2025-11-07',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 188 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 188 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    189,
    'Simple legal questions are answered very reliably 
Very good results with contract drafts – especially in the IT sector (hardware maintenance contract including SLA, schedule of services – "outstanding").
Support in preparing presentations and structuring content is very helpful.
Visualization of answers is perceived positively.
Further inquiries lead to a significant increase in quality ("AI gets into the flow").',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Positive' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm,Bayrische_Landesbank_042026', 4, '', '', '',
    '', false, true,
    '2025-11-07',
    '2026-04-23'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 189 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 189 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    191,
    'Source quality insufficient for legal writing. Links to Beck-Online with the source are missing in the documents.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 1, '', '', '',
    '', true, false,
    '2025-11-07',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 191 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 191 AND f.name = 'Chat'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 191 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    192,
    'User needs to be able to name the export to be able to continue working efficiently.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 1, '', '', '',
    '', true, false,
    '2025-11-07',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 192 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 192 AND f.name = 'Chat Export'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 192 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    193,
    'User need the chat export to be able to work efficiently.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 1, '', '', '',
    '', false, false,
    '2025-11-07',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 193 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 193 AND f.name = 'Chat Export'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 193 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    194,
    'User need to get all relevant sources linked to their answer in order to get the full picture.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm; Corporate Law Department', 'Continous_Direct_Feedback_big_law_firm,Continous_Direct_Feedback_corporate', 2, '', '', '',
    '', true, false,
    '2025-11-07',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 194 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 194 AND f.name = 'Citations'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 194 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    195,
    'The user needs the answers to be accurate.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm,Sparkasse_2026_04,Bayrische_Landesbank_042026', 3, '', '', '',
    '', true, true,
    '2025-11-07',
    '2026-04-23'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 195 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 195 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    196,
    'Content accuracy is not always guaranteed. the correct solution is often only found after inquiries or specific instructions. The answers in the contract were rather unusable in relation to the question.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 2, '', '', '',
    '', true, true,
    '2025-11-07',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 196 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 196 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    197,
    'The users need the reponses to be available within reasonable time.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm; Mixed; Government Institutions', 'Continous_Direct_Feedback_big_law_firm,2025_11_Beck_Feedback_Survey_2,Continous_Direct_Feedback_GovernmentInstitutions,Bayrische_Landesbank_042026', 6, '', '', '',
    'Beck Germany', false, false,
    '2025-11-07',
    '2026-04-23'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 197 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 197 AND f.name = 'all'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 197 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    200,
    'User wants a guidance for Matrix function, examples for legal use cases',
    (SELECT id FROM insight_types WHERE name = 'Idea'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Mixed' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 2, '', '', '',
    '', true, true,
    '2025-11-07',
    '2026-03-31'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 200 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    203,
    'The users want to be able to filter the sources used for their answer generation, in order to remove non relevant sources from consideration.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm; Corporate Law Department; Big Law Firm; Government Institutions', 'Continous_Direct_Feedback_big_law_firm,Continous_Direct_Feedback_corporate,2025_11_Personas_M_B_Lawfirms,Continous_Direct_Feedback_GovernmentInstitutions', 5, '', '', '',
    '', false, false,
    '2025-11-07',
    '2026-03-09'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 203 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 203 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 203 AND f.name = 'All'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 203 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 203 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    204,
    'The user wants to be able to customize they way of working of the system more to their needs.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Big Law Firm; Government Institutions; Corporate Law Department', '202510-Canvas-Interview_Testing,Continous_Direct_Feedback_big_law_firm,Continous_Direct_Feedback_GovernmentInstitutions,Continous_Direct_Feedback_corporate', 5, 'They would like to customize their "own agents".', '', '',
    '', true, false,
    '2025-11-07',
    '2026-04-17'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 204 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 204 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 204 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 204 AND f.name = 'To-Do-List'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 204 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 204 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    205,
    'The users want to be able to store documents in project based structure, in order to be able to better work with them.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department; Government Institutions', 'Continous_Direct_Feedback_corporate,Continous_Direct_Feedback_GovernmentInstitutions', 2, '', '', '',
    '', true, false,
    '2025-11-07',
    '2026-03-04'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 205 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 205 AND f.name = 'Document Storage'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 205 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 205 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    208,
    'The user wants to be able to upload more than 10 files in order to compare more files into one table or use them as input.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Big Law Firm; Corporate Law Department', '2025_11_Beck_Feedback_Survey_2,Continous_Direct_Feedback_big_law_firm,Continous_Direct_Feedback_corporate', 5, '', '', '',
    'Beck Germany', false, false,
    '2025-11-12',
    '2026-04-20'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 208 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 208 AND f.name = 'Matrix Analysis'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 208 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    209,
    'The user does not want to see citations that are not wrong, but granted in order to avoid having too many sources.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 1, '', '', '',
    '', true, false,
    '2025-11-14',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 209 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 209 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 209 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 209 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    210,
    'The user needs the tool to weigh sources accordingly to avoid contradicting or wrong information.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Mixed; Corporate Law Department; Small Law Firm; Big Law Firm; Big Law Firm; Government Institutions; Prosecution/ Judges', '2025_11_Beck_Feedback_Survey_2,2025_10_Beck_Feedback_Survey,Continous_Direct_Feedback_corporate,Continous_Direct_Feedback_small_law_firm,2025_11_Personas_M_B_Lawfirms,Continous_Direct_Feedback_big_law_firm,Continous_Direct_Feedback_GovernmentInstitutions,Continous_Direct_Feedback_Prosecution_Judges', 25, '', '', '',
    'Beck Germany', false, false,
    '2025-11-14',
    '2026-04-17'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 210 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 210 AND f.name = 'all'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 210 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 210 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    211,
    'The users expect the tool to seamlessly integrate into their current database tools (ie. Excel).',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Mixed; Corporate Law Department; Big Law Firm', '202510-Canvas-Interview_Testing,2025_10_Beck_Feedback_Survey,Continous_Direct_Feedback_corporate,2025_11_Personas_M_B_Lawfirms', 6, '', 'ro be rediscussed when higher prio topics are done.', '',
    'Beck Germany', false, false,
    '2025-11-17',
    '2026-04-13'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 211 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 211 AND f.name = 'Excel-Plug-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 211 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 211 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 211 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    212,
    'The users would like to be able to use format templates, that can be accessed to draft documents in order to match individual, company or law firm style.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Big Law Firm; Mixed', '202510-Canvas-Interview_Testing,Continous_Direct_Feedback_big_law_firm,2025_12_KnowledgeBase_UCs_Interviews', 16, '', '', '',
    '', false, false,
    '2025-11-17',
    '2026-04-08'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 212 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 212 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 212 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 212 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 212 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 212 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    213,
    'The user needs to be able to look into the fulltext of the provided answer, in order to make sure that the context also fits the legal case.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Mixed; Big Law Firm; Government Institutions', '2025_11_Beck_Feedback_Survey_2,2025_10_Beck_Feedback_Survey,Continous_Direct_Feedback_big_law_firm,Continous_Direct_Feedback_GovernmentInstitutions', 40, '', '', '',
    'Beck Germany', false, false,
    '2025-11-17',
    '2026-03-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 213 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 213 AND f.name = 'Citations'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 213 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    214,
    'The user needs the system to stick with one language within a chat (unless prompted otherwise), in order to reduce mental load and needing to translate.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Corporate Law Department; Corporate Law Department; Small Law Firm; Big Law Firm', '2025_11_Beck_Feedback_Survey_2,Continous_Direct_Feedback_corporate,2025_11_Zalando_Hackathon,Continous_Direct_Feedback_small_law_firm,Continous_Direct_Feedback_big_law_firm', 8, '', '', '',
    'Beck Germany', false, false,
    '2025-11-17',
    '2026-04-17'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 214 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 214 AND f.name = 'all'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 214 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 214 AND st.name = 'Hackathon'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    215,
    'The user wants to be able to copy only parts of the answer.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Distribution Department', '2025_11_Beck_Feedback_Survey_2,Continous_Direct_Feedback_Distribution', 2, '', '', '',
    'Beck Germany', true, false,
    '2025-11-17',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 215 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 215 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 215 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    216,
    'The user wants to be able to use Powerpoint as an Input Document in order to be able to use all their usually used documents as input.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department; Big Law Firm', 'Continous_Direct_Feedback_corporate,2025_11_Personas_M_B_Lawfirms', 4, '', '', '',
    '', false, false,
    '2025-11-18',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 216 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 216 AND f.name = 'Document Upload'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 216 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 216 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    217,
    'The user wants to be supported to efficiently draft contracts.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 1, '', '', '',
    '', false, true,
    '2025-11-18',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 217 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 217 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 217 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 217 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    218,
    'The user needs the system to be able to process PDF content as input for the answer.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 1, '', '', '',
    '', true, false,
    '2025-11-18',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 218 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 218 AND f.name = 'Document Upload'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 218 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    219,
    'The user needs more onboarding for the matrix analysis in order to work with it.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department; Big Law Firm', 'Continous_Direct_Feedback_corporate,Continous_Direct_Feedback_big_law_firm', 3, '', '', '',
    '', true, false,
    '2025-11-18',
    '2026-03-31'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 219 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 219 AND f.name = 'Matrix-Analysis'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 219 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    220,
    'The user needs the system to be more resistant to upper and lower case writing.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 1, '', '', '',
    '', true, false,
    '2025-11-18',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 220 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 220 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 220 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    221,
    'The user needs legislations of different countries to be used for cases that involve international parties.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department; Corporate Law Department; Big Law Firm', '2025_11_Zalando_Hackathon,Continous_Direct_Feedback_corporate,2025_11_Personas_M_B_Lawfirms', 5, '', '', '',
    '', false, true,
    '2025-11-19',
    '2026-03-09'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 221 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 221 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 221 AND st.name = 'Hackathon'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 221 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    222,
    'The user expects the tool to be able to translate legal findings into technical/product implications, in order to communicate them efficiently to other (non-legal) parties.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', '2025_11_Zalando_Hackathon', 1, '', '', '',
    '', true, false,
    '2025-11-19',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 222 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 222 AND f.name = 'all'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 222 AND st.name = 'Hackathon'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    223,
    'The users expect the tool to know who they are or who they work for and consider that for answer generation.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department; Corporate Law Department; Mixed; Mixed; Government Institutions', '2025_11_Zalando_Hackathon,Continous_Direct_Feedback_corporate,2025_12_KnowledgeBase_UCs_Interviews,2025_12_Word_Expectations_Usability,Continous_Direct_Feedback_GovernmentInstitutions', 7, '', '', '',
    '', false, false,
    '2025-11-20',
    '2026-04-17'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 223 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 223 AND f.name = 'All'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 223 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 223 AND st.name = 'Hackathon'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 223 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 223 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    224,
    'The users need to be able to easily understand the research output.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 1, '', '', '',
    '', true, false,
    '2025-11-20',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 224 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 224 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 224 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    225,
    'The user needs the system to indicate legal uncertainty if there are alternative viewpoints or if there are ongoing debates.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 1, '', '', '',
    '', true, false,
    '2025-11-20',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 225 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 225 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 225 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    226,
    'The user would like to be able to create slide and speaker bulletpoints for a specific topic to transfer that to powerpoint for speeches.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 1, '', '', '',
    '', true, false,
    '2025-11-20',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 226 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 226 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 226 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    227,
    'The user needs the system to be resistant to the way a prompt is worded.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 1, '“Jura ist Präzision, wir wollen das ganz genau haben”', '', '',
    '', false, false,
    '2025-11-20',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 227 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 227 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 227 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    228,
    'The users need more onboarding on how to prompt best.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Implemented - a solution is released'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department; Big Law Firm', 'Continous_Direct_Feedback_corporate,2025_11_Personas_M_B_Lawfirms', 5, '“Dann kann die Schwarmintelligenz dazu führen auch richtig gute Prompts zu erschaffen”.', '', '',
    '', false, false,
    '2025-11-20',
    '2026-03-23'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 228 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 228 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 228 AND f.name = 'Chat'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 228 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 228 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    229,
    'The user wants the system to automatically update matrices with new decisions.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 1, '', '', '',
    '', true, true,
    '2025-11-20',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 229 AND f.name = 'Matrix-Analysis'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 229 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    230,
    'The user would like to be able to work in another chat while the prompt is running.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 1, '', '', '',
    '', true, false,
    '2025-11-20',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 230 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 230 AND f.name = 'All'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 230 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    231,
    'The user needs to be able to stop the tool from running in order to correct mistakes.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department; Publisher; Publisher; Corporate Law Department', 'Continous_Direct_Feedback_corporate,Continous_Publisher_Manz_Noxtua,Continous_Publisher_Swiss_Noxtua,2026_02_Personas_Corporate', 8, '"If I could intervene to readjust - ''no, that''s not the direction''" (Corporate Personas)', '', '',
    'Manz', false, true,
    '2025-11-20',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 231 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 231 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 231 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    232,
    'The user needs the tool to comply with data security measures necessary for the data that they work with and to comply with their "Berufsrecht".',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm; Big Law Firm; Prosecution/ Judges', 'Continous_Direct_Feedback_big_law_firm,2025_11_Personas_M_B_Lawfirms,Continous_Direct_Feedback_Prosecution_Judges', 10, '', '', '',
    '', false, true,
    '2025-11-30',
    '2026-04-17'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 232 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 232 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    233,
    'Answers are too long; users prefer shorter, more concise results.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 1, '', '', '',
    '', true, true,
    '2025-11-30',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 233 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 233 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    234,
    'Overall Impression: Beck-Noxtua is currently not competitive with Libra and Legora',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 1, '', '', '',
    '', true, true,
    '2025-11-30',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 234 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    236,
    'The user needs to be able to access chats over time and from different devices and browsers, so that the history is always accessible.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm; Government Institutions', 'Continous_Direct_Feedback_big_law_firm,Continous_Direct_Feedback_GovernmentInstitutions', 4, '', '', '',
    '', true, false,
    '2025-11-30',
    '2026-03-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 236 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 236 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 236 AND f.name = 'Encryption'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 236 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    237,
    'No Word plugin was available during beta phase; this was explicitly missed.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 1, '', '', '',
    '', true, true,
    '2025-11-30',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 237 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    238,
    'No playbook function for contract comparisons or template contracts.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 1, '', '', '',
    '', true, true,
    '2025-11-30',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 238 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    239,
    'The users want the tool to integrate into existing systems for file storage.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 3, '', '', '',
    '', true, true,
    '2025-11-30',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 239 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 239 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    240,
    'A prompt library as a central working resource',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 1, '', '', '',
    '', true, true,
    '2025-11-30',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 240 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 240 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    241,
    'Clear guidance options for controlled AI deployment (similar to a data room approach)',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 1, '', '', '',
    '', true, true,
    '2025-11-30',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 241 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 241 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    242,
    'Stronger linking of references in pleadings or contracts',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 1, '', '', '',
    '', true, true,
    '2025-11-30',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 242 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 242 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    243,
    'A follow-up question function implemented within the answer output window.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 1, '', '', '',
    '', true, false,
    '2025-11-30',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 243 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 243 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 243 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    244,
    'The option to compare different documents uploaded within a matrix.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 1, '', '', '',
    '', true, true,
    '2025-11-30',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 244 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    245,
    'The functions of the matrix are self-explanatory, and the displays are well-structured.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Positive' LIMIT 1),
    'Corporate Law Department; Mixed', 'Continous_Direct_Feedback_corporate,2025_11_Beck_Feedback_Survey_2', 3, '', '', '',
    'Beck Germany', false, true,
    '2025-11-30',
    '2026-03-31'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 245 AND f.name = 'Matrix'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 245 AND f.name = 'Matrix-Analysis'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 245 AND f.name = 'Matrix Analysis'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 245 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    246,
    'The user needs the tool to be able to process also scanned documents.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm; Small Law Firm', 'Continous_Direct_Feedback_big_law_firm,Continous_Direct_Feedback_small_law_firm', 2, '', '', '',
    '', true, false,
    '2025-12-01',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 246 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 246 AND f.name = 'Document Upload'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 246 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    247,
    'The user needs to be able to export the entire chat, including all sub-questions.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Small Law Firm; Big Law Firm; Small Law Firm; Corporate Law Department', 'Continous_Direct_Feedback_small_law_firm,Continous_Direct_Feedback_big_law_firm,2026_02_Personas_Corporate', 4, '"I want to download externally but reload easily, with reasoning included" (Corporate Personas)', '', '',
    '', false, true,
    '2025-12-10',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 247 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 247 AND f.name = 'Document Upload'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 247 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 247 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    249,
    'An option to set the context window size to 250,000 or higher would be desirable.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Small Law Firm', 'Continous_Direct_Feedback_small_law_firm', 1, '', '', '',
    '', true, false,
    '2025-12-10',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 249 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 249 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 249 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    250,
    'Implement VL capabilities in order to also be able to use floor plans for rental agreements.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Small Law Firm', 'Continous_Direct_Feedback_small_law_firm', 1, '', '', '',
    '', true, false,
    '2025-12-10',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 250 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 250 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 250 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    251,
    'The users want to be able to have the reasoning directly at the changed clause in order to have full transparency for themselves and others.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_Word_Expectations_Usability', 3, '', '', '',
    '', true, false,
    '2025-12-15',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 251 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 251 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 251 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    252,
    'The user needs the AI to seamlessly integrate into word by inserting and prompting directly in the word environment without additional manual effort on their end.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'Implemented - a solution is released'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Corporate Law Department; Corporate Law Department', '2025_12_Word_Expectations_Usability,Continous_Direct_Feedback_corporate,2026_02_Personas_Corporate', 9, '“Ideally, I would like to have the entire workflow in a sidebar: select a clause, have it checked, receive a proposed change, view sources, and jump directly from the sidebar to the Beck database without any media discontinuity.”
"It would be great if you could attach it to an email or paste it in" (Corporate Personas)', '', '',
    '', false, false,
    '2025-12-17',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 252 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 252 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 252 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 252 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 252 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    253,
    'The user wants to be able to see the sources of the generated content directly in word in order to have full transparency.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Implemented - a solution is released'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_Word_Expectations_Usability', 7, '', '', '',
    '', false, false,
    '2025-12-17',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 253 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 253 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 253 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    254,
    'The users want to be able to mark sections within a word document and prompt referring only the selected content.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Implemented - a solution is released'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_Word_Expectations_Usability', 6, '', '', '',
    '', false, false,
    '2025-12-17',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 254 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 254 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 254 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    255,
    'The user expects the tool to directly use the words tracked changes feature, so that they themselves keep the overview of the changes and can send it to other parties.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'Implemented - a solution is released'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_Word_Expectations_Usability', 6, '', '', '',
    '', false, true,
    '2025-12-17',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 255 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 255 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    256,
    'The users expect by using the word add in that the formatting templates they use and the formatting that the document has is obeyed by the AI when changes and insertions are made, so that they don''t have to fix formatting.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Implemented - a solution is released'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_Word_Expectations_Usability', 6, '', '', '',
    '', false, false,
    '2025-12-17',
    '2026-03-09'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 256 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 256 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 256 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    257,
    'The users expect the word-add-in to be intuitive and offer guidance so that they don''t have to watch tutorials to be able to use it.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Positive' LIMIT 1),
    'Mixed', '2025_12_Word_Expectations_Usability', 3, 'Said that colleagues already have „enough difficulty introducing AI into their life, which shouldn''t be made extra hard by giving them extra effort to learn". ', '', '',
    '', true, false,
    '2025-12-17',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 257 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 257 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 257 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    258,
    'The users expect the research functionality to be available through the word interface within the word-plug-in, in order to avoid switching touchpoints if they want to research something while working on a document.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    '', '[]', 6, '', '', '',
    '', false, false,
    '2025-12-17',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 258 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 258 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    259,
    'The user expects each change suggestion to come with a reasoning, why it should be changed in this way, in order to make an informed decision on the change.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_Word_Expectations_Usability', 4, '', '', '',
    '', true, false,
    '2025-12-17',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 259 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 259 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 259 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 259 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    260,
    'The user expects change suggestions to come with the supporting law of the reason for the change, to see which source it was derived from.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_Word_Expectations_Usability', 1, '', '', '',
    '', true, false,
    '2025-12-17',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 260 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 260 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 260 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 260 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    261,
    'The user needs to be able to get an overview of all changes to evaluate them in context, to be able to make a decision on each of the changes.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_Word_Expectations_Usability', 1, '', '', '',
    '', true, false,
    '2025-12-17',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 261 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 261 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 261 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    262,
    'The user needs to be able to preview changes before they are applied in the document in order to feel in control and be able to individually review them.',
    (SELECT id FROM insight_types WHERE name = 'Idea'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Mixed' LIMIT 1),
    'Mixed', '2025_12_Word_Expectations_Usability', 3, '“I find it good that I can look at it separately first and then... So that nothing accidentally gets in or I overlook something.” ', '', '',
    '', true, false,
    '2025-12-17',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 262 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 262 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 262 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    263,
    'The users wish to be able to have transparency of why changes have been made even after inserting them into the document in order to allow themselves or another party to have full transparency into reasoning.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_Word_Expectations_Usability', 3, '', '', '',
    '', true, false,
    '2025-12-17',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 263 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 263 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 263 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    264,
    'The user would like to be able to apply all changes after reviewing them, in order to not have to approve each one individually.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_Word_Expectations_Usability', 1, '', '', '',
    '', true, false,
    '2025-12-17',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 264 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 264 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 264 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    265,
    'The user needs the tool to be able to offer automatic insertion or preview of changes for manual approval in order to be able to work efficiently in all cases.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_Word_Expectations_Usability', 3, '“For me it depends on the quality of the changes. If its high, then an auto modus would be better. But if I have to revert all changes and make further changes anyways, I think I would prefer to preview.” ', '', '',
    '', true, false,
    '2025-12-17',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 265 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 265 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 265 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    266,
    'The user needs to be able to lock parts of a document so that they are not edited by the AI anymore.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Corporate Law Department', '2025_12_Word_Expectations_Usability,Continous_Direct_Feedback_corporate', 3, '', '', '',
    '', true, false,
    '2025-12-17',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 266 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 266 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 266 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 266 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 266 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    267,
    'The user would like to be able to tell the tool how harsh or lenient the AI should be when reviewing and suggesting changes to a document.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_Word_Expectations_Usability', 1, '', '', '',
    '', true, false,
    '2025-12-17',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 267 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 267 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 267 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 267 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    268,
    'The user expects the tool to adjust the drafting to individual style and preferences.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', '2025_11_Personas_M_B_Lawfirms', 5, '', 'Personlization as holistic topic should be looked into. ', '',
    '', false, false,
    '2025-12-17',
    '2026-04-20'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 268 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 268 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 268 AND f.name = 'Personalization '
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 268 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    269,
    'The user needs to be able disable tracking changes so that they can quickly iterate from scratch until they have a solid state from which they then want to track the essentiell changes being made.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_Word_Expectations_Usability', 4, '“So at the moment when I’m creating a draft [from scratch], it might actually not be so clever to have all changes directly always in Track Changes mode, because creation often has a different speed there.” ', '', '',
    '', true, false,
    '2025-12-17',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 269 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 269 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 269 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    270,
    'The user wants to know which file is affected if one of the files can''t be read.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 1, '', '', '',
    '', true, false,
    '2026-01-02',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 270 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 270 AND f.name = 'Error Management'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 270 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    271,
    'The user expects a clear distinction between thinking process and content output in order to navigate the result.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'Implemented - a solution is released'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm; Corporate Law Department; Publisher', 'Continous_Direct_Feedback_big_law_firm,Continous_Direct_Feedback_corporate,Continous_Publisher_Manz_Noxtua', 5, '', '', '',
    'Manz', false, false,
    '2026-01-02',
    '2026-03-16'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 271 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 271 AND f.name = 'Thinking Process'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 271 AND f.name = 'Design'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 271 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    272,
    'The user need the document drafting to be more detailed in order to be able to continue working with the generated document.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 1, '', '', '',
    '', true, false,
    '2026-01-02',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 272 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 272 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 272 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 272 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 272 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    273,
    'The user would like to be supported in drafting answers to a request in understandable language.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Government Institutions', 'Continous_Direct_Feedback_GovernmentInstitutions', 2, '', '', '',
    '', false, true,
    '2026-01-19',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 273 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    274,
    'User wish for a seamless integration of all features within the tool (e.g. Workflows, matrix, Chat).',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm; Big Law Firm; Mixed; Corporate Law Department; Mixed', 'Continous_Direct_Feedback_big_law_firm,2025_11_Personas_M_B_Lawfirms,2026_01_Workflow_Expectations_Interview,Continous_Direct_Feedback_corporate,2026_Feedback_Survey_3', 15, '', '', '',
    '', false, false,
    '2026-01-19',
    '2026-04-13'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 274 AND s.name = 'Design'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 274 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 274 AND f.name = 'Matrix'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 274 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 274 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 274 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 274 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 274 AND st.name = 'Online Survey'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    275,
    'User would like to have an admin view where they can see metrics of usage behaviour in their company in order to target trainings and licenses accordingly,',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 3, '', '', '',
    '', true, true,
    '2026-01-19',
    '2026-02-25'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 275 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 275 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    276,
    'The user needs the tool to use further external data sources.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm; Mixed; Corporate Law Department; Prosecution/ Judges', 'Continous_Direct_Feedback_big_law_firm,2026_01_Workflow_Expectations_Interview,Continous_Direct_Feedback_corporate,Continous_Direct_Feedback_Prosecution_Judges', 6, '', '', '',
    '', false, false,
    '2026-01-19',
    '2026-04-17'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 276 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 276 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 276 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 276 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 276 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 276 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    277,
    'The user needs a possibility to connect the individual steps of a workflow  with each other or with decision points.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 4, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-10'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 277 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 277 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 277 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    278,
    'The user wants a tool case that already involves example e.g. prompts / steps which they can reuse or adjust to their needs.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 3, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 278 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 278 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 278 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    279,
    'The user wants to be able to add prompts to  a tool case which they can reuse or adjust to their needs.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 2, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-10'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 279 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 279 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 279 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    280,
    'The user would like to be able to assign specific documents to a workflow/ step within a workflow.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Implemented - a solution is released'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Mixed', '2026_01_Workflow_Expectations_Interview,2025_12_KnowledgeBase_UCs_Interviews', 5, '', '', '',
    '', false, false,
    '2026-01-28',
    '2026-04-13'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 280 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 280 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 280 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 280 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 280 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    281,
    'The user would like to be able to create workflows in cooperation with the tool  by e.g. prompting an intial workflow that is set up by the tool.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 5, '', '', '',
    '', false, false,
    '2026-01-28',
    '2026-04-13'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 281 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 281 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 281 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    282,
    'The user would like to be able to improve  an existing workflow  in cooperation with noxtua by  active prompting.',
    (SELECT id FROM insight_types WHERE name = 'Idea'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Mixed' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 2, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 282 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 282 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 282 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    283,
    'The user would like to be able to improve  an existing workflow  in cooperation with noxtua by e.g. getting recommendations.',
    (SELECT id FROM insight_types WHERE name = 'Idea'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Mixed' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 2, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 283 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 283 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 283 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    284,
    'The user needs to be able to create decision points for their workflows.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 2, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 284 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 284 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 284 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    285,
    'The user needs a dashboard or a whiteboard on which I can insert single prompts which all can be integrated into one workflow.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 2, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 285 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 285 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 285 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    286,
    'The user needs to be able to (re-)name the individual workflows.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 2, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-10'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 286 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 286 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 286 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    287,
    'The user would like to be able to define triggers, which would lead to starting the workflow.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 2, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-10'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 287 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 287 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 287 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    288,
    'The user would like to have the option to set the trigger for the workflow to manual.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 1, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 288 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 288 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 288 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    289,
    'The user would like to be able to create/ adjust a workflow using drag & drop to make it es effortless as possible.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 2, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-10'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 289 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 289 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 289 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    290,
    'The user would like to predefine in the workflow which specific parts of a template should be adjusted/ filled based on the input.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 1, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 290 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 290 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 290 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    291,
    'The user would like to get suggestions for new workflows based on his usage of the AI.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Big Law Firm', '2026_01_Workflow_Expectations_Interview,2025_11_Personas_M_B_Lawfirms', 2, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 291 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 291 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 291 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    292,
    'The user would like the AI to suggest next logical steps based on the already existing ones in a workflow.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 1, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 292 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 292 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 292 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    293,
    'The user would like to stay in control and decide whether they want suggestions for workflow improvements from the AI or not.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 1, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 293 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 293 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 293 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    294,
    'The user would like to only provide the input for the workflow and then to have it run autonomously.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 4, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-10'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 294 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 294 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 294 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    295,
    'The user needs to be able to retrace the results of  every step of the workflow, in order to double check results.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 3, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 295 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 295 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 295 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    296,
    'The user needs to be able to check used sources in a workflow easily (i.e. one click).',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 2, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 296 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 296 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 296 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    297,
    'The user would like to be actively involved if multiple options to proceed arise.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 1, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 297 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 297 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 297 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    298,
    'The user would like to be able to adjust an existing workflow based on their needs (e.g. changing parameters).',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 2, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-10'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 298 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 298 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 298 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    299,
    'The user would like to be able to also run parts of workflows only.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 1, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 299 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 299 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 299 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    300,
    'The user needs to be able to share workflows with other users individually.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 6, '', '', '',
    '', false, false,
    '2026-01-28',
    '2026-03-09'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 300 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 300 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 300 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    301,
    'The user needs to be able to share workflows/ templates with certain user groups (e.g. department, legal area).',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Corporate Law Department', '2026_01_Workflow_Expectations_Interview,Continous_Direct_Feedback_corporate', 5, '', '', '',
    '', false, false,
    '2026-01-28',
    '2026-04-20'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 301 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 301 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 301 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 301 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    302,
    'The user wants to be able to provide access to workflows not only for individual workflows but also by workflow groups, that they can set up .',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 1, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 302 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 302 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 302 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    303,
    'The user wants other users to only be able to use the workflow not edit it, so that their workflow is not ruined.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 3, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-10'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 303 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 303 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 303 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    304,
    'The user needs to be able to collaborate within workflows, i.e. not only one person can give input/ review steps in the workflow.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Corporate Law Department', '2026_01_Workflow_Expectations_Interview,2026_02_Personas_Corporate', 5, '"If multiple participants could input into the workflow, that''s a universal tool" (Corporate Personas)', '', '',
    '', true, false,
    '2026-01-28',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 304 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 304 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 304 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    305,
    'The user needs to be able to export the final result that a workflow produced for documentation/ sharing  purposes.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 2, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-10'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 305 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 305 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 305 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    306,
    'The user needs to be able to use his own documents (e.g. files, folders) within workflows.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Mixed', '2026_01_Workflow_Expectations_Interview,2025_12_KnowledgeBase_UCs_Interviews', 5, '', '', '',
    '', false, false,
    '2026-01-28',
    '2026-04-20'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 306 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 306 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 306 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 306 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 306 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    307,
    'The user would like to be able to use matrices in workflows.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 4, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-10'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 307 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 307 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 307 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    308,
    'The user would like the workflows to be able to use the drafting tools (i.e. canvas, word-add-in) for text creation.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 4, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-10'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 308 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 308 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 308 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    309,
    'The user wants to be able to store and use word documents within a knowledge base.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 7, '', '', '',
    '', false, false,
    '2026-01-28',
    '2026-02-23'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 309 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 309 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 309 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    310,
    'The user wants to be able to store and use PDF documents within a knowledge base.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 5, '', '', '',
    '', false, false,
    '2026-01-28',
    '2026-04-20'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 310 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 310 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 310 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    311,
    'The user wants to be able to store and use Excel documents within a knowledge base.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 3, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 311 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 311 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 311 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    312,
    'The user wants to be able to store and use Email documents within a knowledge base.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 4, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 312 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 312 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 312 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    313,
    'The user wants to be able to store and use Powerpoint documents within a knowledge base.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 4, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 313 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 313 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 313 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    314,
    'The user wants to be able to store and use format templates from a knowledge base.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Mixed', '2025_12_KnowledgeBase_UCs_Interviews,2025_11_Beck_Feedback_Survey_2', 6, '', '', '',
    'Beck Germany', false, false,
    '2026-01-28',
    '2026-04-13'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 314 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 314 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 314 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 314 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    315,
    'The users would like to be able to use old files, that can be accessed to draft documents.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Mixed; Mixed; Big Law Firm; Corporate Law Department; Mixed; Big Law Firm', '202510-Canvas-Interview_Testing,2025_10_Beck_Feedback_Survey,2025_11_Beck_Feedback_Survey_2,Continous_Direct_Feedback_big_law_firm,Continous_Direct_Feedback_corporate,2025_12_KnowledgeBase_UCs_Interviews,2025_11_Personas_M_B_Lawfirms', 9, '', '', '',
    'Beck Germany', false, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 315 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 315 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 315 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 315 AND f.name = 'Document Storage'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 315 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 315 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 315 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    316,
    'The user wants to be able to store and use pleadings in a knowledge base.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 3, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 316 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 316 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 316 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    317,
    'The user wants to be able to store and use rulings/ judgements in a knowledge base.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 2, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 317 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 317 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 317 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    318,
    'The user wants to be able to store and use internal guidelines in a knowledge base.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 3, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 318 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 318 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 318 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    319,
    'The user wants to be able to store and use additional legal commentary in a knowledge base.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 1, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 319 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 319 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 319 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    320,
    'The user wants to be able to store and use additional external data sources (e.g. laws from other countries) in a knowledge base.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 1, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 320 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 320 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 320 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    321,
    'The user wants to be able to manually select documents from the knowledge base for a prompt.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 6, '', '', '',
    '', false, false,
    '2026-01-28',
    '2026-04-13'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 321 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 321 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 321 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    322,
    'The user needs the solution to work really well to be able to let the solution choose relevant documents from within the knowledge base on its own for a case.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Mixed' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 7, '', '', '',
    '', false, false,
    '2026-01-28',
    '2026-04-13'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 322 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 322 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 322 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    323,
    'The user needs to be able to get an overview of existing documents within the knowledge base.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 5, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 323 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 323 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 323 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    324,
    'The user needs documents within the knowledge base to have meta data available to them.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 3, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 324 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 324 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 324 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    325,
    'The user needs to create folders within the knowledge base in order to be able to structure their documents.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 2, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 325 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 325 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 325 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    326,
    'The user needs to be able to share files in the knowledge base with individual users.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 3, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 326 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 326 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 326 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    327,
    'The user needs to be able to share files in the knowledge base with ceratin  teams.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 2, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 327 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 327 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 327 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    328,
    'The user needs to be able to share files in the knowledge base with all users.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 3, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 328 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 328 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 328 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    329,
    'The user needs also people without license to be able to input documents into a knowledge base as input material.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Big Law Firm', '2025_12_KnowledgeBase_UCs_Interviews,2025_11_Personas_M_B_Lawfirms', 3, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 329 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 329 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 329 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    330,
    'The user needs content from the documents within the knowledge base to be cited precisely word by word.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 7, '', '', '',
    '', false, false,
    '2026-01-28',
    '2026-04-13'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 330 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 330 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 330 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    331,
    'The user needs content from the documents within the knowledge base to be used only as reference (not exact matching of phrasing)',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 8, '', '', '',
    '', false, false,
    '2026-01-28',
    '2026-04-13'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 331 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 331 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 331 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    332,
    'The user needs to be able to search through documents within the knowledge base.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 3, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 332 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 332 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 332 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    333,
    'The user needs to be able to manually add and edit meta information of a file stored in the knowledge base.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 3, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 333 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 333 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 333 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    334,
    'The user wants to be able to retrace from which document a information orginiated from.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Implemented - a solution is released'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 5, '', '', '',
    '', false, false,
    '2026-01-28',
    '2026-04-20'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 334 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 334 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 334 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    335,
    'The user wants to be able to add tags in the knowledge base to improve filtering and searchability.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 2, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 335 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 335 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 335 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    336,
    'The user wants to be able to ask questions to documents within their knowledge base in order to identify the answer.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 2, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 336 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 336 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 336 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    337,
    'The user wants the AI to automatically update  the information in the knowledge base based on changes in the law or commentaries.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 1, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 337 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 337 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 337 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    338,
    'The user needs the knowledge base and especially editing and uploading of documents to be retricted in order to make sure information is correct and not everybody can change documents or upload them publicly without review.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 2, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 338 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 338 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 338 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    339,
    'The user wants to be able to seleting whole folders  for usage in a prompt in order to not have select all documents manually.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 1, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 339 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 339 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 339 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    340,
    'The users would like to have an Integration/ API for automation to feed in data from DMS via vector-based data base into the knowledge base.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Corporate Law Department', '2025_12_KnowledgeBase_UCs_Interviews,2026_02_Personas_Corporate', 3, '"Copilot is connected to the entire SharePoint, can search all approved internal docs" (Corporate Personas)', '', '',
    '', true, false,
    '2026-01-28',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 340 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 340 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 340 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    341,
    'The users would like to be supported in structuring the files within the knowledge base.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_KnowledgeBase_UCs_Interviews', 4, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 341 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 341 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 341 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    342,
    'The users would like to be able to seamlessly use the tool with their file management system.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm; Corporate Law Department; Prosecution/ Judges', '2025_11_Personas_M_B_Lawfirms,2026_02_Personas_Corporate,2026_03_Personas_Judiciary', 12, '"My dream tool would be linked to my matter management - access to my whole arsenal of briefs to pull arguments I''ve used before" (Corporate Personas)
"I''d most wish for AI applications to be integrated into our specialty programs (Justice4)" (Judiciary Personas)
"AI talks to contract management - take the PDF, feed it in, then do the next 3 steps" (Corporate Personas)', '', '',
    '', false, false,
    '2026-01-28',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 342 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 342 AND f.name = 'DMS Integration'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 342 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    343,
    'The user would like to enable clients to take over parts of their work supported by AI, so that they are more the reviewing and strategic instance.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', '2025_11_Personas_M_B_Lawfirms', 1, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 343 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 343 AND f.name = 'Roles'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 343 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    344,
    'The user needs the tool to support me in documenting my approach and the usage of AI, in order to make sure that I don''t run into liability issues.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm; Corporate Law Department', '2025_11_Personas_M_B_Lawfirms,2026_02_Personas_Corporate', 3, '"Internally nothing for a while, then everything appears at once. Supervisors want to see what we considered, excluded, included - I can use the reasoning to document that" (Corporate Personas)', '', '',
    '', true, true,
    '2026-01-28',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 344 AND f.name = 'Documentation'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 344 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    345,
    'The user needs to be able to give access to their files on a case-by-case basis in order to ensure control.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', '2025_11_Personas_M_B_Lawfirms', 8, '', '', '',
    '', false, false,
    '2026-01-28',
    '2026-04-13'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 345 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 345 AND f.name = 'DMS Integration, Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 345 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    346,
    'The user needs the tool to adjust the output to the purpose that I wanna use it for (e.g. if The user wants to use it in an email, the language and lenght should be adequate).',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm; Prosecution/ Judges', '2025_11_Personas_M_B_Lawfirms,2026_03_Personas_Judiciary', 6, '"Sometimes I need a quick answer; you could go more into the concrete work situation" (Judiciary Personas)', '', '',
    '', false, false,
    '2026-01-28',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 346 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 346 AND f.name = 'Customization'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 346 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    347,
    'The user needs the tool to provide them with practical usage examples and explains it step-by-step to me so that I can learn how to best use the tool.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', '2025_11_Personas_M_B_Lawfirms', 4, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 347 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 347 AND f.name = 'Onboarding'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 347 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    348,
    'The user needs a digital "Schmierzettel" in order to organize my thoughts and findings to put it together later.',
    (SELECT id FROM insight_types WHERE name = 'Idea'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Mixed' LIMIT 1),
    'Big Law Firm', '2025_11_Personas_M_B_Lawfirms', 1, '', '', '',
    '', true, true,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 348 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 348 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    349,
    'The user needs to be able to restrict certain features (such as file or outlook integration) for certain user groups, that work on highly confidential topics or are too junior to judge what can be shared.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', '2025_11_Personas_M_B_Lawfirms', 1, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 349 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 349 AND f.name = 'Roles'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 349 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    350,
    'The user needs to be always the one controlling where information is send by the tool (colleagues, clients etc.).',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', '2025_11_Personas_M_B_Lawfirms', 1, '', '', '',
    '', false, true,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 350 AND s.name = 'All'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 350 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    351,
    'The user needs the AI to help me find uncertainties or potential errors by evaluating its own performance/ certainty.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', '2025_11_Personas_M_B_Lawfirms', 2, '', '', '',
    '', true, true,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 351 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 351 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 351 AND s.name = 'Design'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 351 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    352,
    'The user needs the tool to monitor sources (newsletters, databases etc.) and provide me with an overview of recent changes and what they imply regularly.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', '2025_11_Personas_M_B_Lawfirms', 2, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 352 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 352 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 352 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    353,
    'The user needs a quick overview of what the tool can and can not do, in order to start working with it and learning on the go.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', '2025_11_Personas_M_B_Lawfirms', 1, '', '', '',
    '', true, true,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 353 AND s.name = 'Marketing'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 353 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    354,
    'The user needs the tool to support using gender neutral/ inclusive speech or at least give me the opportunity to enable it.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', '2025_11_Personas_M_B_Lawfirms', 1, '', '', '',
    '', true, true,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 354 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 354 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 354 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    355,
    'The user needs the tool to be able to work with documents in different languages.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', '2025_11_Personas_M_B_Lawfirms', 1, '', '', '',
    '', true, true,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 355 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 355 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    356,
    'The user needs the tool to be approved by the "Anwältekammer" in order to be able to trust it with confidential information.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', '2025_11_Personas_M_B_Lawfirms', 1, '', '', '',
    '', true, true,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 356 AND f.name = 'Trust Center'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 356 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    357,
    'The user needs the producers of the AI to commit to ethical training of the AI to avoid bias and offer the option to notify them if a bias is encountered.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', '2025_11_Personas_M_B_Lawfirms', 1, '', '', '',
    '', true, false,
    '2026-01-28',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 357 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 357 AND f.name = 'Trust Center'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 357 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    358,
    'The user needs to be able to do legal research directly in the word-add-in in order to avoid switching between tools.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Planned for development'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_Word_Expectations_Usability', 5, '', '', '',
    '', false, false,
    '2026-02-02',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 358 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 358 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 358 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 358 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 358 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    359,
    'The user needs the settings to be easily discoverable in order to configure the tool to their needs.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_Word_Expectations_Usability', 2, '', '', '',
    '', true, false,
    '2026-02-02',
    '2026-02-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 359 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 359 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 359 AND f.name = 'Onboarding'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 359 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    360,
    'The user would like to be supported in answering questions about their own document.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Implemented - a solution is released'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_12_Word_Expectations_Usability', 2, '', '', '',
    '', false, false,
    '2026-02-02',
    '2026-03-05'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 360 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 360 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 360 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 360 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 360 AND st.name = 'Usability Testing'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    361,
    'The user would like to be able to search through the chat to find information in older chats efficiently.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 5, '', '', '',
    '', true, false,
    '2026-02-03',
    '2026-02-03'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 361 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 361 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 361 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    362,
    'The user would like to be supported in prioritzing currently running workflows (and their results) to be able to know which one to focus on first.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 1, '', '', '',
    '', true, false,
    '2026-02-10',
    '2026-02-10'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 362 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 362 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 362 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    363,
    'The user would like to be supported in identifying who else needs to be involved in a specific case in a workflow to give them access to the case.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 1, '', '', '',
    '', true, false,
    '2026-02-10',
    '2026-02-10'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 363 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 363 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 363 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    364,
    'The user would like to be able to set company specific elements for workflows that can be shared and reused.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 1, '', '', '',
    '', true, false,
    '2026-02-10',
    '2026-02-10'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 364 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 364 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 364 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    365,
    'The user would like to have some guidance on how much information they need to provide to set up a workflow (step).',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 1, '', '', '',
    '', true, false,
    '2026-02-10',
    '2026-02-10'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 365 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 365 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 365 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    366,
    'The user would like to be able to get an overview of which documents have been processed or involved in a workflow in order to check that nothing was missing.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2026_01_Workflow_Expectations_Interview', 1, '', '', '',
    '', true, false,
    '2026-02-10',
    '2026-02-10'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 366 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 366 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 366 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    367,
    'The user expects the matrix analysis to show the citations from respective documents or sources.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department; Big Law Firm', 'Continous_Direct_Feedback_corporate,Continous_Direct_Feedback_big_law_firm', 3, 'Wenn eine Matrix-Analyse durchgeführt wurde, sollte die Quelle für die extrahierte Antwort resp. die extrahierten Daten angezeigt werden. Die Kunden erwarten einen Hover-Effekt, in welchem ein Snippet aus der Original-Quelle angezeigt wird, damit die Daten schnell überprüft werden können.
Visitenkarten Bild habe ich nur hochgeladen, weil ich keinen Anhang zum hochladen habe (aber der Upload zwingend ist).', '', '',
    '', true, true,
    '2026-02-11',
    '2026-04-08'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 367 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    368,
    'Beck-Noxtua is showing an incorrect date in the chat',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 1, '', '', '',
    '', true, false,
    '2026-02-12',
    '2026-02-12'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 368 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 368 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 368 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    369,
    'The user wants onboarding ressources (like videos) to be available for them to learn how to use the tools.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 1, '', '', '',
    '', false, false,
    '2026-02-17',
    '2026-02-17'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 369 AND s.name = 'Marketing'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 369 AND f.name = 'All'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 369 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    370,
    'The user wants the chat to be structured like legal case files, in order to fit their usual structures.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 1, '', '', '',
    '', true, false,
    '2026-02-23',
    '2026-02-23'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 370 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 370 AND s.name = 'Design'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 370 AND f.name = 'Chat'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 370 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    371,
    'The user needs a clearer structure of the sources overview in order to be able to work with it.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 1, '', '', '',
    '', true, false,
    '2026-02-23',
    '2026-02-23'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 371 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 371 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 371 AND f.name = 'Sources'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 371 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    372,
    'The user needs the chat export to have sources inserted in order to use it for documentation and sharing purposes.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm; Corporate Law Department', 'Continous_Direct_Feedback_big_law_firm,2026_02_Personas_Corporate', 3, '"Annoying that the footnotes aren''t exported with the chat" (Corporate Personas)
"Internally nothing for a while, then everything appears at once. Supervisors want to see what we considered, excluded, included - I can use the reasoning to document that" (Corporate Personas)', '', '',
    '', true, false,
    '2026-02-23',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 372 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 372 AND f.name = 'Chat Export'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 372 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 372 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    373,
    'Documents from DATEV DMS cannot be uploaded directly, they always get a file format error and have to save the file locally first as a workaround',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Small Law Firm', 'Continous_Direct_Feedback_small_law_firm', 1, 'Darüber hinaus ist uns aufgefallen, dass Dokumente aus DATEV DMS nicht direkt in Beck-Noxtua hochgeladen werden können. Hier erscheint immer wieder ein Fehler, dass das Dateiformat nicht zu verarbeiten sei. Wir müssen uns dann damit behelfen, dieses Dokument lokal abzuspeichern. Nur dann kann das Dokument nach Beck-Noxtua verschoben werden, damit es dann dort analysiert werden kann.', '', '',
    '', true, true,
    '2026-02-25',
    '2026-02-25'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 373 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    374,
    'Automatically generating document with employees names in Editor',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', '202510-Canvas-Interview', 0, '', '', '',
    '', true, true,
    '2026-03-02',
    '2026-03-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 374 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 374 AND st.name = 'User Interview'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    375,
    'The user expects the tool to not be biased by context that is given in a chat beforehand to stay objective.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Distribution Department', 'Continous_Direct_Feedback_Distribution', 1, '', '', '',
    '', true, false,
    '2026-03-02',
    '2026-03-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 375 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 375 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 375 AND f.name = 'Review'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 375 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    376,
    'The user needs the exact marginal numbers to be cited, so that the citations can be used directly in e.g. documents.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 2, '', '', '',
    '', true, false,
    '2026-03-02',
    '2026-03-23'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 376 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 376 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 376 AND f.name = 'Citations'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 376 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    377,
    'The user needs to be able to mark a section in the chat and prompt referring to this section in order to work more efficiently.',
    (SELECT id FROM insight_types WHERE name = 'Idea'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Mixed' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 1, '', '', '',
    '', true, false,
    '2026-03-02',
    '2026-03-02'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 377 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 377 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 377 AND f.name = 'Chat'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 377 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    378,
    'The user needs to be able to organize their (prompt) templates e.g. into folders to improve organization and finding specific templates more easily.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Distribution Department', '2026_01_Workflow_Expectations_Interview,Continous_Direct_Feedback_Distribution', 2, '', '', '',
    '', true, false,
    '2026-03-04',
    '2026-03-04'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 378 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 378 AND f.name = 'Templates'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 378 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 378 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    379,
    'The user needs to be able to differentiate fine granularly what other users can do to templates/ workflows (i.e. creating, using, modifying, and deleting them), in order to have control over quality and access.',
    (SELECT id FROM insight_types WHERE name = ''),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed; Distribution Department', '2026_01_Workflow_Expectations_Interview,Continous_Direct_Feedback_Distribution', 2, '', '', '',
    '', true, true,
    '2026-03-04',
    '2026-03-04'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 379 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 379 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    380,
    'The user needs the sources to be linked (clickable) in the export and not only in the chat.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Continous_Publisher_Manz_Noxtua', 2, '', '', '',
    'Manz', true, false,
    '2026-03-16',
    '2026-03-16'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 380 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 380 AND f.name = 'Export'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 380 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    381,
    'The user needs the tool to use smaller headlines for better readability of the export.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Continous_Publisher_Manz_Noxtua', 2, '', '', '',
    'Manz', true, false,
    '2026-03-16',
    '2026-03-16'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 381 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 381 AND f.name = 'Export'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 381 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    382,
    'The user expect to be able to continue a chat even after a bit of time has passed.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 1, '', '', '',
    '', true, false,
    '2026-03-16',
    '2026-03-16'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 382 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 382 AND f.name = 'Chat'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 382 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    383,
    'The user needs the snippets of the citations to give them all context needed.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Continous_Publisher_Swiss_Noxtua', 1, '', '', '',
    'Swiss', true, false,
    '2026-03-16',
    '2026-03-16'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 383 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 383 AND f.name = 'Citations'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 383 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    384,
    'The user needs the chat overview to include when the chat happens.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 1, '', '', '',
    '', true, false,
    '2026-03-16',
    '2026-03-16'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 384 AND s.name = 'Design'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 384 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 384 AND f.name = 'Chat'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 384 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    385,
    'If the prompt in a column is subsequently changed, the response is automatically updated, which is very important.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 1, '', '', '',
    '', false, false,
    '2026-03-30',
    '2026-03-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 385 AND s.name = 'Review Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 385 AND f.name = 'Matrix'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 385 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    386,
    'The user needs clear transparency on existing limitations, e.g. upload limitations.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 1, '', '', '',
    '', true, false,
    '2026-03-31',
    '2026-03-31'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 386 AND s.name = 'Review Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 386 AND f.name = 'Matrix'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 386 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    387,
    'The user wishes the export of the matrix to keep the well-structured overview.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 2, '', '', '',
    '', true, false,
    '2026-03-31',
    '2026-03-31'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 387 AND s.name = 'Review Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 387 AND f.name = 'Matrix'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 387 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    388,
    'The users need the possibility to structure the data within the matrix in different ways.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_11_Beck_Feedback_Survey_2', 1, '', '', '',
    'Beck Germany', false, false,
    '2026-03-31',
    '2026-03-31'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 388 AND s.name = 'Review Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 388 AND f.name = 'Matrix'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 388 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    389,
    'The users need a structured way to review multiple documents.',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'Well done - positive feedback outweighs negative'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm; Mixed; Corporate Law Department', 'Continous_Direct_Feedback_big_law_firm,2025_11_Beck_Feedback_Survey_2,Continous_Direct_Feedback_corporate', 7, '', '', '',
    'Beck Germany', false, false,
    '2026-03-31',
    '2026-04-17'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 389 AND s.name = 'Review Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 389 AND f.name = 'Matrix'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 389 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    390,
    'The user expects clear error messages, to be able to fix them, when uploads don''t succeed in matrix analysis.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Mixed', '2025_11_Beck_Feedback_Survey_2', 1, '', '', '',
    'Beck Germany', true, false,
    '2026-03-31',
    '2026-03-31'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 390 AND s.name = 'Review Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 390 AND f.name = 'Matrix'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 390 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    391,
    'The user would like to be able to comment on matrixes in order to communicate with team members or other parties.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Big Law Firm', 'Continous_Direct_Feedback_big_law_firm', 1, '', '', '',
    '', true, false,
    '2026-03-31',
    '2026-03-31'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 391 AND s.name = 'Review Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 391 AND f.name = 'Matrix'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 391 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    392,
    'Users need to be able to add supporting documents to the Word-Add-In in order to adjust the document based on further info.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 1, '', '', '',
    '', false, false,
    '2026-04-17',
    '2026-04-17'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 392 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 392 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 392 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    393,
    'The user needs to be able to see and access old chats (within the Word-Add-In) in order to have access to all necessary information.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Implemented - a solution is released'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 1, '', '', '',
    '', false, false,
    '2026-04-17',
    '2026-04-17'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 393 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 393 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 393 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    394,
    'The User needs to be able to start a new chat (within the Word-Add-In) in order to start clean for a new topic.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'Implemented - a solution is released'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 1, '', '', '',
    '', false, false,
    '2026-04-17',
    '2026-04-17'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 394 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 394 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 394 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    395,
    'The user needs the editor to save all made changes, when they change to another chat to avoid data loss.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 2, '', '', '',
    '', true, false,
    '2026-04-17',
    '2026-04-17'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 395 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 395 AND f.name = 'Canvas'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 395 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    396,
    'The user needs the Word-Add-In to be able to work with footnotes in order to have sources less prominent in the document.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 1, '', '', '',
    '', true, false,
    '2026-04-17',
    '2026-04-17'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 396 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 396 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 396 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    397,
    'The user needs the tool to automatically select the right way of working in order to avoid having to do it manually.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Continous_Publisher_Swiss_Noxtua', 1, '', '', '',
    'Swiss', true, false,
    '2026-04-17',
    '2026-04-17'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 397 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 397 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 397 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 397 AND f.name = 'Chat'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 397 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    398,
    'The user needs the login to be smooth an easy and ideally not happen too often.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Continous_Direct_Feedback_corporate', 1, '', '', '',
    '', true, false,
    '2026-04-17',
    '2026-04-17'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 398 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 398 AND f.name = 'Login'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 398 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    399,
    'The user needs the last engaged chat to be at the top, not the last newly created one.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Continous_Publisher_PL_Noxtua', 1, '', '', '',
    'Beck Poland', true, false,
    '2026-04-17',
    '2026-04-17'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 399 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 399 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 399 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    400,
    'The user experiences chat aborts and timeouts, particularly when processing large documents, preventing task completion.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'Identified - JIRA ticket exists'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Unknown', 'Sparkasse_2026_04', 1, 'mitten im Chat abgebrochen, Timeouts / nur bei großen Dokumenten scheitert es manchmal', 'Sentiment: Negative. Customer segment: Unknown (corporate/banking). Batch: feedback_batch_20260423.', '',
    '', false, false,
    '2026-04-23',
    '2026-04-23'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 400 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 400 AND f.name = 'Chat'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 400 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    401,
    'Users find that legal reasoning and subsumption in answers is too shallow, with alternative solutions, risk assessments, and minority views often missing.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Unknown', 'Bayrische_Landesbank_042026', 1, 'Einzelne Antworten wirkten in der Herleitung zu kurz oder ohne alternative Lösungsansätze sowie ohne Risiken ausreichend darzustellen', 'Sentiment: Negative. Customer segment: Unknown (corporate/banking). Batch: feedback_batch_20260423.', '',
    '', true, false,
    '2026-04-23',
    '2026-04-23'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 401 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 401 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 401 AND f.name = 'Chat'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 401 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    402,
    'Users cannot clearly tell whether the system is still processing or has already finished, due to missing or unclear progress indicators.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'All'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Corporate Law Department', 'Bayrische_Landesbank_042026', 2, 'nicht immer klare Rückmeldung, ob ein Verarbeitungsvorgang noch läuft oder bereits abgeschlossen ist', 'Test note from dashboard', '',
    '', true, false,
    '2026-04-23',
    '2026-04-23'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 402 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 402 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 402 AND f.name = 'Error Handling'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 402 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    403,
    'Multi-step reasoning is cut off after about 5 conversation turns; PDF upload size limits prevent processing larger documents.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Publisher Feedback - Beck Germany', 1, 'es nicht möglich [ist], einen Gedanken mehrstufig zu entwickeln. Das System beendet die Kommunikation spätestens nach der 5. Stufe.', '', 'CS-997',
    'Beck Germany', true, false,
    '2026-04-30',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 403 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 403 AND f.name = 'Chat'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 403 AND f.name = 'Document Upload'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 403 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    404,
    'Beck-Noxtua sales reports clients frequently ask for a chat-search feature because they don''t name chats consistently and struggle to find prior conversations.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Publisher Feedback - Beck Germany', 1, 'Beck-Noxtua Sales people are apparently often asked whether Noxtua will offer a Chat search function soon. They do not always name their chats properly and find it difficult to find information from previous chats.', '', 'CS-1027',
    'Beck Germany', true, false,
    '2026-04-30',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 404 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 404 AND f.name = 'Chat'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 404 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    405,
    'German-speaking clients find it odd that the Thinking Process is shown in English while answers are in German; they want the thought process in the prompt language.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Publisher Feedback - Beck Germany', 1, 'see the AI thinking in German', '', 'CS-1029',
    'Beck Germany', true, false,
    '2026-04-30',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 405 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 405 AND f.name = 'Thinking Process'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 405 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    406,
    'Saved Matrix Analysis prompts disappear when re-opening "Spalte bearbeiten"; users want Excel exports of a populated matrix to also include the prompts (separate sheet).',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = 'Mixed' LIMIT 1),
    'Publisher', 'Publisher Feedback - Beck Germany', 1, 'Es wäre außerdem sehr praktisch, wenn beim Excel-Export der befüllten Matrix auch die Prompts mit exportiert werden, gern auf einem separaten Tabellenblatt.', '', 'CS-1039',
    'Beck Germany', true, false,
    '2026-04-30',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 406 AND s.name = 'Review Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 406 AND f.name = 'Matrix Analysis'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 406 AND f.name = 'Export'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 406 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    407,
    'Citation format for Swiss federal laws and rulings must follow Swiss conventions (e.g. "Art. 123 OR" not "OR - Art. 123"; BGer 5A_604/2024; BGE 148 III 161; plus Bundesstrafgericht/Bundesverwaltungsgericht/Bundespatentgericht each with own format).',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Switzerland'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Publisher Feedback - Swiss', 1, 'Gesetze auf Bundesebene: Art. 123 OR (nicht OR - Art. 123)… Urteile auf Bundesebene: BGer 5A_604/2024, BGE 148 III 161… aus entscheidsuche API können zusätzlich Urteile des Bundesstrafgericht, Bundesverwaltungsgericht und Bundespatentgericht aggregiert werden, welche je eine eigene Zitierweise haben.', '', 'CS-1046',
    'Swiss', true, false,
    '2026-04-30',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 407 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 407 AND s.name = 'Review Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 407 AND f.name = 'Citations'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 407 AND f.name = 'Sources'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 407 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    408,
    'User should be able to collapse the Thinking Process with one click after it is generated.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Switzerland'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Publisher Feedback - Swiss', 1, 'Es sollte mit einem Klick möglich sein den Denkprozess einzuklappen, nachdem dieser generiert wurde.', '', 'CS-1048',
    'Swiss', true, false,
    '2026-04-30',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 408 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 408 AND f.name = 'Thinking Process'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 408 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    409,
    'Noxtua should send structured KPI/log data to HLV (TTFB, response time, conversation table, error stats, click tracking on legalis links, cited_sources) for performance monitoring and author royalty calculations - via API/webhook.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Switzerland'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Publisher Feedback - Swiss', 1, 'Noxtua soll Log-Daten strukturiert an HLV übermitteln zur Messung von Performance, Nutzerverhalten und Content-Nutzung für Autorenhonorar-Berechnung.', '', 'CS-1049',
    'Swiss', true, false,
    '2026-04-30',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 409 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 409 AND f.name = 'Sources'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 409 AND f.name = 'Citations'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 409 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    410,
    'Until point-in-time legal queries are supported, older editions should be ranked lower than newer ones; also: support delete commands per bucket; avoid daily re-indexing of unchanged laws.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Switzerland'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Publisher Feedback - Swiss', 1, 'Solange keine Point-In-Time-Betrachtung des Rechts vorgenommen werden kann, sollten Altauflagen weniger relevant eingestuft werden, als neuere.', '', 'CS-1050',
    'Swiss', true, false,
    '2026-04-30',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 410 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 410 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 410 AND f.name = 'Sources'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 410 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    411,
    'Integrate cantonal jurisprudence and laws (entscheidsuche API + cantonal legal databases) into the knowledge base.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Switzerland'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Publisher Feedback - Swiss', 1, 'Integration der Daten aus dem Scaping der entscheidsuche API und der kantonalen Gesetzesdatenbanken. V1 soll gemäss heutiger Besprechung bereits nächste Woche auf Dev deployed werden.', '', 'CS-1051',
    'Swiss', true, false,
    '2026-04-30',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 411 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 411 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 411 AND f.name = 'Sources'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 411 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    412,
    'Model must reflect the hierarchy of Swiss legal sources (federal vs cantonal precedence) and the differentiated binding effect of court decisions when ranking and answering.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Switzerland'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Publisher Feedback - Swiss', 1, 'Die hierarchische Struktur der Rechtsordnung mit Vorrangregeln (Bundesrecht vor kantonalem Recht) und deren Ausnahmen… präzise abbilden und bei der Relevanzbewertung von Quellen berücksichtigen. Das System muss die differenzierte Bindungswirkung von Gerichtsentscheiden (Präjudizien… vs. präjudizielle Erwägungen) erkennen und bei der Antwortgenerierung entsprechend gewichten.', '', 'CS-1052',
    'Swiss', true, false,
    '2026-04-30',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 412 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 412 AND f.name = 'Sources'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 412 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 412 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    413,
    'Use the legalis "Verweise" cross-reference structure to populate the Knowledge Graph and improve citation quality / document interconnection.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Switzerland'),
    (SELECT id FROM sentiments WHERE name = 'Mixed' LIMIT 1),
    'Publisher', 'Publisher Feedback - Swiss', 1, 'Prüfung, ob die bestehende Verweisstruktur von legalis (Reiter „Verweise', '', 'CS-1053',
    'Swiss', true, false,
    '2026-04-30',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 413 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 413 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 413 AND f.name = 'Citations'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 413 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    414,
    'Multilingual source matching: French-language questions should also surface German/Italian/English references (and reverse).',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Switzerland'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Publisher Feedback - Swiss', 1, 'Bei französischsprachigen Fragestellungen sollten auch deutsche / italienische / englische Referenzen berücksichtigt werden (und umgekehrt).', '', 'CS-1056',
    'Swiss', true, false,
    '2026-04-30',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 414 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 414 AND f.name = 'Sources'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 414 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 414 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    415,
    'Broaden source coverage so multiple commentaries (BSK StGB/JStG, CR CP II, PraxKomm StGB, HK EMRK, etc.) are surfaced rather than a single source per topic.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Switzerland'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Publisher Feedback - Swiss', 1, '', '', 'CS-1057',
    'Swiss', true, false,
    '2026-04-30',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 415 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 415 AND f.name = 'Sources'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 415 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 415 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    416,
    'Source filtering / discovery still misses specific known works and rulings (e.g. BGer 6S.62/2000); filter on works/categories/rulings should be reliable.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Switzerland'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Publisher Feedback - Swiss', 1, 'Generell stelle ich fest, dass bestimmte Werke inzwischen schon viel besser gefunden werden. Dennoch habe ich folgende Beispiele für nicht gefundene Quellen bzw. nicht funktionierenden Quellen-Filtern. Prompt: BGer 6S.62/2000 vom 30. September 1998 zusammenfassen. Antwort: Leider konnte ich den spezifischen Bundesgerichtsentscheid… in der verfügbaren Datenbank nicht finden.', '', 'CS-1059',
    'Swiss', true, false,
    '2026-04-30',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 416 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 416 AND f.name = 'Sources'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 416 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 416 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    417,
    'Right-pane / hover-box source previews currently show the start of the snippet - they should show the exact passage that proves the cited statement.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Switzerland'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Publisher Feedback - Swiss', 1, 'Aktuell zeigt die Vorschau schlichtweg den Beginn des Snippets an, besser wäre es wenn genau diejenige Stelle aus dem Werk zitiert würde, welche durch die Quelle bewiesen werden soll.', '', 'CS-1061',
    'Swiss', true, false,
    '2026-04-30',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 417 AND s.name = 'Review Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 417 AND f.name = 'Sources'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 417 AND f.name = 'Citations'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 417 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    418,
    'Status request for the previously discussed "3 model-suggested follow-up questions" feature; if shipped, elisa needs them via API as well.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Switzerland'),
    (SELECT id FROM sentiments WHERE name = 'Mixed' LIMIT 1),
    'Publisher', 'Publisher Feedback - Swiss', 1, 'Ihr hattet mal erwähnt, dass ihr euch auch für den Workspace überlegt 3 vom Model vorgeschlagene Folgefragen zu generieren. Was ist der Status bezüglich diesem Vorhaben? Falls dies umgesetzt würde, bräuchten wir auch für elisa die entsprechenden Folgefragen über die API response.', '', 'CS-1063',
    'Swiss', true, false,
    '2026-04-30',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 418 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 418 AND f.name = 'Prompting'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 418 AND f.name = 'Chat'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 418 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    419,
    'Footnote handling in source previews: full snippet with footnotes is hard to read; need a smarter way to display footnote-rich passages.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Switzerland'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Publisher Feedback - Swiss', 1, 'In der Vorschau in der Right-Pane und in der Hover-Box wird derzeit der ganze Snippet angezeigt. Bei Fussnoten führt dies zu einem schwer lesbaren Text mit unschönen Zeilenumbrüchen. Das Dilema ist, dass die Fussnoten durchaus teilweise sehr relevanten Text… enthalten können.', '', 'CS-1064',
    'Swiss', true, false,
    '2026-04-30',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 419 AND s.name = 'Review Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 419 AND f.name = 'Sources'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 419 AND f.name = 'Citations'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 419 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    420,
    'Tool-call display in elisa''s Thinking Process currently shows raw API function names (e.g. "german_law_lookup"); needs human-readable labels.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Switzerland'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Publisher Feedback - Swiss', 1, 'Wir arbeiten gerade an der Darstellung der Tool Calls im Thinking Process von elisa. Aktuell zeigen wir die technischen Function Names aus eurer API (z.B. „german_law_lookup', '', 'CS-1065',
    'Swiss', true, false,
    '2026-04-30',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 420 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 420 AND f.name = 'Thinking Process'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 420 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    421,
    'Chats should be persisted server-side rather than in the browser.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Switzerland'),
    (SELECT id FROM sentiments WHERE name = 'Mixed' LIMIT 1),
    'Publisher; Corporate Law Department', 'Publisher Feedback - Swiss,2026_02_Personas_Corporate', 3, 'Mir ist bewusst, dass dies bereits in Umsetzung ist. Das Ticket dient nur dem Status-Tracking.
"Maybe a desktop application alongside, with browser in background" (Corporate Personas)', '', 'CS-1068',
    'Swiss', true, false,
    '2026-04-30',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 421 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 421 AND f.name = 'Chat'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 421 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 421 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    422,
    'Thinking Process should always be in the language of the prompt.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Switzerland'),
    (SELECT id FROM sentiments WHERE name = 'Mixed' LIMIT 1),
    'Publisher', 'Publisher Feedback - Swiss', 1, 'Ich weiss, dass ihr daran bereits arbeitet. Das Ticket dient nur dem Status-Tracking.', '', 'CS-1069',
    'Swiss', true, false,
    '2026-04-30',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 422 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 422 AND f.name = 'Thinking Process'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 422 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    423,
    'Support templates for contracts and legal pleadings.',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Switzerland'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Publisher Feedback - Swiss', 1, '', '', 'CS-1070',
    'Swiss', true, false,
    '2026-04-30',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 423 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 423 AND f.name = 'Templates'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 423 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    424,
    'When uploaded documents are queried, the answer should reference the specific text passages used; in long documents users currently have to search manually for the cited paragraph.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Austria'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Publisher Feedback - Manz', 1, 'Wir der Dokumentupload genutzt und diesbezügliche Fragen beantwortet, wäre ein passender Verweis auf Textpassagen des Dokuments wünschenswert. Gerade bei sehr umfassenden Dokumenten muss man sehr lange suchen um jenen Absatz zu identifizieren, welcher vom System zur Beantwortung verwendet wurde.', '', 'CS-1094',
    'Manz', true, false,
    '2026-04-30',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 424 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 424 AND s.name = 'Review Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 424 AND f.name = 'Citations'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 424 AND f.name = 'Document Upload'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 424 AND f.name = 'Sources'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 424 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    425,
    'Show the document date directly with each source - useful indicator of how current/outdated the content is.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Austria'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Publisher Feedback - Manz', 1, 'Das Dokumentdatum ist ein hilfreiches Indiz, ob ein Inhalt noch aktuell oder eher veraltet ist. Es wäre gut, dies direkt bei der Quellenanzeige darzustellen.', '', 'CS-1095',
    'Manz', true, false,
    '2026-04-30',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 425 AND s.name = 'Review Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 425 AND f.name = 'Sources'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 425 AND f.name = 'Citations'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 425 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    426,
    'Court-level filter: when a question targets a specific court (e.g. OGH), only that court should be searched. Currently other courts are pulled in.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Austria'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Publisher Feedback - Manz', 1, 'Fragen zu bestimmten Gerichten sollten auch nur jenes Gericht durchsuchen. Im angehängten Export werden mehrere Gerichte herangezogen obwohl nur nach dem OGH gefragt war.', '', 'CS-1097',
    'Manz', true, false,
    '2026-04-30',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 426 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 426 AND f.name = 'Sources'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 426 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 426 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    427,
    'After switching from legalis to entscheidsuche API for Bundesgerichtsentscheide, the citation format is no longer correct - needs adjustment for cantonal rulings index.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Switzerland'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Publisher Feedback - Swiss', 1, 'Bundesgerichtsentscheide werden neu aus der entscheidsuche API bezogen und nicht mehr aus legalis. Dies führt dazu, dass die Zitierweise nun nicht mehr korrekt ist.', '', 'CS-1109',
    'Swiss', true, false,
    '2026-04-30',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 427 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 427 AND s.name = 'Review Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 427 AND f.name = 'Citations'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 427 AND f.name = 'Sources'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 427 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    428,
    'Avoid listing the exact same source multiple times in the same paragraph.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Switzerland'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Publisher Feedback - Swiss', 1, '', '', 'CS-1111',
    'Swiss', true, false,
    '2026-04-30',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 428 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 428 AND f.name = 'Citations'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 428 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    429,
    'Follow-up questions are answered without taking the prior question''s context (e.g. the previously named statute) into account - context is not carried forward.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Switzerland'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Publisher Feedback - Swiss', 1, '', '', 'CS-1112',
    'Swiss', true, false,
    '2026-04-30',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 429 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 429 AND f.name = 'Chat'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 429 AND f.name = 'Thinking Process'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 429 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    430,
    'LLM produces hallucinated, misleading or legally incorrect explanations across many areas of Swiss law (employment, criminal, family, contract, data protection) and fabricates German court citations (e.g. BGH); even when the conclusion is correct, the reasoning is often flawed. Consolidates 21 systematic Swiss-law QA test reports plus 1 Beck-Noxtua attorney report.',
    (SELECT id FROM insight_types WHERE name = 'Improvement'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Switzerland; Germany'),
    (SELECT id FROM sentiments WHERE name = 'Negative' LIMIT 1),
    'Publisher', 'Publisher Feedback - Swiss; Publisher Feedback - Beck Germany', 22, 'Grds. sind wir von der KI angetan. Man bekommt im Researchbereich Antworten, die juristisch auf viel hoeherem Niveau als bei Konkurrenten sein duerften. ... Teilweise fantasieren die Antworten aber ziemlich.', '', 'CS-1073; CS-1074; CS-1075; CS-1076; CS-1077; CS-1078; CS-1079; CS-1080; CS-1081; CS-1082; CS-1083; CS-1084; CS-1085; CS-1086; CS-1087; CS-1088; CS-1089; CS-1090; CS-1091; CS-1092; CS-1106; CS-1107',
    'Swiss', true, false,
    '2026-01-15',
    '2026-04-30'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 430 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 430 AND f.name = 'Knowledge Base'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 430 AND f.name = 'Sources'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 430 AND f.name = 'Citations'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 430 AND st.name = 'Direct Feedback'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    431,
    'AI should detect deadlines/urgency from incoming items (e.g. BeA messages, emails) and proactively create calendar entries, tasks and reminders',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = '' LIMIT 1),
    'Corporate Law Department', '2026_02_Personas_Corporate', 2, '"If I get a BeA message, it should immediately flag: attention, deadlines apply, and propose one - like the iPhone does | Estimate how fast it must be done, put a task in the calendar, remind me if I don''t process it fast enough" (Corporate Personas)', '', '',
    '', true, false,
    '2026-05-01',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 431 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 431 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 431 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 431 AND f.name = 'Outlook-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 431 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    432,
    'AI agents/self-service surfaces per business unit so non-legal users can self-serve, with legal curating the knowledge base and human-in-the-loop escalation when needed',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = '' LIMIT 1),
    'Corporate Law Department', '2026_02_Personas_Corporate', 2, '"Business unit sees the UI; I curate the database | Agents for each business unit... they recognize when human-in-the-loop is needed" (Corporate Personas)', '', '',
    '', true, false,
    '2026-05-01',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 432 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 432 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 432 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 432 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    433,
    'AI helps decode unfamiliar business-unit jargon to clarify what the case is even about',
    (SELECT id FROM insight_types WHERE name = 'General Feedback'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = '' LIMIT 1),
    'Corporate Law Department', '2026_02_Personas_Corporate', 1, '"Pasting it in, it figured out ''this is banking regulation context'' - that helped illuminate the facts" (Corporate Personas)', '', '',
    '', true, false,
    '2026-05-01',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 433 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 433 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    434,
    'AI should ingest requests from multiple input channels (email, intranet form, voice/phone) into one structured intake',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = '' LIMIT 1),
    'Corporate Law Department', '2026_02_Personas_Corporate', 1, '"A tool with different input options - email, intranet integration, maybe voice so I can call in my problem and attach documents" (Corporate Personas)', '', '',
    '', true, false,
    '2026-05-01',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 434 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 434 AND f.name = 'Voice Control'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 434 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 434 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    435,
    'AI should balance workload across team members based on current capacity',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = '' LIMIT 1),
    'Corporate Law Department', '2026_02_Personas_Corporate', 1, '"Shift things between employees based on workload - if peaks are at one colleague, push to someone else" (Corporate Personas)', '', '',
    '', true, false,
    '2026-05-01',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 435 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 435 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 435 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    436,
    'AI should keep requesters informed of progress automatically',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = '' LIMIT 1),
    'Corporate Law Department', '2026_02_Personas_Corporate', 1, '"Keep the requester informed about individual steps in between" (Corporate Personas)', '', '',
    '', true, false,
    '2026-05-01',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 436 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 436 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    437,
    'Gamification elements (streaks, daily nudges) would motivate consistent tool use',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = '' LIMIT 1),
    'Corporate Law Department', '2026_02_Personas_Corporate', 1, '"What''s good about Duolingo is the gamification - puts pressure but doesn''t take much time per day" (Corporate Personas)', '', '',
    '', true, false,
    '2026-05-01',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 437 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 437 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    438,
    'Want comparative drafting where AI redlines existing Word doc minimally rather than regenerating a new draft',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = '' LIMIT 1),
    'Corporate Law Department', '2026_02_Personas_Corporate', 1, '"Lay it against in a Word file, not get a complete new draft but only slightly adjust individual sentences" (Corporate Personas)', '', '',
    '', true, false,
    '2026-05-01',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 438 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 438 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 438 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 438 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    439,
    'Need AI to flag cross-clause and cross-domain (tax, antitrust) impacts when one clause changes',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = '' LIMIT 1),
    'Corporate Law Department', '2026_02_Personas_Corporate', 1, '"If you change something here, ping me that it could have a tax or antitrust impact - don''t just edit this one clause" (Corporate Personas)', '', '',
    '', true, false,
    '2026-05-01',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 439 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 439 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    440,
    'Want to generate visual diagrams (Schaubilder) of contractual relationships from large contracts',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = '' LIMIT 1),
    'Corporate Law Department', '2026_02_Personas_Corporate', 1, '"Upload a 500-page contract and say: make me a diagram of the contractual relationships, who delivers what to whom" (Corporate Personas)', '', '',
    '', true, false,
    '2026-05-01',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 440 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 440 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    441,
    'Need a tabular overview of contractual obligations, rights, and termination notice periods extracted from a contract',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = '' LIMIT 1),
    'Corporate Law Department', '2026_02_Personas_Corporate', 1, '"An overview: notice periods, my rights, my duties, what happens when a contract ends - neatly in a table" (Corporate Personas)', '', '',
    '', true, false,
    '2026-05-01',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 441 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 441 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    442,
    'Need AI to optimize my own English drafting on demand (''make this proper legal English'')',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = '' LIMIT 1),
    'Corporate Law Department', '2026_02_Personas_Corporate', 1, '"We work a lot with English contracts - ''make legal English of this'' to optimize phrasing is really useful" (Corporate Personas)', '', '',
    '', true, false,
    '2026-05-01',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 442 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 442 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    443,
    'Want AI to cover EU regulations and EU case law alongside national law in one tool',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = '' LIMIT 1),
    'Corporate Law Department', '2026_02_Personas_Corporate', 1, '"Not only national law but also overarching European law in one AI tool, including the related rulings" (Corporate Personas)', '', '',
    '', true, false,
    '2026-05-01',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 443 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 443 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    444,
    'Need unlimited input/output length for template-filling tasks',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = '' LIMIT 1),
    'Corporate Law Department', '2026_02_Personas_Corporate', 1, '"20-page template with 400 blanks to be filled - want arbitrary input/output" (Corporate Personas)', '', '',
    '', true, false,
    '2026-05-01',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 444 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 444 AND f.name = 'Templates'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 444 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    445,
    'Vendor proactively curates templates/checklists in tool over time',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = '' LIMIT 1),
    'Corporate Law Department', '2026_02_Personas_Corporate', 1, '"Functionality fills up - ''they made a template for this, I can use it directly''" (Corporate Personas)', '', '',
    '', true, false,
    '2026-05-01',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 445 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 445 AND f.name = 'Templates'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 445 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    446,
    'AI should auto-suggest relevant case law/judgments in the background when opening a case file',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = '' LIMIT 1),
    'Prosecution/ Judges', '2026_03_Personas_Judiciary', 1, '"When I open my case file... prompts have already been sent that show me important judgments that could belong to it" (Judiciary Personas)', '', '',
    '', true, false,
    '2026-05-01',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 446 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 446 AND f.name = 'Document Upload'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 446 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    447,
    'AI should auto-extract procedural data (admissibility, deadlines, time limits) from case files immediately',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = '' LIMIT 1),
    'Prosecution/ Judges', '2026_03_Personas_Judiciary', 1, '"I open the file, it tells me directly: here is the deadline information, and: this is already time-barred" (Judiciary Personas)', '', '',
    '', true, false,
    '2026-05-01',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 447 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 447 AND f.name = 'Document Upload'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 447 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    448,
    'Need cross-border procedural comparison (e.g. covert seizure in Austria) for trans-national cases',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = '' LIMIT 1),
    'Prosecution/ Judges', '2026_03_Personas_Judiciary', 1, '"Can they do a covert seizure in Austria? Today this is always laborious research" (Judiciary Personas)', '', '',
    '', true, false,
    '2026-05-01',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 448 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 448 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    449,
    'Need AI to remind me what I already read/wrote in a long-running case so I don''t redo work',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = '' LIMIT 1),
    'Prosecution/ Judges', '2026_03_Personas_Judiciary', 1, '"You forget what you already read when you''re working in pieces - you do the work twice or three times" (Judiciary Personas)', '', '',
    '', true, false,
    '2026-05-01',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 449 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 449 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    450,
    'Need AI to flag contradictions between submissions and suggest fact-finding gaps for offence elements',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = '' LIMIT 1),
    'Prosecution/ Judges', '2026_03_Personas_Judiciary', 1, '"Highlight contradictions between submissions, prompt fact-finding suggestions for missing elements of the offence" (Judiciary Personas)', '', '',
    '', true, false,
    '2026-05-01',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 450 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 450 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    451,
    'Need AI to verify and link cited rulings/sources within the parties'' incoming submissions',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = '' LIMIT 1),
    'Prosecution/ Judges', '2026_03_Personas_Judiciary', 1, '"Linking of judgements that are cited in submissions, checking citations" (Judiciary Personas)', '', '',
    '', true, false,
    '2026-05-01',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 451 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 451 AND f.name = 'Citations'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 451 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    452,
    'AI should be able to make tool calls / autonomous internet research instead of needing manual context',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = '' LIMIT 1),
    'Prosecution/ Judges', '2026_03_Personas_Judiciary', 1, '"Ability to use tools, especially to do internet research itself" (Judiciary Personas)', '', '',
    '', true, false,
    '2026-05-01',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 452 AND s.name = 'AI Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 452 AND f.name = 'Research'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 452 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    453,
    'Want agentic automation of administrative steps (e.g. dispatch decree to attorneys whose addresses are known)',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = '' LIMIT 1),
    'Prosecution/ Judges', '2026_03_Personas_Judiciary', 1, '"I write a decree, it could be recognized automatically... addresses are in the system, why does a person still do it manually?" (Judiciary Personas)', '', '',
    '', true, false,
    '2026-05-01',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 453 AND s.name = 'Workflow Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 453 AND f.name = 'Workflows'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 453 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;

INSERT INTO insights (
    legacy_id, insight, insight_type_id, status_id, country_id, sentiment_id,
    user_group, source, mentions, quotes, notes, jira_tickets, publisher,
    is_new, unclassified, created_at, modified_at
) VALUES (
    454,
    'Want inline AI clause suggestions in Word (Copilot-style) while drafting a contract',
    (SELECT id FROM insight_types WHERE name = 'Missing Feature'),
    (SELECT id FROM insight_statuses WHERE name = 'New - Not yet discussed'),
    (SELECT id FROM countries WHERE name = 'Germany'),
    (SELECT id FROM sentiments WHERE name = '' LIMIT 1),
    'Corporate Law Department', '2026_02_Personas_Corporate', 2, '"A Copilot-like sidebar in Word with Noxtua suggesting clause variants 1, 2, 3, 4 as I draft would be a huge relief" (Corporate Personas)', '', '',
    '', true, false,
    '2026-05-01',
    '2026-05-01'
)
ON CONFLICT (legacy_id) DO UPDATE SET
    insight         = EXCLUDED.insight,
    insight_type_id = EXCLUDED.insight_type_id,
    status_id       = EXCLUDED.status_id,
    mentions        = EXCLUDED.mentions,
    modified_at     = EXCLUDED.modified_at,
    is_new          = EXCLUDED.is_new,
    unclassified    = EXCLUDED.unclassified;


INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 454 AND s.name = 'Drafting Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_squads (insight_id, squad_id)
SELECT i.id, s.id FROM insights i, squads s
WHERE i.legacy_id = 454 AND s.name = 'Platform Squad'
ON CONFLICT DO NOTHING;

INSERT INTO insight_features (insight_id, feature_id)
SELECT i.id, f.id FROM insights i, features f
WHERE i.legacy_id = 454 AND f.name = 'Word-Add-In'
ON CONFLICT DO NOTHING;

INSERT INTO insight_source_types (insight_id, study_type_id)
SELECT i.id, st.id FROM insights i, study_types st
WHERE i.legacy_id = 454 AND st.name = 'Interview Study'
ON CONFLICT DO NOTHING;
COMMIT;