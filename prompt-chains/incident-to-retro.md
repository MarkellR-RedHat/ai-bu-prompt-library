# Incident to Retrospective

Turn a production incident into a thorough, blameless retrospective document and prevention plan. This chain walks you through building a timeline, identifying root causes, generating action items, assembling the retro document, and producing a prevention plan that addresses systemic issues rather than just symptoms.

**Difficulty:** Advanced

---

## Naive vs. Engineered

**What most people do:** Paste a wall of incident data into a single prompt and ask "write me a retrospective." The result looks like this:

> **Incident Retrospective**
>
> **Summary:** A production outage occurred on Friday afternoon, affecting the order processing API for approximately one hour.
>
> **Root Cause:** A bad deployment caused the database to become overloaded.
>
> **Action Items:**
> - Improve monitoring
> - Add more tests
> - Review deployment process
>
> **Lessons Learned:** We should be more careful with deployments and improve our testing practices.

The timeline is vague ("Friday afternoon"), the root cause stops at "a bad deployment" without asking why the system allowed that deployment to cause an outage, the action items are so generic they could apply to any incident at any company, and there is no prevention plan. "Be more careful" is not a systemic fix.

**Why that falls flat:** A single prompt forces the model to do five different cognitive tasks at once: reconstruct events, analyze causes, generate actions, write a polished document, and think systemically. When you ask for everything at once, the model satisfices on each task rather than excelling at any of them. The timeline gets simplified to make room for the analysis. The root causes stay shallow because the model is already drafting prose. The action items are vague because the model never deeply examined what went wrong.

**What this workflow produces instead:** Five focused steps, each building on verified output from the previous one. The timeline is thorough because that is the only job in Step 1. The root cause analysis is deep because it works from a complete, reviewed timeline. The action items are specific because they trace directly to validated root causes. The retro document is polished because it assembles reviewed components rather than generating everything from scratch. The prevention plan is systemic because it starts from a finished retrospective, not raw data.

The difference is not subtle. Run it once and compare the output to what you get from a single prompt. You will not go back.

## When to Use

- A production incident has been resolved and you need to write the retrospective.
- You have raw incident data (chat logs, alerts, dashboards, postmortem notes) and need to turn it into a structured analysis.
- You want to ensure the retro produces genuine preventive action rather than a list of tasks that quietly expires.

## When NOT to Use

- The incident is still ongoing. Finish fighting the fire first.
- You are writing a customer-facing incident report. This chain produces an internal engineering retrospective, not a status page update.
- The incident was trivial (a typo in a config that was caught in staging). Not every incident needs a five-step retrospective.

## Workflow Recipe

### What You Start With

- Raw, messy incident data: Slack logs, PagerDuty alerts, Grafana screenshots (described in text), status page updates, notes from responders, ticket numbers
- The incident is resolved and the dust has settled
- You have 30 to 60 minutes to produce a first draft

### What You End With

- A complete, blameless retrospective document ready for team review
- A structured prevention plan that addresses the pattern, not just this one incident
- Concrete, assignable action items with priorities and verification criteria

### The Steps

This workflow has five steps. The ordering is deliberate and each step depends on the previous one.

1. **Build the timeline.** Reconstruct what happened, when, and who did what. A clean timeline is the foundation for everything else. Without it, root cause analysis drifts into speculation. *Output: a chronological timeline table with key timestamps, information gaps, and initial observations.*

2. **Identify root causes.** Use the timeline to distinguish contributing factors from root causes. This step applies structured analysis (the "5 Whys" technique or similar) to avoid stopping at surface-level explanations. *Output: contributing factors classified by type, 5 Whys chains, root causes, and what went well and poorly.*

3. **Generate action items.** Convert root causes into concrete, assignable, measurable action items. This step also categorizes items by type (detection, prevention, response) and priority. *Output: a prioritized action items table with effort estimates, dependencies, and verification criteria.*

4. **Assemble the retro document.** Combine all previous outputs into a single, polished retrospective document that follows a standard format. This is the artifact that gets shared with the team and stakeholders. *Output: a complete markdown retrospective document ready for review.*

5. **Create the prevention plan.** Zoom out from this specific incident to identify systemic improvements. Good prevention plans address patterns, not just the one thing that broke. *Output: a systemic prevention plan with detection improvements, process changes, metrics, and a review schedule.*

Running these steps in order prevents a common failure mode: jumping straight to action items without understanding the root cause, which produces fixes that address symptoms instead of causes.

---

## Step 1: Build the Timeline

```
You are an incident analyst specializing in production systems. Your job is
to take raw, unstructured incident data and produce a clean, factual timeline.
You are meticulous about timestamps, causation vs. correlation, and
distinguishing facts from assumptions.

Here is the raw incident data. This may include chat logs, alert
notifications, dashboard screenshots (described), status page updates,
and notes from the incident commander or responders:

<incident_data>
[PASTE RAW INCIDENT DATA HERE: chat logs, alert texts, notes, dashboards,
 ticket numbers, anything you have]
</incident_data>

Produce a structured timeline with the following sections:

1. INCIDENT SUMMARY (3-4 sentences): What happened, at the highest level?
   What service or system was affected? What was the user impact? How long
   did it last?

2. TIMELINE TABLE: A chronological table with these columns:
   - Timestamp (use UTC; note if times are approximate)
   - Event (what happened)
   - Source (where this information came from: alert, chat log, dashboard, etc.)
   - Actor (who did something, or "automated" for system actions)
   - Category: one of DETECTION, INVESTIGATION, MITIGATION, RESOLUTION,
     COMMUNICATION

3. KEY TIMESTAMPS:
   - Time of first user impact (or best estimate)
   - Time of first alert
   - Time incident was declared
   - Time of mitigation (user impact reduced)
   - Time of full resolution
   - Total duration of user impact
   - Time to detect (first impact to first alert)
   - Time to mitigate (first alert to mitigation)

4. INFORMATION GAPS: What parts of the timeline are uncertain or missing?
   What data would help fill them in? Be specific about what you could not
   determine from the available information.

5. INITIAL OBSERVATIONS (bulleted list): Note any patterns you see in the
   timeline, but label them as observations rather than conclusions.
   Examples: "There was a 15-minute gap between the first alert and the
   first human response" or "Three separate config changes were deployed
   in the hour before the incident."

OUTPUT FORMAT: Use the exact section headers above. The timeline table should
be in markdown table format. Use 24-hour UTC timestamps.

ANTI-PATTERNS TO AVOID:
- Do not assign blame. Use names only to track who did what; do not
  characterize anyone's actions as mistakes.
- Do not speculate about causes in the timeline. Record what happened, not why.
- Do not skip events that seem unimportant. A thorough timeline includes
  dead ends and false starts, because those often reveal process issues.
- Do not use em dashes. Use commas, semicolons, colons, or separate
  sentences instead.
- Do not round timestamps to make the story cleaner. If the data says
  14:03, do not write "around 2 PM."
```

---

> **CHECKPOINT: Review the timeline before proceeding.** Read through the timeline table and key timestamps. Are the timestamps accurate? Are there events you remember that are missing? Is anything listed as fact that is actually uncertain? Correct errors and fill gaps now. Every subsequent step builds on this timeline, so mistakes here will compound. Once you are satisfied, paste the Step 1 output into the placeholder in Step 2.

## Step 2: Root Cause Analysis

```
You are a systems reliability engineer conducting a root cause analysis.
You understand that most incidents have multiple contributing factors, and
that "human error" is never a root cause; it is a symptom of a system that
made the error possible or likely. You practice blameless analysis.

Here is the incident timeline from the previous step:

<timeline>
[PASTE OUTPUT FROM STEP 1 HERE]
</timeline>

Conduct a root cause analysis and produce the following:

1. CONTRIBUTING FACTORS (bulleted list): List every factor that contributed
   to this incident. For each factor, classify it as one of:
   - TRIGGER: The immediate event that started the incident
   - ENABLING CONDITION: Something that was already true and made the
     incident possible
   - AMPLIFIER: Something that made the incident worse or longer than
     it needed to be
   - DETECTION GAP: A reason the incident was not caught sooner

2. "5 WHYS" ANALYSIS: Starting from the most immediate cause, ask "why"
   repeatedly until you reach a systemic issue. Show your chain of
   reasoning. Stop when you reach a factor that is about process, tooling,
   or organizational structure rather than a specific technical event.
   Run this analysis for the top 2-3 contributing factors.

3. ROOT CAUSES (2-4 items): Based on the 5 Whys analysis, state the root
   causes. A good root cause meets these criteria:
   - Fixing it would have prevented this specific incident
   - Fixing it would likely prevent similar future incidents
   - It is about a system, process, or design, not about a person's judgment

4. WHAT WENT WELL (bulleted list): What worked during the incident response?
   What prevented the incident from being worse? Retros that only focus on
   failures miss the chance to reinforce good practices.

5. WHAT WENT POORLY (bulleted list): Beyond the root causes, what made the
   response harder? Think about communication, tooling, runbooks, escalation
   paths, and access controls.

6. SURPRISE FACTOR: On a scale of 1-5, how surprising was this incident?
   1 = "we knew this could happen and had not fixed it" to 5 = "no one
   predicted this failure mode." Justify your rating.

OUTPUT FORMAT: Use the exact section headers above. Be specific and reference
the timeline by timestamp when possible.

ANTI-PATTERNS TO AVOID:
- Do not stop at "someone made a mistake." Ask why the system allowed that
  mistake to have the impact it did.
- Do not list "better monitoring" as a root cause. That is a solution, not
  a cause. The root cause is the specific gap in monitoring.
- Do not confuse the trigger with the root cause. The trigger is what set
  things off; the root cause is why the system was vulnerable.
- Do not use em dashes anywhere in your output.
- Do not write root causes that are so broad they are meaningless, such as
  "we need to be more careful" or "communication could be improved."
```

---

> **CHECKPOINT: Validate the root causes before proceeding.** Do the root causes ring true? Did the "5 Whys" analysis stop too early or go too deep into speculation? Is "human error" listed as a root cause (it should not be)? If a root cause feels too neat or too vague, run Step 2 again with a note asking the model to dig deeper on that specific factor. Once you are satisfied, paste outputs from Steps 1 and 2 into Step 3.

## Step 3: Generate Action Items

```
You are an engineering program manager who specializes in turning incident
retrospectives into concrete, trackable action items. You know that vague
action items ("improve monitoring") never get done, and that action items
without owners decay into wishful thinking.

Here is the root cause analysis from the previous step:

<root_cause_analysis>
[PASTE OUTPUT FROM STEP 2 HERE]
</root_cause_analysis>

And here is the incident timeline for reference:

<timeline>
[PASTE OUTPUT FROM STEP 1 HERE]
</timeline>

Generate action items and produce the following:

1. ACTION ITEMS TABLE: A table with these columns:
   - ID (AI-1, AI-2, etc.)
   - Description (specific, actionable, starts with a verb)
   - Root cause addressed (reference by number from Step 2)
   - Category: one of PREVENT (stop it from happening), DETECT (catch it
     faster), RESPOND (handle it better when it happens), RECOVER (reduce
     blast radius or recovery time)
   - Priority: P1 (do this week), P2 (do this sprint/iteration), P3 (do
     this quarter), P4 (backlog, track but do not schedule yet)
   - Effort estimate: S (hours), M (days), L (weeks), XL (months)
   - Suggested owner (role, not person, unless you know the team structure)

2. QUICK WINS (subset of above): Which action items are high-impact and
   low-effort? These should be done first regardless of other prioritization.

3. DEPENDENCIES: Are any action items blocked by others? Note the
   dependencies explicitly.

4. VERIFICATION CRITERIA: For each P1 and P2 action item, describe how
   you will know it is done. What test, metric, or observable behavior
   confirms the fix is in place?

5. ITEMS TO AVOID: List 1-3 action items that might seem obvious but
   would be counterproductive. Explain why. Examples: adding an alert
   that will just create noise, or writing a runbook for a scenario that
   should be automated away entirely.

OUTPUT FORMAT: Use the exact section headers above. The action items table
should be in markdown table format. Action descriptions should be specific
enough that someone could pick one up and start working without asking
clarifying questions.

ANTI-PATTERNS TO AVOID:
- Do not write action items that start with "consider" or "evaluate."
  Those are not actions; they are suggestions to think about actions.
- Do not create more than 10 action items. If you have more, prioritize
  and merge. Too many action items is the same as no action items.
- Do not assign everything as P1. If everything is urgent, nothing is.
- Do not write action items that duplicate existing work. If a related
  project is already in flight, note it rather than creating a new item.
- Do not use em dashes. Use commas, semicolons, colons, or periods instead.
```

---

> **CHECKPOINT: Audit the action items before proceeding.** Are there more than 10 items? Consolidate. Do any start with "consider" or "evaluate"? Rewrite them as concrete actions. Is everything marked P1? Reprioritize. Are the verification criteria specific enough that you would know the item is done? Fix any that are vague. Once the list is clean, paste outputs from Steps 1, 2, and 3 into Step 4.

## Step 4: Assemble the Retro Document

```
You are a technical writer who specializes in incident retrospectives for
engineering organizations. You write clearly, without jargon or hedging,
and you understand that a retro document serves multiple audiences:
the team that owns the service, leadership who needs a summary, and
future engineers who will read this when a similar incident occurs.

Here is all the material from previous steps:

<timeline>
[PASTE OUTPUT FROM STEP 1 HERE]
</timeline>

<root_cause_analysis>
[PASTE OUTPUT FROM STEP 2 HERE]
</root_cause_analysis>

<action_items>
[PASTE OUTPUT FROM STEP 3 HERE]
</action_items>

Additional context (fill in what you can):
- Incident ID/ticket number: [e.g., INC-2024-0042]
- Severity level: [e.g., SEV-1, SEV-2]
- Services affected: [list]
- Incident commander: [name]
- Retro meeting date: [date]
- Author: [name]

Assemble a complete retrospective document with the following structure:

1. HEADER: Title formatted as "[Date] [Service] Incident Retrospective."
   Include metadata: severity, duration, incident commander, author, date
   of retro, document status (draft/final).

2. EXECUTIVE SUMMARY (1 paragraph, 4-6 sentences): What happened, what
   the impact was, what the root causes were, and what the team is doing
   about it. A VP should be able to read this paragraph and understand
   the situation without reading further.

3. IMPACT STATEMENT: Quantify the impact. Include:
   - Number of users or requests affected
   - Duration of user-facing impact
   - Revenue impact (if known or estimable)
   - SLA/SLO implications
   - Any downstream service impacts

4. TIMELINE: Include the timeline table from Step 1, cleaned up and
   formatted consistently.

5. ROOT CAUSE ANALYSIS: Include the root causes and contributing factors
   from Step 2, written in clear prose rather than raw analysis format.

6. WHAT WENT WELL / WHAT WENT POORLY: Include these sections from Step 2.

7. ACTION ITEMS: Include the action items table from Step 3.

8. LESSONS LEARNED (3-5 bullets): What did the team learn from this
   incident that applies beyond just fixing the immediate problem?
   These should be insights, not restatements of the action items.

9. APPENDIX: List any supporting materials (links to dashboards, chat
   logs, related incidents, monitoring queries) with brief descriptions.

OUTPUT FORMAT: Produce a complete markdown document. Use consistent heading
levels (H1 for title, H2 for major sections, H3 for subsections). The
document should be ready to share after a human review pass.

ANTI-PATTERNS TO AVOID:
- Do not soften the impact. If the incident was bad, say so plainly.
- Do not use passive voice to obscure who did what. "A deploy was pushed"
  is worse than "The on-call engineer deployed the fix at 14:32 UTC."
- Do not editorialize. Report facts and analysis, not feelings.
- Do not use em dashes anywhere in the document.
- Do not include placeholder text like "[TBD]" for information you have.
  Only use placeholders for information you genuinely do not have.
```

---

> **CHECKPOINT: Review the assembled document before proceeding.** Read the retrospective as a stakeholder would. Does the executive summary make sense without reading the rest? Is the impact statement specific? Does the narrative flow logically from timeline to root causes to action items? Mark anything that needs editing, but do not worry about wordsmithing yet. Once the structure is sound, paste the full document into Step 5.

## Step 5: Create the Prevention Plan

```
You are a reliability engineering lead who thinks in systems. You have seen
dozens of retrospectives, and you know that most action items fix the
specific incident but do not address the pattern. Your job is to zoom out
from this one incident and identify systemic improvements that reduce the
likelihood of an entire category of failures.

Here is the full retrospective document:

<retro_document>
[PASTE OUTPUT FROM STEP 4 HERE]
</retro_document>

Produce a prevention plan with the following sections:

1. PATTERN IDENTIFICATION: What category of incident is this? Name the
   pattern (e.g., "configuration drift," "cascading failure due to missing
   circuit breaker," "deployment without rollback capability"). Describe
   2-3 other incidents (real or hypothetical) that fit the same pattern.

2. SYSTEMIC IMPROVEMENTS (3-5 items): For each improvement:
   - What is it? (one sentence)
   - What pattern does it break? (reference the pattern from section 1)
   - What would it have changed about this incident? (specific, referencing
     the timeline)
   - What is the investment? (rough scope: small/medium/large project)
   - What is the expected reduction in incident frequency or severity?
   - Are there tradeoffs? (e.g., increased deploy time, added complexity,
     operational overhead)

3. DETECTION IMPROVEMENTS: How should the team's monitoring, alerting, or
   observability change to catch this category of incident earlier? Be
   specific about:
   - What signals to watch
   - What thresholds to set
   - What dashboards or runbooks to create or update
   - How to avoid alert fatigue (do not just add more alerts)

4. PROCESS IMPROVEMENTS: What changes to deployment, review, or operational
   processes would reduce risk? Consider:
   - Change management and approval workflows
   - Canary deployments or progressive rollouts
   - Pre-deploy validation checks
   - On-call procedures and escalation paths
   - Knowledge sharing and documentation

5. MEASUREMENT PLAN: How will the team know if the prevention plan is
   working? Define 2-3 metrics or indicators to track over the next
   quarter. Each metric should have:
   - What to measure
   - Current baseline (from this incident)
   - Target value
   - How to measure it (specific tool or query)

6. REVIEW SCHEDULE: When should the team review this prevention plan to
   check progress? Suggest specific dates and what to evaluate at each
   checkpoint.

OUTPUT FORMAT: Use the exact section headers above. The prevention plan
should be actionable and specific, not a list of good intentions.

ANTI-PATTERNS TO AVOID:
- Do not propose improvements that are really just the action items from
  Step 3 reworded. This plan is about systemic change, not incident-specific
  fixes.
- Do not recommend "more testing" without specifying what kind of testing
  and what it would catch.
- Do not propose process changes that add friction without adding safety.
  Every new gate or approval step has a cost.
- Do not use em dashes anywhere in your output.
- Do not write a plan that requires a large infrastructure team if the
  organization has three engineers. Scale recommendations to the team.
```

---

## Why This Works

Prompt chaining produces better retrospectives than a single prompt for three specific reasons.

**Separation of concerns.** Each step asks the model to do exactly one cognitive task. Step 1 reconstructs events. Step 2 analyzes causes. Step 3 generates actions. When a model does one thing at a time, it does that thing well. When it does five things at once, it takes shortcuts on all of them.

**Verified intermediate outputs.** The checkpoints between steps let you catch and correct errors before they propagate. A wrong timestamp in the timeline becomes a wrong root cause, which becomes a wrong action item. Reviewing the timeline before analyzing it is dramatically cheaper than discovering the error in the final document.

**Progressive context building.** Each step receives the output of all previous steps, so the model's context gets richer and more accurate as the chain progresses. By Step 5, the model is working from a complete, reviewed retrospective rather than raw incident data. This is why the prevention plan can identify systemic patterns instead of just restating the action items.

## Tips for Running This Workflow

- **Gather your raw data before starting.** The more you put into Step 1, the better the entire chain works. Chat logs and alert timestamps are especially valuable.
- **Review the timeline carefully.** The timeline is the foundation. If it is wrong, every subsequent step will be wrong. Take the time to verify timestamps and correct any errors before moving on.
- **Run Step 2 with a skeptical eye.** The "5 Whys" analysis sometimes converges too early. If the root cause feels too neat, push back and ask for another pass.
- **Keep the action items list short.** Fewer, better action items are more effective than a long list. If Step 3 produces more than 10, ask the model to consolidate.
- **The prevention plan (Step 5) is where the real value is.** Most retros stop at action items. The prevention plan is what turns a single incident into a lasting improvement.
- **Involve the team.** Run the chain to produce a draft, then review it with the people who responded to the incident. They will catch errors and add context that the raw data does not capture.
- **If the raw incident data exceeds the model's context window,** split it into phases (detection, mitigation, resolution) and run Step 1 once per phase, then combine the timelines before proceeding to Step 2.
- **If you are running this on a smaller model (under 32k context),** consider running Steps 1-3 as standalone prompts and assembling the results manually rather than passing cumulative context that may overflow.
- **Slash command connection:** If you use `claude-commands`, the `/retro` slash command automates this entire chain against a repository's recent activity, and the `/summarize-thread` slash command can extract raw incident data from long discussion threads.

## Example

Below is an abbreviated example showing output from Steps 1 and 2 for a hypothetical database connection pool exhaustion incident.

### Example Step 1 Output

> **INCIDENT SUMMARY:** On 2024-03-15, the user-facing API for the order processing service became unresponsive due to database connection pool exhaustion. Approximately 12,000 users were unable to place orders for 47 minutes. The incident was triggered by a slow query introduced in a deploy 2 hours before the outage began.
>
> **TIMELINE TABLE:**
>
> | Timestamp (UTC) | Event | Source | Actor | Category |
> |---|---|---|---|---|
> | 12:15 | Deploy v2.4.7 pushed to production | CI/CD logs | Automated | N/A |
> | 14:02 | Connection pool utilization exceeds 80% | Grafana alert | Automated | DETECTION |
> | 14:08 | First user reports of failed orders in support channel | Slack | Customer support | DETECTION |
> | 14:14 | On-call engineer acknowledges alert | PagerDuty | On-call engineer | INVESTIGATION |
> | 14:22 | Incident declared as SEV-1 | Slack | On-call engineer | COMMUNICATION |
> | 14:31 | Slow query identified via database query logs | PostgreSQL logs | On-call engineer | INVESTIGATION |
> | 14:38 | Decision made to roll back v2.4.7 | Slack | Incident commander | MITIGATION |
> | 14:45 | Rollback initiated | CI/CD | On-call engineer | MITIGATION |
> | 14:49 | Rollback complete, connection pool draining | Grafana | Automated | RESOLUTION |
> | 14:55 | API response times return to normal | Grafana | Automated | RESOLUTION |
>
> **KEY TIMESTAMPS:**
> - First user impact: ~14:02 UTC
> - First alert: 14:02 UTC
> - Incident declared: 14:22 UTC
> - Mitigation: 14:49 UTC
> - Full resolution: 14:55 UTC
> - Total user impact: ~53 minutes
> - Time to detect: ~0 minutes (alert fired as impact began)
> - Time to mitigate: 47 minutes

### Example Step 2 Output

> **CONTRIBUTING FACTORS:**
> - TRIGGER: A new database query in v2.4.7 performed a full table scan on the orders table (3.2M rows), taking 8-12 seconds per execution instead of the expected 50ms.
> - ENABLING CONDITION: The connection pool maximum was set to 20 connections, a default value that had never been tuned for current traffic levels.
> - ENABLING CONDITION: No query performance review was part of the deploy pipeline. The slow query passed code review because the reviewer focused on correctness, not performance.
> - AMPLIFIER: The rollback process required manual approval from the incident commander, adding 7 minutes to the mitigation timeline.
> - DETECTION GAP: The connection pool utilization alert had an 80% threshold but no warning at 60%, so the team had no early warning.
>
> **"5 WHYS" ANALYSIS (Trigger):**
> 1. Why did the API go down? Connection pool was exhausted.
> 2. Why was the connection pool exhausted? A query was holding connections for 8-12 seconds each.
> 3. Why was the query so slow? It performed a full table scan instead of using an index.
> 4. Why was there no index? The query was new and the migration did not include an index.
> 5. Why was the missing index not caught? There is no automated query performance check in the deploy pipeline.
>
> **ROOT CAUSES:**
> 1. No automated query performance validation in the CI/CD pipeline. Slow queries can reach production without any performance gate.
> 2. Connection pool defaults have never been reviewed against current traffic patterns. The pool size was set during initial setup when traffic was 10x lower.
>
> **WHAT WENT WELL:**
> - The alert fired immediately when connection pool utilization spiked.
> - The on-call engineer identified the slow query within 17 minutes.
> - The team had a working rollback process, even though it required manual approval.
>
> **WHAT WENT POORLY:**
> - 20-minute gap between alert and incident declaration. The on-call engineer tried to diagnose alone before escalating.
> - Rollback required manual approval, adding delay during a SEV-1.
> - No pre-deploy check for query performance regressions.
>
> **SURPRISE FACTOR:** 2/5. The team knew the connection pool defaults were stale (it was on a backlog ticket from six months ago). The specific trigger was new, but the vulnerability was known.
