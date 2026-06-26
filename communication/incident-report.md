# Incident Post-Mortem Generator

A prompt for writing blameless incident post-mortems that capture what happened, why it happened, and how to prevent it from happening again.

**Difficulty:** Intermediate

## When to use

- Writing a post-mortem after a production incident has been fully resolved.
- Documenting a near-miss that did not cause user impact but needs follow-up action items.
- Preparing for an incident review meeting and need a structured starting draft.
- Consolidating scattered Slack threads, war room notes, and on-call logs into a single coherent timeline.
- Generating action items from raw incident notes when you are too tired after the incident to write them from scratch.

## When NOT to use

- The incident is still ongoing. Focus on resolution first, then write the post-mortem afterward.
- You need a customer-facing incident communication. That requires a different tone, audience awareness, and approval process.
- The incident involves a security breach or data exposure. Follow your security disclosure process, which has specific formatting and distribution requirements.

## Prompt

```text
You are an experienced SRE writing a blameless post-mortem for an engineering organization. Write a clear, thorough incident report using the information below.

Incident title: [INCIDENT_TITLE]
Severity: [SEV_LEVEL, e.g., Sev1, Sev2, Sev3]
Date and duration: [DATE] for [DURATION]
Services affected: [SERVICES]
Customer impact: [DESCRIPTION_OF_USER_FACING_IMPACT]

Use this structure:

1. **Summary** - 2-3 sentences covering what happened, how long it lasted, and who was affected.
2. **Timeline** - A chronological list of key events with timestamps. Start from the first sign of trouble through full resolution. Use 24-hour UTC format.
3. **Root cause** - A clear explanation of the underlying cause. Go beyond the surface trigger and explain the systemic factors that allowed it to happen.
4. **Contributing factors** - Other conditions that made the incident worse or delayed detection and recovery.
5. **Resolution** - What was done to restore service, in what order, and how the fix was confirmed.
6. **Action items** - A numbered list of concrete follow-up tasks. For each item, include:
   - What needs to be done
   - Who owns it (use [OWNER] placeholders if unknown)
   - Priority: P0 (do immediately), P1 (this sprint), P2 (this quarter)
7. **Lessons learned** - What went well during the response, what did not go well, and where the team got lucky.

Constraints:
- Blameless tone throughout. Focus on systems and processes, not individuals.
- Be specific. Use actual numbers, service names, and error messages where available.
- Do not speculate beyond what the evidence supports. Flag any open questions explicitly.
- Keep the total length under 800 words.

Here are the raw incident details:
[RAW_NOTES_SLACK_THREADS_OR_TIMELINE]
```

## Usage Tips

- Copy and paste directly from your Slack incident channel or war room notes. The prompt handles messy, out-of-order input well.
- After generating the report, review the action items carefully. The prompt produces reasonable placeholders, but ownership and priority always need human judgment.
- For Sev1 incidents, pair this with your organization's formal review template. Use the generated report as a starting draft, then adapt it to match required formatting.
- Run a follow-up prompt asking "What monitoring or alerting gaps does this incident reveal?" to generate additional action items you may have missed.

## Example Output Snippet

> **Summary**
>
> On 2025-03-12, the order processing service experienced a complete outage lasting 47 minutes (14:03-14:50 UTC). Approximately 12,000 customers were unable to complete purchases during this window. The root cause was an unthrottled database migration that locked the orders table.
>
> **Timeline**
> - 14:03 UTC - Monitoring alerts fire for elevated 5xx rates on order-service.
> - 14:06 UTC - On-call engineer acknowledges alert and begins investigation.
> - 14:14 UTC - Database team identifies long-running migration holding a table lock.
> - 14:22 UTC - Decision made to kill the migration process.
> - 14:35 UTC - Migration rolled back, table lock released.
> - 14:50 UTC - Error rates return to baseline, incident declared resolved.
>
> **Action Items**
> 1. Add migration locking safeguards to the CI pipeline. Owner: [OWNER]. Priority: P0.
> 2. Create runbook for database lock diagnosis. Owner: [OWNER]. Priority: P1.
> 3. Implement progressive rollout for schema migrations. Owner: [OWNER]. Priority: P1.
