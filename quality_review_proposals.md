# Insights Quality Review — Proposals
_Generated 2026-07-09, updated against current insights.json_

---

## Specific Edits

### ID 189 — Split into 4

**Current (bundled):**
> Very good results with contract drafts – especially in the IT sector (hardware maintenance contract including SLA, schedule of services – "outstanding").
> Support in preparing presentations and structuring content is very helpful.
> Visualization of answers is perceived positively.
> Further inquiries lead to a significant increase in quality ("AI gets into the flow").
> _(Quote: "Good result with white paper (first) drafts")_

**Proposed split:**

| New Insight | Status | Suggested merge |
|---|---|---|
| **A** — The tool produces very good results with contract drafts, particularly in the IT sector (e.g. hardware maintenance contracts including SLA and schedules of services). | Well done | Merge mentions from ID 217 |
| **B** — The tool produces good results with first drafts of white papers and other documents. | Well done | — |
| **C** — The user finds support in preparing presentations and structuring content very helpful. | Well done | — |
| **D** — The user finds that answer quality increases significantly with follow-up prompting ("AI gets into the flow"). | Well done | — |

> Visualization of answers being "perceived positively" overlaps with ID 125/245 — consider merging there instead of creating a 5th entry.

---

### ID 406 — Split into 2

**Current (bundled):**
> Saved Matrix Analysis prompts disappear when re-opening "Spalte bearbeiten"; users want Excel exports of a populated matrix to also include the prompts (separate sheet).

**Proposed split:**

- **A (General Feedback):** The user needs Matrix Analysis prompts to be preserved when re-opening "Spalte bearbeiten".
- **B (Improvement):** The user needs Matrix Analysis Excel exports to include the column prompts on a separate sheet.

---

### ID 109 — Add citation to notes

**Current insight:** The user needs all relevant sources to be available and used for the answer.

**Add to notes field:**
> Citation: "Broaden source coverage so multiple commentaries (BSK StGB/JStG, CR CP II, PraxKomm StGB, HK EMRK, etc.) are surfaced rather than a single source per topic." (Publisher Feedback — Swiss, ID 415)

> Note: ID 415 has already been resolved/merged.

---

### ID 402 — Remove test note

Remove `"Test note from dashboard"` from the notes field. Leave notes empty.

---

## Flagged Insights — Reformulation Proposals

65 insights in the current insights.json do not start with "The user(s)" or "Users". All reformulations describe the desired or expected system behaviour, not the current state.

Legend: **SPLIT** = should be divided | **DELETE/merge** = merge into another insight | _italic_ = note

---

| ID | Current | Proposed reformulation |
|---|---|---|
| 43 | The non-native speaker needs help in translating the results of a search. | The user needs the tool to translate search results into their preferred language. |
| 93 | The less technical-affine user needs to be enabled to use the tool within their known environment. | The user needs the tool to be accessible and usable within their familiar working environment, especially if they have less technical proficiency. |
| 106 | Language settings in the app — currently not possible to set up the language of the app in Noxtua | The user needs to be able to set the interface language of the app in Noxtua. |
| 107 | Customer would like to have an option to upload files bigger than 10 MB | The user needs to be able to upload files larger than 10 MB. |
| 124 | Easy creation of new criteria or matrices in the Matrix Analysis | The user needs to be able to create new criteria and matrices in Matrix Analysis quickly and easily. |
| 125 | Good overview and structured layout in Matrix Analysis | **SPLIT:** (a) The user expects Matrix Analysis to provide a clear and structured overview of results. (b) The user expects the Matrix Analysis layout to be well-structured and easy to navigate. → Well done status |
| 126 | Speed and efficiency of matrix analysis: evaluation of large amounts of data simultaneously | The user needs Matrix Analysis to evaluate large amounts of data simultaneously with speed and efficiency. |
| 128 | Slow upload times in matrix analysis: Sometimes no result is obtained | The user needs upload times in Matrix Analysis to be reliably fast and always return a result. |
| 129 | No reliability in matrix analysis; there is no clear handling of law updates | The user needs Matrix Analysis results to be reliable and expects the tool to handle law updates clearly, without requiring manual review. |
| 130 | Missing logic between columns and across rows | The user needs Matrix Analysis to apply consistent logic between columns and across rows. |
| 137 | The feature of comparing changes needs to be more intuitive: Icon is not self-explanatory. | The user needs the compare-changes feature to be intuitive and its icon to be self-explanatory. |
| 154 | Prompts are typically simple and resemble Google searches. Complex, multi-step prompts are rarely used. | The user expects to be able to use simple, Google-style prompts effectively without needing to learn complex multi-step prompting. |
| 156 | The Editor interface is described as intuitive, with a layout and button design similar to familiar tools. | The user expects the Editor interface to be intuitive, with a layout and button design familiar from other tools. → Well done status |
| 189 | Very good results with contract drafts… | **SPLIT into 4 — see section above** |
| 191 | Source quality insufficient for legal writing. Links to Beck-Online with the source are missing. | **SPLIT:** (a) Source quality insufficient for legal writing → _merge into ID 103_ (b) The user needs direct links to Beck-Online sources to be included in the output. → standalone |
| 196 | Content accuracy is not always guaranteed. The correct solution is often only found after inquiries. | The user needs the tool to provide accurate answers on the first attempt, without requiring multiple follow-up queries to reach the correct solution. |
| 233 | Answers are too long; users prefer shorter, more concise results. | _merge into ID 77 ("The users have different needs for the level of detail of the answer.", 7 mentions)_ |
| 234 | Overall Impression: Beck-Noxtua is currently not competitive with Libra and Legora | The user expects Beck-Noxtua to be competitive with comparable tools such as Libra and Legora. |
| 238 | No playbook function for contract comparisons or template contracts. | The user needs a playbook function for contract comparisons and template contracts. |
| 240 | A prompt library as a central working resource | The user needs a prompt library as a central working resource. |
| 241 | Clear guidance options for controlled AI deployment (similar to a data room approach) | The user needs clear guidance options for controlled AI deployment, similar to a data room approach. |
| 242 | Stronger linking of references in pleadings or contracts | The user needs references in pleadings or contracts to be more strongly and reliably linked. |
| 244 | The option to compare different documents uploaded within a matrix. | The user needs to be able to compare different documents uploaded within a matrix. |
| 245 | The functions of the matrix are self-explanatory, and the displays are well-structured. | The user expects matrix functions to be self-explanatory and displays to be well-structured. → Well done status |
| 249 | An option to set the context window size to 250,000 or higher would be desirable. | The user needs to not be limited by context window size constraints when working with large documents or complex tasks. (Proposed solution: option to set context window to 250,000 tokens or higher.) |
| 250 | Implement VL capabilities in order to also be able to use floor plans for rental agreements. | The user needs the tool to support visual language (VL) capabilities so that floor plans can be used for rental agreement tasks. |
| 368 | Beck-Noxtua is showing an incorrect date in the chat | The user expects the chat to display the correct date at all times. |
| 373 | Documents from DATEV DMS cannot be uploaded directly, they always get a file format error | The user needs to be able to upload documents from DATEV DMS directly without encountering file format errors. |
| 374 | Automatically generating document with employees names in Editor | The user needs the tool to automatically generate documents pre-populated with employee names in the Editor. |
| 385 | If the prompt in a column is subsequently changed, the response is automatically updated, which is very important. | The user expects that when a column prompt is subsequently changed, the response is automatically updated. → Well done status |
| 403 | Multi-step reasoning is cut off after about 5 conversation turns. | The user needs multi-step reasoning to be maintained consistently across more than 5 conversation turns. |
| 406 | Saved Matrix Analysis prompts disappear… | **SPLIT into 2 — see section above** |
| 422 | Thinking Process should always be in the language of the prompt. | The user needs the Thinking Process to always be displayed in the language of the prompt. |
| 430 | LLM produces hallucinated, misleading or legally incorrect explanations across many areas of Swiss law… | The user needs explanations across all areas of Swiss law to be legally accurate, with correct court citations and sound reasoning. |
| 431 | AI should detect deadlines/urgency from incoming items (e.g. BeA messages, emails) and proactively create calendar entries… | The user needs the tool to automatically detect deadlines and urgency from incoming items and proactively create calendar entries, tasks, and reminders. |
| 432 | AI agents/self-service surfaces per business unit so non-legal users can self-serve… | The user needs AI self-service surfaces per business unit so non-legal users can self-serve, with legal teams curating the knowledge base and human-in-the-loop escalation available when needed. |
| 433 | AI helps decode unfamiliar business-unit jargon to clarify what the case is even about | The user needs the tool to help decode unfamiliar business-unit jargon so they can quickly understand what a case is about. |
| 434 | AI should ingest requests from multiple input channels (email, intranet form, voice/phone) into one structured intake. | The user needs the tool to accept and consolidate requests from multiple input channels (email, intranet form, voice/phone) into one unified system. |
| 435 | AI should balance workload across team members based on current capacity | The user needs the tool to balance workload across team members based on current capacity. |
| 436 | AI should keep requesters informed of progress automatically | The user needs the tool to automatically keep requesters informed of the progress of their request. |
| 437 | Gamification elements (streaks, daily nudges) would motivate consistent tool use | The user needs motivational features (e.g. streaks, daily nudges) to encourage consistent tool use. |
| 438 | Want comparative drafting where AI redlines existing Word doc minimally rather than regenerating a new draft. | The user needs the tool to redline an existing Word document with minimal changes rather than regenerating a new document from scratch. |
| 439 | Need AI to flag cross-clause and cross-domain (tax, antitrust) impacts when one clause changes | The user needs the tool to flag cross-clause and cross-domain impacts (e.g. tax, antitrust) automatically when one clause is changed. |
| 440 | Want to generate visual diagrams (Schaubilder) of contractual relationships from large contracts | The user needs the tool to generate visual diagrams (Schaubilder) of contractual relationships from large contracts. |
| 441 | Need a tabular overview of contractual obligations, rights, and termination notice periods extracted from a contract | The user needs the tool to extract and present a tabular overview of contractual obligations, rights, and termination notice periods from a contract. |
| 442 | Need AI to optimize my own English drafting on demand ('make this proper legal English') | The user needs the tool to optimise their English drafting on demand into proper legal English. |
| 443 | Want AI to cover EU regulations and EU case law alongside national law in one tool | The user needs the tool to cover EU regulations and EU case law alongside national law in one unified tool. |
| 444 | Need unlimited input/output length for template-filling tasks | The user needs unlimited input and output length for template-filling tasks. |
| 445 | Vendor proactively curates templates/checklists in tool over time | The user needs the vendor to proactively curate and maintain templates and checklists within the tool over time. |
| 446 | AI should auto-suggest relevant case law/judgments in the background when opening a case file | The user needs the tool to automatically suggest relevant case law and judgments in the background when a case file is opened. |
| 447 | AI should auto-extract procedural data (admissibility, deadlines, time limits) from case files immediately | The user needs the tool to automatically extract procedural data (admissibility, deadlines, time limits) from case files. |
| 448 | Need cross-border procedural comparison (e.g. covert seizure in Austria) for trans-national cases | The user needs the tool to support cross-border procedural comparison (e.g. covert seizure in Austria) for trans-national cases. |
| 449 | Need AI to remind me what I already read/wrote in a long-running case so I don't redo work | The user needs the tool to keep track of what has already been read or written in a long-running case, so they do not duplicate work. |
| 450 | Need AI to flag contradictions between submissions and suggest fact-finding gaps for offence elements | The user needs the tool to flag contradictions between submissions and suggest fact-finding gaps for offence elements. |
| 451 | Need AI to verify and link cited rulings/sources within the parties' incoming submissions | The user needs the tool to verify and correctly link cited rulings and sources within incoming submissions from parties. |
| 452 | AI should be able to make tool calls / autonomous internet research instead of needing manual context | The user needs the tool to conduct autonomous research and tool calls, rather than requiring the user to provide context manually. |
| 453 | Want agentic automation of administrative steps (e.g. dispatch decree to attorneys whose addresses are known) | The user needs the tool to automate routine administrative steps (e.g. dispatching decrees to attorneys whose addresses are already known). |
| 454 | Want inline AI clause suggestions in Word (Copilot-style) while drafting a contract | The user needs inline AI clause suggestions directly in Word while drafting a contract. |
| 457 | Copying text that contained a citation reference strips the reference but leaves a stray space behind, forcing manual cleanup. | The user needs copied text to preserve citation references correctly, without leaving stray spaces behind. |
| 458 | The citation function is broken in Firefox — raw placeholder tokens are emitted into the text instead of formatted citations. | _Bug — keep as-is, change Type to Bug_ |
| 460 | Despite explicit prompting the AI under-uses its access to the publisher content corpus, inserting too few literature and commentary references. | The user needs the tool to make full use of the available publisher content corpus and insert sufficient literature and commentary references, even when explicitly prompted to do so. |
| 461 | Output is over-structured with excessive bullet points; users want more prose and running-text output. | The users need the tool to produce prose-based, running-text output by default and avoid excessive use of bullet points. |
| 462 | A court decision could not be found in-product, forcing a cumbersome manual download-from-one-system and upload-to-another workflow. | The user needs court decisions to be findable and accessible directly within the tool, without requiring manual download and re-upload workflows. |
| 465 | For two-column bilingual documents users want edits on one side to propagate automatically to the other side across the entire document. | The user needs edits on one side of a two-column bilingual document to propagate automatically to the other side across the entire document. |
| 466 | A corporate customer signals commercial intent — needs 2-3 licenses, at least 5 requested, and openness to a monthly quote. | _⚠️ Not a user insight — appears to be a sales/CRM note. Consider deleting from insights database entirely._ |

---

## Summary

| Category | Count |
|---|---|
| Reformulate to positive desired-state framing | 50 |
| Split into multiple insights | 4 (IDs 125, 191, 406, 189) |
| Merge into existing insight | 2 (IDs 233→77, 191a→103) |
| Change to Well done status | 4 (IDs 125, 156, 245, 385) |
| Delete / not a real insight | 1 (ID 466) |
| **Total flagged** | **65** |

---

## Already resolved since last review (26 insights)

IDs 57, 59, 60, 61, 66, 120, 188, 237, 243, 404, 405, 407, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 423, 424, 425, 426, 427, 428, 429, 455 — no longer flagged in current insights.json.
