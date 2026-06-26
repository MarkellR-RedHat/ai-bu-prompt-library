# Structured Trade-Off Analysis

A prompt for systematically evaluating competing technical options against weighted criteria to make well-documented engineering decisions.

**Difficulty:** Intermediate

## Naive vs. Engineered

**Naive prompt:** "Compare gRPC vs REST for our internal services."

**What you get:** Output like this:

> **gRPC vs. REST:**
>
> gRPC offers better performance with binary serialization and native streaming support. REST is simpler, more widely understood, and easier to debug. gRPC has a steeper learning curve but scales better for high-throughput services. REST is the safer choice for most teams.
>
> **Conclusion:** It depends on your use case. Consider your team's experience and performance requirements.

No weighted criteria, no evidence-backed ratings, no analysis of second-order effects, no risk assessment, and no clear recommendation. "It depends on your use case" is where you started. You have spent ten minutes reading what you already knew.

**This prompt** produces a structured analysis with a clear decision frame, 6-10 precisely defined and weighted evaluation criteria, an evidence-backed comparison matrix, second-order effects over a 2+ year horizon, a risk assessment with mitigations, and a recommendation that explicitly states what you are trading away. For example, instead of "gRPC is faster," you get "Latency at 10K RPS (CRITICAL): gRPC STRONG, measured 8ms P99 in bench; REST ADEQUATE, measured 22ms P99 in bench. Both within the 50ms target, but gRPC has more headroom above 50K RPS." The difference is between a "here are some pros and cons" list and a defensible engineering decision that you can present to a review board, put in an ADR, and revisit with confidence when circumstances shift.

## When to use

- You are choosing between two or more technical approaches (libraries, architectures, protocols, vendors) and need a defensible recommendation.
- A design review or architecture decision record (ADR) requires a structured comparison of alternatives.
- Stakeholders disagree on the right approach and you need a framework that separates opinions from evidence.
- You are evaluating whether to build, buy, or adopt an open source solution for a specific capability.
- You need to document why a particular option was chosen so future engineers understand the reasoning.
- You are preparing a technical proposal for leadership and want to show that alternatives were rigorously considered.

## When NOT to use

- The decision has already been made and you are looking for post-hoc justification. This prompt is for genuine evaluation, not rubber-stamping.
- The options are not meaningfully comparable (for example, comparing a database to a message queue). Reframe the decision first.
- You need a financial-only analysis with NPV, IRR, or payback period calculations. Use the cost-benefit prompt instead.
- The choice is trivial or easily reversible. Not every decision warrants a formal trade-off analysis; save it for decisions that are expensive to undo.

## Prompt

```
You are a principal engineer with deep experience in systems architecture,
distributed systems, and engineering trade-offs. You approach technical
decisions with rigor, intellectual honesty, and a bias toward clarity
over cleverness.

Conduct a structured trade-off analysis for the following decision.

Decision: [DESCRIBE THE DECISION IN ONE SENTENCE]
Context: [WHY THIS DECISION MATTERS NOW, WHAT TRIGGERED IT]
Options Under Consideration:
  - Option A: [NAME AND BRIEF DESCRIPTION]
  - Option B: [NAME AND BRIEF DESCRIPTION]
  - Option C (if applicable): [NAME AND BRIEF DESCRIPTION]
Constraints: [HARD CONSTRAINTS: budget ceiling, timeline, compliance
requirements, team skills, existing infrastructure commitments]
Decision Stakeholders: [WHO WILL BE AFFECTED BY THIS DECISION]

Follow these steps in order:

STEP 1 - CLARIFY THE DECISION FRAME
Restate the decision as a clear, answerable question. Identify what
"success" looks like for this decision 6 months from now and 2 years
from now. These timeframes matter because the best short-term choice
is often not the best long-term choice.

STEP 2 - DEFINE EVALUATION CRITERIA
Propose 6-10 evaluation criteria relevant to this decision. For each
criterion:
  - Define it precisely (what does "scalability" mean in this context?)
  - Assign a weight: CRITICAL (must-have, disqualifying if absent),
    HIGH (strongly influences the decision), MEDIUM (matters but not
    decisive), or LOW (nice-to-have)
  - State how you will measure or assess it (quantitative metric,
    qualitative judgment, or binary yes/no)

Common criteria to consider (include only those relevant):
  - Performance characteristics (latency, throughput, resource efficiency)
  - Operational complexity (deployment, monitoring, debugging, upgrades)
  - Security posture (authentication, authorization, data protection, audit)
  - Team capability and learning curve
  - Community health and long-term viability
  - Integration with existing systems
  - Licensing and compliance
  - Cost (initial, ongoing, scaling cost curve)
  - Reversibility (how hard is it to switch later?)

STEP 3 - EVALUATE EACH OPTION
For each option, assess it against every criterion. Use this scale:
  STRONG: clearly meets or exceeds the criterion
  ADEQUATE: meets the criterion with minor caveats
  WEAK: partially meets the criterion with significant gaps
  FAILS: does not meet the criterion

For each rating, provide a specific justification. Do not rate without
evidence or reasoning. If you lack information to rate a criterion,
say UNKNOWN and note what investigation would be needed.

Present the results in a comparison matrix (table format).

STEP 4 - ANALYZE SECOND-ORDER EFFECTS
For each option, answer:
  - What does this choice make easier in the future?
  - What does this choice make harder or foreclose?
  - What new risks does this choice introduce?
  - What maintenance burden does this choice create over 2-3 years?
  - How does this choice affect hiring, onboarding, or team structure?

STEP 5 - IDENTIFY RISKS AND MITIGATIONS
For each option, list the top 3 risks. For each risk:
  - Likelihood: HIGH, MEDIUM, or LOW
  - Impact: HIGH, MEDIUM, or LOW
  - Mitigation: a specific action that reduces the risk
  - Residual risk after mitigation

STEP 6 - RECOMMENDATION
State your recommendation clearly. Structure it as:
  - Primary recommendation and the 2-3 strongest reasons for it
  - What you are trading away by choosing this option (be honest)
  - Conditions that would change your recommendation
  - Suggested validation steps before fully committing

STEP 7 - SELF-CRITIQUE CHECKLIST
Before presenting your final analysis, verify:
  [ ] Each criterion is defined precisely, not used as a vague buzzword
  [ ] Ratings are justified with evidence, not just asserted
  [ ] The recommendation acknowledges real downsides, not just strengths
  [ ] Second-order effects consider a 2+ year time horizon
  [ ] At least one criterion addresses reversibility or switching cost
  [ ] The analysis does not assume current team size, skills, or
      priorities are permanent
  [ ] Constraints are respected (no recommendation violates a hard
      constraint)

ANTI-PATTERNS TO AVOID:
1. Strawmanning an option you do not prefer by understating its
   strengths or exaggerating its weaknesses.
2. Using vague criteria like "better developer experience" without
   defining what that means in measurable terms.
3. Ignoring total cost of ownership by focusing only on initial
   implementation cost.
4. Assuming the team will "learn it later" without accounting for the
   real cost of ramping up on unfamiliar technology.
5. Treating community popularity as a proxy for technical merit.
   Popular tools can be wrong for your use case.
6. Anchoring on the first option listed. Evaluate each option
   independently before comparing.

EDGE CASE HANDLING:
- If two options score nearly identically, explicitly call it out and
  recommend a time-boxed proof of concept rather than forcing a choice
  based on thin margins.
- If one option dominates on all criteria, double-check whether you
  have framed the criteria fairly. Lopsided results sometimes indicate
  biased framing rather than a clear winner.
- If a constraint eliminates all but one option, state that the decision
  is effectively made by the constraint, note the constraint, and
  recommend revisiting if the constraint changes.
- If the decision is highly reversible (for example, choosing a library
  behind a clean interface), say so and recommend spending less time
  analyzing and more time prototyping.

Format your output with clear Markdown headers for each step.
Use tables for the comparison matrix and risk assessment.
```

## Why This Works

**Principal engineer persona.** The prompt assigns the role of someone with deep experience in systems architecture who has a "bias toward clarity over cleverness." This framing produces output that prioritizes honest assessment over impressive-sounding analysis. Without it, the model tends toward a balanced-but-unhelpful "both options have merits" conclusion.

**Multi-step structured reasoning.** The seven-step sequence (frame, define criteria, evaluate, analyze second-order effects, assess risks, recommend, self-critique) forces the model to build the analysis methodically rather than jumping to a conclusion. Each step depends on the previous one, creating a chain of reasoning that is easy to audit and challenge.

**Weighted criteria with precise definitions.** Requiring each criterion to be defined precisely ("what does scalability mean in this context?") and weighted (CRITICAL, HIGH, MEDIUM, LOW) prevents the model from using vague buzzwords. It also forces prioritization: if everything is critical, nothing is. This mirrors how real engineering decision-making works.

**Second-order effects analysis.** Step 4 asks what each choice makes easier, what it forecloses, what risks it introduces, and how it affects hiring and team structure over 2-3 years. Most trade-off analyses only look at immediate pros and cons. The second-order analysis is where the real insight lives, and most people skip it because they do not think to ask.

**Self-critique checklist.** The checklist catches confirmation bias (strawmanning the less-preferred option), vague criteria, missing reversibility analysis, and recommendations that ignore real downsides. These are the failure modes that make trade-off analyses unreliable, and explicitly checking for them produces noticeably more honest output.

**Edge case handling.** The prompt addresses near-ties (recommend a proof of concept), lopsided results (check for biased framing), constraint-eliminated options (say so directly), and highly reversible decisions (suggest spending less time analyzing). This prevents the model from applying the same heavyweight process regardless of the situation.

These techniques combine to produce the difference shown above: a defensible, evidence-backed recommendation instead of a pros-and-cons list that leaves the decision unmade.

## Usage Tips

- Be precise about constraints. "We have a tight timeline" is not helpful; "We must ship by Q3 and have two engineers available" gives the model something to work with.
- If you already have a preference, state it up front and ask the model to challenge it. This produces better analysis than pretending to be neutral.
- For vendor or product evaluations, paste in relevant sections of documentation, benchmark results, or feature comparison pages as additional context.
- Run the analysis twice with different weightings on the criteria to see how sensitive the recommendation is to your assumptions about what matters most.
- Use the "Conditions that would change your recommendation" section as a living checklist. Revisit it when circumstances shift.
- Share the comparison matrix with stakeholders before the full write-up. It surfaces disagreements about criteria weights early, which is where most real debates happen.

## Example Output

> ### Step 1: Decision Frame
>
> **Question:** Should we use gRPC or REST (OpenAPI 3.1) for the internal service mesh between the inference gateway and model-serving backends?
>
> **Success at 6 months:** The chosen protocol is in production, handling 10,000 RPS with P99 latency under 50ms, and the team can add new endpoints without external help.
>
> **Success at 2 years:** The protocol scales to 100,000 RPS, supports our multi-cluster rollout, and has not required a migration to something else.
>
> ### Step 3: Comparison Matrix (excerpt)
>
> | Criterion | Weight | gRPC | REST (OpenAPI 3.1) |
> |---|---|---|---|
> | Latency at 10K RPS | CRITICAL | STRONG: binary serialization, measured 8ms P99 in bench | ADEQUATE: JSON overhead, measured 22ms P99 in bench |
> | Operational debuggability | HIGH | WEAK: binary on the wire, requires grpcurl or custom tooling | STRONG: curl, browser, standard log parsing |
> | Team familiarity | HIGH | WEAK: 1 of 6 engineers has gRPC experience | STRONG: entire team has shipped REST APIs |
> | Streaming support | MEDIUM | STRONG: native bidirectional streaming | WEAK: requires SSE or WebSocket bolt-on |
> | Schema evolution | MEDIUM | STRONG: protobuf backward/forward compatibility | ADEQUATE: OpenAPI versioning works but requires discipline |
> | Reversibility | MEDIUM | ADEQUATE: behind service interface, switchable in 2-3 sprints | ADEQUATE: same reasoning applies |
>
> ### Step 6: Recommendation
>
> **Recommendation: REST (OpenAPI 3.1)** for the initial rollout, with a gRPC migration path documented for when throughput exceeds 50,000 RPS.
>
> **Strongest reasons:**
> 1. The team can ship faster with REST given current skills, and the 6-month deadline is a hard constraint.
> 2. Debuggability in production is significantly better with REST, which matters more during the early operational phase when we are still building observability.
> 3. Measured latency at 10K RPS (22ms P99) is well within our 50ms target.
>
> **What we trade away:** Native streaming (will need SSE for the real-time inference status endpoint) and the performance headroom that gRPC provides beyond 50K RPS.
>
> **Conditions that would change this:** If the traffic forecast moves to 50K+ RPS within 12 months, or if we hire two engineers with gRPC experience, revisit this decision.
