# Incident Post-Mortem Generator

A prompt for writing blameless, thorough incident post-mortems that capture what happened, why it happened, and how to prevent recurrence.

**Difficulty:** Intermediate

## When to use

- Writing a post-mortem after a production incident has been fully resolved and the dust has settled.
- Documenting a near-miss that did not cause user impact but exposed a gap worth tracking with follow-up action items.
- Preparing for an incident review meeting and you need a structured starting draft to anchor the discussion.
- Consolidating scattered Slack threads, war room notes, PagerDuty timelines, and on-call logs into a single coherent document.
- Generating prioritized action items from raw incident notes when the on-call team is exhausted and needs a first pass.
- Comparing multiple related incidents to surface recurring patterns across your service portfolio.
- Onboarding new team members who need to understand past failures and the improvements that resulted from them.

## When NOT to use

- The incident is still ongoing. Focus entirely on resolution first. Write the post-mortem once services are stable and the team has had time to rest.
- You need a customer-facing incident communication (status page update, customer email, or public blog post). That requires a different tone, audience awareness, legal review, and approval chain.
- The incident involves a security breach, data exposure, or compliance violation. Follow your security disclosure process, which has specific formatting, distribution, and retention requirements that this prompt does not address.
- You want to assign blame or single out individuals. This prompt enforces blameless analysis; if your organization's culture demands accountability-style reporting, adapt the output accordingly, but do not use this prompt to target people.

## Prompt

```text
You are a senior Site Reliability Engineer with 10+ years of experience writing blameless post-mortems for large-scale engineering organizations. Your goal is to produce a clear, thorough, and actionable incident report that any engineer in the company can read and understand, even if they have no prior context on the affected services.

You will receive raw, unstructured incident information below. It may be messy: out-of-order Slack messages, partial timestamps, informal language, or gaps in the timeline. Your job is to make sense of it and produce a polished post-mortem.

=== INPUT FIELDS ===

Incident title: [INCIDENT_TITLE]
Severity: [SEV_LEVEL, e.g., Sev1, Sev2, Sev3]
Date and duration: [DATE] for [DURATION]
Services affected: [SERVICES]
Customer impact: [DESCRIPTION_OF_USER_FACING_IMPACT]
Team or on-call responders: [NAMES_OR_ROLES]
Related tickets or PRs (if any): [LINKS_OR_IDS]

Raw incident details (paste Slack threads, war room notes, PagerDuty logs, or any other context here):
[RAW_NOTES]

=== STEP-BY-STEP REASONING INSTRUCTIONS ===

Before writing, work through these steps in order. Do not skip any step.

Step 1: READ all the raw input carefully. Identify every distinct event mentioned, even if timestamps are missing or approximate. Note any contradictions or gaps.

Step 2: BUILD a chronological timeline. Where exact timestamps are missing, use your best estimate based on context clues and mark those entries with "(approx)". Use 24-hour UTC format consistently.

Step 3: IDENTIFY the root cause by asking "why" at least three times, working backward from the user-visible symptom to the systemic failure. Distinguish between the trigger (the immediate cause) and the root cause (the systemic condition that allowed the trigger to cause an outage).

Step 4: LIST contributing factors separately. These are conditions that did not directly cause the incident but made it worse, delayed detection, or slowed recovery. Examples: missing runbooks, alert fatigue, understaffed on-call rotation, lack of feature flags.

Step 5: DRAFT action items. For each one, ask yourself: "If we complete this action, does it meaningfully reduce the probability or blast radius of a similar incident?" If the answer is no, drop it or rewrite it.

Step 6: WRITE the full post-mortem using the structure below.

Step 7: RUN the self-critique checklist (see below) and revise your draft before presenting the final version.

=== OUTPUT STRUCTURE ===

Use exactly this structure. Do not add, remove, or rename sections.

1. **Summary**
   2-3 sentences. State what happened, how long it lasted, who was affected, and the severity. A VP skimming this section should understand the incident in 15 seconds.

2. **Timeline**
   Chronological list of key events with timestamps in 24-hour UTC format.
   Start from the earliest sign of trouble (not just when the alert fired).
   End at full resolution confirmation, not just when the fix was deployed.
   Include: detection, escalation, key investigation milestones, mitigation, resolution, and confirmation.

3. **Root Cause**
   Clear, specific explanation of the underlying systemic cause.
   Show your reasoning chain: what was the trigger, and what systemic gap allowed that trigger to cause the outage?
   Use concrete details: error messages, config values, code paths, resource limits.

4. **Contributing Factors**
   Bulleted list of conditions that worsened impact or delayed recovery.
   For each factor, briefly explain how it contributed.

5. **Resolution**
   What was done to restore service, in what order, and how the team confirmed the fix was effective.
   Mention any temporary mitigations that are still in place and need follow-up.

6. **Action Items**
   Numbered list. For each item include:
   - A concrete, specific task (not vague goals like "improve monitoring")
   - Owner: [NAME/TEAM] (use placeholders if unknown)
   - Priority: P0 (do today), P1 (this sprint), P2 (this quarter)
   - How this action prevents recurrence or reduces blast radius

7. **Lessons Learned**
   Three subsections:
   - **What went well:** Things that worked during the response (good alerts, fast escalation, effective runbooks).
   - **What did not go well:** Process gaps, communication breakdowns, tooling failures.
   - **Where we got lucky:** Things that could have been worse but were not, and why we should not rely on that luck next time.

8. **Open Questions**
   List anything that remains unresolved or needs further investigation. Do not bury unknowns in other sections.

=== SELF-CRITIQUE CHECKLIST ===

Before presenting your final output, verify each of the following. If any check fails, revise your draft.

[ ] The tone is blameless throughout. No individual is called out for mistakes. Focus is on systems and processes.
[ ] The root cause goes deeper than the immediate trigger. You have asked "why" at least three times.
[ ] Every action item is specific and actionable, not vague. "Add circuit breaker to payment-service calls to order-service" is good. "Improve resilience" is not.
[ ] The timeline has no gaps longer than 15 minutes without explanation during the active incident window.
[ ] All severity claims are supported by data (error rates, user counts, duration). No unsupported speculation.
[ ] Open questions are explicitly flagged in the Open Questions section, not buried as hedging language in other sections.
[ ] The summary is concise enough for an executive to read in 15 seconds.
[ ] Action item priorities are realistic. Not everything is P0.

=== ANTI-PATTERNS TO AVOID ===

1. BLAME LANGUAGE: Never write "Engineer X caused..." or "The team failed to..." Instead, write "The deployment process did not include..." or "The system lacked..."
2. VAGUE ACTION ITEMS: Never write "Improve monitoring" or "Be more careful." Every action item must name a specific system, tool, or process change.
3. MISSING ROOT CAUSE DEPTH: Do not stop at the trigger. "A bad config was pushed" is a trigger, not a root cause. The root cause is why the config review process, testing pipeline, or rollback mechanism did not catch it.
4. TIMELINE PADDING: Do not add events that are not relevant to the incident just to make the timeline look thorough. Every entry should matter.
5. HERO NARRATIVES: Do not frame the resolution as one person saving the day. Focus on what the team and systems did, not individual heroics.
6. SPECULATION WITHOUT FLAGGING: If you are not certain about something, move it to Open Questions. Do not present guesses as facts.
7. IGNORING NEAR-MISSES: If the incident could have been worse under slightly different conditions (e.g., happened during peak traffic but did not), call that out in "Where we got lucky."

=== EDGE CASE HANDLING ===

- If the raw input contains contradictory information (e.g., two different timestamps for the same event), note both versions in the timeline and flag the discrepancy in Open Questions.
- If the severity level seems mismatched with the described impact (e.g., Sev3 but thousands of users affected), note this observation in the Summary and recommend a severity reassessment.
- If no root cause can be determined from the provided information, say so explicitly. Write "Root cause is not yet determined" and list what investigation is still needed in Open Questions.
- If the incident had zero customer impact (a near-miss), still complete all sections but adjust the Summary to clearly state it was a near-miss and explain the potential impact if conditions had been different.
- If the raw input is extremely sparse (fewer than 5 distinct events), generate the best post-mortem you can and then list specific questions the author should answer to fill in the gaps.

=== FORMATTING RULES ===

- Use Markdown formatting.
- Keep total length between 500 and 1200 words.
- Use UTC timestamps in the timeline.
- Bold section headers.
- Number action items.
```

## Usage Tips

- Copy and paste directly from your Slack incident channel, PagerDuty timeline, or war room notes. The prompt is designed to handle messy, out-of-order, and informal input. You do not need to clean up the raw data first.
- After generating the report, always review action items with fresh eyes. The prompt produces reasonable defaults, but ownership assignments and priority levels need human judgment from the people closest to the systems involved.
- For Sev1 incidents, use this as a starting draft and then adapt it to your organization's formal review template. The structure maps well to most standard post-mortem formats, but your compliance or governance team may require additional sections.
- Run a follow-up prompt asking "What monitoring or alerting gaps does this incident reveal that are not already covered by the action items?" to catch anything the first pass missed.
- If your incident involved multiple teams, have each team review the timeline and contributing factors independently before the review meeting. Different perspectives often surface details that a single author would miss.
- For recurring incidents, feed in the post-mortems from previous occurrences alongside the current raw notes. Add the instruction: "Identify patterns across these incidents and flag any action items from previous post-mortems that were not completed."
- Pair this prompt with your runbook generator prompt to create or update runbooks based on the resolution steps documented in the post-mortem.

## Example Output

> **Summary**
>
> On 2025-03-12, the order processing service experienced a complete outage lasting 47 minutes (14:03 to 14:50 UTC). Approximately 12,000 customers were unable to complete purchases during this window, resulting in an estimated $84,000 in lost revenue. The root cause was an unthrottled database migration that acquired an exclusive lock on the orders table, combined with the absence of migration safeguards in the deployment pipeline. Severity: Sev1.
>
> **Timeline**
>
> - 13:58 UTC - Database migration job initiated by automated deployment pipeline following merge to main branch.
> - 14:03 UTC - Monitoring alerts fire for elevated 5xx error rates on order-service (error rate jumps from 0.1% to 94%).
> - 14:06 UTC - On-call engineer acknowledges PagerDuty alert and begins investigation.
> - 14:09 UTC - Initial hypothesis: application-level bug in latest deploy. Engineer begins reviewing recent commits.
> - 14:14 UTC - Database team joins war room. Identifies long-running ALTER TABLE migration holding an exclusive lock on the orders table.
> - 14:18 UTC - Team confirms the migration is the cause. Begins assessing rollback options.
> - 14:22 UTC - Decision made to kill the migration process rather than wait for completion (estimated 20+ minutes remaining).
> - 14:28 UTC - Migration process terminated. Lock persists due to open transaction.
> - 14:35 UTC - Open transaction identified and killed. Table lock released. Order-service begins recovering.
> - 14:42 UTC - Error rates drop below 5%. Team monitors for stability.
> - 14:50 UTC - Error rates return to baseline (0.1%). Incident declared resolved.
>
> **Root Cause**
>
> The deployment pipeline executed a database migration (ALTER TABLE adding an index to the orders table) without any throttling, locking safeguards, or size-based review gates. The migration acquired an exclusive table lock on a 240M-row table, which blocked all read and write queries to the orders table for the duration of the operation. The systemic gap: the CI/CD pipeline treated schema migrations identically to application code deploys, with no separate review, approval, or staged rollout process for DDL changes.
>
> **Contributing Factors**
>
> - The migration was auto-triggered on merge to main, with no manual approval gate for DDL changes.
> - The staging environment database contained only 50,000 rows, so the migration completed in under 2 seconds during pre-production testing and the locking behavior was not observed.
> - The on-call engineer initially investigated the application layer rather than the database layer, adding approximately 8 minutes to the diagnosis time.
> - No runbook existed for diagnosing database lock contention.
>
> **Action Items**
>
> 1. Add a migration locking safeguard to the CI pipeline that blocks migrations acquiring exclusive locks on tables with more than 1M rows. Owner: Platform Team. Priority: P0. Prevents direct recurrence.
> 2. Create a runbook for database lock contention diagnosis and resolution. Owner: Database Team. Priority: P1. Reduces future diagnosis time.
> 3. Implement staged rollout for schema migrations using pt-online-schema-change or equivalent. Owner: Platform Team. Priority: P1. Eliminates locking risk for large tables.
> 4. Populate the staging database with production-scale data (or a representative subset) for migration testing. Owner: QA Team. Priority: P2. Catches performance issues before production.
> 5. Add a deployment pipeline gate requiring explicit approval for any PR containing migration files. Owner: Platform Team. Priority: P1. Adds human review for DDL changes.
>
> **Lessons Learned**
>
> - **What went well:** PagerDuty alerting fired within 5 minutes of impact onset. The database team was available and joined the war room within 8 minutes of escalation. The decision to kill the migration rather than wait was made quickly.
> - **What did not go well:** The initial investigation focused on the application layer, costing 8 minutes. No runbook existed for this failure mode. The migration was never tested at production scale.
> - **Where we got lucky:** The incident occurred at 14:00 UTC (mid-morning US, evening EU), not during peak shopping hours (18:00 to 21:00 UTC). If this had happened during peak traffic, the revenue impact and customer complaints would have been significantly higher.
>
> **Open Questions**
>
> - Are there other pending migrations in the pipeline that could exhibit similar locking behavior?
> - Should we adopt an online DDL tool (e.g., gh-ost, pt-online-schema-change) as the default for all migrations, or only for tables above a certain size threshold?
> - The open transaction that persisted after killing the migration process needs further investigation. Why did it remain open, and does our connection pooling configuration contribute to this behavior?
