# Prompt Engineering Guide

A practical reference for writing prompts that produce consistent, useful results.
This guide covers the techniques used throughout this library and provides a template
for contributors.

## Why Prompt Engineering Matters

A well-written prompt is the difference between output you can use and output you throw away.

Large language models respond to structure, specificity, and context. Vague instructions
produce vague results. Precise instructions produce results you can ship. The goal is not
to write clever prompts; it is to write prompts that work reliably across runs, models,
and use cases.

Every prompt in this library is designed to be reusable, testable, and predictable.
This guide explains how we get there.

## Core Techniques

### 1. Role and Context Setting

Tell the model who it is and what situation it is operating in. This grounds the response
and constrains it to a useful domain.

**Pattern:**

```
You are a [ROLE] with expertise in [DOMAIN].
You are working with [AUDIENCE] who need [OUTCOME].
```

**Why it works:** Role assignment narrows the model's output distribution. A prompt that
says "You are a senior site reliability engineer" will produce different (and more
technically precise) output than one that says nothing about role.

**Guidelines:**
- Be specific about the role. "Engineer" is too broad. "Senior platform engineer
  specializing in Kubernetes networking" is useful.
- Include the audience. A response for a VP is different from a response for a
  junior developer.
- State the goal. The model should know what success looks like.

### 2. Chain-of-thought Reasoning

For complex tasks, ask the model to reason through the problem step by step before
producing a final answer.

**Pattern:**

```
Before providing your answer:
1. Identify the key constraints in this problem.
2. Consider at least two approaches and their trade-offs.
3. Select the best approach and explain your reasoning.
4. Then provide your final recommendation.
```

**Why it works:** Forcing intermediate reasoning steps reduces errors on multi-step
problems. The model is less likely to skip important considerations when it must
show its work.

**When to use it:**
- Debugging and root cause analysis
- Architecture decisions with trade-offs
- Any task where the first intuition is often wrong

**When to skip it:** Simple extraction or formatting tasks. Do not add chain-of-thought
to a prompt that just needs to reformat JSON.

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

**Why it works:** Without format constraints, models will invent their own structure,
which varies between runs. Explicit format instructions produce outputs that can be
parsed, compared, and integrated into workflows.

**Guidelines:**
- Use markdown headers and lists for structured content.
- Specify lengths when they matter ("2-3 sentences", "no more than 5 bullet points").
- Include examples of the expected format when the structure is non-obvious.

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

**Why it works:** Models can catch their own errors when explicitly asked to look for
them. This is not foolproof, but it catches a meaningful percentage of mistakes,
especially omissions and logical gaps.

**When to use it:**
- High-stakes outputs (production runbooks, security reviews)
- Complex analysis where errors compound
- Content that will be shared with stakeholders

### 5. Anti-pattern Avoidance

Explicitly tell the model what NOT to do. Models have default behaviors that are
often unhelpful for professional work.

**Common anti-patterns to block:**

```
Do not:
- Use filler phrases like "Great question!" or "Certainly!"
- Repeat the question back before answering
- Add disclaimers about being an AI
- Use buzzwords or marketing language
- Hedge excessively with phrases like "it depends" without following up with specifics
```

**Why it works:** Models are trained on a lot of content that includes filler,
hedging, and excessive politeness. Explicitly blocking these patterns produces
cleaner, more direct output.

### 6. Edge Case Handling

Good prompts anticipate unusual inputs and tell the model how to handle them.

**Pattern:**

```
If the provided [INPUT] is:
- Empty or missing: State what information is needed and why.
- Ambiguous: List the possible interpretations and ask for clarification.
- Outside your expertise: Say so directly rather than guessing.
```

**Why it works:** Without edge case instructions, models will either hallucinate
an answer or produce something generic. Explicit handling instructions give the
model a safe path for unusual situations.

### 7. Placeholder Design with [BRACKETS]

Every prompt in this library uses bracket placeholders for variable content.
This makes prompts reusable and self-documenting.

**Convention:**

```
[SYSTEM_NAME]       - The system or service being discussed
[TEAM]              - The team responsible
[CONTEXT]           - Background information the user provides
[TIMEFRAME]         - Relevant time period
[CONSTRAINTS]       - Known limitations or requirements
```

**Guidelines:**
- Use ALL CAPS inside brackets for readability.
- Choose descriptive names. `[INPUT]` is acceptable; `[X]` is not.
- Add a comment or description when the expected content is not obvious.
- Group related placeholders together and document them at the top of the prompt.

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

This order matters. Role and context prime the model before it encounters the task.
Constraints and format shape the output. Examples reduce ambiguity. Verification
catches errors.

Not every prompt needs all seven sections. Simple prompts may only need task and
format. Complex prompts benefit from all of them.

## Common Mistakes and How to Fix Them

### Mistake 1: Being too vague

**Bad:** "Review this code."
**Fix:** "Review this Python function for security vulnerabilities, focusing on input
validation, SQL injection, and authentication bypass. For each issue found, provide
the line number, the vulnerability type, the severity (critical/high/medium/low),
and a specific fix."

### Mistake 2: Cramming multiple tasks into one prompt

**Bad:** "Analyze this system, write a migration plan, create the test cases, and
draft the stakeholder email."
**Fix:** Break this into four separate prompts, each focused on one task. Chain them
if needed, using the output of one as input to the next.

### Mistake 3: Not specifying the output format

**Bad:** "Give me a summary of the incident."
**Fix:** "Provide a summary of the incident in the following format: Timeline (bullet
points with timestamps), Root Cause (one paragraph), Impact (bullet points), and
Action Items (numbered list with owners and deadlines)."

### Mistake 4: Assuming the model knows your context

**Bad:** "What should we do about the latency issue?"
**Fix:** "Our API gateway (running Envoy 1.28 on RHEL 9) is showing p99 latency spikes
of 3.2 seconds during peak traffic (2-4 PM ET). Normal p99 is 180ms. The spikes
started after we deployed version 4.2.1 on Tuesday. What are the most likely causes
and what diagnostic steps should we take first?"

### Mistake 5: No constraints on length or depth

**Bad:** "Explain Kubernetes networking."
**Fix:** "Explain Kubernetes pod-to-pod networking in 200 words or less, assuming the
reader understands Linux networking basics but has not worked with container
orchestration before."

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

## Before and After: From Naive to Well-engineered

### Example 1: Code Review

**Before (naive):**
```
Review this code and tell me if it's good.
```

**After (well-engineered):**
```
You are a senior software engineer conducting a code review.

Review the following [LANGUAGE] code for:
1. Correctness: Logic errors, off-by-one errors, null/nil handling
2. Security: Input validation, injection vulnerabilities, credential exposure
3. Performance: Unnecessary allocations, O(n^2) or worse patterns, missing caching
4. Maintainability: Naming clarity, function length, test coverage gaps

For each issue found, provide:
- File and line number
- Severity: critical / high / medium / low
- Description of the problem
- Suggested fix with a code snippet

If the code is solid, say so and highlight what makes it good.
Do not summarize the code back to me. Focus only on actionable findings.
```

### Example 2: Incident Summary

**Before (naive):**
```
Summarize this incident.
```

**After (well-engineered):**
```
You are an SRE writing a post-incident summary for engineering leadership.

Given the following incident details, produce a summary in this format:

## Incident Summary
- **Duration:** [start time to resolution time]
- **Severity:** [S1/S2/S3/S4]
- **Services affected:** [list]
- **Customer impact:** [one sentence]

## Timeline
[Bullet points with timestamps, covering detection, escalation, mitigation,
and resolution]

## Root Cause
[One paragraph, technically precise but readable by non-specialists]

## Action Items
| # | Action | Owner | Priority | Due Date |
|---|--------|-------|----------|----------|
| 1 | [action] | [owner] | [P1/P2/P3] | [date] |

Keep the tone factual. No blame language. Focus on systems and processes,
not individuals.
```

### Example 3: Architecture Decision

**Before (naive):**
```
Should we use Kafka or RabbitMQ?
```

**After (well-engineered):**
```
You are a senior platform architect evaluating messaging systems.

**Context:** [SYSTEM_DESCRIPTION]
- Current message volume: [VOLUME] messages/second
- Expected growth: [GROWTH_RATE] over [TIMEFRAME]
- Message size: [SIZE] average
- Ordering requirements: [ORDERING_NEEDS]
- Team experience: [TEAM_EXPERTISE]

Compare Apache Kafka and RabbitMQ for this use case. For each option, assess:
1. Throughput fit for current and projected volume
2. Operational complexity given the team's experience
3. Ecosystem integration with [EXISTING_STACK]
4. Cost at projected scale
5. Failure modes and recovery characteristics

Provide a clear recommendation with reasoning. If the answer genuinely
depends on factors not provided, list the specific questions that would
change the recommendation.
```

## Final Notes

Good prompt engineering is not about tricks. It is about clarity, structure, and
specificity. The techniques in this guide are not complex, but they require
discipline to apply consistently.

When in doubt:
- Be more specific, not less.
- Show the model what good output looks like.
- Tell the model what to avoid.
- Check the output format matches what you need.
- Test the prompt multiple times before committing it to the library.

See [testing-prompts.md](testing-prompts.md) for guidance on evaluating prompt quality.
