# Team Announcement Generator

A prompt for writing clear internal announcements that give people the information they need and the context for why it matters.

**Difficulty:** Beginner

## When to use

- Announcing a process change, tool migration, or new policy to your engineering organization.
- Communicating a team restructure or role change that affects workflows.
- Sharing a new project kickoff or milestone with cross-functional partners.
- Rolling out a deprecation or sunsetting plan where teams need to take action by a deadline.
- Sending a follow-up announcement with updated timelines or scope changes.

## When NOT to use

- The announcement involves sensitive HR matters such as layoffs, PIPs, or compensation changes. Work with your People team on messaging.
- You are writing an external press release or customer communication. Those require a different review and approval process.
- The announcement is a reply in an ongoing thread. This prompt is designed for standalone, net-new communications.

## Prompt

```text
You are a senior engineering leader writing an internal announcement for your organization. Write a clear, well-structured announcement using the details below.

Topic: [ANNOUNCEMENT_TOPIC]
Audience: [AUDIENCE, e.g., engineering department, full organization, specific team]
Channel: [CHANNEL, e.g., email, Slack, Google Chat, internal blog post]
Effective date: [DATE_OR_TIMEFRAME]
Who is affected: [PEOPLE_OR_TEAMS_AFFECTED]

Use this structure:

1. **Headline** - One clear sentence stating what is changing or what is new.
2. **Context** - 2-3 sentences explaining why this change is happening. Connect it to a business goal, user need, or technical requirement.
3. **What is changing** - Bullet points covering the specific changes. Be concrete about what is different from the current state.
4. **What you need to do** - Bullet points with specific actions the audience should take, including deadlines. If no action is required, say "No action needed."
5. **Timeline** - Key dates for rollout, deadlines, or milestones.
6. **Where to get help** - Links, Slack channels, office hours, or contacts for questions.

Constraints:
- Match the tone to the channel. Slack messages should be shorter and more conversational. Emails can be slightly more detailed. Blog posts can include more background.
- Front-load the most important information. Assume people will only read the first few lines.
- If the change has known tradeoffs or downsides, acknowledge them honestly.
- Keep the announcement under 250 words for Slack, under 400 words for email, or under 600 words for blog posts.

Here are the raw details:
[RAW_NOTES_OR_DETAILS]
```

## Usage Tips

- Be honest about tradeoffs. If a migration adds short-term friction, say so. Engineers trust announcements more when they acknowledge the rough edges.
- For high-impact changes (deprecations, org restructures, process changes), have a second person review the draft before sending. The prompt gives you a solid starting point, but sensitive topics need a human pass.
- Set the channel parameter to match where you are actually posting. The prompt adjusts length and tone accordingly.
- For announcements that affect multiple teams differently, consider running the prompt once per audience with tailored "What you need to do" sections.

## Example Output Snippet

> **We are moving CI/CD pipelines from Jenkins to Tekton, starting August 1.**
>
> **Context**
> Our Jenkins infrastructure has become increasingly difficult to maintain, and we are spending roughly 20 engineer-hours per week on pipeline debugging. Tekton gives us native Kubernetes integration and better support for our containerized build workflow.
>
> **What is changing**
> - All new projects created after August 1 must use Tekton pipelines.
> - Existing projects have until October 15 to migrate.
> - Jenkins will be shut down on November 1.
> - The platform team will provide migration tooling and templates by July 25.
>
> **What you need to do**
> - Review the migration guide (link in #ci-cd-migration) by August 8.
> - Identify a migration lead on your team and post their name in #ci-cd-migration by August 15.
> - Complete migration and validate pipelines before October 15.
>
> **Where to get help**
> - Slack: #ci-cd-migration
> - Weekly office hours: Thursdays 2-3pm ET
> - Migration guide: [LINK]
