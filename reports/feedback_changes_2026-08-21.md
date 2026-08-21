# Featurebase change report — 2026-07-31 → 2026-08-21

Every item below is a Featurebase post; the board status is the pipeline status. The insights database is the intermediary that feeds the boards — it contributes mention counts and the backlog of needs not yet pushed, nothing else.

## 1. Headline numbers

| Metric | Value |
|---|---|
| Posts on the boards (baseline 2026-07-31 → 2026-08-21) | 90 → 348 |
| Newly gathered posts | 5 |
| Posts transferred onto the boards before 2026-08-01 (excluded from intake) | 253 |
| Posts that gained upvotes | 32 |
| Upvotes added | 95 |
| Posts whose need was voiced again (new mentions) | 6 |
| Posts that gained comments | 3 |
| Posts planned or in progress right now | 15 |
| Status moves on the boards | n/a — baseline has no status data |
| Open needs not yet on any board | 28 |
| Delivered needs, correctly not on a board | 91 |

The post count reconciles exactly: 90 at the baseline + 253 transferred + 5 newly gathered = 348 on the boards now. That is the only partition here — every other table is a lens on the same posts, so one post can appear in several of them (Outlook Add-In gained 3 votes *and* 1 comment, and is in the pipeline). Rows are never duplicated within a single table.

## 2. What new feedback we gathered

> 253 posts absent from the baseline were created before `2026-08-01` — the bulk transfer of already-collected research onto the boards. Excluded from every count in this section: `2026-07-31` 253.

| Board | New posts |
|---|---|
| Feedback | 3 |
| Product Board | 2 |


| Created | Votes | Board | Status | Post | Squad tags |
|---|---|---|---|---|---|
| 2026-08-20 | 2 | Feedback | In Review | [The user needs recent case law that is publicly available to be acces…](https://noxtua.featurebase.app/p/the-user-needs-recent-case-law-that-is-publicly-available) | — |
| 2026-08-20 | 2 | Feedback | In Review | [The user wants several well-reasoned wording alternatives with an exp…](https://noxtua.featurebase.app/p/the-user-wants-several-well-reasoned-wording-alternatives-with-an) | — |
| 2026-08-12 | 1 | Feedback | In Review | [No jump to the end of the chat when closing a table](https://noxtua.featurebase.app/p/no-jump-to-the-end-of-the-chat-when-closing) | Platform Squad, Design |
| 2026-08-20 | 1 | Product Board | Planned | [Configurable Retention Periods](https://noxtua.featurebase.app/p/configurable-retention-periods) | — |
| 2026-08-04 | 1 | Product Board | Completed | [Reference the current Word document (Word add-in)](https://noxtua.featurebase.app/p/reference-the-current-word-document-word-add-in) | — |

## 3. Which feedback gained weight

32 of the 90 posts that already existed at the baseline gained upvotes. None lost any. A vote does not bump a post's `updatedAt`, so vote timing cannot be narrowed below the span between the two snapshots — which is this window. The mentions column is the intermediary's count of the same need being voiced again by a separate customer.

| Δ votes | Votes | Δ mentions | Status | Board | Post | Squad tags |
|---|---|---|---|---|---|---|
| +13 | 19 → 32 | — | Reviewed | Feature Request | [Format templates for documents](https://noxtua.featurebase.app/p/format-templates-for-documents) | Drafting Squad |
| +9 | 2 → 11 | — | Planned | Product Board | [UI/UX Template Improvements (incl. private Templates)](https://noxtua.featurebase.app/p/template-upgrade) | — |
| +7 | 11 → 18 | — | Reviewed | Feature Request | [Source passage highlighting](https://noxtua.featurebase.app/p/source-passage-highlighting) | Platform Squad |
| +7 | 12 → 19 | — | In Progress | Product Board | [Stop answer generation and enable prompt re-editing](https://noxtua.featurebase.app/p/stop-answer-generation-and-enable-prompt-re-editing) | Research-Based, Platform Squad |
| +7 | 8 → 15 | — | Completed | Product Board | [Cloud Storage](https://noxtua.featurebase.app/p/cloud-storage) | Research-Based, Platform Squad |
| +6 | 13 → 19 | — | Planned | Product Board | [DMS Integration concept: first integration](https://noxtua.featurebase.app/p/dms-integrations-first-integration) | Research-Based, Platform Squad |
| +4 | 13 → 17 | — | Reviewed | Feature Request | [Collaborative editing environment](https://noxtua.featurebase.app/p/collaborative-editing-environment) | Platform Squad, Drafting Squad |
| +4 | 11 → 15 | +1 | Reviewed | Feature Request | [Prompt writing guidance](https://noxtua.featurebase.app/p/prompt-writing-guidance) | AI Squad, Platform Squad |
| +4 | 12 → 16 | — | In Progress | Product Board | [Holistic Concept for Onboarding & Feature Adoption](https://noxtua.featurebase.app/p/improvements-to-onboarding-feature-adoption-and-chat-interactions) | Research-Based, Platform Squad |
| +3 | 3 → 6 | — | Reviewed | Feature Request | [DMS and API integration](https://noxtua.featurebase.app/p/dms-and-api-integration) | Platform Squad |
| +3 | 11 → 14 | — | Reviewed | Feature Request | [Personalised tool customization](https://noxtua.featurebase.app/p/personalised-tool-customization) | Research-Based, Needs Research, Platform Squad |
| +3 | 23 → 26 | — | Reviewed | Feature Request | [Custom data integration](https://noxtua.featurebase.app/p/custom-data-integration) | Platform Squad |
| +3 | 28 → 31 | — | Coming Soon | Product Board | [Outlook Add-In](https://noxtua.featurebase.app/p/outlook-add-in) | Research-Based, Platform Squad, Drafting Squad |
| +2 | 6 → 8 | — | Reviewed | Feature Request | [Individual drafting style adaptation](https://noxtua.featurebase.app/p/individual-drafting-style-adaptation) | AI Squad, Drafting Squad |
| +2 | 11 → 13 | — | Reviewed | Feature Request | [Reusable clause snippets](https://noxtua.featurebase.app/p/reusable-clause-snippets) | Platform Squad, Drafting Squad |
| +2 | 4 → 6 | — | In Progress | Product Board | [Implement UI language selector](https://noxtua.featurebase.app/p/implement-ui-language-selector) | Research-Based |
| +1 | 6 → 7 | — | Reviewed | Feature Request | [The user needs a playbook function for contract comparisons and templ…](https://noxtua.featurebase.app/p/the-user-needs-a-playbook-function-for-contract-comparisons-and) | — |
| +1 | 6 → 7 | — | Reviewed | Feature Request | [Chat history search](https://noxtua.featurebase.app/p/chat-history-search) | Platform Squad |
| +1 | 4 → 5 | — | Reviewed | Feature Request | [Knowledge base file structuring](https://noxtua.featurebase.app/p/knowledge-base-file-structuring) | Platform Squad |
| +1 | 5 → 6 | — | Reviewed | Feature Request | [Knowledge base document overview](https://noxtua.featurebase.app/p/knowledge-base-document-overview) | Platform Squad |
| +1 | 6 → 7 | — | Reviewed | Feature Request | [Workflow sharing between users](https://noxtua.featurebase.app/p/workflow-sharing-between-users) | Workflow Squad |
| +1 | 5 → 6 | — | Reviewed | Feature Request | [Custom workflow creation](https://noxtua.featurebase.app/p/custom-workflow-creation) | Workflow Squad |
| +1 | 6 → 7 | — | Reviewed | Feature Request | [Additional external data sources](https://noxtua.featurebase.app/p/additional-external-data-sources) | AI Squad, Platform Squad |
| +1 | 4 → 5 | — | Reviewed | Feature Request | [Full chat export](https://noxtua.featurebase.app/p/full-chat-export) | Platform Squad |
| +1 | 9 → 10 | — | Reviewed | Feature Request | [User identity awareness](https://noxtua.featurebase.app/p/user-identity-awareness) | Platform Squad |
| +1 | 6 → 7 | — | Reviewed | Feature Request | [Excel and database integration](https://noxtua.featurebase.app/p/excel-and-database-integration) | Platform Squad |
| +1 | 36 → 37 | — | In Progress | Feature Request | [Content templates for drafting](https://noxtua.featurebase.app/p/content-templates-for-drafting) | Platform Squad, Drafting Squad |
| +1 | 6 → 7 | — | Reviewed | Feature Request | [Document comparison workflow](https://noxtua.featurebase.app/p/document-comparison-workflow) | Drafting Squad |
| +1 | 4 → 5 | — | Reviewed | Feature Request | [Time tracking for cases](https://noxtua.featurebase.app/p/time-tracking-for-cases) | AI Squad |
| +1 | 8 → 9 | — | Reviewed | Feature Request | [Adjustable answer detail level](https://noxtua.featurebase.app/p/adjustable-answer-detail-level) | Platform Squad |
| +1 | 1 → 2 | — | Planned | Product Board | [Word Add-in Stabilisation](https://noxtua.featurebase.app/p/word-add-in-stabilisation) | — |
| +1 | 2 → 3 | — | In Progress | Product Board | [Improved Document Processing](https://noxtua.featurebase.app/p/improved-document-processing) | — |

Gained mentions but no votes — the need was voiced again in research, but nobody upvoted it on the board:

| Δ mentions | Votes | Status | Board | Post | Insight IDs |
|---|---|---|---|---|---|
| +2 | 8 | Reviewed | Feedback | [The user needs the tool to also provide them with alternative perspec…](https://noxtua.featurebase.app/p/the-user-needs-the-tool-to-also-provide-them-with) | #72 |
| +1 | 86 | Reviewed | Feedback | [The user needs the answers to have a high accuracy to be beneficial t…](https://noxtua.featurebase.app/p/the-user-needs-the-answers-to-have-a-high-accuracy) | #102 |
| +1 | 26 | Reviewed | Feedback | [The user needs all relevant sources to be available and used for the …](https://noxtua.featurebase.app/p/the-user-needs-all-relevant-sources-to-be-available-and) | #109 |
| +1 | 6 | Reviewed | Feedback | [The users expect the word-add-in to be intuitive and offer guidance s…](https://noxtua.featurebase.app/p/the-users-expect-the-word-add-in-to-be-intuitive) | #257 |
| +1 | 12 | Reviewed | Product Board | [File management system integration](https://noxtua.featurebase.app/p/file-management-system-integration) | #342 |

New discussion — comment counts, not votes. A post can appear here and in the vote table above; the two numbers count different things.

| Δ comments | Comments | Votes | Board | Post |
|---|---|---|---|---|
| +1 | 0 → 1 | 26 | Feature Request | [Custom data integration](https://noxtua.featurebase.app/p/custom-data-integration) |
| +1 | 0 → 1 | 2 | Product Board | [The complete, current C.H. BECK knowledge from beck-online in Beck-No…](https://noxtua.featurebase.app/p/the-complete-current-ch-beck-knowledge-from-beck-online-in) |
| +1 | 2 → 3 | 31 | Product Board | [Outlook Add-In](https://noxtua.featurebase.app/p/outlook-add-in) |

## 4. What is in development, and what should be

| Board / status | Posts |
|---|---|
| Feature Request / In Progress | 1 |
| Feature Request / In Review | 71 |
| Feature Request / Reviewed | 36 |
| Feedback / Completed | 1 |
| Feedback / In Progress | 1 |
| Feedback / In Review | 113 |
| Feedback / Reviewed | 72 |
| Product Board / Coming Soon | 1 |
| Product Board / Completed | 26 |
| Product Board / In Progress | 7 |
| Product Board / In Review | 7 |
| Product Board / Planned | 5 |
| Product Board / Reviewed | 7 |


> The 2026-07-31 baseline carries no status values, so status moves cannot be diffed for this window and the pipeline above is a current-state read. Snapshots from 2026-08-21 onward record status.

### In the pipeline and gaining demand

| Δ votes | Votes now | Δ mentions | Status | Post |
|---|---|---|---|---|
| +9 | 11 | — | Planned | [UI/UX Template Improvements (incl. private Templates)](https://noxtua.featurebase.app/p/template-upgrade) |
| +7 | 19 | — | In Progress | [Stop answer generation and enable prompt re-editing](https://noxtua.featurebase.app/p/stop-answer-generation-and-enable-prompt-re-editing) |
| +6 | 19 | — | Planned | [DMS Integration concept: first integration](https://noxtua.featurebase.app/p/dms-integrations-first-integration) |
| +4 | 16 | — | In Progress | [Holistic Concept for Onboarding & Feature Adoption](https://noxtua.featurebase.app/p/improvements-to-onboarding-feature-adoption-and-chat-interactions) |
| +3 | 31 | — | Coming Soon | [Outlook Add-In](https://noxtua.featurebase.app/p/outlook-add-in) |
| +2 | 6 | — | In Progress | [Implement UI language selector](https://noxtua.featurebase.app/p/implement-ui-language-selector) |
| +1 | 37 | — | In Progress | [Content templates for drafting](https://noxtua.featurebase.app/p/content-templates-for-drafting) |
| +1 | 2 | — | Planned | [Word Add-in Stabilisation](https://noxtua.featurebase.app/p/word-add-in-stabilisation) |
| +1 | 3 | — | In Progress | [Improved Document Processing](https://noxtua.featurebase.app/p/improved-document-processing) |

### Already shipped, still gaining votes

| Δ votes | Votes now | Δ mentions | Status | Post |
|---|---|---|---|---|
| +7 | 15 | — | Completed | [Cloud Storage](https://noxtua.featurebase.app/p/cloud-storage) |

### Gained votes, now ≥10, still in review — promotion candidates

| Δ votes | Votes now | Δ mentions | Status | Post |
|---|---|---|---|---|
| +13 | 32 | — | Reviewed | [Format templates for documents](https://noxtua.featurebase.app/p/format-templates-for-documents) |
| +7 | 18 | — | Reviewed | [Source passage highlighting](https://noxtua.featurebase.app/p/source-passage-highlighting) |
| +4 | 17 | — | Reviewed | [Collaborative editing environment](https://noxtua.featurebase.app/p/collaborative-editing-environment) |
| +4 | 15 | +1 | Reviewed | [Prompt writing guidance](https://noxtua.featurebase.app/p/prompt-writing-guidance) |
| +3 | 14 | — | Reviewed | [Personalised tool customization](https://noxtua.featurebase.app/p/personalised-tool-customization) |
| +3 | 26 | — | Reviewed | [Custom data integration](https://noxtua.featurebase.app/p/custom-data-integration) |
| +2 | 13 | — | Reviewed | [Reusable clause snippets](https://noxtua.featurebase.app/p/reusable-clause-snippets) |
| +1 | 10 | — | Reviewed | [User identity awareness](https://noxtua.featurebase.app/p/user-identity-awareness) |

## 5. Open needs not yet on a board

119 of the intermediary's 383 records have no board post. 91 of those are marked implemented or well done — already delivered, so their absence is correct by the rule that implemented insights are never pushed. That leaves **28** open needs that cannot collect votes and are invisible to the pipeline:

| Mentions | Δ in window | Research status | Need | Segment |
|---|---|---|---|---|
| 22 | — | Identified - JIRA ticket exists | The user needs explanations across all areas of Swiss law to be legally accurate | Publisher |
| 15 | — | Identified - JIRA ticket exists | The user needs guidance in case of occuring errors in order to be able to unders | Mixed; Big Law Firm; Corporate Law Department |
| 7 | — | Identified - JIRA ticket exists | The visible thinking process / step-by-step reasoning is highly valued — it help | Unknown |
| 6 | — | Identified - JIRA ticket exists | Source and citation quality is a highlight — precise references, working Fundste | Unknown |
| 5 | — | Identified - JIRA ticket exists | Login is not persisted — users are auto-logged-out after a short time and a fres | Unknown |
| 4 | — | Identified - JIRA ticket exists | Users value the fast, useful first assessment and the resulting time savings. | Unknown |
| 4 | — | Identified - JIRA ticket exists | The user needs the tool to preserve and fill a user-provided outline (Gliederung | Unknown |
| 3 | — | New – Not yet discussed | Recurring system errors / crashes — 'Es ist ein interner Fehler aufgetreten' app | Unknown |
| 2 | — | New – Not yet discussed | Storage limit is too low — 30 MB is insufficient; ~50 MB is workable. | Unknown |
| 2 | — | New – Not yet discussed | Response / generation speed is too slow. | Unknown |
| 2 | — | New – Not yet discussed | The user needs the Word-Add-In to be able to add comments addressed to the other | Unknown |
| 1 | +1 | New – Not yet discussed | Users felt the added value of Noxtua's large archive/data volume did not justify | Unknown |
| 1 | +1 | New – Not yet discussed | Trial users saw an advantage for the competitor on deep, thorough research tasks | Unknown |
| 1 | +1 | New – Not yet discussed | Procurement declined budget to run two parallel legal AI tools; the decision was | Unknown |
| 1 | +1 | New – Not yet discussed | Customer indicated a target price point of around €200 per user/month and reques | Unknown |
| 1 | +1 | New – Not yet discussed | To ease the transition to the competitor, the customer asked to keep a minimal f | Unknown |
| 1 | — | New – Not yet discussed | The citation function is broken in Firefox - raw placeholder tokens are emitted  |  |
| 1 | — | New – Not yet discussed | The user needs the tool to make full use of the available publisher content corp |  |
| 1 | — | New – Not yet discussed | The user needs court decisions to be findable and accessible directly within the |  |
| 1 | — | New – Not yet discussed | The user needs Matrix Analysis Excel exports to include the column prompts on a  | Publisher |
| 1 | — | New – Not yet discussed | Users want generated output delivered as a downloadable PPTX file. | Unknown |
| 1 | — | New – Not yet discussed | Users need project workspaces / collaboration, including editing two interdepend | Unknown |
| 1 | — | New – Not yet discussed | Users want an iOS app. | Unknown |
| 1 | — | New – Not yet discussed | Generated pleadings/briefs often miss required legal formalities (e.g. Rechtsbeh | Unknown |
| 1 | — | New – Not yet discussed | The user needs to be able to save their own prompts for reuse. | Unknown |
| 1 | — | New – Not yet discussed | The user wants to be able to correct the AI's errors directly so that the correc | Unknown |
| 1 | — | New – Not yet discussed | The user needs a unified, standard citation style (e.g. Bearbeiter/MüKo, § x Rn. | Unknown |
| 1 | — | New – Not yet discussed | Suggestion to add/improve a button that helps users refine or improve their prom | Corporate Lawyer |

Resolution is by stored `featurebase_id` or exact post title, so a post that was retitled after being pushed shows up here as absent.

## 6. How this gets reported from now on

| Cadence | What runs | Output | Audience |
|---|---|---|---|
| Every Tuesday, before sprint review | featurebase_snapshot.py, committed | featurebase_snapshot_<date>.json | nobody — it is the baseline four weeks from now |
| Every Tuesday, in sprint review | feedback_change_report.py, --since 28 days, baseline four weeks back | reports/feedback_changes_<date>.md / .json / .html | sprint review: product + squads |
| First run, Tuesday 2026-08-25 | baseline featurebase_snapshot_2026-07-31.json | a hair under four weeks; a true four-week baseline exists from 2026-09-22 | sprint review |
| After each intake merge | same script, --since the merge date | the delta of that batch only | whoever ran the intake, as a QA check |
| Weekly, already in place | roadmap-feedback-review skill | one Confluence page per Next-up item | Lea, for per-page approval |

