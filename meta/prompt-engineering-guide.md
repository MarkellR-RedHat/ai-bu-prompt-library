# Prompt Engineering Guide

Everything you need to know about writing prompts that actually work. This guide walks through every technique used in this prompt library, with real examples and before/after comparisons showing why each one matters.

If you use AI tools every day and your results are "okay but not great," this will show you exactly what is missing. The gap between mediocre prompts and engineered prompts comes down to a set of specific, learnable techniques that make the model work harder and produce output you can actually use.

Every prompt in this library applies these techniques. Here is how they work, why they work, and how to apply them yourself.

## Technique Quick Reference

| # | Technique | What It Does | See It In Action |
|---|-----------|-------------|------------------|
| 1 | Role and Context Setting | Grounds the model in a specific expertise and situation | [Blog Intro](../content/blog-intro.md), [Architecture Review](../engineering/architecture-review.md) |
| 2 | Chain-of-thought Reasoning | Forces the model to reason through problems step by step | [Root Cause Analysis](../analysis/root-cause.md), [Debug Helper](../engineering/debug-helper.md) |
| 3 | Output Format Specification | Locks the output into a consistent, scannable structure | [Stakeholder Update](../communication/stakeholder-update.md), [OKR Writer](../strategy/okr-writer.md) |
| 4 | Self-critique and Verification | Makes the model check its own work before delivering | [Code Review](../engineering/code-review.md), [Blog Intro](../content/blog-intro.md) |
| 5 | Anti-pattern Avoidance | Blocks common failure modes by telling the model what NOT to do | [Feedback Draft](../leadership/feedback-draft.md), [Stakeholder Update](../communication/stakeholder-update.md) |
| 6 | Edge Case Handling | Tells the model how to behave when inputs are unusual | [Debug Helper](../engineering/debug-helper.md), [OKR Writer](../strategy/okr-writer.md) |
| 7 | Placeholder Design | Makes prompts reusable and self-documenting | [Executive Brief](../communication/exec-brief.md), [Architecture Review](../engineering/architecture-review.md) |

## Core Techniques

### 1. Role and Context Setting

Tell the model who it is, what situation it is operating in, and who the audience is. This grounds the response and constrains it to a useful domain.

**Pattern:**

```
You are a [ROLE] with expertise in [DOMAIN].
You are working with [AUDIENCE] who need [OUTCOME].
```

**Why it works:** Telling the model who it is changes what it produces. A prompt that says "You are a senior site reliability engineer" pulls from different training patterns than one that says nothing about role. The model learned from text written by many different types of professionals. When you specify which one to emulate, you get that domain's language, reasoning, and conventions.

#### Before and After

**Before (no role):**
```
Write an introduction for a blog post about Kubernetes GPU scheduling.
```
What you get: A generic paragraph that opens with "In today's rapidly evolving cloud landscape..." and meanders through vague statements about GPU computing. No specificity, no hook, no reason for the reader to continue.

**After (with role and context):**
```
You are a senior technical writer at a major infrastructure company with
deep experience writing for engineering audiences. Your job is to write a strong introduction
(4-7 sentences) for a blog post.

TOPIC: How llm-d schedules GPU inference workloads on Kubernetes
AUDIENCE: Platform engineers running Kubernetes clusters with GPU nodes
```
What you get: A tight introduction that opens with the specific pain of GPU scheduling on Kubernetes, names concrete problems the audience has experienced (custom operators, resource hacks, manual node pinning), and sets up the article with a clear scope.

#### Real Example from the Library

The [Blog Intro](../content/blog-intro.md) prompt opens with:

> `You are a senior technical writer at a major infrastructure company with deep experience writing for engineering audiences.`

This is not just a generic role. It specifies seniority (which calibrates quality expectations), the kind of company (which sets organizational context), and the audience (engineering, not marketing). Compare this to the [Root Cause Analysis](../analysis/root-cause.md) prompt:

> `You are a senior site reliability engineer with 15+ years of experience conducting blameless post-mortems and root cause analyses in large-scale distributed systems.`

The role here is even more specific: it includes years of experience, the specific skill (blameless post-mortems), and the operating environment (large-scale distributed systems). That level of specificity is what gets you domain-appropriate language, frameworks (5 Whys, Ishikawa), and reasoning patterns in the output.

**Guidelines:**
- Be specific about the role. "Engineer" is too broad. "Senior platform engineer specializing in Kubernetes networking" is useful.
- Include the audience. A response for a VP is different from a response for a junior developer. The [Stakeholder Update](../communication/stakeholder-update.md) prompt explicitly names the audience ("VP-level leadership", "cross-functional partners") because the register and detail level change dramatically.
- State the goal. The model should know what success looks like.

---

### 2. Chain-of-thought Reasoning

For complex tasks, instruct the model to reason through the problem step by step before producing a final answer. Do not just ask for output; ask the model to show its work.

**Pattern:**

```
Before providing your answer:
1. Identify the key constraints in this problem.
2. Consider at least two approaches and their trade-offs.
3. Select the best approach and explain your reasoning.
4. Then provide your final recommendation.
```

**Why it works:** When you force the model to show intermediate steps, it makes fewer errors on multi-step problems. It is less likely to skip important considerations when it has to show its work. Without chain-of-thought, the model jumps straight to an answer, and for complex problems that answer is often the first plausible one, not the best one.

#### Before and After

**Before (no chain-of-thought):**
```
I'm getting a 500 error on my API endpoint. How do I fix it?
```
What you get: The model guesses at the most common cause from its training data. It suggests "try adding error handling" or "check your database connection." You try the fix, it does not work, you paste the new error, and you are three rounds into trial-and-error.

**After (with chain-of-thought):**
```
Follow this structured debugging process:

Step 1: Reproduce and Clarify
  Restate your understanding of the bug. What is expected vs. actual behavior?

Step 2: Isolate the Failure Domain
  Where in the call stack does the error originate? Rule out entire subsystems.

Step 3: Generate Ranked Hypotheses
  List the top 3-5 most probable root causes, ranked by likelihood.
  For each: state supporting evidence, confirming evidence, and disconfirming evidence.

Step 4: Design Diagnostic Steps
  For the most likely hypothesis, suggest 1-3 specific commands or log lines
  to confirm or eliminate it.
```
What you get: A structured investigation with ranked hypotheses, evidence requirements, and specific diagnostic commands you can run immediately. The model traces execution paths instead of guessing.

#### Real Example from the Library

The [Debug Helper](../engineering/debug-helper.md) prompt uses a five-step chain-of-thought process: Reproduce and Clarify, Isolate the Failure Domain, Generate Ranked Hypotheses, Design Diagnostic Steps, and Fix and Verify. Each step builds on the previous one, preventing the model from jumping to a fix before the root cause is confirmed.

The [Root Cause Analysis](../analysis/root-cause.md) prompt uses a six-step chain that moves from Problem Statement to Fishbone Diagram to 5 Whys Chain to Root Cause Identification to Remediation. The output of each step feeds the next. This is not just formatting; it is a reasoning scaffold that produces deeper analysis.

**When to use it:**
- Debugging and root cause analysis
- Architecture decisions with trade-offs
- Any task where the first intuition is often wrong
- Multi-part analysis where conclusions build on earlier findings

**When to skip it:** Simple extraction or formatting tasks. Do not add chain-of-thought to a prompt that just needs to reformat JSON.

---

### 3. Output Format Specification

Tell the model exactly what shape the output should take. Do not leave this to chance.

**Pattern:**

```
Provide your response in the following format:

## Summary
[2-3 sentence overview]

## Findings
- Finding 1: [description]
  - Impact: [high/medium/low]
  - Recommendation: [action]

## Next Steps
1. [First action item with owner]
2. [Second action item with owner]
```

**Why it works:** Without format constraints, the model invents its own structure, and that structure varies between runs. When you lock in the format, you get output you can parse, compare, and plug into workflows. This is the single most impactful technique for consistency. Two runs of the same prompt should produce output that looks structurally identical, even if the content differs.

#### Before and After

**Before (no format specification):**
```
Give me a status update on my project.
```
What you get: A rambling narrative paragraph that buries the key information in the middle. Sometimes it starts with accomplishments, sometimes with risks, sometimes with a general reflection on progress. Each run looks different. You cannot scan it in 30 seconds.

**After (with format specification):**
```
Use this exact structure for the final update:

**Status: [On Track | At Risk | Blocked]**
[One-sentence justification]

**Key Accomplishments**
- [Accomplishment 1, with quantified impact if available]
- [Accomplishment 2]

**Upcoming Milestones**
- [Milestone 1]: [Target date]

**Risks and Blockers**
- [Risk/Blocker]: [Impact]. Mitigation: [Action underway or planned].

**Asks**
- [Decision, resource, or support needed, with a deadline if applicable]
```
What you get: A scannable, consistent update every time. Status at the top, accomplishments quantified, milestones dated, risks paired with mitigations, asks specific and actionable. Your VP can read it in 90 seconds.

#### Real Example from the Library

The [Stakeholder Update](../communication/stakeholder-update.md) prompt specifies every section: Status indicator (with only three valid options), Key Accomplishments (3-5 bullets, each one sentence), Upcoming Milestones (always with dates), Risks and Blockers (each with impact and mitigation), and Asks (with deadlines). This level of specificity means the output is consistent whether you run the prompt on Monday or Friday, with sparse notes or dense ones.

The [OKR Writer](../strategy/okr-writer.md) prompt goes further, specifying a table format for key results with columns for baseline, target, deadline, and owner. This structure forces the model to produce measurable, accountable output rather than vague aspirational statements.

**Guidelines:**
- Use markdown headers and lists for structured content.
- Specify lengths when they matter ("2-3 sentences", "no more than 5 bullet points").
- Include examples of the expected format when the structure is non-obvious.
- Specify what to do when a section has no content (e.g., "If none, write 'No active risks or blockers at this time.'").

---

### 4. Self-critique and Verification Loops

Ask the model to check its own work before delivering the final output.

**Pattern:**

```
After drafting your response, review it against these criteria:
- Does every recommendation include a concrete next step?
- Are there any claims without supporting evidence?
- Have you considered the failure modes?

Revise your response if any criteria are not met.
```

**Why it works:** Models can catch their own errors when you explicitly ask them to look. It is not foolproof, but it catches a meaningful percentage of mistakes: omissions, logical gaps, and calibration errors (calling something "High" severity when it is actually "Low"). The key is making the checklist specific to the task, not generic.

#### Before and After

**Before (no self-critique):**
```
Review this code for bugs.
```
What you get: A list that mixes real bugs with speculative concerns. A cosmetic naming issue gets the same treatment as a data-loss bug. There is no severity calibration, and some findings are hunches rather than confirmed issues.

**After (with self-critique checklist):**
```
After completing all categories, run this self-critique checklist
before presenting your final output:
- [ ] Did I confirm each finding by tracing the execution path, or did I
      flag something based on a hunch?
- [ ] Are my severity ratings calibrated? A cosmetic naming issue is not
      "High" severity. A potential data loss bug is not "Low."
- [ ] Did I provide a concrete fix for every finding, not just a description
      of the problem?
- [ ] Did I avoid inventing problems that are not actually present in the code?
```
What you get: A review where every finding is backed by execution path tracing, severity ratings are properly calibrated, and speculative issues are filtered out. The signal-to-noise ratio goes up dramatically.

#### Real Example from the Library

The [Code Review](../engineering/code-review.md) prompt includes a seven-item self-critique checklist that specifically asks the model to verify it traced execution paths (not just guessed), calibrated severity ratings, provided concrete fixes, and avoided inventing problems. This is why the code review prompt produces findings like "off-by-one on line 89 will skip the first page of results" instead of "consider adding error handling."

The [Blog Intro](../content/blog-intro.md) prompt includes a ten-item checklist covering everything from "Does the first sentence describe a real, specific problem?" to "Are there zero em dashes?" The model runs through every check and marks pass/fail, revising if anything fails. This built-in quality gate is visible in the output, so you can see exactly which criteria your introduction met.

**When to use it:**
- High-stakes outputs (production runbooks, security reviews, executive briefs)
- Complex analysis where errors compound
- Content that will be shared with stakeholders
- Any prompt where quality calibration matters

---

### 5. Anti-pattern Avoidance

Explicitly tell the model what NOT to do. Models have default behaviors that are often unhelpful for professional work. If you do not block them, they will show up in every output.

**Pattern:**

```
Do not:
- Use filler phrases like "Great question!" or "Certainly!"
- Repeat the question back before answering
- Add disclaimers about being an AI
- Use buzzwords or marketing language
- Hedge excessively with phrases like "it depends" without following up
```

**Why it works:** Models are trained on a lot of content that includes filler, hedging, and excessive politeness. They also pick up domain-specific bad habits: code reviews that recommend unnecessary abstractions, feedback that uses the "sandwich" technique, status updates that bury risks. When you explicitly block these patterns, the output gets cleaner and more direct. This is the technique that most directly improves the professional quality of what you get back.

#### Before and After

**Before (no anti-patterns specified):**
```
Write feedback for a team member who interrupted a colleague in a meeting.
```
What you get: "I wanted to start by saying what a great team player you are, and I really value your contributions to the architecture review. That said, I noticed that in the meeting, there was a moment where perhaps the flow of the conversation could have been smoother. It might be worth considering being a bit more mindful of..." The actual feedback is buried in qualifiers, hollow praise, and softening. The recipient walks away unsure what the message was.

**After (with anti-patterns blocked):**
```
ANTI-PATTERNS TO AVOID:
1. The "feedback sandwich." Do not wrap constructive feedback in unrelated
   compliments. People see through it and it dilutes both the praise and
   the critique.
2. Vague praise like "great job" or "keep it up." If you cannot name what
   they did and why it mattered, the recognition is meaningless.
3. Softening to the point of confusion: "Maybe you could possibly consider
   perhaps looking into..." Say what you mean.
4. Attributing intent: "You clearly did not care about the deadline."
   Stick to what you observed, not what you assume they were thinking.
```
What you get: "When Aisha presented the event-driven approach, you interrupted her twice and moved straight to listing drawbacks before she had finished. After that, she went quiet for the rest of the meeting. In future review meetings, let the presenter finish their full explanation before responding." Direct, specific, actionable.

#### Real Example from the Library

The [Feedback Draft](../leadership/feedback-draft.md) prompt blocks seven specific anti-patterns: the feedback sandwich, vague praise, attributing intent, softening to confusion, making it about you, comparing to other team members, and stacking multiple critiques. Each anti-pattern is not just named but explained with an example of what it looks like, so the model can recognize and avoid it.

The [Stakeholder Update](../communication/stakeholder-update.md) prompt blocks activity reporting ("worked on X" instead of "delivered X"), burying the lead, optimism bias (downgrading "At Risk" to avoid uncomfortable conversations), vague risks, missing asks, jargon overload, and walls of text. These are the specific failure modes that make status updates useless in practice.

**Key principle:** Anti-patterns should be specific to the domain. Generic instructions like "be professional" do not help. Specific instructions like "Do not recommend adding comments that would just restate what the code already says" catch real problems.

---

### 6. Edge Case Handling

Good prompts anticipate unusual inputs and tell the model how to handle them.

**Pattern:**

```
If the provided [INPUT] is:
- Empty or missing: State what information is needed and why.
- Ambiguous: List the possible interpretations and ask for clarification.
- Outside your expertise: Say so directly rather than guessing.
```

**Why it works:** Without edge case instructions, the model will either hallucinate an answer or produce something generic. Giving it explicit handling instructions creates a safe path for unusual situations. This is what prevents the model from confidently producing garbage when the input is bad.

#### Before and After

**Before (no edge case handling):**
```
Write OKRs for this initiative: "be the best platform."
```
What you get: The model gamely produces OKRs for a vague, unmeasurable goal. "Objective: Become the industry-leading platform. KR1: Increase market share by 20%." The output looks polished but is completely fictional because the input was too vague to produce anything real.

**After (with edge case handling):**
```
Edge case handling:
- If the user provides a goal that is too broad (e.g., "be the best platform"),
  ask clarifying questions before drafting. Do not guess.
- If the user provides a goal that is actually a task ("migrate to Kubernetes"),
  reframe it as an outcome-oriented Objective and explain why.
- If the user's context suggests competing priorities, surface the tension and
  ask them to choose or rank.
```
What you get: "Your goal 'be the best platform' is too broad to produce measurable OKRs. To narrow this down, I need you to answer: Best for whom? (internal developers, external customers, a specific market?) Best at what? (reliability, developer experience, cost efficiency?) What does 'best' look like in 6 months?" The model asks for clarification instead of producing impressive-looking nonsense.

#### Real Example from the Library

The [OKR Writer](../strategy/okr-writer.md) prompt handles four specific edge cases: goals that are too broad, goals that are actually tasks, competing priorities, and missing timelines. Each edge case has a specific instruction for how the model should respond. The model does not guess; it pushes back.

The [Debug Helper](../engineering/debug-helper.md) prompt handles empty error messages (check logs at each tier), intermittent bugs (ask about load patterns, concurrency, time-of-day), stack traces pointing to library code (trace backwards to the application code that called it), and missing environment details (ask for them). These are the exact situations where debugging goes sideways, and the prompt has a plan for each one.

The [Stakeholder Update](../communication/stakeholder-update.md) prompt handles contradictory notes (flag the contradiction), sparse input (produce what you can, then list questions to strengthen the update), missing risks (include the section anyway with an explicit "none" statement), and mixed audiences (default to the less technical register and add a technical appendix).

---

### 7. Placeholder Design with [BRACKETS]

Every prompt in this library uses bracket placeholders for variable content. This makes prompts reusable and self-documenting.

**Convention:**

```
[SYSTEM_NAME]       - The system or service being discussed
[TEAM]              - The team responsible
[CONTEXT]           - Background information the user provides
[TIMEFRAME]         - Relevant time period
[CONSTRAINTS]       - Known limitations or requirements
```

**Why it works:** Placeholders turn a one-off prompt into a reusable tool. They also serve as documentation: anyone looking at the prompt can immediately see what inputs are needed and what each one means. A prompt with clear placeholders is self-service. A prompt without them requires you to explain how to use it every time someone asks.

#### Before and After

**Before (no placeholders):**
```
Review the order processing system architecture. It runs on AWS with
PostgreSQL and handles about 200 orders per second. We want to scale to
2000 orders per second next year.
```
This prompt works once, for one system. When someone else wants to review a different system, they have to figure out which parts to replace and which to keep. They will inevitably leave in context that does not apply or forget to add context that does.

**After (with well-designed placeholders):**
```
System context:
- System name: [SYSTEM_NAME]
- Architecture description: [ARCHITECTURE_DESCRIPTION]
- Current scale: [CURRENT_SCALE]
- Target scale or upcoming requirements: [TARGET_SCALE_OR_UPCOMING_REQUIREMENTS]
- Known pain points: [KNOWN_ISSUES]
- Deployment environment: [DEPLOYMENT_ENVIRONMENT]
```
Anyone can use this prompt by filling in the brackets. The placeholder names make it clear what each field expects. There is no ambiguity about what to include or what to leave out.

#### Real Example from the Library

The [Executive Brief](../communication/exec-brief.md) prompt uses five clearly named placeholders: `[TOPIC]`, `[AUDIENCE]`, `[DECISION]`, `[PRIOR_CONTEXT]`, and a paste area for raw notes. Each placeholder includes inline guidance. For example, `[DECISION]` is annotated with examples: "approve funding for Q3," "align on technical direction," "no decision needed, awareness only." The user does not have to guess what goes in each field.

The [Architecture Review](../engineering/architecture-review.md) prompt uses six placeholders with descriptive names: `[SYSTEM_NAME]`, `[ARCHITECTURE_DESCRIPTION]`, `[CURRENT_SCALE]`, `[TARGET_SCALE_OR_UPCOMING_REQUIREMENTS]`, `[KNOWN_ISSUES]`, and `[DEPLOYMENT_ENVIRONMENT]`. Each name tells you exactly what to provide, and the usage tips explain what level of detail produces the best results.

**Guidelines:**
- Use ALL CAPS inside brackets for readability.
- Choose descriptive names. `[INPUT]` is acceptable; `[X]` is not.
- Add inline examples or descriptions when the expected content is not obvious.
- Group related placeholders together and document them at the top of the prompt.

---

## Structuring a Prompt for Consistent Results

A well-structured prompt follows this order:

```
1. ROLE         - Who the model is
2. CONTEXT      - What situation it is operating in
3. TASK         - What it needs to do (be specific)
4. CONSTRAINTS  - What it must and must not do
5. FORMAT       - What the output should look like
6. EXAMPLES     - What good output looks like (optional but valuable)
7. VERIFICATION - How to check the work (optional)
```

This order matters. Role and context prime the model before it sees the task, so it is already thinking in the right domain. Constraints and format shape the output. Examples reduce ambiguity. Verification catches errors.

Not every prompt needs all seven sections. A simple prompt may only need task and format. For complex prompts, use all of them.

## Common Mistakes and How to Fix Them

### Mistake 1: Being too vague

**Before:** "Review this code."

**After:** "Review this Python function for security vulnerabilities, focusing on input validation, SQL injection, and authentication bypass. For each issue found, provide the line number, the vulnerability type, the severity (critical/high/medium/low), and a specific fix."

The fix is specificity. Name the language, name the concern, name the output format. Every detail you add narrows the space of possible outputs, and that makes the useful output more likely.

### Mistake 2: Cramming multiple tasks into one prompt

**Before:** "Analyze this system, write a migration plan, create the test cases, and draft the stakeholder email."

**After:** Break this into four separate prompts, each focused on one task. Chain them if needed, using the output of one as input to the next. See the [Prompt Chains](../prompt-chains/) section for examples of multi-step workflows.

### Mistake 3: Not specifying the output format

**Before:** "Give me a summary of the incident."

**After:** "Provide a summary of the incident in the following format: Timeline (bullet points with timestamps), Root Cause (one paragraph), Impact (bullet points), and Action Items (numbered list with owners and deadlines)."

### Mistake 4: Assuming the model knows your context

**Before:** "What should we do about the latency issue?"

**After:** "Our API gateway (running Envoy 1.28 on RHEL 9) is showing p99 latency spikes of 3.2 seconds during peak traffic (2-4 PM ET). Normal p99 is 180ms. The spikes started after we deployed version 4.2.1 on Tuesday. What are the most likely causes and what diagnostic steps should we take first?"

The model does not know your system. Every detail you provide (software version, normal baseline, timing of the change) helps it produce a relevant answer instead of a generic one.

### Mistake 5: No constraints on length or depth

**Before:** "Explain Kubernetes networking."

**After:** "Explain Kubernetes pod-to-pod networking in 200 words or less, assuming the reader understands Linux networking basics but has not worked with container orchestration before."

## Contributor Template

Use this template when adding new prompts to the library:

```markdown
# [PROMPT_NAME]

## Purpose
[One sentence: what this prompt does and who it is for]

## Prompt

---

You are a [ROLE] with expertise in [DOMAIN].

**Context:** [CONTEXT]

**Task:** [Clear, specific description of what to do]

**Constraints:**
- [Constraint 1]
- [Constraint 2]
- Do not [anti-pattern 1]
- Do not [anti-pattern 2]

**Output Format:**
[Specify the exact structure]

**Verification:**
Before finalizing, confirm that:
- [Check 1]
- [Check 2]

---

## Placeholders
| Placeholder | Description | Example |
|------------|-------------|---------|
| [ROLE] | The expert role | Senior SRE |
| [DOMAIN] | Area of expertise | Kubernetes operations |

## Usage Notes
[Any tips for getting the best results from this prompt]

## Example Output
[A representative example of what good output looks like]
```

## Final Notes

Prompt engineering is not magic. It is clarity, structure, and specificity, applied consistently. The seven techniques in this guide are not complex individually, but they compound: a prompt that applies all of them produces output that is categorically different from a prompt that applies none.

When in doubt:
- Be more specific, not less.
- Show the model what good output looks like.
- Tell the model what to avoid.
- Check the output format matches what you need.
- Test the prompt multiple times before committing it to the library.

The prompts in this library are proof that these techniques work. Pick any one, compare its output to what you get from a naive version of the same request, and the difference is obvious.

## Cross-Model Considerations

These prompts are designed to work across different LLMs, but model-specific behavior can affect results:

- **Context window limits:** If you are running prompts on a model with a small context window (under 16k tokens), consider removing the self-critique checklist and the chain-of-thought reasoning sections. These improve quality but consume tokens. Prioritize the role setting, output format, and anti-pattern sections, which have the highest impact per token.
- **Different providers:** These prompts use no provider-specific features (function calling, system prompts, structured output modes). They work in any chat interface. If your model supports system prompts, move the role and context setting into the system prompt for better adherence.
- **Open-weight models:** Smaller open-weight models (7B-13B parameters) may struggle with long, multi-section prompts. For these models, break complex prompts into smaller sequential prompts or use the prompt chains workflow instead.
- **Temperature and sampling:** These prompts are designed for low-temperature settings (0.0 to 0.3). Higher temperatures produce more creative output but reduce format compliance and consistency.

See [testing-prompts.md](testing-prompts.md) for guidance on evaluating prompt quality.
