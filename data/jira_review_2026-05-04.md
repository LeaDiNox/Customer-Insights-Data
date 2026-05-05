# JIRA Review Package — 2026-05-04

**Automated daily run** · CS project · 50 tickets fetched (newest: CS-1421, oldest in batch: CS-1365)  
**Status:** Awaiting your confirmation before CSV is generated.

> ⚠️ **Note:** The API returned `isLast: false` — there are older tickets beyond CS-1365 not yet fetched. These may need a separate pass if they fall within scope.

---

## 🔴 DISCARDED — Skipped (bug reports / internal)

These have been automatically excluded as clear bugs or internal routing:

- **CS-1421** — Incorrect legal reference to § 449 instead of § 451 Civil Code — AI factual error / hallucination
- **CS-1420** — Incorrect statement that Slovak Commercial Code was repealed — AI factual error
- **CS-1419** — Confusion between Slovak and Czech law and substantive/procedural legal acts — AI confusion error
- **CS-1417** — Incorrect legal reference to § 77 SSP instead of § 191 SSP — AI citation error
- **CS-1416** — Context window exceeded error during streaming when processing large document set — technical failure / system bug
- **CS-1413** — Outdated legal citation of Electronic Communications Act (ZEK) — AI citation error
- **CS-1412** — Incorrect legal citation of Labour Code provisions — AI citation error
- **CS-1411** — Incorrect reference to outdated Slovak Electronic Communications Act — AI citation error
- **CS-1410** — Incorrect and outdated legal source used for non-seizable assets — AI citation error
- **CS-1409** — Incorrect legal reference and incomplete answer on probation period — AI citation error
- **CS-1405** — Language switching issue when creating a new template (SK → PL → CZ) — confirmed UI/localization bug (Petra Zatkova: "This is clearly a bug")
- **CS-1400** — Support: Beck Hotline - Noxtua Technik Schnittstelle — internal support process / routing question
- **CS-1399** — Noxtua Denkprozess Chinesisch — bug (thinking process showing in wrong language)
- **CS-1398** — WG: Beck-Noxtua Test — sales/licensing routing issue
- **CS-1394** — Word-add-in Anmeldung funktioniert nicht — login bug
- **CS-1391** — Falsches Dokument geprüft ("1 Time") — minimal description, likely bug report

---

## 🟡 FLAG FOR REVIEW — Needs your decision

Please indicate for each: **Bug (DISCARD)** / **Feedback (add to database)** / **Keep as flagged**

---

**[CS-1408] — Incomplete and non-exhaustive answer on mandatory elements of heat supply contract**
> "Observed in this case; may occur in similar legal queries requiring exhaustive legal enumeration."

**Proposed classification:** FLAG FOR REVIEW  
**Reason:** Could be an AI completeness failure (bug) or a genuine insight about the AI's inability to return exhaustive statutory enumerations in legal workflows.

➡️ **Your decision:** Bug (DISCARD) / Feedback (add to database) / Keep as flagged

---

**[CS-1407] — Insufficient reference to applicable legislation in real estate purchase contract answer**
> "Observed in this case; may occur in similar legal queries where secondary sources are prioritized."

**Proposed classification:** FLAG FOR REVIEW  
**Reason:** Could be an AI quality issue (wrong sourcing priority) or a feedback point about sourcing behaviour needing improvement.

➡️ **Your decision:** Bug (DISCARD) / Feedback (add to database) / Keep as flagged

---

**[CS-1406] — Use of outdated legislation and misleading information in direct marketing answer**
> "Observed in this case; may occur in similar legal queries involving regulatory updates."

**Proposed classification:** FLAG FOR REVIEW  
**Reason:** "Use of outdated legislation" could be an AI knowledge cutoff bug, or a systemic sourcing quality issue worth capturing as feedback.

➡️ **Your decision:** Bug (DISCARD) / Feedback (add to database) / Keep as flagged

---

**[CS-1403] — Terminology inconsistencies and incorrect legal conclusion regarding short-term lease (Act No. 98/2014 Z.z.)**
> "Observed in this case; may occur in similar legal queries."

**Proposed classification:** FLAG FOR REVIEW  
**Reason:** "Terminology inconsistencies" could be a language/model issue; "incorrect legal conclusion" points to hallucination.

➡️ **Your decision:** Bug (DISCARD) / Feedback (add to database) / Keep as flagged

---

**[CS-1404] — Terminology issues and unclear legal conditions regarding moving cost compensation**
> Internal comment from Petra Zatkova: "what is the solution when the terminology or wording of Noxtua makes mistakes in language? This might be an issue for multiple future publishers. Can this be tackled? Last information I got was from @Leif-Nissen Lundbæk that unless the model changes itself, we cannot do anything about this."

**Proposed classification:** FLAG FOR REVIEW  
**Reason:** The internal comment frames this as a systemic product limitation worth tracking across publishers. Could be General Feedback (AI terminology accuracy) or DISCARD (inherent model limitation).

➡️ **Your decision:** Bug (DISCARD) / Feedback – General Feedback (add to database) / Keep as flagged

---

**[CS-1396] — Fwd: Beck-Noxtua Word Add In (Knorr-Bremse data privacy questions)**
> "Auf welche Daten greift das Add in zu? Kann es auf andere Microsoft Applikationen zugreifen (Outlook?) Wie weit geht das? Greift das Add in auf mehr zu als nur das Word, dass man aktuell offen hat?"

**Proposed classification:** FLAG FOR REVIEW  
**Reason:** Could be classified as a FEEDBACK insight about customers needing clearer data privacy documentation for the Word Add-In, or a pure support request.

➡️ **Your decision:** Support (DISCARD) / Feedback – Missing Feature / Improvement (Trust Center / Word Add-In docs) / Keep as flagged

---

**[CS-1395] — AW: Frage zu Templates in Noxtua (Seidler)**
> Customer: "kann es sein, dass während der Testphase keine eigenen Templates erstellt bzw. bestehende Templates nicht angepasst werden können? Das wäre bedauerlich, da ich das gerne prüfen würde, aufgrund erheblicher Relevanz für unsere praktischen Nutzung."
>
> Customer follow-up: "bei der Nutzung des Templates der bisher in einem Schritt durchlaufende Denkprozess von Noxtua auf mehrere Einzelabschnitte aufgegliedert wird. Entsprechend ist das Prüfungsergebnis von mehreren Denkprozessen unterbrochen, was dazu führt, dass ich im Editor nur den letzten Teil der Ergebnisse aufrufen kann, alles andere ist dort nicht mehr sichtbar. Das ist sehr störend."

**Proposed classification:** FLAG FOR REVIEW  
**Reason:** The follow-up describes a genuine UX problem — when using templates, the thinking process is split into multiple sections and only the last result is visible in the editor.

➡️ **Your decision:** Bug (DISCARD) / Feedback – Improvement (Templates / Thinking Process UX) / Keep as flagged

---

## 🟢 FEEDBACK — Proposed insights for confirmation

Please confirm, correct, or reject each proposed insight below.

---

**[CS-1418] — Add cloud-based chat history linked to user account**
> **Citation:** "Currently, chat history appears to be stored only locally in the browser (client-side storage). We assume this behavior may be related to the current Alpha testing phase. However, it represents a significant limitation for real-world usage. As a result: Chat history is not accessible when logging in from a different device or browser; Users lose access to previous conversations when clearing cache or switching environments; There is no continuity of work across devices. [...] Proposed improvement: Store chat history server-side and link it to user accounts; Enable access to full chat history across devices (desktop, laptop, etc.); Allow users to manage, search, and revisit previous conversations."

| Field | Value |
|---|---|
| Core Insight | Chat history is stored client-side only, preventing access across devices and sessions. Users want server-side, account-linked chat history to support professional legal workflows. |
| Insight Type | Missing Feature |
| Source Type | Direct Feedback |
| Source Label | Publisher Feedback – Beck Czech |
| Customer Segment | Publisher |
| Affected Country | Slovakia |
| Sentiment | Negative |
| Status | New – Not yet discussed |
| Mention Count | 1 |
| Affected Squad(s) | Platform Squad |
| Affected Feature(s) | Chat |

---

**[CS-1415] — Increase attachment upload limit (e.g. 50–100 files) for complex legal use cases**
> **Citation:** "The current limitation on the number of uploaded attachments (e.g. 15 files) is restrictive for real legal workflows. In many practical use cases, significantly larger document sets are required, such as: M&A due diligence; complex litigation (large case files); contract portfolio analysis; regulatory reviews. [...] Benchmark: Some competing legal AI tools already support significantly higher upload limits."
>
> *Leif-Nissen comment:* "I marked it as duplicate as we already have a request for that for Q3"

| Field | Value |
|---|---|
| Core Insight | The 15-file attachment limit is insufficient for real legal workflows (M&A, litigation, regulatory review). Users need 50–100 file uploads, comparable to competitor tools. Already on roadmap for Q3 per Leif-Nissen. |
| Insight Type | Improvement |
| Source Type | Direct Feedback |
| Source Label | Publisher Feedback – Beck Czech |
| Customer Segment | Publisher |
| Affected Country | Slovakia |
| Sentiment | Negative |
| Status | New – Not yet discussed |
| Mention Count | 1 |
| Affected Squad(s) | Platform Squad |
| Affected Feature(s) | Document Upload |

---

**[CS-1414] — Add "Improve Prompt" feature for automatic prompt enhancement**
> **Citation:** "It would be highly beneficial to introduce an 'Improve Prompt' feature that helps users refine their input before sending it to the model. This feature exists in other legal AI tools (e.g. Harvey, Libra) and significantly improves output quality. [...] This is particularly valuable in legal context, where: precision of wording matters; missing context leads to incorrect answers; structured prompts yield significantly better results."
>
> *Leif-Nissen comment:* "This was discussed a couple of times but the benefit is rather low as the model has no benefit from that... Competitors had this feature but seemed to move away from it already."

| Field | Value |
|---|---|
| Core Insight | Users request an "Improve Prompt" feature (auto-enhancement before submission), citing Harvey and Libra as examples. Particularly valued in legal contexts where prompt precision affects answer quality. Deprioritized internally but demand signal exists. |
| Insight Type | Idea |
| Source Type | Direct Feedback |
| Source Label | Publisher Feedback – Beck Czech |
| Customer Segment | Publisher |
| Affected Country | Slovakia |
| Sentiment | Mixed |
| Status | New – Not yet discussed |
| Mention Count | 1 |
| Affected Squad(s) | AI Squad |
| Affected Feature(s) | Prompting |

---

**[CS-1392] — Name of a legal act in the list of sources**
> **Citation:** "Currently, the list of sources in the right-hand panel does not include the designation/title of the legal act. In obvious cases and well-known regulations, this may go unnoticed, but when working with many legal acts it becomes very cumbersome — without going into Legalis, it is impossible to determine which legal act is being referred to."
>
> *Note: Sophie Corboz from Noxtua team responded with a proposed UI design — already in progress.*

| Field | Value |
|---|---|
| Core Insight | The Sources panel only shows section/paragraph numbers without the full title of the legal act, making it impossible to identify which law is cited when working across multiple acts. Already in progress per Noxtua team. |
| Insight Type | Improvement |
| Source Type | Direct Feedback |
| Source Label | Publisher Feedback – Beck Poland |
| Customer Segment | Publisher |
| Affected Country | Poland |
| Sentiment | Negative |
| Status | New – Not yet discussed |
| Mention Count | 1 |
| Affected Squad(s) | AI Squad |
| Affected Feature(s) | Sources |

---

**[CS-1365] — Option to share chats with other users / within the organisation**
> **Citation:** "It would be helpful if users had the option to share selected chats with other users at least within the same organisation / tenant. That way the goal of having a shared legal workspace would be more achievable as opposed to having the chats confined only to the cache of each user's browser. (For example, templates are already working this way – user can create a template on entire organisation / tenant level.)"

| Field | Value |
|---|---|
| Core Insight | Users want the ability to share chat sessions with colleagues within the same organisation/tenant, similar to how templates are already shared org-wide, to enable collaborative legal workflows. |
| Insight Type | Missing Feature |
| Source Type | Direct Feedback |
| Source Label | Publisher Feedback – Beck Czech |
| Customer Segment | Publisher |
| Affected Country | Czech Republic |
| Sentiment | Negative |
| Status | New – Not yet discussed |
| Mention Count | 1 |
| Affected Squad(s) | Platform Squad |
| Affected Feature(s) | Chat |

---

## ⚠️ Open Questions for You

**1. New publisher source — Beck Slovak:**  
Reporter `lubomir.chripko@beck.sk` is from Beck's Slovak operation (separate entity from beck.cz). Should this be:
- `Publisher Feedback – Beck Slovak` (new label), or
- Merged under `Publisher Feedback – Beck Czech`?

**2. Older tickets:**  
The API returned `isLast: false`, meaning tickets older than CS-1365 were not fetched. Should I run another pass to retrieve them?

---

## Next Steps

Once you've reviewed and confirmed the FEEDBACK insights above (and resolved the FLAG FOR REVIEW tickets), reply with your decisions and I'll generate the CSV file ready for the Database Management skill.
