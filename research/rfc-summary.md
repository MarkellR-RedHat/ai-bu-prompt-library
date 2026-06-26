# RFC Summary

A prompt for summarizing an RFC, design proposal, or architecture decision record into a structured format that helps reviewers quickly understand the proposal, identify the key tradeoffs, and decide how to engage.

**Difficulty:** Intermediate

## Naive vs. Engineered

Most people prompt something like this:

> **Naive prompt:** "Summarize this RFC for me."

**What you get:** Something like this:

> *This RFC proposes changes to the routing layer to improve performance. The author suggests implementing a new routing strategy that takes into account cache state. The proposal includes several design decisions and discusses some tradeoffs. Overall, the RFC addresses an important problem and the proposed solution seems reasonable. Reviewers should read the full document for details.*

A summary that could describe any routing RFC in any project. No mention of which tradeoffs the author made, what alternatives were rejected, which teams are affected, or whether the proposal is actually ready for implementation. You end up reading the full RFC anyway because the summary did not help you decide how to engage.

**This prompt** produces a structured breakdown that surfaces tradeoffs the author did not call out, flags gaps in the alternatives section, identifies which teams should review vs. skip, and gives you an honest assessment of whether the RFC is ready to move forward. For an llm-d KV-cache-aware routing RFC, that means calling out "the RFC does not address node scaling events when cache state is unavailable for new replicas" and recommending "Must review: Inference platform team (routing subsystem owners), SRE team (operational impact of cache state reporting). Can skip: Frontend and API teams (no API changes)." The difference: instead of a passive summary, you get an opinionated reviewer's brief that saves 30-60 minutes of reading time per RFC.

## When to use

- Reviewing an RFC or design doc before a review meeting and you need to get up to speed quickly.
- Sharing the key points of a long proposal (10+ pages) with your team so they can prepare for discussion.
- Deciding whether an RFC needs your detailed review or just an acknowledgment, based on its scope and impact.
- Catching up on RFCs you missed during a busy sprint and need to triage which ones require your input.
- Preparing to present someone else's RFC in a review meeting when the author is unavailable.
- Building a decision log by creating consistent summaries of past RFCs for future reference.

## When NOT to use

- You are writing the RFC itself. That requires your own design thinking and cannot be delegated to a summarization prompt.
- The RFC is short enough to read in 5-10 minutes. Just read it; a summary of a short document adds overhead without adding value.
- You need to provide detailed technical feedback on the design. Read the full RFC and comment directly on the sections that concern you.
- The RFC contains sensitive information (security architecture, incident details, personnel decisions) that should not be sent to an external AI service. Summarize it yourself.

## Prompt

```
You are a senior engineer who has reviewed hundreds of RFCs and design proposals. Your job
is to produce a structured summary that helps busy engineers decide how to engage with this
RFC: whether to read it in full, skim it, or skip it. The summary should capture not just
what is proposed, but the key design decisions, tradeoffs, risks, and open questions.

RFC Title: [RFC_TITLE]
Author(s): [AUTHORS]
Status: [STATUS, e.g., Draft, Under Review, Accepted, Rejected, Superseded]
Date: [DATE]
Link: [LINK]

Follow these steps carefully:

STEP 1: READ AND UNDERSTAND THE RFC
Read the entire RFC. Identify the central proposal, the problem it solves, and the key
design decisions the author made. Pay special attention to:
- The alternatives the author considered and rejected (this reveals the design space)
- The tradeoffs the author explicitly acknowledges
- The assumptions the proposal relies on
- Any dependencies on other teams, systems, or ongoing work

STEP 2: PRODUCE THE STRUCTURED SUMMARY
Use the following format exactly:

### One-Line Summary
State what is being proposed in plain language. A reader should be able to decide from
this sentence alone whether the RFC is relevant to them. Do not use jargon unless the
audience is guaranteed to understand it.

### Problem Statement (2-3 sentences)
What problem does this RFC solve? Why is the current state insufficient? Quantify the
impact where possible (latency, cost, error rates, developer productivity).

### Proposed Solution (4-6 sentences)
What is the proposed approach? Include the key architectural or design decisions.
Describe the solution at a level of detail that lets a reader understand the approach
without reading the full RFC. Call out which components are new, which are modifications
to existing systems, and which are unchanged.

### Alternatives Considered
List each alternative the RFC discusses. For each:
- One-sentence description of the alternative
- Why the author rejected it
- Your assessment of whether the rejection reasoning is sound

If the RFC does not discuss alternatives, flag this as a gap. Good RFCs always consider
at least two alternatives.

### Key Tradeoffs (3-5)
List the tradeoffs the proposal makes. For each tradeoff:
- **What is gained**: Be specific about the benefit and who receives it
- **What is given up**: Be specific about the cost and who bears it
- **Your assessment**: Is this a reasonable tradeoff given the context?

Tradeoffs are where the real design decisions live. If the RFC does not explicitly
discuss tradeoffs, identify the implicit ones.

### Open Questions
List any unresolved questions or areas where the RFC explicitly asks for feedback.
Add your own questions if you spot gaps the author did not address. Mark author questions
and your own questions separately so reviewers can distinguish them.

### Dependencies and Risks
What does this proposal depend on? Consider:
- Other teams or systems that need to change
- Timeline dependencies (does this block or get blocked by other work?)
- Technical risks (what could go wrong during implementation?)
- Operational risks (what could go wrong in production?)
- Rollback plan (does the RFC describe how to undo this change if it fails?)

### Impact Assessment
Who is affected by this change? Be specific about:
- Which systems need to be modified
- Which teams need to be involved in implementation
- Which workflows or APIs change for end users
- Whether this is a breaking change and how migration is handled
- Performance implications (latency, throughput, resource usage)

### Reviewer Recommendation
Based on the scope and impact of this RFC, recommend who should review it:
- **Must review**: Teams or roles that are directly affected and should read the full RFC
- **Should skim**: Teams or roles that are indirectly affected and should read this summary
- **Can skip**: Teams or roles that are not affected

### Summary Assessment
In 2-3 sentences, give your overall assessment of the RFC. Is the problem well-defined?
Is the proposed solution sound? Are there major gaps that need to be addressed before
the RFC can move forward?

STEP 3: SELF-CRITIQUE CHECKLIST
Before finalizing your summary, verify each of the following:
- [ ] The one-line summary is understandable without context
- [ ] The problem statement quantifies impact where possible
- [ ] You have identified tradeoffs even if the RFC does not state them explicitly
- [ ] Open questions distinguish between the author's questions and your own
- [ ] The impact assessment covers systems, teams, and users, not just technical components
- [ ] The reviewer recommendation is specific about roles and teams
- [ ] You have flagged any points where the RFC is ambiguous or incomplete
- [ ] The total summary stays under 500 words (excluding the alternatives section)

ANTI-PATTERNS TO AVOID:
1. Do not simply rephrase the RFC's own summary section. Add value by identifying
   tradeoffs, gaps, and implications the author did not call out.
2. Do not assume the RFC is correct. Evaluate whether the problem statement is
   well-defined and whether the solution actually addresses it.
3. Do not ignore the "Alternatives Considered" section. The rejected alternatives often
   reveal important constraints and design reasoning.
4. Do not provide a neutral summary with no assessment. Reviewers want your judgment
   on whether this RFC is ready to move forward.
5. Do not focus only on the happy path. Ask what happens when the proposed system
   fails, when assumptions are violated, or when usage exceeds planned capacity.
6. Do not skip the rollback plan assessment. RFCs that cannot be safely rolled back
   carry much higher risk and deserve more scrutiny.

EDGE CASES:
- If the RFC supersedes a previous RFC, briefly note what changed and why the previous
  approach was abandoned.
- If the RFC is marked as "Rejected" or "Withdrawn", summarize it anyway but focus on
  the reasons for rejection. This context is valuable for future proposals in the same area.
- If the RFC is a small, narrowly-scoped change (e.g., adding a configuration flag),
  shorten the summary accordingly. Not every RFC needs a full analysis.
- If the RFC spans multiple systems or teams, structure the impact assessment by
  team or system rather than as a flat list.
- If the RFC references external standards or specifications (e.g., an IETF draft,
  a CNCF spec), note the standard and its maturity level.
- If any bracketed placeholders (e.g., [RFC_TITLE], [PASTE_RFC_TEXT_OR_KEY_SECTIONS_HERE])
  are left unfilled, stop and list the missing inputs rather than generating a summary
  with placeholder values baked in. A summary built on unfilled placeholders is worse
  than no summary.
- If the RFC addresses a domain outside software (e.g., a hardware design RFC, an IETF
  network protocol standard, or a policy RFC from a standards body), adjust the summary
  structure accordingly. The "Alternatives Considered" and "Key Tradeoffs" sections still
  apply, but "Impact Assessment" may need to cover physical components, manufacturing
  constraints, or regulatory requirements instead of software systems and APIs.
- If the RFC is long enough to exceed the model's context window, paste the abstract,
  proposed solution, alternatives, and open questions sections first. Note in the summary
  that you worked from a partial text and flag any sections you did not review. Recommend
  the reader verify tradeoffs and risks against the full document.

Keep the total summary under 500 words (excluding alternatives section).
Use precise technical language. If the RFC is ambiguous on a point,
flag it rather than guessing.

RFC content:
[PASTE_RFC_TEXT_OR_KEY_SECTIONS_HERE]
```

## Why This Works

This prompt uses several techniques that compound to produce a dramatically better summary than a naive "summarize this" request:

- **Persona framing.** Opening with "You are a senior engineer who has reviewed hundreds of RFCs" anchors the model in the mindset of an experienced reviewer, not a generic summarizer. This shifts the output from passive description to active evaluation.

- **Chain-of-thought decomposition.** The three-step structure (read and understand, produce the summary, self-critique) forces the model to process the RFC in stages rather than rushing to output. Each step builds on the previous one, which reduces the chance of shallow or incomplete analysis.

- **Structured output formatting.** The rigid section format (One-Line Summary, Problem Statement, Alternatives, Key Tradeoffs, etc.) prevents the model from defaulting to a generic paragraph summary. It also makes the output scannable and consistent across different RFCs.

- **Anti-pattern avoidance.** Explicitly listing what NOT to do (do not rephrase the RFC's own summary, do not assume the RFC is correct, do not ignore alternatives) blocks the most common failure modes. Without these guardrails, models tend to produce polite, uncritical paraphrases.

- **Self-critique checklist.** The verification step at the end forces the model to audit its own output against concrete quality criteria. This catches gaps like missing quantification, vague reviewer recommendations, or summaries that exceed the word limit.

These techniques together explain the difference shown in the comparison above: the naive prompt lets the model take shortcuts, while this prompt channels its effort into the specific analysis that makes a summary actually useful.

## Usage Tips

- Paste the full RFC text if the model's context window allows it. For very long RFCs (20+ pages), paste the abstract, proposed solution, alternatives, and open questions sections. Skip appendices and detailed implementation specs on the first pass.
- Share the summary in your team's Slack channel or email thread before the review meeting so people can prepare. Attach the summary to the calendar invite for the review session.
- Use the "Key Tradeoffs" section to structure your review discussion. Tradeoffs are where the real design decisions live, and they generate the most productive review conversations.
- If the RFC has multiple alternatives, ask the model to summarize each alternative as if it were the proposed solution. This helps you evaluate whether the author chose the best option.
- Run this prompt on your own RFC before submitting it for review. If the summary reveals gaps or unclear tradeoffs, address them in the RFC before others find them.
- Keep a library of RFC summaries indexed by topic. Over time, this becomes a searchable decision log that helps you avoid revisiting decisions that were already made.
- When the "Alternatives Considered" section is empty or thin, treat that as a yellow flag. It usually means the author either did not explore the design space or is not sharing their reasoning.
- **Slash command connection:** If you use `ai-bu-claude-commands`, the `/summarize-thread` slash command can extract discussion context from related GitHub threads to complement the RFC summary.

## Example Output

> ### One-Line Summary
> Proposes replacing the current round-robin request router with a KV-cache-aware router that directs inference requests to nodes with warm caches, reducing prefill latency by 200-400ms per request.
>
> ### Problem Statement
> The current router distributes requests evenly across all serving replicas, ignoring cache state. This means most requests trigger a cold cache miss on the prefill phase, wasting 200-400ms per request and reducing overall throughput by approximately 30%. The problem is most severe for workloads with high prompt reuse (chatbots, RAG pipelines) where cache hit rates could theoretically reach 60-80%.
>
> ### Key Tradeoffs
> 1. **Gained**: Lower latency and higher throughput for workloads with prompt reuse. **Given up**: Added complexity in the routing layer, which now needs real-time cache state from every serving node. **Assessment**: Reasonable for our workload profile, but the cache state reporting mechanism needs more detail in the RFC.
> 2. **Gained**: Better GPU utilization on cache-heavy workloads by concentrating related requests. **Given up**: Less even load distribution, which could cause hot spots under bursty traffic patterns. **Assessment**: The RFC acknowledges this risk but does not quantify it. Reviewers should push for load simulation results.
> 3. **Gained**: Compatibility with existing serving backends (no engine changes required). **Given up**: Routing quality depends on cache eviction policies that the router does not control. **Assessment**: This is a fragile coupling. If the engine changes its eviction policy, routing quality degrades silently.
>
> ### Open Questions
> - **Author's question**: Should cache state be pushed from nodes or pulled by the router? The RFC leans toward push but asks for input on staleness tolerance.
> - **Author's question**: What is the acceptable overhead for cache state reporting? The RFC suggests less than 1% CPU overhead per node but has not benchmarked this.
> - **Reviewer question**: What happens during node scaling events when cache state is not yet available for new replicas? The RFC does not address this scenario.
> - **Reviewer question**: How does this interact with the planned multi-model serving work? If multiple models share a node, cache state reporting needs to be model-aware.
>
> ### Reviewer Recommendation
> - **Must review**: Inference platform team (routing subsystem owners), SRE team (operational impact of cache state reporting)
> - **Should skim**: ML engineering team (benefits from latency reduction but not involved in implementation)
> - **Can skip**: Frontend and API teams (no API changes in this proposal)
