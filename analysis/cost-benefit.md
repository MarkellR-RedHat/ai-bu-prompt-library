# Cost-Benefit Analysis

A prompt for producing a structured cost-benefit analysis of a proposed feature, project, or investment to support data-informed decision-making.

**Difficulty:** Advanced

## When to use

- You are writing a business case for a new feature or project and need to quantify the expected costs and benefits.
- Leadership has asked for a go/no-go recommendation backed by financial and operational reasoning.
- You need to compare the ROI of multiple proposed initiatives competing for the same budget or engineering capacity.
- A project is already in progress and you need to evaluate whether to continue, pivot, or cancel based on updated cost and benefit estimates.
- You are preparing a quarterly planning proposal and want to rank candidate projects by expected value.
- You need to justify infrastructure spending (for example, migrating to a new platform) with concrete projected savings or gains.

## When NOT to use

- You need a pure technical trade-off analysis between implementation approaches. Use the trade-off prompt instead.
- The decision is primarily values-driven or political and no amount of cost-benefit framing will change the outcome. Recognize those situations and address them directly.
- You have no data, estimates, or benchmarks to work with. A cost-benefit analysis built on guesses looks rigorous but is not. Gather baseline data first.

## Prompt

```
You are a senior engineering leader with strong financial acumen and
experience building business cases for technical investments at
enterprise software companies. You are rigorous about separating
hard costs from soft benefits, quantifying uncertainty, and presenting
honest assessments rather than advocacy documents.

Conduct a cost-benefit analysis for the following proposal.

Proposal: [DESCRIBE THE PROPOSED FEATURE, PROJECT, OR INVESTMENT]
Business Context: [WHY IS THIS BEING CONSIDERED NOW? WHAT PROBLEM DOES
IT SOLVE OR OPPORTUNITY DOES IT CAPTURE?]
Time Horizon: [OVER WHAT PERIOD SHOULD COSTS AND BENEFITS BE EVALUATED?
e.g., 12 months, 3 years]
Baseline: [WHAT IS THE CURRENT STATE? WHAT HAPPENS IF WE DO NOTHING?]
Budget Envelope: [AVAILABLE BUDGET OR RESOURCE CONSTRAINTS, IF KNOWN]

Follow these steps in order:

STEP 1 - DEFINE THE SCOPE
Clearly state what is included in this analysis and what is excluded.
Identify assumptions that underpin the analysis and flag which ones
are most uncertain. Number each assumption (A1, A2, ...) so they can
be referenced later.

STEP 2 - ITEMIZE COSTS
Break costs into the following categories. For each line item, provide:
  - A description of the cost
  - Whether it is one-time or recurring
  - A low, expected, and high estimate (three-point estimate)
  - The assumption(s) the estimate depends on (reference by number)

Cost categories:
  a) Personnel: engineering time, hiring, contractor costs, training
  b) Infrastructure: compute, storage, networking, licensing, tooling
  c) Opportunity cost: what the team will NOT be working on during
     this period (be specific; name the deferred work)
  d) Operational: ongoing maintenance, support, on-call burden, upgrades
  e) Risk-related: costs associated with failure scenarios, rollback,
     or rework
  f) Transition: migration, data conversion, integration, downtime

Present costs in a table. Include a total for low, expected, and high
scenarios.

STEP 3 - ITEMIZE BENEFITS
Break benefits into the following categories. For each line item:
  - Describe the benefit
  - Classify it as QUANTIFIABLE (can be measured in dollars or a
    concrete metric), ESTIMABLE (reasonable to approximate), or
    QUALITATIVE (real but hard to measure)
  - Provide a low, expected, and high estimate for quantifiable and
    estimable benefits
  - State the metric you would use to verify the benefit was realized
  - Reference the assumption(s) the estimate depends on

Benefit categories:
  a) Revenue: new revenue, upsell, reduced churn, faster sales cycles
  b) Cost savings: reduced infrastructure spend, headcount efficiency,
     fewer incidents
  c) Productivity: engineering velocity, reduced toil, faster
     onboarding
  d) Risk reduction: security improvements, compliance, reduced
     outage frequency
  e) Strategic positioning: market differentiation, ecosystem
     leverage, talent attraction

Present benefits in a table. Include a total for low, expected, and
high scenarios. Keep qualitative benefits in a separate section so
they do not inflate the quantified total.

STEP 4 - NET ANALYSIS
Calculate:
  - Net benefit (expected benefits minus expected costs) for each
    scenario (low, expected, high)
  - Simple ROI: (net benefit / total cost) as a percentage
  - Payback period: when cumulative benefits exceed cumulative costs
  - Break-even assumptions: what must be true for the project to
    break even? Identify the 2-3 assumptions that matter most.

STEP 5 - SENSITIVITY ANALYSIS
Identify the 3-5 variables that most affect the outcome. For each:
  - Show how the net benefit changes if the variable moves 25% up
    or down from the expected value
  - State whether the project remains net-positive under the
    pessimistic scenario

Present this as a table or a text-based sensitivity summary.

STEP 6 - RISK ASSESSMENT
List the top 5 risks to realizing the projected benefits. For each:
  - Likelihood: HIGH, MEDIUM, or LOW
  - Impact on the business case: what happens to the numbers if this
    risk materializes?
  - Mitigation: a specific action to reduce the risk
  - Whether the project is still worth pursuing if the risk occurs

STEP 7 - RECOMMENDATION
State one of the following:
  - PROCEED: the expected net benefit justifies the investment
  - PROCEED WITH CONDITIONS: proceed only if specific conditions are
    met (list them)
  - DEFER: the timing is wrong but the idea has merit (explain what
    should change before revisiting)
  - DO NOT PROCEED: the costs outweigh the benefits or the risks are
    too high (explain clearly)

Include a brief narrative (3-5 sentences) explaining the reasoning
in plain language suitable for a non-technical executive.

STEP 8 - SELF-CRITIQUE CHECKLIST
Before presenting your final analysis, verify:
  [ ] Costs include opportunity cost, not just direct spend
  [ ] Benefits are not double-counted (for example, counting both
      "reduced headcount" and "improved productivity" for the same
      engineer hours)
  [ ] The "do nothing" baseline is realistic, not artificially
      pessimistic to make the proposal look better
  [ ] Qualitative benefits are separated from quantified totals
  [ ] At least one pessimistic scenario is modeled where the project
      is net-negative, so stakeholders can see the downside
  [ ] Assumptions are numbered and referenced, making it easy to
      update the analysis when assumptions change
  [ ] The recommendation acknowledges genuine uncertainty rather than
      projecting false precision

ANTI-PATTERNS TO AVOID:
1. Inflating benefits with vague multipliers ("10x developer
   productivity improvement") without evidence or benchmarks.
2. Omitting opportunity cost entirely. Every engineering hour on this
   project is an engineering hour not spent on something else.
3. Treating the expected case as the only case. Always present a range.
4. Mixing quantified and qualitative benefits in the same total to
   make the number look bigger.
5. Anchoring on sunk costs. Money already spent is irrelevant to the
   go-forward decision.
6. Using "strategic value" as a catch-all to justify projects that
   fail the financial analysis. If strategy is the real driver, say
   so explicitly and do not dress it up as ROI.
7. Ignoring the cost of delay. If the project takes 6 months longer
   than planned, what happens to the business case?

EDGE CASE HANDLING:
- If the proposal is primarily strategic (for example, entering a new
  market or building a platform capability), acknowledge that the
  financial analysis captures only part of the value. Present the
  financial analysis honestly and discuss strategic value separately.
- If the "do nothing" baseline involves significant risk (for example,
  a security vulnerability or compliance deadline), frame the analysis
  as cost-of-inaction vs. cost-of-action rather than traditional ROI.
- If the proposal has network effects or compounding benefits that
  grow over time, model the first year conservatively and show the
  growth trajectory separately with explicit assumptions about
  adoption rates.
- If cost data is highly uncertain (for example, a new technology
  with no internal benchmarks), recommend a time-boxed proof of
  concept to reduce uncertainty before committing to the full
  investment.

Format your output with clear Markdown headers for each step.
Use tables for cost and benefit itemization.
Use a consistent currency and time unit throughout.
```

## Usage Tips

- The "do nothing" baseline is the most important input. If you describe it vaguely, the entire analysis shifts. Spend time getting this right before running the prompt.
- Provide actual numbers wherever possible, even rough ones. "$200K-$400K in annual infrastructure costs" is far more useful to the model than "significant infrastructure spending."
- Run the analysis once with optimistic assumptions and once with pessimistic assumptions. If the recommendation changes, the decision is sensitive to assumptions and deserves more investigation.
- Use the numbered assumptions (A1, A2, ...) as a living document. When an assumption is validated or invalidated, update the analysis and see if the conclusion holds.
- For large investments, pair this prompt with the trade-off prompt to first select the best implementation approach, then run cost-benefit on the winning approach.
- Share the sensitivity analysis section with finance stakeholders. It speaks their language and builds credibility for the technical team's planning rigor.
- Revisit the analysis at project milestones (25%, 50%, 75% complete) to check whether the original assumptions still hold. Early detection of cost overruns or benefit shortfalls saves money.

## Example Output

> ### Step 1: Scope
>
> **Included:** Engineering cost to build, infrastructure cost to run, projected reduction in inference latency and compute spend, migration effort from current system.
>
> **Excluded:** Marketing costs for announcing the new capability, sales enablement, and indirect revenue from improved brand perception.
>
> **Key Assumptions:**
> - A1: The team has 4 engineers available for 3 months (one quarter).
> - A2: Current inference infrastructure costs $38K/month and is growing 12% month-over-month.
> - A3: The new serving framework reduces per-request compute cost by 30-50% based on published benchmarks (not yet validated internally).
> - A4: Migration can happen incrementally with no full-service downtime.
>
> ### Step 2: Costs (excerpt)
>
> | Category | Item | Type | Low | Expected | High | Assumptions |
> |---|---|---|---|---|---|---|
> | Personnel | 4 engineers, 3 months | One-time | $180K | $200K | $260K | A1 |
> | Infrastructure | New serving cluster (GPU instances) | Recurring/mo | $12K | $15K | $20K | A3 |
> | Opportunity cost | Deferred: automated model rollback feature | One-time | - | $80K equiv. | - | A1 |
> | Transition | Incremental migration, dual-run period | One-time | $15K | $25K | $40K | A4 |
> | **Total (Year 1)** | | | **$339K** | **$485K** | **$540K** | |
>
> ### Step 3: Benefits (excerpt)
>
> | Category | Item | Type | Low | Expected | High | Metric | Assumptions |
> |---|---|---|---|---|---|---|---|
> | Cost savings | Reduced GPU compute (30-50% per request) | Recurring/mo | $11K | $16K | $19K | Monthly cloud bill delta | A2, A3 |
> | Productivity | Reduced on-call incidents (fewer OOMs) | Estimable/yr | $20K | $40K | $60K | Incident count, MTTR | A3 |
> | Risk reduction | Headroom delays need for capacity expansion | Estimable | $50K | $100K | $150K | Months before next capacity purchase | A2 |
>
> ### Step 4: Net Analysis
>
> | Scenario | Total Cost (Y1) | Total Benefit (Y1) | Net Benefit | Simple ROI | Payback |
> |---|---|---|---|---|---|
> | Low | $540K | $232K | -$308K | -57% | >12 months |
> | Expected | $485K | $392K | -$93K | -19% | 15 months |
> | High | $339K | $498K | +$159K | +47% | 9 months |
>
> The project breaks even at approximately 15 months in the expected case. The Year 2 picture is significantly better because one-time costs are eliminated and recurring savings compound with traffic growth (A2).
>
> ### Step 7: Recommendation
>
> **PROCEED WITH CONDITIONS.** Proceed only if (1) the team validates assumption A3 with an internal benchmark within the first 3 weeks, confirming at least a 30% compute cost reduction, and (2) the automated model rollback feature (the primary opportunity cost) is rescheduled for Q3.
>
> In plain language: this project pays for itself in about 15 months and becomes strongly positive in Year 2 as our inference traffic continues to grow. The main risk is that the projected compute savings do not materialize at the expected level. We mitigate that risk by running a focused benchmark early and treating it as a go/no-go gate before committing the full team.
