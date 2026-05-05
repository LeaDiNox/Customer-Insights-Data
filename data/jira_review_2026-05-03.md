# JIRA Review Package — 2026-05-03 (Daily Publisher Feedback Transfer)

## Header

- **Window:** 2026-05-02 → 2026-05-03 (last 24 h)
- **Project:** CS (Customer Support)
- **Customer segment:** Publisher
- **JQL used:** `project = CS AND created >= "2026-05-02" ORDER BY created ASC`
- **Total tickets fetched:** 14
- **Classification summary:** 4 FEEDBACK · 8 FLAG · 2 DISCARD

## ⚠️ New Publisher Source — Needs Your Decision

All 14 tickets were filed by **Ľubomír Chripko (lubomir.chripko@beck.sk)** — i.e. **Beck Slovakia**. Beck Slovakia is **not** in the existing publisher source list (Manz / Swiss / Beck Germany / Beck Poland / Beck Czech).

I have provisionally tagged every row in the draft CSV with `source_label = Publisher Feedback – Beck Slovakia` and `country = Slovakia`. Please confirm or correct:

1. **Canonical label:** keep `Publisher Feedback – Beck Slovakia`, or fold under `Publisher Feedback – Beck Czech` (Beck-online operates jointly in CZ/SK)?
2. If we keep the new label, I will append it to the Classification Reference skill so all future runs use it.

---

## 🟢 FEEDBACK — Proposed insights for confirmation

### CS-1407 — Insufficient reference to applicable legislation in real estate purchase contract answer

> **Citation:** "Observed in this case; may occur in similar legal queries where secondary sources are prioritized."

| Field | Value |
|---|---|
| Core Insight | Legal users expect AI answers to ground in primary legislation rather than secondary sources, especially for transaction-heavy topics like real estate purchase contracts. |
| Insight Type | Improvement |
| Source Type | Direct Feedback |
| Source Label | Publisher Feedback – Beck Slovakia |
| Customer Segment | Publisher |
| Affected Country | Slovakia |
| Sentiment | Negative |
| Status | New – Not yet discussed |
| Mention Count | 1 |
| Affected Squad(s) | AI Squad |
| Affected Feature(s) | Sources;Citations |

> ⚠️ Likely overlaps with the consolidated **hallucination / legal accuracy** insight (master ID 102). If you agree, this can be merged at the Database Management step rather than landing as a new row.

---

### CS-1408 — Incomplete and non-exhaustive answer on mandatory elements of heat supply contract

> **Citation:** "Observed in this case; may occur in similar legal queries requiring exhaustive legal enumeration."

| Field | Value |
|---|---|
| Core Insight | Legal users want exhaustive enumeration of statutory mandatory elements (e.g., for heat supply contracts) rather than partial answers. |
| Insight Type | Improvement |
| Source Type | Direct Feedback |
| Source Label | Publisher Feedback – Beck Slovakia |
| Customer Segment | Publisher |
| Affected Country | Slovakia |
| Sentiment | Negative |
| Status | New – Not yet discussed |
| Mention Count | 1 |
| Affected Squad(s) | AI Squad |
| Affected Feature(s) | Sources |

> ⚠️ Same potential overlap with master ID 102 (legal-answer completeness / hallucination cluster).

---

### CS-1414 — Add "Improve Prompt" feature for automatic prompt enhancement

> **Citation:** "It would be highly beneficial to introduce an \"Improve Prompt\" feature that helps users refine their input before sending it to the model."
>
> **Internal comment (for context):** "This was discussed a couple of times but the benefit is rather low as the model has no benefit from that as it already takes improvement assumptions into its processing."

| Field | Value |
|---|---|
| Core Insight | Legal users want an Improve Prompt feature that suggests a more precise, structured version of their query (with jurisdiction, legal basis, role) before submission to raise output quality. |
| Insight Type | Missing Feature |
| Source Type | Direct Feedback |
| Source Label | Publisher Feedback – Beck Slovakia |
| Customer Segment | Publisher |
| Affected Country | Slovakia |
| Sentiment | Negative |
| Status | New – Not yet discussed |
| Mention Count | 1 |
| Affected Squad(s) | AI Squad;Drafting Squad |
| Affected Feature(s) | Prompting |

---

### CS-1415 — Increase attachment upload limit (e.g. 50–100 files) for complex legal use cases

> **Citation:** "The current limitation on the number of uploaded attachments (e.g. 15 files) is restrictive for real legal workflows."
>
> **Internal comment (for context):** "First we move increasing the limit of Matrix review in Q2, so that it can handle many thousands of documents. Once that is done we can increase the capacity of the chat as well in Q3."

| Field | Value |
|---|---|
| Core Insight | Legal users want to upload 50–100 files (or scale by subscription tier) so that workflows like M&A due diligence, complex litigation and contract portfolio analysis can be handled without repeated uploads. |
| Insight Type | Improvement |
| Source Type | Direct Feedback |
| Source Label | Publisher Feedback – Beck Slovakia |
| Customer Segment | Publisher |
| Affected Country | Slovakia |
| Sentiment | Negative |
| Status | New – Not yet discussed |
| Mention Count | 1 |
| Affected Squad(s) | Review Squad;Platform Squad |
| Affected Feature(s) | Document Upload;Matrix Analysis |

---

## 🟡 FLAG FOR REVIEW — Needs your decision

All eight FLAG tickets sit in the same theme: **AI legal-content correctness** (wrong / outdated statute citations, terminology drift, incomplete enumerations) reported by Beck Slovakia. They straddle the line between bug and improvement and most plausibly fold into the existing master insight ID 102 (hallucination / legal accuracy cluster — current mention count 60). Decide per ticket: **Bug (DISCARD) / Feedback (add) / Merge into ID 102 / Keep flagged**.

### CS-1403 — Terminology inconsistencies and incorrect legal conclusion regarding short-term lease (Act No. 98/2014 Z.z.)
> **Citation:** "Observed in this case; may occur in similar legal queries."
> **Reason for flag:** Reporter labels it as a New Feature and flags AI output quality (terminology consistency + correctness in legal answers); ambiguous between AI-content bug and AI quality improvement.
> **Proposed core insight:** Slovak legal users want terminologically consistent and legally correct answers when querying statutes such as Act No. 98/2014 Z.z. on short-term lease.
> **Proposed:** Improvement · Negative · AI Squad · Citations;Sources

### CS-1404 — Terminology issues and unclear legal conditions regarding moving cost compensation
> **Citation:** "Observed in this case; may occur in similar legal queries."
> **Reason for flag:** Logged as New Feature flagging unclear legal conditions and terminology in AI answers — ambiguous between AI quality bug and improvement request.
> **Proposed core insight:** Legal users need answers that present legal conditions clearly and use consistent terminology, especially in topics like moving cost compensation.
> **Proposed:** Improvement · Negative · AI Squad · Citations;Sources

### CS-1406 — Use of outdated legislation and misleading information in direct marketing answer
> **Citation:** "Observed in this case; may occur in similar legal queries involving regulatory updates."
> **Reason for flag:** Logged as New Feature about outdated legal sources and misleading AI answers — ambiguous between content correctness bug and improvement to source freshness.
> **Proposed core insight:** Legal users want the system to cite current, in-force legislation rather than outdated rules when answering regulatory questions like direct marketing.
> **Proposed:** Improvement · Negative · AI Squad · Sources;Citations

### CS-1409 — Incorrect legal reference and incomplete answer on probation period under Slovak Labour Code
> **Citation:** "Observed in this case; may occur in other legal queries involving statutory references."
> **Reason for flag:** Wrong statutory reference + incomplete answer — borderline between AI content bug and improvement to statute lookup.
> **Proposed core insight:** Legal users need correct statutory references and complete coverage when asking about Slovak Labour Code provisions like probation periods.
> **Proposed:** Improvement · Negative · AI Squad · Citations;Sources

### CS-1410 — Incorrect and outdated legal source used for non-seizable assets in enforcement proceedings
> **Citation:** "Observed in this case; risk of recurrence in legal queries where the system prefers commentary over current statutory law."
> **Reason for flag:** AI prioritises outdated commentary over current statutes — borderline between content bug and source-ranking improvement.
> **Proposed core insight:** Legal users want the AI to prioritise current statutory law over older commentary when answering enforcement-procedure questions.
> **Proposed:** Improvement · Negative · AI Squad · Sources;Citations

### CS-1411 — Incorrect reference to outdated Slovak Electronic Communications Act in cookies regulation answer
> **Citation:** "Observed in this case; likely recurring in regulatory/legal queries involving amended or replaced legislation."
> **Reason for flag:** AI cites repealed/replaced legislation — borderline between answer-correctness bug and improvement to legal-source freshness.
> **Proposed core insight:** Legal users expect citations to reflect the currently in-force version of statutes (e.g., the new Slovak Electronic Communications Act) instead of repealed acts.
> **Proposed:** Improvement · Negative · AI Squad · Sources;Citations

### CS-1412 — Incorrect legal citation of Labour Code provisions in immediate termination of pregnant employee case
> **Citation:** "Observed in this case; likely recurring in labour law queries involving specific statutory provisions."
> **Reason for flag:** Wrong statutory citation in a sensitive labour-law scenario — borderline AI accuracy bug vs. improvement to citation precision.
> **Proposed core insight:** Legal users need precise, correct Labour Code citations in sensitive scenarios such as immediate termination of pregnant employees.
> **Proposed:** Improvement · Negative · AI Squad · Citations

### CS-1413 — Outdated legal citation of Electronic Communications Act (ZEK) in pricing change response
> **Citation:** "Observed in this case; likely recurring in areas where legislation has been recently recodified or replaced."
> **Reason for flag:** AI cites a recodified/repealed act — borderline accuracy bug vs. improvement to handling of recodified legislation.
> **Proposed core insight:** Legal users want the AI to recognise when legislation has been recodified or replaced and to cite the currently valid act.
> **Proposed:** Improvement · Negative · AI Squad · Sources;Citations

➡️ **Suggested shortcut:** confirm "merge all 8 FLAG tickets into master ID 102 (hallucination cluster), increment mention_count by 8, append source labels & ticket keys" — and the Database Management skill will handle the rest.

---

## 🔴 DISCARDED — Skipped (bug reports)

- **CS-1405:** Language switching issue when creating a new template (SK → PL → CZ) — clear functional bug: UI language switches unexpectedly when creating a new template, logged as Bug.
- **CS-1416:** Context window exceeded error during streaming when processing large document set — explicit Bug ticket: streaming fails with a context-window-exceeded error and returns no usable output (~31k chars input). Internal comment confirms it is a known output-context-length issue.

---

## ⚠️ Needs Classification

- **New publisher source** (Beck Slovakia) — see top of document.
- No Squad/Feature gaps beyond that — all FEEDBACK and FLAG rows have proposed values.

---

## Outputs produced this run

- `jira_review_2026-05-03.md` — this review package.
- `jira_review_2026-05-03_DRAFT.csv` — draft CSV containing the **4 FEEDBACK rows only** (FLAG tickets are not yet in the CSV; they need your decision first).

The draft CSV is **not yet** merged into the master database. Once you confirm the FEEDBACK rows and decide on the FLAG tickets + the Beck Slovakia label, hand the finalised CSV to the **Database Management skill** for deduplication / merge.

## Next run

The next daily run will pick up tickets created from 2026-05-03 onwards.
