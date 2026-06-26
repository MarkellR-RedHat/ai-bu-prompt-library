# Executive Brief

Distill a complex technical topic into a 1-page executive brief that gives a non-technical leader enough context to make decisions or have informed conversations.

**Difficulty:** Intermediate

## When to use
- Briefing an executive on a technical initiative before a review meeting
- Summarizing a complex project for a skip-level or VP audience
- Preparing a one-pager for a budget or investment decision
- Translating a technical RFC into language leadership can act on

## When NOT to use
- The audience is technical and wants implementation details (share the RFC or design doc directly)
- You need a full business case with financial modeling (work with your PM or finance partner)
- The topic is straightforward and can be explained in a Slack message

## Prompt

```
You are a senior technical leader preparing a one-page executive brief. Distill the following topic into a clear, decision-ready document for a non-technical executive.

Topic: [TOPIC]
Audience: [AUDIENCE, e.g., VP of Engineering, CTO, product leadership, executive staff]
Decision or action needed: [DECISION, e.g., "approve funding for Q3," "align on technical direction," "no decision needed, awareness only"]
Context the audience already has: [PRIOR_CONTEXT, e.g., "aware of the project at a high level," "no prior exposure," "attended the kickoff meeting"]

Structure the brief as follows:

1. **Bottom line up front** (2-3 sentences): State the most important thing the executive needs to know. If a decision is needed, state the recommendation.
2. **Background** (3-4 sentences): What is this project or initiative? Why does it exist? What problem does it solve? Keep it jargon-free.
3. **Current status**: Where does the project stand today? Use a clear status indicator (On Track, At Risk, Blocked) and 2-3 key facts.
4. **Key tradeoffs or decisions** (2-3 items): What are the major tradeoffs the team is navigating? For each, briefly state the options and the team's recommendation.
5. **What we need** (1-3 items): What does the team need from this audience? Be specific: budget, headcount, a decision, air cover, or nothing.
6. **Risks** (2-3 items): What could go wrong, and what is the team doing about it?
7. **Timeline**: Key milestones with dates.

Constraints:
- Keep the entire brief under 500 words. Executives will not read more than one page.
- No jargon. If you must use a technical term, define it in parentheses.
- Lead every section with the most important information. Assume the reader might stop reading at any point.
- Do not use em dashes. Use commas, periods, or "and" instead.

Raw information:
[PASTE_RAW_NOTES_DOCS_OR_CONTEXT_HERE]
```

## Usage Tips

- The "Bottom line up front" section is the most important part. If the executive reads nothing else, that section should stand on its own.
- Paste in raw notes, design docs, or status updates. The prompt handles unstructured input well.
- If no decision is needed, say so explicitly in the "What we need" section. Executives appreciate knowing when something is informational only.
- For recurring briefs, keep the same format each time so the reader can scan quickly.

## Example Output Snippet

> **Bottom line up front**: The inference platform (llm-d) is on track for GA in Q3. We are requesting approval for 4 additional GPU nodes ($180K) to support the beta load test scheduled for July 15. Without the additional capacity, the load test will be limited to 2x production traffic instead of the planned 10x.
>
> **Background**: llm-d is an open source platform that runs LLM inference on OpenShift. It reduces GPU costs by routing requests to nodes with warm caches instead of cold-starting each request. The platform team has been building it for 6 months and currently runs 3 internal models in pre-production.
>
> **What we need**:
> - Approval for $180K in GPU node procurement by July 1.
> - Confirmation that the GA target of September 15 aligns with the product launch calendar.
