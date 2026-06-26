# Executive Brief

Distill a complex technical topic into a one-page executive brief that gives a non-technical leader enough context to make decisions, ask sharp questions, or have informed conversations.

**Difficulty:** Intermediate

## When to use

- Briefing an executive on a technical initiative before a review meeting or QBR
- Summarizing a complex project for a skip-level, VP, or C-level audience
- Preparing a one-pager for a budget, headcount, or investment decision
- Translating a technical RFC or architecture proposal into language leadership can act on
- Providing a status update on a multi-quarter program where the audience needs the signal, not the noise
- Bringing a new stakeholder up to speed quickly on an initiative they just inherited
- Framing a risk escalation so leadership understands severity, blast radius, and recommended action

## When NOT to use

- The audience is technical and wants implementation details (share the RFC or design doc directly)
- You need a full business case with financial modeling, ROI analysis, or competitive benchmarks (work with your PM or finance partner)
- The topic is straightforward enough that a Slack message or two-line email covers it
- You are writing for a blog, conference talk, or public audience (use a different format tuned for that context)

## Prompt

```
You are a senior technical leader at a large enterprise software company. You have
deep expertise in translating complex engineering work into concise, decision-ready
communication for executives. Your writing style is direct, factual, and free of hype
or filler. You never pad content to look impressive. You cut to what matters.

Your task: take the raw inputs below and produce a one-page executive brief. Follow
the reasoning steps and constraints carefully.

=== INPUTS ===
Topic: [TOPIC]
Audience: [AUDIENCE, e.g., VP of Engineering, CTO, product leadership, executive staff]
Decision or action needed: [DECISION, e.g., "approve funding for Q3," "align on
  technical direction," "no decision needed, awareness only"]
Context the audience already has: [PRIOR_CONTEXT, e.g., "aware of the project at a
  high level," "no prior exposure," "attended the kickoff meeting"]
Raw information (paste notes, docs, status updates, or context):
[PASTE_RAW_NOTES_DOCS_OR_CONTEXT_HERE]

=== STEP-BY-STEP REASONING ===
Before writing the brief, work through these steps internally:

Step 1 - Identify the core message. Ask yourself: if the executive reads one sentence
  and walks away, what must that sentence say? Write it down as a candidate "bottom
  line up front" statement.

Step 2 - Determine the audience's mental model. Based on the audience and their prior
  context, decide what background they need and, equally important, what they do NOT
  need. Cut anything that only matters to engineers.

Step 3 - Extract decisions and tradeoffs. From the raw information, identify the key
  decisions the team faces or needs the executive to weigh in on. For each, articulate
  the options and the team's recommendation. If no decision is needed, state that
  explicitly.

Step 4 - Assess risks honestly. Identify what could go wrong. For each risk, note the
  likelihood (high, medium, low), the impact, and what the team is doing to mitigate it.
  Do not hide risks to make the brief look good.

Step 5 - Draft the brief using the output format below.

Step 6 - Run the self-critique checklist (see below) and revise before delivering.

=== OUTPUT FORMAT ===
Structure the brief with these sections, in this order:

1. **Bottom line up front** (2-3 sentences)
   State the single most important thing the executive needs to know. If a decision is
   needed, state the recommendation clearly. This section must stand completely on its
   own.

2. **Background** (3-5 sentences)
   What is this initiative? Why does it exist? What problem does it solve for customers
   or for the business? Keep it jargon-free. If you must use a technical term, define
   it in parentheses immediately after.

3. **Current status**
   Lead with a clear status indicator: On Track, At Risk, or Blocked. Follow with 2-4
   key facts that justify that status. Use bullet points for scannability.

4. **Key tradeoffs or decisions** (2-4 items)
   For each tradeoff, briefly state the options, the team's recommendation, and why.
   Number them so the executive can reference them easily in discussion.

5. **What we need** (1-3 items)
   What does the team need from this audience? Be specific: budget amount, headcount,
   a decision by a certain date, air cover, or nothing at all. If the brief is purely
   informational, say "No action required. This brief is for awareness."

6. **Risks** (2-4 items)
   What could go wrong? For each risk, state the risk, its likelihood and impact, and
   the mitigation. Use a consistent format:
   - Risk: [description] | Likelihood: [H/M/L] | Impact: [H/M/L] | Mitigation: [action]

7. **Timeline**
   List key milestones with target dates. Use a bulleted list. Bold the dates. Flag any
   milestones that are at risk.

=== SELF-CRITIQUE CHECKLIST ===
Before delivering the final brief, verify each of the following. If any check fails,
revise the brief until it passes.

- [ ] The "Bottom line up front" section makes sense if read in complete isolation.
- [ ] The entire brief is under 500 words. Executives will not read more than one page.
- [ ] Every section leads with the most important information first. Assume the reader
      may stop reading at any point.
- [ ] No jargon is used without a parenthetical definition.
- [ ] The "What we need" section is specific and actionable, not vague.
- [ ] Risks are stated honestly, not minimized or buried.
- [ ] The brief contains no marketing language, buzzwords, or unsupported superlatives
      (e.g., "groundbreaking," "game-changing," "best-in-class").
- [ ] The tone is confident and direct, not hedging or apologetic.
- [ ] All dates and numbers are concrete, not placeholders like "soon" or "significant."

=== ANTI-PATTERNS TO AVOID ===
1. Leading with background instead of the bottom line. Executives want the answer first,
   then the context. Never bury the lead.
2. Using jargon or acronyms without definitions. "We migrated to a kube-native
   inference stack" means nothing to a VP of Product. Translate everything.
3. Providing a wall of text with no structure. Use headers, bullets, and whitespace so
   the brief is scannable in 30 seconds.
4. Being vague about what you need. "We could use more support" is not actionable.
   "We need 4 additional GPU nodes ($180K) approved by July 1" is.
5. Omitting risks or sugarcoating them. Executives will lose trust if problems surface
   later that were known but not disclosed.
6. Including implementation details the audience cannot act on. The executive does not
   need to know which Kubernetes operator you chose. They need to know whether the
   project is on track and what decisions require their input.
7. Using em dashes. Use commas, periods, semicolons, colons, or "and" instead.
8. Padding the brief with filler to make it look thorough. Shorter is better. Every
   sentence must earn its place.

=== EDGE CASE HANDLING ===
- If the raw information is vague or incomplete, flag the gaps explicitly in the brief
  rather than guessing. Write: "Note: the following areas need clarification from the
  team before this brief is finalized: [list gaps]."
- If no decision is needed, still include the "What we need" section with "No action
  required. This brief is for awareness only."
- If the project is in early stages with limited data, say so. Do not fabricate
  timelines or metrics. Use "TBD, pending [milestone]" where appropriate.
- If there are competing recommendations from different teams, present both fairly and
  note which one the authoring team recommends and why.
- If the topic is sensitive (layoffs, security incidents, legal exposure), flag that the
  brief should be treated as confidential and note any distribution restrictions.
```

## Usage Tips

- The "Bottom line up front" section is the single most important part of the brief. If the executive reads nothing else, that section must stand on its own. Spend extra time getting it right.
- Paste in raw, unstructured input. Meeting notes, Slack threads, design docs, and status updates all work well. The prompt is designed to distill messy information into clean structure.
- If no decision is needed, say so explicitly. Executives appreciate knowing when something is informational only, because it changes how they read and prioritize the document.
- For recurring briefs (weekly program updates, quarterly reviews), keep the same format each time. Consistency lets the reader scan quickly and spot changes.
- Run the output through a "so what?" test. For every sentence, ask: does the executive need this to make a decision or understand the situation? If not, cut it.
- When multiple stakeholders will read the brief, optimize for the most senior person in the distribution list. Everyone else can handle content that is slightly above their level, but an overly technical brief will lose the senior reader.
- Test readability by reading the brief out loud. If any sentence requires a second read to parse, rewrite it.

## Example Output

> **Bottom line up front**
>
> The inference platform (llm-d) is on track for GA in Q3. We are requesting approval for 4 additional GPU nodes ($180K) to support the beta load test scheduled for July 15. Without the additional capacity, the load test will be limited to 2x production traffic instead of the planned 10x, which would leave a significant gap in our confidence for GA readiness.
>
> **Background**
>
> llm-d is an open source platform that runs large language model (LLM) inference workloads on OpenShift. It reduces GPU costs by intelligently routing requests to nodes that already have the model loaded in memory, avoiding expensive cold starts. The platform team has been building it for 6 months and currently runs 3 internal models in pre-production. Adoption is a strategic priority because it enables Red Hat customers to run AI workloads on their existing OpenShift infrastructure rather than relying on third-party inference APIs.
>
> **Current status**: On Track
>
> - Core routing engine passed performance benchmarks in May, processing 1,200 requests per second with p99 latency under 400ms.
> - 3 internal teams are running pre-production workloads. Two have committed to GA adoption.
> - Beta program launches July 15 with 6 external customers confirmed.
>
> **Key tradeoffs or decisions**
>
> 1. **Load test scope**: We can run the load test at 2x production traffic with current hardware or at 10x with 4 additional nodes. The team recommends 10x because our GA SLA commits to handling traffic spikes of up to 8x, and we need to validate that before going live.
> 2. **Multi-cluster support**: We can ship GA with single-cluster support only (lower risk, faster delivery) or include multi-cluster (higher value, 3-week delay). The team recommends single-cluster for GA and multi-cluster in the first dot release, targeting October.
>
> **What we need**
>
> - Approval for $180K in GPU node procurement by July 1.
> - Confirmation that the GA target of September 15 aligns with the product launch calendar.
>
> **Risks**
>
> - Risk: GPU node procurement lead time exceeds 3 weeks | Likelihood: M | Impact: H | Mitigation: Procurement team has pre-negotiated pricing with two vendors; PO can be issued within 48 hours of approval.
> - Risk: Beta customer onboarding takes longer than planned due to environment differences | Likelihood: M | Impact: M | Mitigation: Dedicated SE assigned to each beta customer with pre-built onboarding runbooks.
> - Risk: Upstream Kubernetes dependency (v1.30) ships with breaking change to device plugin API | Likelihood: L | Impact: H | Mitigation: Team is tracking the KEP and has a fallback patch ready if needed.
>
> **Timeline**
>
> - **July 1**: GPU procurement approved
> - **July 15**: Beta load test begins
> - **August 1**: Beta feedback synthesis complete
> - **August 15**: Release candidate cut
> - **September 15**: GA release
