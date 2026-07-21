# Cost-Benefit Analysis

A prompt for producing a structured cost-benefit analysis of a proposed feature, project, or investment to support data-informed decision-making.

**Difficulty:** Advanced

## Naive vs. Engineered

**Naive prompt:** "Do a cost-benefit analysis of migrating our inference serving to a new framework."

**What you get:** Output like this:

> **Cost-Benefit Analysis: Inference Serving Migration**
>
> **Costs:** The migration will require significant engineering effort and some infrastructure investment.
>
> **Benefits:** The new framework will save money on compute costs and improve inference latency, leading to a better user experience and reduced operational burden.
>
> **Recommendation:** The benefits outweigh the costs. We recommend proceeding with the migration.

No numbers, no range estimates, no sensitivity analysis, no distinction between hard costs and soft benefits. "Significant engineering effort" could mean two weeks or two quarters. "Save money" could mean $5K or $500K. You cannot take this to a finance review or use it to make an actual go/no-go decision.

**This prompt** produces a structured business case with numbered assumptions, three-point cost estimates (low, expected, high) broken down by category (personnel, infrastructure, opportunity cost, transition), quantified and classified benefits (separating hard numbers from qualitative value), net analysis with ROI and payback period calculations, sensitivity analysis on the variables that matter most, a risk assessment, and a clear recommendation with conditions. For example, instead of "save money on compute," you get "Reduced GPU compute (30-50% per request): low $11K/mo, expected $16K/mo, high $19K/mo, measured by monthly cloud bill delta, dependent on assumption A3." The difference is between a hand-wavy narrative that sounds analytical and a rigorous financial case that a CFO can actually evaluate.

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
     influence, talent attraction

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
- If any placeholder fields are left unfilled (e.g., "[PROPOSAL]" or
  "[BASELINE]"), do not generate an analysis with invented project
  details. Instead, list the unfilled fields and ask the user to
  provide them. A cost-benefit analysis built on assumed inputs
  produces false precision that is worse than no analysis at all.
- If the project's primary benefits are intangible (e.g., improved
  developer experience, better team morale, reduced cognitive load),
  classify them clearly as QUALITATIVE and present them in a separate
  section. Do not attempt to force dollar values onto intangible
  benefits. Instead, identify proxy metrics that can be tracked over
  time (e.g., developer survey scores, time-to-first-commit for new
  hires, voluntary attrition rate).
- If costs span multiple budget owners (e.g., infrastructure costs
  charged to platform team, personnel costs charged to product team),
  break the cost table into sections by budget owner. This makes the
  analysis actionable for funding conversations, since each stakeholder
  needs to see their specific financial exposure rather than a single
  blended total.

Format your output with clear Markdown headers for each step.
Use tables for cost and benefit itemization.
Use a consistent currency and time unit throughout.
```

## Why This Works

**Persona with financial acumen.** The prompt assigns the role of "a senior engineering leader with strong financial acumen" who is "rigorous about separating hard costs from soft benefits." This framing is specific and directional: it tells the model to be honest rather than optimistic, to separate quantifiable value from qualitative claims, and to present assessments rather than advocacy documents. Without this, cost-benefit outputs tend to read like sales pitches.

**Three-point estimation.** Requiring low, expected, and high estimates for every cost and benefit line item forces the model to acknowledge uncertainty rather than presenting a single number as fact. This is standard practice in financial analysis but almost never requested in casual prompts, which is why naive cost-benefit outputs look precise but are actually unreliable.

**Numbered assumptions.** Each assumption is labeled (A1, A2, ...) and referenced throughout the analysis. This creates traceability: when an assumption turns out to be wrong, you can immediately see which cost and benefit estimates are affected. It also makes the analysis a living document that you can update as you learn more.

**Opportunity cost inclusion.** The prompt explicitly requires naming what the team will NOT be working on during the project. This is the most commonly omitted cost in business cases, and its absence makes every project look cheaper than it really is. Forcing it into the analysis produces a more honest picture.

**Sensitivity analysis.** Step 5 identifies the 3-5 variables that most affect the outcome and shows how the conclusion changes when those variables shift. This is where decision-makers actually learn something useful: not "is this a good project" but "what would have to be true for this project to fail?" Without this step, stakeholders have no way to assess the robustness of the recommendation.

**Anti-pattern avoidance.** The explicit prohibition against inflating benefits with vague multipliers, mixing qualitative and quantified totals, anchoring on sunk costs, and using "strategic value" as a catch-all directly suppresses the most common ways cost-benefit analyses become misleading. These patterns are pervasive in training data, so naming them is necessary to override the default.

These techniques combine to produce the difference shown above: a rigorous, honest financial case with traceable assumptions and clear sensitivity, rather than a narrative that sounds analytical but cannot survive a finance review.

## Usage Tips

- The "do nothing" baseline is the most important input. If you describe it vaguely, the entire analysis shifts. Spend time getting this right before running the prompt.
- Provide actual numbers wherever possible, even rough ones. "$200K-$400K in annual infrastructure costs" is far more useful to the model than "significant infrastructure spending."
- Run the analysis once with optimistic assumptions and once with pessimistic assumptions. If the recommendation changes, the decision is sensitive to assumptions and deserves more investigation.
- Use the numbered assumptions (A1, A2, ...) as a living document. When an assumption is validated or invalidated, update the analysis and see if the conclusion holds.
- For large investments, pair this prompt with the trade-off prompt to first select the best implementation approach, then run cost-benefit on the winning approach.
- Share the sensitivity analysis section with finance stakeholders. It speaks their language and builds credibility for the technical team's planning rigor.
- Revisit the analysis at project milestones (25%, 50%, 75% complete) to check whether the original assumptions still hold. Early detection of cost overruns or benefit shortfalls saves money.
- **Slash command connection:** If you use `claude-commands`, the `/what-next` slash command can help prioritize which cost-benefit analyses to run first when evaluating multiple competing project proposals.

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
