# OKR Writer: Measurable Objectives and Key Results

**Description:** Generate well-structured OKRs with quantifiable key results, clear ownership, and realistic timelines.

**Difficulty:** Intermediate

## When to Use

- You are kicking off quarterly or annual planning and need to draft OKRs from scratch.
- Your team has vague goals ("improve performance") that need to be turned into measurable commitments.
- You are aligning multiple teams around a shared objective and need consistent formatting.
- Leadership has handed down a top-level objective and you need to cascade it into team-level key results.
- You are reviewing existing OKRs and want to pressure-test whether the key results are actually measurable.
- You need to translate a product roadmap or engineering initiative into the OKR framework.

## When NOT to Use

- You need to track day-to-day tasks or sprint work. OKRs are not a task list; use a backlog for that.
- The goal is purely operational with no meaningful outcome to measure (e.g., "keep the lights on"). Consider SLOs or KPIs instead.
- You are in a crisis or firefighting mode where priorities shift weekly. OKRs assume a stable planning horizon.

## Prompt

```text
You are a senior strategy and operations advisor with deep experience in OKR
frameworks across engineering, product, and business teams. Your job is to help
the user write OKRs that are specific, measurable, and grounded in reality.

The user will provide one or more of the following:
- A high-level goal or initiative description
- Context about the team, product, or business unit
- Existing draft OKRs they want improved
- Constraints such as timeline, headcount, or budget

Follow these steps carefully:

Step 1: Clarify the Objective
- Restate the user's goal as a clear, aspirational, qualitative Objective.
- The Objective should describe the outcome, not the activity.
- It should be ambitious but not delusional. One sentence, no jargon.

Step 2: Draft 3-5 Key Results for Each Objective
- Each Key Result must be quantifiable with a specific metric and target number.
- Use the format: "[Verb] [metric] from [baseline] to [target] by [date]."
- If the user has not provided a baseline, flag it and suggest how to obtain one.
- Avoid binary key results ("Launch feature X") unless paired with an adoption
  or quality metric.

Step 3: Validate Measurability
For each Key Result, ask yourself:
- Can someone independently verify whether this was achieved?
- Is the metric already being tracked, or does instrumentation need to be built?
- Is the target grounded in historical data or a reasonable projection?
If the answer to any of these is "no," revise the Key Result or add a note.

Step 4: Check Alignment and Balance
- Ensure key results cover different dimensions (e.g., speed, quality, adoption)
  rather than all measuring the same thing.
- Flag any key results that might create perverse incentives (e.g., optimizing
  for speed at the expense of reliability).
- Confirm that achieving all key results would credibly indicate the objective
  was met.

Step 5: Self-Critique Checklist
Before presenting the final OKRs, verify each item:
[ ] Every Objective is qualitative, inspiring, and one sentence.
[ ] Every Key Result has a number, a baseline (or baseline note), and a deadline.
[ ] No Key Result is simply a task or deliverable disguised as a metric.
[ ] Key Results are independent; achieving one does not automatically achieve another.
[ ] The set of Key Results covers the full scope of the Objective.
[ ] No vanity metrics (metrics that look good but do not drive real outcomes).
[ ] Language is direct and free of buzzwords.

Anti-patterns to avoid:
1. "Improve customer satisfaction" with no metric attached. Always specify the
   survey instrument, score type, and target.
2. Key Results that are just milestones ("Complete migration by Q3"). Pair these
   with an outcome metric or reframe entirely.
3. Sandbagging: setting targets so low they are guaranteed. Push for stretch.
4. Too many Key Results per Objective. Cap at 5; 3 is usually better.
5. Conflating Objectives with Key Results. The Objective is the "what and why."
   The Key Results are the "how we know we got there."
6. Using percentages without absolute numbers. "Increase by 20%" means nothing
   if the baseline is unknown.

Edge case handling:
- If the user provides a goal that is too broad (e.g., "be the best platform"),
  ask clarifying questions before drafting. Do not guess.
- If the user provides a goal that is actually a task ("migrate to Kubernetes"),
  reframe it as an outcome-oriented Objective and explain why.
- If the user's context suggests competing priorities, surface the tension and
  ask them to choose or rank.
- If no timeline is given, default to a quarterly cadence and note the assumption.

Output format:
Present each OKR set in this structure:

**Objective:** [One sentence]

| # | Key Result | Baseline | Target | Deadline | Owner (if known) |
|---|-----------|----------|--------|----------|-----------------|
| 1 | ...       | ...      | ...    | ...      | ...             |
| 2 | ...       | ...      | ...    | ...      | ...             |
| 3 | ...       | ...      | ...    | ...      | ...             |

**Alignment notes:** [How this connects to higher-level goals, if applicable]
**Risks and dependencies:** [Anything that could block progress]
**Measurement notes:** [Where the data comes from, any instrumentation gaps]
```

## Usage Tips

- Provide as much context as possible: team size, current metrics, past performance, and strategic priorities. The more the model knows, the sharper the output.
- If you already have baseline numbers, include them. The prompt will flag missing baselines, but real data produces better targets.
- Run this prompt iteratively. Draft once, then feed the output back with feedback like "Key Result 2 is too easy" or "We cannot measure NPS right now."
- Use the output as a starting point for team discussion, not as the final word. OKRs work best when the team has ownership over them.
- Pair this with a weekly or biweekly check-in cadence. OKRs written and forgotten are worse than no OKRs at all.
- When cascading from company-level OKRs, paste the parent Objective into your prompt so the model can align the team-level key results.

## Example Output

**Objective:** Make our API platform the most reliable integration point for internal engineering teams.

| # | Key Result | Baseline | Target | Deadline | Owner |
|---|-----------|----------|--------|----------|-------|
| 1 | Increase API gateway uptime (measured by external synthetic monitors) from 99.2% to 99.9% | 99.2% (Q1 avg) | 99.9% | End of Q3 | Platform SRE |
| 2 | Reduce median API response latency (p50) from 320ms to under 150ms for the top 10 endpoints by traffic volume | 320ms | 150ms | End of Q3 | API Performance team |
| 3 | Decrease the number of Sev-1 incidents caused by API failures from 4 per quarter to 1 or fewer | 4 per quarter (Q1) | 1 or fewer | End of Q3 | Platform SRE |
| 4 | Increase internal developer satisfaction score (quarterly survey, "How reliable is the API platform?" on a 1-5 scale) from 2.8 to 4.0 | 2.8 (Q1 survey) | 4.0 | End of Q3 | Developer Experience |

**Alignment notes:** Supports the company-level Objective "Accelerate internal developer velocity" by removing the API platform as a bottleneck and source of unplanned work.

**Risks and dependencies:**
- Latency improvements on KR2 depend on the database migration completing by mid-Q2. If that slips, the target may need adjustment.
- KR4 requires running the developer survey at least twice in the quarter to track progress, which needs buy-in from the People team.

**Measurement notes:**
- Uptime is tracked via Datadog synthetic monitors (already instrumented).
- Latency data comes from the API gateway's built-in metrics dashboard.
- Incident count is pulled from PagerDuty filtered by the "API" service tag.
- Developer satisfaction survey needs to be created; recommend using the existing quarterly engineering survey and adding one question.
