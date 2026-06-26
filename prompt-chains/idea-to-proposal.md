# Idea to Proposal

Take a rough idea and develop it into a complete, structured proposal with an executive summary. This chain walks you through brainstorming to flesh out the idea, validating it against practical constraints, building an outline, writing the full proposal, and condensing it into an executive summary that decision-makers will actually read.

**Difficulty:** Intermediate

---

## Naive vs. Engineered

**What most people do:** Dump their idea into a single prompt and ask "write me a proposal." The result is a generic document that sounds plausible but lacks depth. The problem statement is vague, the solution section reads like a product brochure, the risks are hand-waved away, and the executive summary is just a shorter version of the same vague content.

**Why that falls flat:** Writing a good proposal requires at least five distinct thinking modes: creative exploration, critical analysis, structural design, persuasive writing, and ruthless compression. Asking a model to do all five in one pass means it never fully explores the idea before evaluating it, never fully evaluates it before structuring it, and never fully structures it before writing it. You get a document that looks like a proposal but does not survive scrutiny.

**What this workflow produces instead:** Each step does one job well. The brainstorm expands the idea without judging it. The validation stress-tests it without trying to fix it. The outline structures the argument without writing prose. The full proposal writes from a solid foundation. The executive summary compresses a complete argument, not a half-formed one.

The difference shows up in review meetings. Single-prompt proposals get questions the author cannot answer. Workflow-built proposals have already answered those questions in Step 2.

## When to Use

- You have a project idea, technical initiative, or process change that needs a written proposal to get buy-in.
- You want to pressure-test an idea before investing time in a polished document.
- You need to produce a proposal that is structured enough for leadership review and specific enough for engineering execution.

## When NOT to Use

- The idea is already well-defined and you just need to write it up. Skip to Step 3 (outline) or Step 4 (full proposal).
- You need a formal business case with financial modeling. This chain produces a technical/strategic proposal, not a finance document.
- The decision has already been made and you need a design document. A proposal argues for something; a design document specifies how to build it.

## Workflow Recipe

### What You Start With

- A rough idea: maybe a few sentences, maybe a few paragraphs, maybe just a problem you have been thinking about
- Some context about your team, audience, and constraints (even if incomplete)
- The need to turn this into a document that will convince someone to say yes

### What You End With

- A complete, structured proposal document ready for leadership review
- A 1-page executive summary that stands on its own
- An idea that has been pressure-tested against real constraints before you invested hours in polishing it

### The Steps

This workflow has five steps. Each step refines and builds on the previous one, moving from rough to polished.

1. **Brainstorm.** Expand the initial idea into a rich set of possibilities, angles, and implications. The goal is breadth, not polish. This step surfaces things you have not thought of yet. *Output: expanded scope, stakeholder map, open questions, and precedents.*

2. **Validate.** Pressure-test the brainstorm output against real-world constraints: technical feasibility, organizational readiness, risks, and competing alternatives. This is where weak ideas get strengthened or killed early. *Output: feasibility ratings, risk assessment, alternatives analysis, and a go/no-go verdict.*

3. **Outline.** Structure the surviving, validated ideas into a proposal outline with clear sections, arguments, and evidence needs. This step forces logical organization before prose. *Output: a detailed section-by-section outline with argument flow and evidence gaps identified.*

4. **Full proposal.** Write the complete proposal document based on the outline. This is the main deliverable. *Output: a polished markdown proposal document ready for review.*

5. **Executive summary.** Condense the full proposal into a 1-page summary for decision-makers. This step comes last because writing a good summary requires understanding the full argument. *Output: a 300-500 word executive summary that stands alone as a decision-support document.*

Running the validation step before the outline prevents a common failure: writing a polished proposal for an idea that falls apart under scrutiny. Better to discover problems in Step 2 than in a review meeting.

---

## Step 1: Brainstorm

```
You are a senior technical strategist helping an engineer or engineering
leader develop a rough idea into something concrete. Your job in this step
is to expand the idea, not to evaluate it. You should surface angles,
implications, adjacent possibilities, and questions that the person has
not considered yet.

Here is the initial idea:

<idea>
[DESCRIBE YOUR IDEA HERE. Include whatever you have: the problem you want
to solve, the approach you are considering, who it affects, and why you
think it matters. A few sentences to a few paragraphs is fine.]
</idea>

Additional context (fill in what you can):
- Organization/team: [who are you, what do you work on]
- Audience for the proposal: [who will read and approve it]
- Constraints you already know about: [budget, timeline, team size, etc.]
- Related work: [anything similar that has been tried before]

Produce the following:

1. IDEA RESTATEMENT (2-3 sentences): Restate the idea in your own words
   to confirm understanding. Be precise about what is being proposed and
   what problem it solves.

2. EXPANDED SCOPE: Identify 3-5 dimensions of the idea that the initial
   description did not address. For each dimension:
   - Name it (e.g., "user migration path," "backwards compatibility,"
     "team skills gap")
   - Explain why it matters
   - Suggest 2-3 possible approaches

3. ADJACENT IDEAS: List 2-3 related ideas or extensions that the initial
   idea naturally leads to. For each, note whether it strengthens or
   complicates the original proposal.

4. STAKEHOLDER MAP: Who cares about this idea? List the stakeholders,
   what each one cares about, and whether they are likely to support or
   resist the proposal. Include at least one stakeholder the proposer
   might not have thought of.

5. OPEN QUESTIONS (bulleted list): List 5-10 questions that need answers
   before this idea can become a proposal. Categorize each as:
   - MUST ANSWER: Blocks the proposal entirely if unanswered
   - SHOULD ANSWER: Strengthens the proposal significantly
   - NICE TO ANSWER: Adds depth but is not critical

6. ANALOGIES AND PRECEDENTS: Has something similar been done elsewhere
   (in the industry, in open source, at another company)? List 2-3
   precedents with a sentence about what can be learned from each.

OUTPUT FORMAT: Use the exact section headers above. The brainstorm should
be expansive and generative. Quantity matters more than polish at this stage.

ANTI-PATTERNS TO AVOID:
- Do not evaluate or critique the idea in this step. That happens in Step 2.
- Do not converge on a single approach. Keep multiple possibilities open.
- Do not write proposal-quality prose. Bullets and fragments are fine.
- Do not use em dashes. Use commas, semicolons, colons, or periods instead.
- Do not generate ideas that are disconnected from the original concept.
  Everything should trace back to the core idea.
```

---

> **CHECKPOINT: Review the brainstorm before proceeding.** Read through the expanded scope, stakeholder map, and open questions. Did the brainstorm surface angles you had not considered? Are the "must answer" questions actually answerable? If the brainstorm missed something important about your context, add it now. Do not evaluate the ideas yet; that is Step 2's job. Once you are satisfied with the breadth of exploration, paste the brainstorm output into Step 2.

## Step 2: Validate

```
You are a pragmatic engineering leader who has seen many proposals succeed
and fail. Your job is to stress-test this idea before it becomes a formal
proposal. You are constructive but honest. You would rather kill a weak idea
early than let it waste months of planning.

Here is the brainstorm output from the previous step:

<brainstorm>
[PASTE OUTPUT FROM STEP 1 HERE]
</brainstorm>

And here is the original idea for reference:

<original_idea>
[PASTE YOUR ORIGINAL IDEA DESCRIPTION HERE]
</original_idea>

Validate the idea against the following dimensions and produce your analysis:

1. TECHNICAL FEASIBILITY:
   - Can this be built with the team's current skills and tools?
   - What are the hardest technical problems, and are they solved problems
     or research problems?
   - What technical risks could derail the project?
   - Rate overall feasibility: high / medium / low. Justify in 2-3 sentences.

2. ORGANIZATIONAL READINESS:
   - Does the team or organization have the capacity to take this on?
   - What competing priorities would this displace?
   - Is there leadership appetite for this kind of change?
   - What organizational dependencies exist (other teams, vendor contracts,
     compliance requirements)?

3. COST-BENEFIT ANALYSIS (qualitative):
   - What are the expected benefits? Be specific and realistic.
   - What are the costs? Include time, money, opportunity cost, and
     complexity added to the system.
   - What is the payback period? When would the investment start paying off?
   - Is the ratio compelling enough to justify the proposal?

4. RISK ASSESSMENT: List the top 5 risks. For each:
   - Describe the risk
   - Rate likelihood: high / medium / low
   - Rate impact: high / medium / low
   - Suggest a mitigation strategy
   - Note whether the risk is acceptable, manageable, or a dealbreaker

5. ALTERNATIVES ANALYSIS: Describe 2-3 alternatives to this proposal,
   including "do nothing." For each:
   - What does it look like?
   - What are its advantages over the proposal?
   - What are its disadvantages?
   - Why might someone prefer it?

6. VALIDATION VERDICT: Based on your analysis, what is your recommendation?
   Choose one:
   - PROCEED: The idea is sound. Move to proposal.
   - PROCEED WITH CHANGES: The idea has merit but needs specific
     modifications. List them.
   - NEEDS MORE INFORMATION: Cannot validate without answers to specific
     questions. List them.
   - DO NOT PROCEED: The idea has fundamental problems. Explain why and
     suggest what to do instead.

OUTPUT FORMAT: Use the exact section headers above. Be direct. If the idea
is weak, say so plainly and explain why. If it is strong, say so and identify
what could still go wrong.

ANTI-PATTERNS TO AVOID:
- Do not be a "yes and" generator. This step is about finding problems.
- Do not be vague about risks. "There might be challenges" is not a risk
  assessment.
- Do not compare to idealized alternatives. Compare to realistic ones,
  including the status quo.
- Do not use em dashes anywhere in your output.
- Do not evaluate feasibility based on a perfect team. Evaluate based on
  the actual team, timeline, and constraints described in the brainstorm.
```

---

> **CHECKPOINT: Decide whether to proceed.** This is the most important checkpoint. If the validation verdict says "do not proceed," take that seriously. If it says "proceed with changes," make those changes to the brainstorm output before moving on. If specific risks were flagged as dealbreakers, address them now or accept them explicitly. This is cheaper than discovering them in a review meeting. Once you have a clear "proceed" signal, paste outputs from Steps 1 and 2 into Step 3.

## Step 3: Outline

```
You are a proposal architect. You design document structures that guide
the reader from "why should I care" to "here is what I need to decide"
in a logical, compelling sequence. You understand that a well-structured
outline makes the difference between a proposal that gets read and one
that gets skimmed.

Here is the brainstorm and validation from previous steps:

<brainstorm>
[PASTE OUTPUT FROM STEP 1 HERE]
</brainstorm>

<validation>
[PASTE OUTPUT FROM STEP 2 HERE]
</validation>

Design a proposal outline and produce the following:

1. PROPOSAL TITLE: A clear, descriptive title. Not clever, not vague.
   The reader should know what the proposal is about from the title alone.

2. DOCUMENT METADATA:
   - Author(s)
   - Date
   - Status (Draft / In Review / Approved)
   - Decision needed by (date)
   - Approver(s)

3. SECTION OUTLINE: For each section, provide:
   - Section title
   - Purpose (why this section exists, in one sentence)
   - Key points to cover (bulleted list, 3-5 items)
   - Evidence or data needed (what facts, metrics, or references should
     support this section)
   - Estimated length (in paragraphs or page fraction)

   The outline should include these sections at minimum, though you may
   add or reorder based on the specific proposal:
   - Problem statement
   - Proposed solution
   - Technical approach
   - Implementation plan (phases, milestones, timeline)
   - Resource requirements (people, budget, tools)
   - Risk mitigation
   - Success criteria and metrics
   - Alternatives considered

4. ARGUMENT FLOW: In 3-5 sentences, describe the logical flow of the
   proposal. How does each section build on the previous one? What is
   the persuasive arc?

5. EVIDENCE GAPS: What data, metrics, or references do you need to
   gather before writing the full proposal? For each gap:
   - What is needed
   - Why it matters
   - Where to find it or how to generate it
   - What to do if it is unavailable (fallback approach)

6. KEY DECISIONS FOR THE READER: What specifically are you asking the
   reader to decide? List each decision point explicitly. Proposals
   fail when the reader finishes and thinks "this is interesting,
   but what do you want me to do?"

OUTPUT FORMAT: Use the exact section headers above. The outline should
be detailed enough that someone else could write the proposal from it.

ANTI-PATTERNS TO AVOID:
- Do not create an outline that is just a generic proposal template.
  Every section should be specific to this idea.
- Do not include sections that have no content to fill them. An empty
  "Market Analysis" section weakens the whole document.
- Do not bury the ask. The reader should know what you want within the
  first page.
- Do not use em dashes. Use commas, semicolons, colons, or periods instead.
- Do not outline a 20-page proposal when a 5-page proposal would suffice.
  Match the depth to the decision being made.
```

---

> **CHECKPOINT: Refine the outline before writing.** Does the section order build a logical argument? Are the "evidence gaps" things you can actually fill in? Does the outline match your organization's proposal format, or do you need to add or remove sections? If your organization has a specific template, adjust the outline now. It is much easier to restructure an outline than to restructure a finished document. Once the outline is solid, paste outputs from Steps 1, 2, and 3 into Step 4.

## Step 4: Full Proposal

```
You are a senior technical writer who produces clear, persuasive, and
well-structured proposals for engineering organizations. You write in a
direct, professional tone without jargon, buzzwords, or filler. Every
sentence in your proposals earns its place.

Here is the complete context from previous steps:

<brainstorm>
[PASTE OUTPUT FROM STEP 1 HERE]
</brainstorm>

<validation>
[PASTE OUTPUT FROM STEP 2 HERE]
</validation>

<outline>
[PASTE OUTPUT FROM STEP 3 HERE]
</outline>

Write the full proposal following the outline from Step 3. Adhere to
these guidelines:

WRITING STANDARDS:
- Lead with the problem and its impact. The reader should care about the
  problem before hearing about the solution.
- Be specific. Replace "significant improvement" with "40% reduction in
  deploy time based on benchmarks from the pilot." If you do not have
  exact numbers, use reasonable estimates and label them as such.
- Address risks and alternatives honestly. Proposals that ignore
  counterarguments lose credibility.
- Use short paragraphs (3-5 sentences). Dense walls of text do not get read.
- Use headers, bullets, and tables to make the document scannable.
- Write for the decision-maker, not for yourself. They care about impact,
  cost, risk, and timeline, in roughly that order.

SECTION-SPECIFIC GUIDANCE:
- PROBLEM STATEMENT: Quantify the pain. How much time, money, or
  reliability is being lost? Who feels the pain most?
- PROPOSED SOLUTION: Describe what you want to build or change. Be
  concrete about scope: what is included and what is explicitly not included.
- TECHNICAL APPROACH: Enough detail to demonstrate feasibility, not enough
  to be a design document. Reference existing systems, tools, or patterns.
- IMPLEMENTATION PLAN: Break into phases. Each phase should deliver
  something usable or measurable. No "Phase 1: Research" unless the
  research has specific deliverables.
- RESOURCE REQUIREMENTS: Be honest about what this costs. Underestimating
  erodes trust.
- RISK MITIGATION: For each risk from the validation step, describe the
  specific mitigation and who is responsible for it.
- SUCCESS CRITERIA: Define measurable outcomes. "Improved developer
  experience" is not a success criterion. "Reduction in mean time to
  deploy from 45 minutes to under 15 minutes" is.
- ALTERNATIVES CONSIDERED: Present alternatives fairly, then explain why
  you recommend this approach.

OUTPUT FORMAT: Produce a complete markdown document. Use H1 for the title,
H2 for major sections, H3 for subsections. Include a metadata block at
the top (author, date, status, decision deadline). The document should be
ready for review after a human editing pass.

ANTI-PATTERNS TO AVOID:
- Do not use filler phrases: "It is worth noting that," "In order to,"
  "At the end of the day." Cut to the point.
- Do not hedge excessively. "This might possibly help reduce some latency"
  should be "This reduces p99 latency by an estimated 30%."
- Do not write a sales pitch. Proposals persuade with evidence, not
  enthusiasm.
- Do not use em dashes anywhere in the document. Use commas, periods,
  semicolons, or colons instead.
- Do not use hype words: "revolutionary," "game-changing," "best-in-class,"
  "cutting-edge," "next-generation." Describe what it does.
- Do not leave placeholder text in the final output unless you genuinely
  do not have the information. Fill in reasonable estimates and label them.
```

---

> **CHECKPOINT: Review the full proposal before summarizing.** Read the proposal as your decision-maker would. Is the problem statement compelling? Is the ask clear? Are the cost and timeline estimates honest? Would you fund this based on what is written? Mark sections that need strengthening, but focus on substance over style. The executive summary can only be as good as the proposal it summarizes. Once the proposal is solid, paste it into Step 5.

## Step 5: Executive Summary

```
You are a communications specialist who writes executive summaries for
technical proposals. You understand that the executive summary is often
the only part of a proposal that senior leaders read in full, so it must
stand on its own. Your summaries are concise, precise, and structured for
fast decision-making.

Here is the full proposal:

<full_proposal>
[PASTE OUTPUT FROM STEP 4 HERE]
</full_proposal>

Write an executive summary that fits on a single page (approximately
300-500 words). Structure it as follows:

1. THE PROBLEM (2-3 sentences): What is broken, missing, or at risk?
   Include one specific metric or data point that makes the problem
   concrete.

2. THE PROPOSAL (2-3 sentences): What are you proposing? Be specific
   about the deliverable, not just the activity. "Build X" is better
   than "invest in improving Y."

3. EXPECTED IMPACT (2-3 sentences): What changes if this is approved?
   Quantify where possible. Reference specific metrics, timelines,
   or outcomes from the full proposal.

4. COST AND TIMELINE (2-3 sentences): What does this require? Include
   people, money, and time. If the proposal is phased, summarize the
   first phase specifically and the full timeline in general terms.

5. KEY RISKS (2-3 sentences): What are the biggest risks, and how are
   they mitigated? Do not list every risk; pick the 1-2 that the
   decision-maker will worry about most.

6. THE ASK (1-2 sentences): What specific decision or action do you need
   from the reader? Be explicit. "Approve funding for Phase 1" or
   "Allocate two engineers for Q3" is what you want here.

ADDITIONAL REQUIREMENTS:
- The summary must stand alone. A reader who never opens the full proposal
  should understand the situation, the recommendation, and what they need
  to do.
- Every claim in the summary must be supported by content in the full
  proposal. Do not introduce new information.
- Use the same terminology as the full proposal. Do not rephrase technical
  terms for a "non-technical audience" unless the proposal itself does.

OUTPUT FORMAT: Produce the executive summary as a single markdown section
with an H1 title: "Executive Summary: [Proposal Title]". Use bold text
for section labels within the summary (e.g., **The Problem:**). Do not
use sub-headers; the summary should read as flowing prose with labeled
paragraphs.

ANTI-PATTERNS TO AVOID:
- Do not write a miniature version of the full proposal. The executive
  summary is a decision-support document, not an abridgment.
- Do not use vague language to avoid committing to numbers. If the full
  proposal says "30% improvement," the summary should say "30% improvement."
- Do not end without a clear ask. The reader should know exactly what
  you need from them.
- Do not use em dashes anywhere. Use commas, periods, semicolons, or
  colons instead.
- Do not use superlatives or hype words. Let the numbers and logic do
  the persuading.
```

---

## Why This Works

Prompt chaining produces better proposals than a single prompt for three specific reasons.

**Creative and critical thinking are separated.** Step 1 brainstorms without judging. Step 2 judges without brainstorming. When you ask a model to do both at once, it self-censors during ideation and pulls punches during evaluation. Separating the two lets each mode operate at full strength.

**The idea is validated before the document is written.** Most proposal failures happen because the underlying idea has a fatal flaw that a polished document only obscures. Step 2 surfaces these flaws while the cost of changing direction is low. By the time you reach Step 4, you are writing about a tested idea, not an untested one.

**Compression happens last, not first.** When you write a summary and a proposal in one prompt, the model tends to write the summary first (in its head) and then pad it to fill the proposal. This workflow inverts that: the full argument is built first, then compressed. That is why the executive summary actually stands on its own instead of just being the introduction repeated.

## Tips for Running This Workflow

- **Spend time on the initial idea description.** The more context you provide in Step 1, the better the brainstorm and every subsequent step will be. Include the problem, your proposed approach, who cares, and any constraints you know about.
- **Do not skip Step 2 (validation).** It is tempting to jump from brainstorm to outline, but the validation step is where bad ideas get caught. If the validation says "do not proceed," listen to it or address the specific concerns before continuing.
- **Fill in the "additional context" fields.** The brainstorm step asks for your team, audience, and constraints. Filling these in makes the output dramatically more relevant.
- **Edit between steps when needed.** If the validation identifies a change to the idea, update the brainstorm output before passing it to Step 3. The chain works best when each step gets accurate input.
- **Adjust the outline to your organization.** Step 3 produces a standard proposal structure. If your organization has a specific template or required sections, modify the outline before running Step 4.
- **Run Step 5 last, always.** Writing the executive summary before the full proposal almost always produces a vague summary that oversells. Write the full argument first; condense second.
- **Review with a colleague before submitting.** The chain produces a strong draft, but proposals benefit from a human reviewer who knows the organizational context, the politics, and the decision-maker's priorities.

## Example

Below is an abbreviated example showing output from Steps 1 and 2 for a hypothetical proposal to adopt an internal developer platform.

### Example Step 1 Output

> **IDEA RESTATEMENT:** Build an internal developer platform (IDP) that standardizes how engineering teams provision infrastructure, deploy services, and manage environments. The goal is to reduce the time engineers spend on operational tasks and eliminate inconsistencies across teams that currently manage their own tooling.
>
> **EXPANDED SCOPE:**
>
> - **Scope of standardization:** Does the IDP replace all existing team-specific tooling, or does it provide a common baseline that teams can extend? This matters because a heavy-handed approach will face resistance from teams with mature, working setups.
>   - Option A: Full replacement with migration path
>   - Option B: Common baseline with optional extensions
>   - Option C: Opt-in adoption with incentives
>
> - **Self-service vs. managed:** Does the platform team operate the IDP for other teams, or do teams operate it themselves? This determines the size of the platform team.
>   - Option A: Fully managed by platform team
>   - Option B: Self-service with platform team support
>   - Option C: Self-service with documentation only
>
> - **Build vs. buy:** Is this a custom-built platform, an integration of existing tools (Backstage, Humanitec, etc.), or a hybrid?
>   - Option A: Build custom on Kubernetes
>   - Option B: Adopt Backstage and build plugins
>   - Option C: Buy a commercial platform and configure it
>
> **STAKEHOLDER MAP:**
> - Engineering teams (users): Want less operational burden. Likely to support if the platform is genuinely easier than what they have. Will resist if adoption is mandated before the platform is ready.
> - Engineering leadership: Wants consistency and faster delivery. Likely to support.
> - Platform team (if it exists): Wants clear ownership and adequate staffing. Needs to be involved early.
> - Security and compliance: Wants standardized guardrails. Likely to support if they get input on policies.
> - Finance: Wants to understand cost. May resist if the ROI case is not clear.

### Example Step 2 Output

> **TECHNICAL FEASIBILITY:**
> The IDP concept is well-established in the industry. Tools like Backstage (open source) and Humanitec (commercial) provide foundations that reduce the build-from-scratch risk. The hardest technical problem is integrating with existing CI/CD pipelines across 12 teams that use 4 different deployment tools. This is a solved problem conceptually, but the integration work is significant.
>
> Rating: **Medium.** Feasible with existing skills, but the integration scope is large and underestimated in the initial idea.
>
> **ORGANIZATIONAL READINESS:**
> The organization does not currently have a platform team. Creating one requires hiring or reassigning 3-4 engineers, which competes with product delivery commitments. Leadership has expressed interest in platform engineering but has not allocated headcount.
>
> **RISK ASSESSMENT:**
>
> | Risk | Likelihood | Impact | Mitigation |
> |---|---|---|---|
> | Teams resist adoption because the platform does not support their workflows | High | High | Start with 2-3 early adopter teams; build for their needs first |
> | Platform team is understaffed and becomes a bottleneck | Medium | High | Define clear scope; say no to customization requests outside scope |
> | Existing tooling is too diverse to standardize without breaking things | Medium | Medium | Audit existing tooling before committing to a technical approach |
> | Cost exceeds initial estimates | Medium | Medium | Phase the rollout; fund Phase 1 only and evaluate before continuing |
> | Platform becomes "another tool to maintain" rather than reducing burden | Low | High | Measure developer time spent on ops before and after; kill the project if it does not improve |
>
> **VALIDATION VERDICT:** PROCEED WITH CHANGES.
> The idea is sound but needs two modifications before it becomes a proposal:
> 1. Scope Phase 1 to 2-3 early adopter teams, not a company-wide rollout.
> 2. Include a build-vs-buy analysis as a key section. The choice between Backstage, a commercial tool, and custom-built affects every other aspect of the proposal.
