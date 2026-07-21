# Root Cause Analysis: 5 Whys + Fishbone

A prompt for conducting a structured root cause analysis of an incident or recurring problem using the 5 Whys technique combined with an Ishikawa (Fishbone) diagram.

**Difficulty:** Intermediate

## Naive vs. Engineered

**Naive prompt:** "Help me figure out why our API went down yesterday."

**What you get:** Output like this:

> **Possible Causes:**
> - It may have been related to a recent deployment.
> - The database could have been overloaded.
> - There might have been a network issue.
> - Perhaps the API rate limits were hit.
>
> **Recommendations:**
> - Improve monitoring to catch issues earlier.
> - Consider adding more capacity.
> - Review recent changes for potential problems.

A speculative list with no structured reasoning, no evidence linking any cause to the actual incident, and remediation so vague that nobody can act on it. "Improve monitoring" does not tell you what metric to watch, what threshold to set, or who owns it. You could have generated the same list by staring at a whiteboard for five minutes.

**This prompt** produces a full root cause analysis: a precise problem statement, a Fishbone diagram with factors categorized and marked as CONFIRMED, SUSPECTED, or RULED OUT, a 5 Whys chain with confidence levels and branching when multiple causes converge, classified root causes (technical, process, organizational), and tiered remediation with priorities and owner roles. For example, instead of "Improve monitoring," you get "Add a connection pool saturation alert at 80% with PagerDuty integration (P1, owner: SRE, this week)." The difference is between guessing at causes and building a traceable chain of reasoning from symptom to systemic fix that you can present to leadership and use to prevent recurrence.

## When to use

- You have just resolved an incident and need to write a thorough post-mortem that goes beyond surface-level symptoms.
- A production issue keeps recurring and you suspect the previous fix only addressed a symptom, not the actual root cause.
- You are facilitating a blameless retrospective and want a structured framework to guide the team through the analysis.
- You need to present root cause findings to leadership with clear, traceable reasoning from symptom to underlying cause.
- A change request or architecture decision needs justification grounded in a documented failure analysis.
- You are onboarding a new team member and want to walk them through how a past incident happened and why.

## When NOT to use

- The incident is still actively in progress. Focus on mitigation first; do root cause analysis after the fire is out.
- You already know the root cause with certainty and just need to write the fix. Skip the analysis and go straight to remediation.
- The problem is a one-time human error with no systemic dimension (for example, a typo in a config file caught in minutes). A lightweight correction is sufficient.

## Prompt

```
You are a senior site reliability engineer with 15+ years of experience
conducting blameless post-mortems and root cause analyses in large-scale
distributed systems. You specialize in combining the 5 Whys technique
with Ishikawa (Fishbone) diagrams to trace incidents from symptoms to
systemic root causes.

Conduct a root cause analysis for the following incident.

Incident Summary: [DESCRIBE THE INCIDENT IN 2-5 SENTENCES]
Impact: [DESCRIBE SCOPE: users affected, duration, revenue impact, SLA breach, etc.]
Environment: [PRODUCTION / STAGING / DEV, plus relevant infrastructure details]
Timeline: [KEY TIMESTAMPS: detection, escalation, mitigation, resolution]

Follow these steps in order:

STEP 1 - PROBLEM STATEMENT
Write a single, precise problem statement. It should describe the
observable symptom, not a presumed cause. Bad example: "The database
was misconfigured." Good example: "API response latency exceeded 5s
for 40% of requests to the /checkout endpoint between 14:00 and 15:30 UTC."

STEP 2 - FISHBONE DIAGRAM CATEGORIES
Organize potential contributing factors into these six categories:
  - People: training gaps, staffing, on-call coverage, communication breakdowns
  - Process: missing runbooks, inadequate change management, review gaps
  - Technology: software bugs, hardware failures, capacity limits, dependencies
  - Environment: network conditions, cloud provider issues, external integrations
  - Measurement: monitoring gaps, alerting thresholds, observability blind spots
  - Management: resource constraints, competing priorities, technical debt decisions

For each category, list 2-5 specific contributing factors that are
relevant to this incident. Mark each factor as CONFIRMED (evidence
exists), SUSPECTED (plausible but unverified), or RULED OUT (investigated
and eliminated). Include the evidence or reasoning for each designation.

STEP 3 - 5 WHYS CHAIN
Starting from the problem statement, ask "Why?" five times. At each
level, provide:
  - The question ("Why did X happen?")
  - The answer, supported by evidence (logs, metrics, timeline data)
  - Confidence level: HIGH, MEDIUM, or LOW
  - If the chain branches (multiple contributing causes at one level),
    follow each branch separately and label them (Branch A, Branch B, etc.)

Do not force exactly five levels if the true root cause surfaces at
level 3 or 4. Do not pad with superficial "whys" just to reach five.
Conversely, if the chain needs a sixth or seventh level, continue.

STEP 4 - ROOT CAUSE IDENTIFICATION
State the root cause (or root causes, if multiple independent chains
converge). Classify each as:
  - Technical: a bug, design flaw, or infrastructure limitation
  - Process: a missing or broken process, procedure, or policy
  - Organizational: a staffing, prioritization, or communication issue

STEP 5 - REMEDIATION RECOMMENDATIONS
For each root cause, propose:
  - Immediate fix: what to do this week to prevent recurrence
  - Short-term improvement: what to do this quarter to harden the system
  - Long-term systemic change: what to address in the next 6-12 months
Assign a priority (P1 critical, P2 high, P3 medium) and an owner role
(not a person's name) to each recommendation.

STEP 6 - SELF-CRITIQUE CHECKLIST
Before presenting your final analysis, verify the following:
  [ ] The problem statement describes a symptom, not a presumed cause
  [ ] Every factor in the fishbone is labeled CONFIRMED, SUSPECTED, or RULED OUT
  [ ] The 5 Whys chain does not stop at a human error without asking
      why the system allowed that error
  [ ] No blame is assigned to individuals; all findings are systemic
  [ ] Remediation actions are specific and actionable, not vague
      ("improve monitoring" is vague; "add a latency P99 alert at
      the gateway with a 3s threshold" is specific)
  [ ] At least one long-term recommendation addresses a systemic or
      organizational factor, not just a technical patch

ANTI-PATTERNS TO AVOID:
1. Stopping at "human error" as a root cause. Always ask why the system
   allowed, encouraged, or failed to catch the error.
2. Listing a single linear chain when multiple independent factors
   contributed. Use branches.
3. Proposing "be more careful" or "add more training" as a remediation
   without a concrete, measurable action.
4. Conflating correlation with causation. A deployment happened at the
   same time does not mean the deployment caused the incident without
   evidence.
5. Ignoring contributing factors outside your team's control. Document
   them and note the dependency, even if the fix requires another team.
6. Writing recommendations so vague that no one can act on them or
   verify they were completed.

EDGE CASE HANDLING:
- If the incident involved a cascading failure across multiple services,
  build a separate fishbone and 5 Whys chain for each service boundary,
  then link them in the root cause identification step.
- If evidence is incomplete (for example, logs were rotated or metrics
  were not collected), explicitly note the gap and recommend closing it
  as part of remediation.
- If the incident was caused by a known risk that was previously
  accepted, document the original risk acceptance decision and
  recommend revisiting it.
- If any placeholder fields are left unfilled (e.g., "[DESCRIBE THE
  INCIDENT]" or "[KEY TIMESTAMPS]"), do not generate an analysis with
  invented incident details. Instead, list the unfilled fields and ask
  the user to provide them. A root cause analysis built on assumed
  facts will produce misleading conclusions and wrong remediations.
- If the incident is in a domain outside software engineering (e.g.,
  manufacturing process failure, supply chain disruption, clinical
  workflow breakdown), adapt the Fishbone categories accordingly.
  Replace "Technology" with the relevant domain equivalent (e.g.,
  "Equipment" or "Materials") and adjust the People and Process
  categories to reflect domain-specific roles and procedures. The
  5 Whys technique works across domains, but the categories must
  match the environment.
- If the incident has no clear timeline data (e.g., the failure was
  discovered long after it started, or timestamps are unreliable),
  note the gap explicitly in the Problem Statement. Use relative
  sequencing ("A happened before B") rather than absolute timestamps,
  and flag timeline reconstruction as a remediation item.

Format your output with clear Markdown headers for each step.
Use tables where they improve readability.
```

## Why This Works

**Expert persona with specific credentials.** The prompt assigns the role of "a senior site reliability engineer with 15+ years of experience conducting blameless post-mortems." This is not decoration. It tells the model to think like someone who has seen hundreds of incidents and knows the difference between a symptom and a root cause. The "blameless" framing is especially important because it suppresses the model's tendency to stop at "human error" as an explanation.

**Dual-framework analysis (Fishbone plus 5 Whys).** Using two complementary frameworks produces better results than either alone. The Fishbone diagram casts a wide net across six categories (People, Process, Technology, Environment, Measurement, Management) to identify all contributing factors. The 5 Whys chain then drills deep on the most significant factors. Breadth plus depth.

**Evidence classification (CONFIRMED, SUSPECTED, RULED OUT).** Requiring each factor to be labeled with its evidence status prevents the model from presenting speculation as fact. This is critical in post-mortem work, where acting on unverified assumptions can lead to wrong fixes. It also builds a natural investigation checklist for follow-up.

**Chain-of-thought with branching.** The 5 Whys section explicitly allows branching when multiple causes contribute at the same level, and it includes confidence ratings (HIGH, MEDIUM, LOW) at each step. This prevents the common failure of forcing a complex incident into a single linear narrative when the reality involves multiple converging causes.

**Tiered remediation.** The three-tier structure (immediate fix, short-term improvement, long-term systemic change) ensures the analysis produces actions at every time horizon. Without this structure, post-mortems tend to produce either quick patches that do not prevent recurrence or ambitious long-term plans that never get started.

**Anti-pattern avoidance.** The explicit instruction to never stop at "human error," never conflate correlation with causation, and never write vague recommendations targets the three most common failures in root cause analysis. These are patterns the model would otherwise reproduce because they appear frequently in its training data.

These techniques combine to produce the difference shown above: a rigorous, evidence-based analysis with classified findings and actionable remediation, rather than a speculative list of guesses.

## Usage Tips

- Fill in the timeline section with precise timestamps. Vague timelines ("sometime in the afternoon") produce vague analyses.
- Run this prompt immediately after an incident while details are fresh, even if you plan to refine the post-mortem later with the full team.
- If you have logs, error messages, or metrics screenshots, paste them into the prompt as additional context. The more evidence you provide, the more specific the analysis will be.
- Use the SUSPECTED vs. CONFIRMED distinction to build a follow-up investigation checklist for factors you have not yet verified.
- Pair this with a remediation tracking tool (Jira, GitHub Issues, etc.) and create one ticket per recommendation with the priority and owner role from the output.
- For recurring incidents, run this analysis on the current occurrence, then compare it with past post-mortems to identify patterns in root causes that were not fully addressed.
- **Slash command connection:** If you use `claude-commands`, the `/retro` slash command can generate a full retrospective from the root cause analysis output.

## Example Output

> ### Step 1: Problem Statement
>
> API response latency for the /v2/inference endpoint exceeded 10 seconds for 62% of requests between 09:12 and 09:47 UTC on 2025-03-14, resulting in timeout errors for downstream clients and a breach of the 99.9% availability SLA.
>
> ### Step 2: Fishbone Diagram
>
> | Category | Factor | Status | Evidence |
> |---|---|---|---|
> | Technology | Connection pool exhaustion on inference gateway | CONFIRMED | Gateway logs show pool at 100% capacity by 09:14 |
> | Technology | Model server memory leak in v2.3.1 | SUSPECTED | Memory usage climbed 40% over 48 hours pre-incident |
> | Process | No load test run against the new gateway config | CONFIRMED | Change request CR-4412 has no load test results attached |
> | Measurement | No alert on connection pool saturation | CONFIRMED | Alert for pool usage was set at 95% but had been silenced |
> | Environment | Upstream traffic spike from partner integration | CONFIRMED | Ingress logs show 3x normal request volume starting 09:10 |
> | People | On-call engineer was in a meeting with notifications muted | SUSPECTED | Page went unacknowledged for 11 minutes |
>
> ### Step 3: 5 Whys (Branch A, Gateway)
>
> 1. **Why did requests time out?** The inference gateway could not allocate connections fast enough. (HIGH confidence, confirmed by gateway logs.)
> 2. **Why was the connection pool exhausted?** The pool was sized for 500 connections but the traffic spike pushed demand to 1,400. (HIGH confidence, metrics confirm.)
> 3. **Why was the pool sized at 500?** The default value from the initial deployment was never revisited after the partner integration was onboarded. (HIGH confidence, CR-2201 shows original sizing rationale.)
> 4. **Why was the sizing never revisited?** There was no capacity review step in the partner onboarding checklist. (HIGH confidence, checklist reviewed.)
>
> **Root Cause (Branch A):** Process gap. The partner onboarding process does not include a capacity review for shared infrastructure components.
>
> ### Step 5: Remediation (Branch A, excerpt)
>
> | Action | Priority | Owner Role | Timeframe |
> |---|---|---|---|
> | Increase gateway connection pool to 2,000 and add autoscaling | P1 | Platform Engineering | This week |
> | Add connection pool saturation alert at 80% with PagerDuty integration | P1 | SRE | This week |
> | Add capacity review step to partner onboarding checklist | P2 | Engineering Manager | This quarter |
> | Implement load testing as a required gate in the change management process | P2 | QE Lead | This quarter |
> | Audit all shared infrastructure components for static sizing that predates current traffic levels | P3 | Platform Engineering | Next 6 months |
