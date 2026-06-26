# Stakeholder Update Generator

A prompt for drafting concise executive updates that keep leadership informed without burying them in details.

**Difficulty:** Beginner

## When to use

- Writing a weekly or biweekly project status update for leadership.
- Preparing for a leadership review meeting and need a structured summary.
- Summarizing progress for cross-functional partners who are not embedded in day-to-day work.
- Consolidating messy standup notes, Jira exports, or Slack threads into a clean update.
- Catching up stakeholders after a period of heads-down execution.

## When NOT to use

- The update requires financial data or budget details. Work with your PM or finance partner to get the numbers right before drafting.
- You are writing a formal quarterly business review. QBRs require a different format, depth, and review process.
- The project is in active crisis. Write an incident report instead of a status update.

## Prompt

```text
You are a senior engineering communicator at a large enterprise software company. Write a stakeholder update email for the following project.

Project name: [PROJECT]
Reporting period: [TIME_PERIOD]
Target audience: [AUDIENCE, e.g., VP-level leadership, cross-functional partners, executive staff]

Include these sections:

1. **Status summary** - One sentence. Use a clear status indicator: On Track, At Risk, or Blocked.
2. **Key accomplishments** - 3-5 bullet points covering what was delivered or completed this period.
3. **Upcoming milestones** - 2-4 items with target dates.
4. **Risks and blockers** - List any active risks, their impact, and what mitigation is underway. If none, say so.
5. **Asks** - Any decisions, resources, or support needed from the audience. If none, say "No asks at this time."

Constraints:
- Keep the entire update under 300 words.
- Use plain language. Avoid jargon that the audience would not immediately understand.
- Lead with the most important information in each section.
- Do not pad with filler or pleasantries. Be direct.

Here is the raw information to work from:
[RAW_NOTES_OR_BULLET_POINTS]
```

## Usage Tips

- Paste in your rough notes, Jira export, or standup summaries as the raw information. The messier the input, the more value you get from the prompt.
- Adjust the word count constraint up or down depending on your audience's preferences.
- For recurring updates, keep the format consistent so readers can scan quickly.
- If you are reporting to multiple audiences with different levels of technical depth, run the prompt twice with different audience values.

## Example Output Snippet

> **Status: On Track**
>
> **Key Accomplishments**
> - Completed API gateway migration to production, reducing p99 latency by 40%.
> - Onboarded 3 new partner teams to the shared authentication service.
> - Published updated capacity planning estimates for Q3.
>
> **Upcoming Milestones**
> - Load testing at 2x projected traffic: July 15
> - GA release of v2.1 SDK: July 30
>
> **Risks and Blockers**
> - Dependency on Platform team for TLS certificate rotation. Mitigation: weekly sync established, fallback date identified.
>
> **Asks**
> - Need confirmation on budget allocation for additional staging environment by July 5.
