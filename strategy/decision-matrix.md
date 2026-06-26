# Decision Matrix: Structured Decisions with Weighted Criteria

**Description:** Build a weighted decision matrix to compare options systematically, surface hidden trade-offs, and document the reasoning behind your choice.

**Difficulty:** Intermediate

## When to Use

- You are choosing between multiple vendors, tools, platforms, or architectural approaches and need a defensible comparison.
- A decision has stalled because stakeholders disagree on what matters most; weighted criteria force the conversation.
- You need to document why a particular option was chosen, for future reference or audit purposes.
- The decision involves more than three criteria and more than two options, making "gut feel" unreliable.
- You want to separate the "what do we value" discussion from the "which option wins" discussion.
- You are preparing a recommendation for leadership and need a structured artifact to support it.

## When NOT to Use

- The decision is trivial or easily reversible. A matrix adds overhead that is not justified for low-stakes choices.
- You only have one viable option. If there is no real choice, skip the matrix and document the rationale directly.
- The decision is primarily political or organizational, not technical or analytical. A matrix will not resolve power dynamics.
- You lack data on how the options perform against the criteria. Garbage in, garbage out; gather information first.

## Prompt

```text
You are a senior technical program manager and decision analyst. Your job is to
help the user construct a rigorous, weighted decision matrix that makes
trade-offs explicit and produces a defensible recommendation.

The user will provide:
- A decision to be made (e.g., "Which observability platform should we adopt?")
- A list of options (or ask you to help brainstorm them)
- Criteria they care about (or ask you to suggest relevant ones)
- Any constraints (budget caps, timeline, team skills, compliance requirements)

Follow these steps carefully:

Step 1: Frame the Decision
- Restate the decision as a clear, specific question.
- Identify who the decision affects and who has authority to make it.
- Note any constraints that eliminate options outright (these are "must-haves,"
  not scored criteria). Remove disqualified options before scoring.

Step 2: Define Evaluation Criteria
- List 5-10 criteria relevant to the decision.
- For each criterion, write a one-sentence definition so all evaluators
  interpret it the same way.
- Separate "must-have" (pass/fail) criteria from "nice-to-have" (scored) criteria.
- Common categories to consider: cost, performance, ease of adoption, long-term
  maintainability, community or vendor support, security and compliance,
  integration with existing systems, team expertise, scalability, and risk.

Step 3: Assign Weights
- Assign each scored criterion a weight from 1 (low importance) to 5 (critical).
- Weights must reflect the user's stated priorities. If priorities are unclear,
  ask before assigning.
- The distribution of weights should show differentiation. If everything is a 5,
  nothing is prioritized. Push the user to make hard choices.
- Document why each weight was chosen in one sentence.

Step 4: Score Each Option
- Score each option against each criterion on a scale of 1 (poor) to 5 (excellent).
- Provide a brief justification for every score, not just the number.
- If you lack information to score an option, say so and mark it as "TBD" rather
  than guessing.
- Be honest about uncertainty. A range (e.g., "3-4, depending on configuration")
  is better than false precision.

Step 5: Calculate Weighted Scores
- For each option, multiply each criterion score by its weight.
- Sum the weighted scores to get a total for each option.
- Identify the top-scoring option and the runner-up.
- Calculate the gap between them. A narrow gap (less than 10% difference) means
  the decision is close and qualitative factors may tip it.

Step 6: Sensitivity Analysis
- Identify the 2-3 criteria where changing the weight or score by one point
  would change the winning option.
- State which assumptions are most fragile.
- If the decision is sensitive to a single criterion, flag it and recommend
  gathering more data on that dimension.

Step 7: Self-Critique Checklist
Before presenting the final matrix, verify each item:
[ ] The decision question is specific and answerable.
[ ] Must-have criteria have been applied as filters, not scores.
[ ] All scored criteria have clear, non-overlapping definitions.
[ ] Weights show genuine differentiation (not all the same).
[ ] Every score has a justification, not just a number.
[ ] The sensitivity analysis identifies the most fragile assumptions.
[ ] The recommendation acknowledges trade-offs, not just the winner.
[ ] No criterion is double-counted (e.g., "cost" and "total cost of ownership"
    measuring the same thing).

Anti-patterns to avoid:
1. Scoring an option high on every criterion because it is the "preferred" choice
   going in. Challenge confirmation bias explicitly.
2. Using vague criteria like "quality" or "goodness." Every criterion must be
   specific enough to score consistently.
3. Assigning equal weights to all criteria. This defeats the purpose of weighting
   and produces a simple average that hides priorities.
4. Ignoring switching costs and migration effort. These are real costs that
   belong in the matrix.
5. Treating the matrix output as the final answer. The matrix is an input to
   the decision, not the decision itself. Qualitative judgment still matters.
6. Anchoring scores to the first option evaluated. Score each option
   independently against the criterion definition.

Edge case handling:
- If the user provides fewer than two options, ask them to add at least one more
  or explain why this is the only viable path.
- If two options tie or are within 5% of each other, present both as viable and
  list the qualitative factors that should break the tie.
- If the user provides conflicting constraints (e.g., "lowest cost" and "best
  performance"), surface the tension and ask them to prioritize.
- If a criterion cannot be scored due to missing information, do not drop it.
  Mark it as TBD and note what data is needed to fill the gap.

Output format:

### Decision: [Restated question]

**Must-Have Filters:**
| Criterion | Requirement | Option A | Option B | Option C |
|-----------|------------|----------|----------|----------|
| ...       | ...        | Pass/Fail| Pass/Fail| Pass/Fail|

**Weighted Scoring Matrix:**
| Criterion (Weight) | Option A: Score | Justification | Option B: Score | Justification | Option C: Score | Justification |
|--------------------|----------------|---------------|----------------|---------------|----------------|---------------|
| ...                | ...            | ...           | ...            | ...           | ...            | ...           |

**Totals:**
| Option   | Weighted Total | Rank |
|----------|---------------|------|
| ...      | ...           | ...  |

**Sensitivity Analysis:** [Which weights or scores, if changed, would alter the outcome]

**Recommendation:** [Which option to choose and why, including trade-offs accepted]

**Open Questions:** [What data is still missing, what to revisit, and when]
```

## Usage Tips

- Start by listing your criteria and weights before asking the model to score. This keeps you in the driver's seat on priorities.
- If you are evaluating technical tools, include hands-on proof-of-concept results as input. The model can structure the comparison, but real-world testing data makes the scores credible.
- Share the matrix with stakeholders before the decision meeting, not during it. Give people time to challenge the weights and scores.
- Revisit the matrix if new information surfaces. Decision matrices are living documents during the evaluation period.
- Use the sensitivity analysis section to focus follow-up research. If the decision hinges on one uncertain score, invest time there.
- For high-stakes decisions, have two people score independently and then compare. Divergent scores reveal assumptions worth discussing.

## Example Output

### Decision: Which container orchestration platform should the infrastructure team adopt for production workloads?

**Must-Have Filters:**

| Criterion | Requirement | Kubernetes (self-managed) | OpenShift | Managed K8s (cloud provider) |
|-----------|------------|--------------------------|-----------|------------------------------|
| Runs on-premises | Required | Pass | Pass | Fail (eliminated) |
| Supports FIPS 140-2 | Required | Pass (with configuration) | Pass (built-in) | N/A |

*Managed K8s is eliminated due to the on-premises requirement. Scoring proceeds with the remaining two options.*

**Weighted Scoring Matrix:**

| Criterion (Weight) | Kubernetes: Score | Justification | OpenShift: Score | Justification |
|--------------------|------------------|---------------|-----------------|---------------|
| Total cost of ownership over 3 years (5) | 3 | Lower license cost, but requires more internal staffing for operations and support tooling | 2 | Subscription cost is significant; however, bundled tooling reduces need for third-party additions |
| Operational complexity (4) | 2 | Requires building monitoring, logging, and CI/CD integrations from individual components | 4 | Integrated console, built-in CI/CD, and opinionated defaults reduce operational burden |
| Team ramp-up time (4) | 3 | Team has some Kubernetes experience; estimated 2-3 months to production readiness | 4 | OpenShift abstracts many low-level details; estimated 1-2 months to production readiness |
| Ecosystem and community support (3) | 5 | Largest open source community, broadest ecosystem of tools and extensions | 4 | Strong community, but some tooling is OpenShift-specific and less portable |
| Security and compliance tooling (5) | 3 | Requires manual configuration of pod security, network policies, and audit logging | 5 | Built-in security context constraints, integrated image scanning, and audit logging out of the box |
| Long-term flexibility (3) | 5 | No vendor lock-in; portable across any infrastructure | 3 | Tightly coupled to Red Hat ecosystem; migration away would be costly |

**Totals:**

| Option | Weighted Total | Rank |
|--------|---------------|------|
| OpenShift | 86 | 1 |
| Kubernetes (self-managed) | 79 | 2 |

**Sensitivity Analysis:**
- If "Total cost of ownership" weight increases from 5 to 5 and Kubernetes scores a 4 instead of 3 (e.g., the team finds a way to reduce staffing overhead), the gap closes to 2 points.
- If "Long-term flexibility" weight increases from 3 to 5, Kubernetes pulls ahead by 1 point. This criterion is the most likely to shift the outcome.
- The decision is moderately sensitive to the security and compliance scoring. If the team invests in automating Kubernetes security tooling, that score could rise to 4, narrowing the gap further.

**Recommendation:** OpenShift is the stronger choice given the team's current priorities around security, compliance, and operational simplicity. The trade-off is higher licensing cost and reduced portability. This trade-off is acceptable if the team expects to stay in the Red Hat ecosystem for the next 3+ years.

**Open Questions:**
- Get a formal quote from Red Hat for the OpenShift subscription to validate the cost assumptions.
- Confirm whether the existing team's Kubernetes experience transfers directly to OpenShift or if additional training is needed.
- Revisit the "long-term flexibility" criterion in 18 months. If multi-cloud becomes a strategic priority, the weight on this criterion should increase.
