#!/usr/bin/env python3
"""
Noxtua Customer Feedback — Import Script
Imports all questionnaire versions into PostgreSQL.

Usage:
  pip3 install psycopg2-binary openpyxl pandas
  python3 import_feedback.py

On re-run with updated files:
  Only NEW rows (by source_response_id) are inserted.
  Existing rows are never overwritten.

New questionnaire files: add an entry to QUESTIONNAIRE_FILES below.
"""

import os
import re
import pandas as pd
import psycopg2
from datetime import datetime

# ── Configuration ────────────────────────────────────────────
DB = {
    "host": "127.0.0.1",
    "port": 5433,
    "dbname": "noxtua_insights",
    "user": "insights_admin",
    "password": "Noxtua2026",
}

# Base directory — all Excel files should be here
BASE_DIR = os.path.expanduser("~/noxtua-insights")

# ── Questionnaire file registry ──────────────────────────────
# Add new files here — nothing else needs to change.
QUESTIONNAIRE_FILES = [
    {
        "version_key": "v1_CSM",
        "file": "Customer_Feedback_1-104_-CSM-202511.xlsx",
        "parser": "parse_v1",
    },
    {
        "version_key": "v2_CSM",
        "file": "Customer_Feedback_-_Agentic_Beck-Noxtua_1-143_-CSM-202602.xlsx",
        "parser": "parse_v2",
    },
    {
        "version_key": "v3_CSM",
        "file": "results-survey789769-CSM-202605.xlsx",
        "parser": "parse_v3",
    },
    {
        "version_key": "v3_SS",
        "file": "results-survey439739-Selfservice-202605.xlsx",
        "parser": "parse_v3_ss",
    },
]

# ── Scale mappings ────────────────────────────────────────────

FREQUENCY_MAP = {
    "nie":                (0, False),
    "nein":               (0, False),
    "selten":             (1, True),
    "seltener":           (1, True),
    "einmal im monat":    (2, True),
    "einmal pro monat":   (2, True),
    "mehrmals pro monat": (2, True),
    "einmal pro woche":   (3, True),
    "mehrmals pro woche": (4, True),
    "täglich":            (5, True),
    "ja":                 (4, True),
}

LIKERT_5_MAP = {
    "sehr unzufrieden": 1,
    "eher unzufrieden": 2,
    "weder noch":       3,
    "eher zufrieden":   4,
    "sehr zufrieden":   5,
}

ATTENTION_CHECK_PASS = "ich arbeite den fragebogen aufmerksam"


# ── Helper functions ──────────────────────────────────────────

def to_float(val):
    """Convert a value to float, handling German labels like '10 - sehr zufrieden'."""
    if val is None:
        return None
    if isinstance(val, float) and pd.isna(val):
        return None
    s = str(val).strip()
    m = re.match(r'^(\d+(?:\.\d+)?)', s)
    if m:
        return float(m.group(1))
    return None


def likert_to_10(val):
    """Convert 1-5 Likert text to 0-10 scale (multiply by 2)."""
    if val is None:
        return None
    if isinstance(val, float) and pd.isna(val):
        return None
    key = str(val).strip().lower()
    score = LIKERT_5_MAP.get(key)
    if score is None:
        return None
    return float(score * 2)


def freq_map(val):
    """Return (frequency_score, used_yn) tuple."""
    if val is None:
        return None, None
    if isinstance(val, float) and pd.isna(val):
        return None, None
    key = str(val).strip().lower()
    return FREQUENCY_MAP.get(key, (None, None))


def safe_str(val):
    """Return stripped string or None."""
    if val is None:
        return None
    if isinstance(val, float) and pd.isna(val):
        return None
    s = str(val).strip()
    return s if s else None


def attention_pass(val):
    if val is None:
        return None
    if isinstance(val, float) and pd.isna(val):
        return None
    return ATTENTION_CHECK_PASS in str(val).strip().lower()


def normalise_age(raw):
    """Convert age to age group bucket."""
    if raw is None:
        return None
    if isinstance(raw, float) and pd.isna(raw):
        return None
    s = str(raw).strip()
    if '-' in s and 'Jahr' in s:
        return s.split(' ')[0]
    try:
        age = int(float(s))
        if age < 30:  return '<30'
        if age < 41:  return '30-40'
        if age < 51:  return '41-50'
        if age < 61:  return '51-60'
        return '60+'
    except Exception:
        return s


def open_text_entries(response_id, entries):
    """Build list of open text dicts from (field_key, feature, text) tuples."""
    result = []
    for field_key, feature, text in entries:
        if text is None:
            continue
        if isinstance(text, float) and pd.isna(text):
            continue
        s = str(text).strip()
        if s and s.lower() not in ('nan', 'none', ''):
            result.append({
                "response_id":    str(response_id),
                "field_key":      field_key,
                "feature":        feature,
                "text_original":  s,
                "categories":     None,
                "sentiment":      None,
                "categorised_by": "pending",
            })
    return result


# ── Version-specific parsers ──────────────────────────────────

def parse_v1(df, version_id):
    """Parse v1_CSM: Microsoft Forms Nov 2025."""
    responses = []
    features = []
    open_texts = []

    for _, row in df.iterrows():
        r = dict(row)
        sid = str(r.get("ID", ""))

        response = {
            "version_id":          version_id,
            "source_response_id":  sid,
            "submitted_at":        r.get("Completion time"),
            "segment":             "CSM",
            "country":             "Germany",
            "csat_overall":        to_float(r.get("Wie zufrieden sind Sie insgesamt mit unserem Produkt/ unserer Dienstleistung")),
            "nps_score":           to_float(r.get("Wie wahrscheinlich ist es, dass Sie das Produkt Ihren Kolleginnen oder Kollegen weiterempfehlen?")),
            "ux_ease_of_learning": to_float(r.get("Wie einfach war es, die Bedienung von Beck-Noxtua zu erlernen?")),
            "ux_discoverability":  to_float(r.get("Wie einfach war es, durch Ausprobieren weitere Funktionen von Beck-Noxtua zu entdecken?")),
            "ux_design":           to_float(r.get("Wie würden Sie Design und Benutzeroberfläche bewerten?")),
            "ux_intuitiveness":    to_float(r.get("Bei regelmäßiger Nutzung, wie intuitiv ist die Handhabung?")),
            "ueq_ease_of_use":     to_float(r.get("Wie sehr stimmen Sie folgender Aussage zu:")),
            "ueq_transparency":    to_float(r.get("Wie sehr stimmen Sie folgender Aussage zu:2")),
            "ueq_answer_quality":  to_float(r.get("Wie sehr stimmen Sie folgender Aussage zu:\n")),
            "ueq_system_trust":    to_float(r.get("Wie sehr stimmen Sie folgender Aussage zu:\n2")),
            "ueq_word1":           to_float(r.get("Wie würden Sie Beck-Noxtua anhand der folgenden Wörter einschätzen?")),
            "ueq_word2":           to_float(r.get("Wie würden Sie Beck-Noxtua anhand der folgenden Wörter einschätzen?2")),
            "ueq_word3":           to_float(r.get("Wie würden Sie Beck-Noxtua anhand der folgenden Wörter einschätzen?3")),
            "ueq_word4":           to_float(r.get("Wie würden Sie Beck-Noxtua anhand der folgenden Wörter einschätzen?4")),
            "ueq_word5":           to_float(r.get("Wie würden Sie Beck-Noxtua anhand der folgenden Wörter einschätzen?5")),
            "ueq_word6":           to_float(r.get("Wie würden Sie Beck-Noxtua anhand der folgenden Wörter einschätzen?6")),
            "demo_gender":         safe_str(r.get("Geschlecht")),
            "demo_age_raw":        safe_str(r.get("Alter")),
            "demo_age_group":      normalise_age(r.get("Alter")),
            "demo_role_raw":       safe_str(r.get("Berufsbezeichnung (Associate, Partner, General Counsel etc.)")),
            "demo_legal_area":     safe_str(r.get("In welchem Rechtsgebiet liegt der Schwerpunkt Ihrer Tätigkeit?")),
            "demo_tech_affinity":  to_float(r.get("Wie technikaffig würden Sie sich einschätzen?")),
            "demo_ai_used_before": str(r.get("Haben Sie in der Vergangenheit bereits KI-Anwendungen jeglicher Art benutzt?", "")).lower() == "ja",
            "demo_ai_satisfaction":to_float(r.get("Wie zufrieden waren Sie bisher mit KI-Anwendungen die Sie genutzt haben?")),
            "attention_check_pass":attention_pass(r.get("Ist ein Zebra schwarz mit weißen Streifen oder weiß mit Schwarzen Streifen?")),
        }
        responses.append(response)

        # Matrix (col 1 in v1 — confirmed from PDF structure)
        matrix_usage = r.get("Haben Sie dieses Feature genutzt?")
        score, used = freq_map(matrix_usage)
        features.append({
            "source_response_id": sid,
            "feature_key":        "matrix",
            "frequency_raw":      safe_str(matrix_usage),
            "frequency_score":    score,
            "used_yn":            used,
            "csat_overall":       to_float(r.get("Inwiefern hat das Feature Ihren Erwartungen entsprochen?")),
        })

        # Research (col 2 in v1 — confirmed from PDF structure)
        research_usage = r.get("Haben Sie dieses Feature genutzt?2")
        score, used = freq_map(research_usage)
        features.append({
            "source_response_id": sid,
            "feature_key":        "research",
            "frequency_raw":      safe_str(research_usage),
            "frequency_score":    score,
            "used_yn":            used,
            "csat_overall":       to_float(r.get("Inwiefern hat das Feature Ihren Erwartungen entsprochen?2")),
            "csat_accuracy":      to_float(r.get("Wie zufrieden sind Sie mit der Antwort als ganzes?")),
            "csat_sources":       to_float(r.get("Wie zufrieden sind Sie mit der Auswahl der zur Verfügung gestellten Quellen?")),
        })
        # Chat Export (col 3 in v1) — intentionally ignored

        open_texts.extend(open_text_entries(sid, [
            ("general:positive", None, r.get("Was gefällt Ihnen an Beck-Noxtua am Besten und warum?")),
            ("general:improve",  None, r.get("Was haben wir Ihrer Meinung nach noch nicht so gut gemacht?")),
            ("general:request",  None, r.get("Gibt es bestimmt Funktionen oder Verbesserungen, die Sie sich wünschen würden?")),
            ("ux:notes",         None, r.get("Haben Sie sonst noch Anmerkungen zur Bedienung?")),
            ("general:other",    None, r.get("Gibt es sonst noch etwas, das Sie uns mitteilen möchten?")),
            ("nps:reason",       None, r.get("Was motiviert Sie dazu, uns weiterzuempfehlen?")),
            ("nps:main_reason",  None, r.get("Was ist der Hauptgrund für Ihre Bewertung?")),
        ]))

    return responses, features, open_texts


def parse_v2(df, version_id):
    """Parse v2_CSM: Microsoft Forms Feb 2026."""
    responses = []
    features = []
    open_texts = []

    for _, row in df.iterrows():
        r = dict(row)
        sid = str(r.get("ID", ""))

        response = {
            "version_id":          version_id,
            "source_response_id":  sid,
            "submitted_at":        r.get("Completion time"),
            "segment":             "CSM",
            "country":             "Germany",
            "csat_overall":        to_float(r.get("Wie zufrieden sind Sie insgesamt mit Beck-Noxtua?")),
            "ux_ease_of_learning": to_float(r.get("Wie einfach war es, die Bedienung von Beck-Noxtua zu erlernen?")),
            "ux_discoverability":  to_float(r.get("Wie einfach war es, durch Ausprobieren weitere Funktionen von Beck-Noxtua zu entdecken?")),
            "ux_design":           to_float(r.get("Wie würden Sie Design und Benutzeroberfläche bewerten?")),
            "ux_intuitiveness":    to_float(r.get("Bei regelmäßiger Nutzung, wie intuitiv ist die Handhabung?")),
            "ueq_ease_of_use":     to_float(r.get("Wie sehr stimmen Sie folgender Aussage zu:")),
            "ueq_transparency":    to_float(r.get("Wie sehr stimmen Sie folgender Aussage zu:2")),
            "ueq_answer_quality":  to_float(r.get("Wie sehr stimmen Sie folgender Aussage zu:\n")),
            "ueq_system_trust":    to_float(r.get("Wie sehr stimmen Sie folgender Aussage zu:\n2")),
            "ueq_word1":           to_float(r.get("Wie würden Sie Beck-Noxtua anhand der folgenden Wörter einschätzen?")),
            "ueq_word2":           to_float(r.get("Wie würden Sie Beck-Noxtua anhand der folgenden Wörter einschätzen?2")),
            "ueq_word3":           to_float(r.get("Wie würden Sie Beck-Noxtua anhand der folgenden Wörter einschätzen?3")),
            "ueq_word4":           to_float(r.get("Wie würden Sie Beck-Noxtua anhand der folgenden Wörter einschätzen?4")),
            "ueq_word5":           to_float(r.get("Wie würden Sie Beck-Noxtua anhand der folgenden Wörter einschätzen?5")),
            "ueq_word6":           to_float(r.get("Wie würden Sie Beck-Noxtua anhand der folgenden Wörter einschätzen?6")),
            "ueq_word7":           to_float(r.get("Wie würden Sie Beck-Noxtua anhand der folgenden Wörter einschätzen?7")),
            "ueq_word8":           to_float(r.get("Wie würden Sie Beck-Noxtua anhand der folgenden Wörter einschätzen?8")),
            "demo_gender":         safe_str(r.get("Geschlecht")),
            "demo_age_raw":        safe_str(r.get("Bitte geben Sie an zu welcher Altersgruppe Sie gehören:")),
            "demo_age_group":      normalise_age(r.get("Bitte geben Sie an zu welcher Altersgruppe Sie gehören:")),
            "demo_firm_type":      safe_str(r.get("Bitte geben Sie an, in welche Kategorie ihr Arbeitsverhältnis fällt. Ich arbeite in...")),
            "attention_check_pass":attention_pass(r.get("Ist ein Zebra schwarz mit weißen Streifen oder weiß mit Schwarzen Streifen?")),
        }
        responses.append(response)

        # Research
        research_usage = r.get("Haben Sie die Recherche-Funktion genutzt?")
        score, used = freq_map(research_usage)
        features.append({
            "source_response_id": sid,
            "feature_key":        "research",
            "frequency_raw":      safe_str(research_usage),
            "frequency_score":    score,
            "used_yn":            used,
            "csat_overall":       to_float(r.get("Wie zufrieden sind Sie mit der Recherche-Funktion insgesamt?")),
            "csat_accuracy":      to_float(r.get("Wie zufrieden sind Sie mit der Antwort als ganzes?")),
            "csat_sources":       to_float(r.get("Wie zufrieden sind Sie mit der Auswahl der zur Verfügung gestellten Quellen?")),
        })

        # Matrix
        matrix_usage = r.get("Haben Sie die Matrix-Analyse genutzt?")
        score, used = freq_map(matrix_usage)
        features.append({
            "source_response_id": sid,
            "feature_key":        "matrix",
            "frequency_raw":      safe_str(matrix_usage),
            "frequency_score":    score,
            "used_yn":            used,
            "csat_overall":       to_float(r.get("Wie zufrieden sind Sie mit der Matix-Analyse insgesamt?")),
        })

        open_texts.extend(open_text_entries(sid, [
            ("general:positive",  None,       r.get("Was gefällt Ihnen an Beck-Noxtua am Besten und warum?")),
            ("general:improve",   None,       r.get("Was haben wir Ihrer Meinung nach noch nicht so gut gemacht?")),
            ("general:request",   None,       r.get("Gibt es bestimmte Funktionen oder Verbesserungen, die Sie sich wünschen würden?")),
            ("research:positive", "research", r.get("Was hat Ihnen an der Recherche-Funktion besonders gut gefallen?\xa0")),
            ("research:improve",  "research", r.get("Was hat Ihnen an der Recherche-Funktion\xa0nicht\xa0so gut gefallen?")),
            ("matrix:positive",   "matrix",   r.get("Was hat Ihnen an der Matrix-Funktion\xa0besonders gut gefallen?\xa0")),
            ("matrix:improve",    "matrix",   r.get("Welcher Teil der Matix-Funktion hat Ihnen nicht\xa0so gut gefallen?")),
            ("ux:notes",          None,       r.get("Haben Sie sonst noch Anmerkungen zur Bedienung?")),
            ("general:other",     None,       r.get("Gibt es sonst noch etwas, das Sie uns mitteilen möchten?")),
        ]))

    return responses, features, open_texts


def parse_v3_core(df, version_id, segment):
    """Shared core parser for v3_CSM and v3_SS."""
    responses = []
    features = []
    open_texts = []

    for _, row in df.iterrows():
        r = dict(row)
        sid = str(r.get("Antwort ID", ""))

        response = {
            "version_id":               version_id,
            "source_response_id":       sid,
            "submitted_at":             None if pd.isnull(pd.to_datetime(r.get("Datum Abgeschickt"), errors='coerce')) else pd.to_datetime(r.get("Datum Abgeschickt"), errors='coerce'),
            "segment":                  segment,
            "country":                  "Germany",
            "csat_overall":             to_float(r.get("Wie zufrieden waren Sie mit Beck-Noxtua ingesamt? []")),
            "csat_workflow_integration":to_float(r.get("Wie zufrieden sind Sie mit der Integration von Beck-Noxtua in Ihren Arbeitsalltag? []")),
        }
        responses.append(response)

        feature_defs = [
            ("research", {
                "freq":        "Wie häufig haben Sie die folgenden Funktionen genutzt? [Research (Chat)]",
                "csat":        "Wie zufrieden waren Sie mit der Research-Funktion (Chat) ingesamt? []",
                "usability":   "Wie zufrieden waren Sie mit der Research-Funktion (Chat) hinsichtlich: [der Nutzerfreundlichkeit]",
                "accuracy":    "Wie zufrieden waren Sie mit der Research-Funktion (Chat) hinsichtlich: [der Richtigkeit der Antworten]",
                "legal":       "Wie zufrieden waren Sie mit der Research-Funktion (Chat) hinsichtlich: [der juristischen Präzision]",
                "fluency":     "Wie zufrieden waren Sie mit der Research-Funktion (Chat) hinsichtlich: [der sprachlichen Flüssigkeit]",
                "sources":     "Wie zufrieden waren Sie mit der Research-Funktion (Chat) hinsichtlich: [der angegebenen Quellen]",
                "positive":    "Was hat Ihnen an der Research-Funktion (Chat) am besten gefallen?",
                "improve":     "Was können wir an der Research-Funktion (Chat) Ihrer Meinung nach noch verbessern?",
            }),
            ("editor", {
                "freq":        "Wie häufig haben Sie die folgenden Funktionen genutzt? [Editor]",
                "csat":        "Wie zufrieden waren Sie mit dem Editor ingesamt? []",
                "usability":   "Wie zufrieden waren Sie mit dem Editor hinsichtlich: [der Nutzerfreundlichkeit]",
                "accuracy":    "Wie zufrieden waren Sie mit dem Editor hinsichtlich: [der Richtigkeit der erstellten Texte]",
                "legal":       "Wie zufrieden waren Sie mit dem Editor hinsichtlich: [der juristischen Präzision]",
                "fluency":     "Wie zufrieden waren Sie mit dem Editor hinsichtlich: [der sprachlichen Flüssigkeit]",
                "sources":     "Wie zufrieden waren Sie mit dem Editor hinsichtlich: [der angegebenen Quellen]",
                "positive":    "Was hat Ihnen am Editor am besten gefallen?",
                "improve":     "Was können wir am Editor Ihrer Meinung nach noch verbessern?",
            }),
            ("matrix", {
                "freq":        "Wie häufig haben Sie die folgenden Funktionen genutzt? [Matrixanalyse]",
                "csat":        "Wie zufrieden waren Sie mit der Matrix-Analyse ingesamt? []",
                "creation":    "Wie zufrieden waren Sie mit der Matrix-Analyse hinsichtlich: [der Nutzerfreundlichkeit der Erstellung]",
                "application": "Wie zufrieden waren Sie mit der Matrix-Analyse hinsichtlich: [der Nutzerfreundlichkeit der Anwendung]",
                "accuracy":    "Wie zufrieden waren Sie mit der Matrix-Analyse hinsichtlich: [der Richtigkeit der Antworten]",
                "positive":    "Was hat Ihnen an der Matrix-Analyse am besten gefallen?",
                "improve":     "Was können wir an der Matrix-Analyse Ihrer Meinung nach noch verbessern?",
            }),
            ("templates", {
                "freq":        "Wie häufig haben Sie die folgenden Funktionen genutzt? [Templates]",
                "csat":        "Wie zufrieden waren Sie mit den Templates ingesamt? []",
                "creation":    "Wie zufrieden waren Sie mit den Temmplates hinsichtlich: [der Nutzerfreundlichkeit der Erstellung]",
                "application": "Wie zufrieden waren Sie mit den Temmplates hinsichtlich: [der Nutzerfreundlichkeit der Anwendung]",
                "accuracy":    "Wie zufrieden waren Sie mit den Temmplates hinsichtlich: [der Richtigkeit der Antworten]",
                "positive":    "Was hat Ihnen an den Templates am besten gefallen?",
                "improve":     "Was können wir an den Templates Ihrer Meinung nach noch verbessern?",
            }),
        ]

        for fkey, cols in feature_defs:
            freq_val = r.get(cols.get("freq", ""))
            score, used = freq_map(freq_val)
            features.append({
                "source_response_id":       sid,
                "feature_key":              fkey,
                "frequency_raw":            safe_str(freq_val),
                "frequency_score":          score,
                "used_yn":                  used,
                "csat_overall":             to_float(r.get(cols.get("csat", ""))),
                "csat_usability":           likert_to_10(r.get(cols.get("usability", ""))),
                "csat_accuracy":            likert_to_10(r.get(cols.get("accuracy", ""))),
                "csat_legal_precision":     likert_to_10(r.get(cols.get("legal", ""))),
                "csat_fluency":             likert_to_10(r.get(cols.get("fluency", ""))),
                "csat_sources":             likert_to_10(r.get(cols.get("sources", ""))),
                "csat_creation_usability":  likert_to_10(r.get(cols.get("creation", ""))),
                "csat_application_usability": likert_to_10(r.get(cols.get("application", ""))),
            })

            open_texts.extend(open_text_entries(sid, [
                (f"{fkey}:positive", fkey, r.get(cols.get("positive", ""))),
                (f"{fkey}:improve",  fkey, r.get(cols.get("improve", ""))),
            ]))

        open_texts.extend(open_text_entries(sid, [
            ("general:positive",  None, r.get("Können Sie Ihre Bewertung erläutern?")),
            ("general:integrate", None, r.get("Wie können wir Sie unterstützen Beck-Noxtua noch besser in Ihren Arbeitsalltag zu integrieren?")),
        ]))

    return responses, features, open_texts


def parse_v3(df, version_id):
    """Parse v3_CSM: LimeSurvey May 2026."""
    return parse_v3_core(df, version_id, "CSM")


def parse_v3_ss(df, version_id):
    """Parse v3_SS: LimeSurvey Self-Service May 2026."""
    responses, features, open_texts = parse_v3_core(df, version_id, "SelfService")

    for i, (_, row) in enumerate(df.iterrows()):
        r = dict(row)
        sid = str(r.get("Antwort ID", ""))

        churn_raw = safe_str(r.get("Bleiben Sie weiterhin Nutzer*in von Beck-Noxtua?")) or ""
        responses[i]["churn_stays_user"] = True if "ja" in churn_raw.lower() else (False if "nein" in churn_raw.lower() else None)
        responses[i]["onboarding_registration"] = likert_to_10(r.get("Wie zufrieden waren Sie mit den Einführungsprozess von Beck-Noxtua? [Zufriedenheit mit dem Registrierungsprozess]"))
        responses[i]["onboarding_information"]  = likert_to_10(r.get("Wie zufrieden waren Sie mit den Einführungsprozess von Beck-Noxtua? [Zufriedenheit mit den begleitenden Informationen]"))
        responses[i]["onboarding_resources"]    = likert_to_10(r.get("Wie zufrieden waren Sie mit den Einführungsprozess von Beck-Noxtua? [Zufriedenheit mit den weiterführenden Ressourcen (z.B. Support)]"))
        responses[i]["onboarding_inapp"]        = likert_to_10(r.get("Wie zufrieden waren Sie mit den Einführungsprozess von Beck-Noxtua? [Zufriedenheit mit der Einführung in der App selbst]"))
        responses[i]["academy_used"]            = safe_str(r.get("Haben Sie die Academy und die darin vorhandenen Lernvideos und Support-Artikel genutzt?\xa0"))

        word_freq = r.get("Wie häufig haben Sie die folgenden Funktionen genutzt? [Word-Add-In]")
        score, used = freq_map(word_freq)
        features.append({
            "source_response_id":       sid,
            "feature_key":              "word_addin",
            "frequency_raw":            safe_str(word_freq),
            "frequency_score":          score,
            "used_yn":                  used,
            "csat_overall":             to_float(r.get("Wie zufrieden waren Sie mit dem Word-Add-In ingesamt? []")),
            "csat_usability":           likert_to_10(r.get("Wie zufrieden waren Sie mit dem Word-Add-In hinsichtlich: [der Nutzerfreundlichkeit]")),
            "csat_accuracy":            likert_to_10(r.get("Wie zufrieden waren Sie mit dem Word-Add-In hinsichtlich: [der Richtigkeit der erstellten Texte]")),
            "csat_legal_precision":     likert_to_10(r.get("Wie zufrieden waren Sie mit dem Word-Add-In hinsichtlich: [der juristischen Präzision]")),
            "csat_fluency":             likert_to_10(r.get("Wie zufrieden waren Sie mit dem Word-Add-In hinsichtlich: [der sprachlichen Flüssigkeit]")),
            "csat_sources":             likert_to_10(r.get("Wie zufrieden waren Sie mit dem Word-Add-In hinsichtlich: [der angegebenen Quellen]")),
        })

        open_texts.extend(open_text_entries(sid, [
            ("word_addin:positive",        "word_addin", r.get("Was hat Ihnen an dem Word-Add-In am besten gefallen?")),
            ("word_addin:improve",         "word_addin", r.get("Was können wir an dem Word-Add-In Ihrer Meinung nach noch verbessern?")),
            ("onboarding:positive",        None,         r.get("Was hat Ihnen einen guten Einstieg in Beck-Noxtua ermöglicht?")),
            ("onboarding:improve",         None,         r.get("Was hätten Sie sich zusätzlich gewünscht, damit Ihnen der Einstieg in Beck-Noxtua (noch) besser gelungen wäre?")),
            ("onboarding:academy_reason",  None,         r.get("Warum haben Sie die Inhalte der Academy nicht verwendet?")),
            ("onboarding:academy_improve", None,         r.get("Wie können wir die Academy oder deren Inhalte optimieren, um Ihnen einen besseren Einstieg zu ermöglichen?")),
            ("general:churn_reason",       None,         r.get("Woran sollten wir arbeiten, damit wir Sie möglicherweise in Zukunft im Kreis unserer Nutzer*innen willkommen heißen könnten? ")),
        ]))

    return responses, features, open_texts


# ── Database insertion ────────────────────────────────────────

RESPONSE_COLS = [
    "version_id", "source_response_id", "submitted_at", "segment", "country",
    "csat_overall", "nps_score",
    "ux_ease_of_learning", "ux_discoverability", "ux_design", "ux_intuitiveness",
    "ueq_ease_of_use", "ueq_transparency", "ueq_answer_quality", "ueq_system_trust",
    "ueq_word1", "ueq_word2", "ueq_word3", "ueq_word4",
    "ueq_word5", "ueq_word6", "ueq_word7", "ueq_word8",
    "csat_workflow_integration",
    "churn_stays_user", "onboarding_registration", "onboarding_information",
    "onboarding_resources", "onboarding_inapp", "academy_used",
    "demo_gender", "demo_age_raw", "demo_age_group", "demo_role_raw",
    "demo_legal_area", "demo_firm_type", "demo_tech_affinity",
    "demo_ai_used_before", "demo_ai_satisfaction",
    "attention_check_pass",
]


def insert_responses(cur, conn, responses, version_id):
    id_map = {}
    inserted = 0
    skipped = 0

    for resp in responses:
        source_id = resp.get("source_response_id", "")
        cur.execute(
            "SELECT id FROM fb_responses WHERE version_id = %s AND source_response_id = %s",
            (version_id, source_id)
        )
        existing = cur.fetchone()
        if existing:
            id_map[source_id] = str(existing[0])
            skipped += 1
            continue

        vals = tuple(resp.get(c) for c in RESPONSE_COLS)
        cur.execute(
            f"INSERT INTO fb_responses ({', '.join(RESPONSE_COLS)}) "
            f"VALUES ({', '.join(['%s'] * len(RESPONSE_COLS))}) RETURNING id",
            vals
        )
        db_id = str(cur.fetchone()[0])
        id_map[source_id] = db_id
        inserted += 1

    conn.commit()
    return id_map, inserted, skipped


def insert_features(cur, conn, features, id_map):
    cur.execute("SELECT key, id FROM fb_features")
    fkey_map = {row[0]: row[1] for row in cur.fetchall()}
    inserted = 0

    for feat in features:
        response_uuid = id_map.get(feat.get("source_response_id", ""))
        feature_id    = fkey_map.get(feat.get("feature_key"))
        if not response_uuid or not feature_id:
            continue

        cur.execute("""
            INSERT INTO fb_feature_responses
              (response_id, feature_id, frequency_raw, frequency_score, used_yn,
               csat_overall, csat_usability, csat_accuracy, csat_legal_precision,
               csat_fluency, csat_sources, csat_creation_usability, csat_application_usability)
            VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
            ON CONFLICT (response_id, feature_id) DO NOTHING
        """, (
            response_uuid, feature_id,
            feat.get("frequency_raw"), feat.get("frequency_score"), feat.get("used_yn"),
            feat.get("csat_overall"), feat.get("csat_usability"), feat.get("csat_accuracy"),
            feat.get("csat_legal_precision"), feat.get("csat_fluency"), feat.get("csat_sources"),
            feat.get("csat_creation_usability"), feat.get("csat_application_usability"),
        ))
        inserted += 1

    conn.commit()
    return inserted


def insert_open_texts(cur, conn, open_texts, id_map):
    inserted = 0
    for ot in open_texts:
        response_uuid = id_map.get(ot.get("response_id", ""))
        if not response_uuid:
            continue
        cur.execute("""
            INSERT INTO fb_open_text
              (response_id, field_key, feature, text_original, categories, sentiment, categorised_by)
            VALUES (%s,%s,%s,%s,%s,%s,%s)
        """, (
            response_uuid, ot.get("field_key"), ot.get("feature"),
            ot.get("text_original"), ot.get("categories"),
            ot.get("sentiment"), ot.get("categorised_by", "pending"),
        ))
        inserted += 1
    conn.commit()
    return inserted


# ── Main ──────────────────────────────────────────────────────

def main():
    conn = psycopg2.connect(**DB)
    cur  = conn.cursor()

    cur.execute("SELECT version_key, id FROM fb_questionnaire_versions")
    version_map = {row[0]: row[1] for row in cur.fetchall()}

    parsers = {
        "parse_v1":    parse_v1,
        "parse_v2":    parse_v2,
        "parse_v3":    parse_v3,
        "parse_v3_ss": parse_v3_ss,
    }

    total_r = total_f = total_t = 0

    for qfile in QUESTIONNAIRE_FILES:
        vkey   = qfile["version_key"]
        fname  = os.path.join(BASE_DIR, qfile["file"])
        parser = parsers[qfile["parser"]]
        ver_id = version_map.get(vkey)

        if not ver_id:
            print(f"  ✗ Version key '{vkey}' not found in DB — skipping")
            continue
        if not os.path.exists(fname):
            print(f"  ✗ File not found: {fname} — skipping")
            continue

        print(f"\n── {vkey}: {qfile['file']}")
        df = pd.read_excel(fname)
        print(f"   {len(df)} rows read")

        responses, features, open_texts = parser(df, ver_id)
        id_map, ins_r, skip_r = insert_responses(cur, conn, responses, ver_id)
        ins_f = insert_features(cur, conn, features, id_map)
        ins_t = insert_open_texts(cur, conn, open_texts, id_map)

        print(f"   responses:  {ins_r} new, {skip_r} already existed")
        print(f"   features:   {ins_f} inserted")
        print(f"   open text:  {ins_t} inserted")
        total_r += ins_r
        total_f += ins_f
        total_t += ins_t

    print(f"\n✓ Import complete")
    print(f"  Total responses:  {total_r}")
    print(f"  Total features:   {total_f}")
    print(f"  Total open text:  {total_t}")

    print("\n── Verification ─────────────────────────────────────")
    for tbl in ("fb_responses", "fb_feature_responses", "fb_open_text"):
        cur.execute(f"SELECT COUNT(*) FROM {tbl}")
        print(f"  {tbl}: {cur.fetchone()[0]} rows")

    cur.execute("SELECT segment, COUNT(*) FROM fb_responses GROUP BY segment ORDER BY segment")
    print("\n  By segment:")
    for row in cur.fetchall():
        print(f"    {row[0]}: {row[1]} responses")

    cur.close()
    conn.close()


if __name__ == "__main__":
    main()
