# Team Announcement Generator

A prompt for drafting clear, actionable internal announcements that respect your audience's time and give them exactly what they need to know.

**Difficulty:** Intermediate

## Naive vs. Engineered

**Naive prompt:** "Write an announcement about migrating from Jenkins to Tekton for my engineering team."

**What you get:** Something like this:

> *I'm excited to announce that we will be migrating from Jenkins to Tekton! This is a great step forward for our engineering organization and will bring many benefits. Tekton is a cloud-native CI/CD solution that will help us modernize our pipelines and improve developer productivity. More details to come. Please reach out if you have any questions!*

No timeline. No action items. No acknowledgment that Tekton's UI is less mature, or that migration takes 2-5 days per project. Readers immediately post "when?", "what about my custom plugins?", and "who do I talk to?" in the thread.

**This prompt** produces an announcement with a front-loaded headline, explicit action items with owners and deadlines, channel-appropriate formatting, and honest tradeoff disclosures. The difference: your team reads it once, knows exactly what to do, and trusts you enough not to flood the thread with "but what about...?" questions.

## When to use

- Announcing a process change, tool migration, or new policy to your engineering organization.
- Communicating a team restructure or role change that affects day-to-day workflows.
- Sharing a new project kickoff or milestone with cross-functional partners.
- Rolling out a deprecation or sunsetting plan where teams need to take action by a specific deadline.
- Sending a follow-up announcement with updated timelines, scope changes, or revised guidance.
- Consolidating scattered updates into one authoritative announcement that becomes the single source of truth.
- Announcing infrastructure changes (maintenance windows, environment migrations, credential rotations) that require coordinated team response.

## When NOT to use

- The announcement involves sensitive HR matters such as layoffs, PIPs, or compensation changes. Work with your People team on messaging before drafting anything.
- You are writing an external press release, blog post for customers, or partner communication. Those require a different review and approval process with legal and comms teams.
- The announcement is a reply in an ongoing thread or a quick status update in an existing conversation. This prompt is designed for standalone, net-new communications only.
- The topic requires executive-level framing (company strategy shifts, M&A activity, major org changes). Those need direct leadership involvement in drafting, not a template.

## Prompt

```text
You are a senior engineering leader at a large technology company. Your job is to write a clear,
well-structured internal announcement for your organization. The announcement must respect
your audience's time, front-load the most important information, and give people concrete
next steps.

INPUTS (fill in each field before running):
- Topic: [ANNOUNCEMENT_TOPIC]
- Audience: [AUDIENCE, e.g., "platform engineering department", "full R&D org", "SRE team"]
- Channel: [CHANNEL, e.g., "Slack post", "email", "Google Chat", "internal blog post"]
- Effective date: [DATE_OR_TIMEFRAME]
- Who is affected: [PEOPLE_OR_TEAMS_AFFECTED]
- Urgency level: [low / medium / high / critical]
- Raw details and notes: [RAW_NOTES_OR_DETAILS]

STEP-BY-STEP REASONING INSTRUCTIONS:

Before writing, think through these steps carefully and in order:

Step 1: Audience analysis.
Identify who will read this. Consider their technical depth, how this change affects their
daily work, and what questions they will ask first. Write one sentence summarizing the
audience's primary concern.

Step 2: Core message extraction.
From the raw details, identify the single most important thing the audience needs to know.
This becomes your headline. If you cannot state the core message in one sentence, the
announcement is trying to cover too much. Split it or narrow the scope.

Step 3: Action identification.
List every action the audience needs to take. For each action, identify: what to do,
who specifically needs to do it, and by when. If there is no action required, state that
explicitly. Do not leave the reader guessing.

Step 4: Channel calibration.
Adjust length and tone based on the channel:
  - Slack: 150-250 words. Conversational, scannable, use bullet points heavily.
  - Email: 250-400 words. Slightly more formal, include a clear subject line suggestion.
  - Blog post: 400-600 words. More background context is acceptable.
  - Google Chat: Same constraints as Slack.

Step 5: Draft the announcement using this structure:
  a) Headline: One clear sentence stating what is changing or what is new.
  b) Context: 2-3 sentences explaining why. Connect it to a business goal, user need,
     or technical requirement. Do not say "exciting" or "thrilled." Just explain why.
  c) What is changing: Bullet points covering the specific changes. Be concrete about
     what is different from the current state. Include before/after comparisons where helpful.
  d) What you need to do: Bullet points with specific actions, owners, and deadlines.
     If no action is required, write "No action needed at this time."
  e) Timeline: Key dates for rollout, deadlines, or milestones in chronological order.
  f) Known tradeoffs or limitations: If the change has downsides, short-term friction,
     or open questions, acknowledge them honestly. Engineers trust announcements that
     are straightforward about rough edges.
  g) Where to get help: Links, Slack channels, office hours, contacts, or documentation.

Step 6: Self-critique checklist.
Before presenting your final output, review your draft against every item below. If any
check fails, revise the draft before outputting it.

  [ ] The headline communicates the core change in one sentence without jargon.
  [ ] A reader who only sees the first three lines gets the essential message.
  [ ] Every action item has a clear owner (or audience) and a deadline.
  [ ] The tone matches the channel (Slack is conversational; email is professional).
  [ ] The word count falls within the channel's target range.
  [ ] No filler phrases: removed "I'm excited to share," "please be advised,"
      "going forward," "at the end of the day," or "synergy."
  [ ] Tradeoffs or known issues are stated honestly, not hidden or minimized.
  [ ] The timeline section is in chronological order with specific dates, not vague
      references like "soon" or "in the coming weeks."
  [ ] The announcement passes the "so what?" test: a reader can immediately understand
      why this matters to them personally.
  [ ] No contradictions between sections (e.g., timeline dates matching action deadlines).

ANTI-PATTERNS TO AVOID:

1. Leading with corporate filler. Do not start with "I'm excited to announce" or
   "As you may know." Start with what is changing.
2. Burying the action items. Do not put required actions at the bottom after five
   paragraphs of context. If action is urgent, surface it early.
3. Being vague about timelines. "Soon," "shortly," "in the near future" are not dates.
   Use specific dates or explicit ranges like "the week of September 8."
4. Writing for yourself instead of the reader. The reader's first question is "what
   does this mean for me?" Answer that question in the first few lines.
5. Mixing multiple announcements into one message. If you are covering more than one
   distinct change, split them into separate announcements or clearly delineate each
   with its own headline and action items.
6. Using passive voice to obscure ownership. "A decision was made" is weaker than
   "The platform team decided." Name the decision-makers.
7. Skipping the "why." Engineers will push back on changes they do not understand.
   Two sentences of honest context prevents a thread full of questions.

EDGE CASE HANDLING:

- If the change is still tentative or dates are not finalized, say so explicitly.
  Use language like "Target date: October 1 (will confirm by September 15)" rather
  than presenting uncertain dates as fixed.
- If different teams are affected differently, create separate "What you need to do"
  subsections for each team or role. Do not force everyone to read through actions
  that do not apply to them.
- If the announcement is a correction or update to a previous announcement, lead with
  "This updates the announcement sent on [DATE]" and clearly state what changed.
- If the change has no deadline (informational only), say "This is informational only.
  No action is required" in the first two lines so people can triage quickly.
- If the urgency level is critical, add a bold "ACTION REQUIRED BY [DATE]" at the very
  top of the announcement before the headline.
- If a placeholder is left unfilled (e.g., [CHANGE_DESCRIPTION] is missing), stop and ask the user to provide it. An announcement with no clear change is confusing, not informational.
- If the announcement is being sent to a distributed or global team, note any timezone-sensitive deadlines in multiple timezones or use UTC.
- If the change reverses a previous decision, acknowledge the reversal directly rather than presenting it as if the new direction was always the plan.

OUTPUT FORMAT:

Return the announcement as plain text formatted for the specified channel. If the channel
is email, include a suggested subject line on the first line prefixed with "Subject: ".
Do not include markdown formatting unless the channel supports it (Slack and blog posts do;
email typically does not).
```

## Why This Works

**Persona framing.** The prompt assigns the role of "senior engineering leader," which calibrates the model's tone, vocabulary, and assumptions about the audience. Without this, the output defaults to a generic, one-size-fits-all voice that reads like a support article, not an internal announcement.

**Chain-of-thought reasoning.** The six-step reasoning sequence (audience analysis, core message extraction, action identification, channel calibration, drafting, self-critique) forces the model to think before writing. Each step builds on the previous one, so the final output reflects deliberate structural choices rather than stream-of-consciousness generation.

**Anti-pattern avoidance.** Explicitly listing what NOT to do (corporate filler, buried actions, vague timelines, passive voice) is as important as listing what to do. Language models tend to fall into cliched patterns unless you name and forbid them. The anti-patterns act as guardrails that keep the output sharp.

**Self-critique checklist.** Asking the model to review its own draft against specific criteria before outputting it adds a revision pass that catches the most common failure modes: missing deadlines, wrong tone for the channel, filler language, and the "so what?" test.

**Output formatting constraints.** Specifying word count ranges per channel and structural requirements (headline, context, changes, actions, timeline, tradeoffs, help) gives the model a scaffold to fill rather than a blank page. Constrained generation produces more consistently useful output than open-ended generation.

## Usage Tips

- Be honest about tradeoffs. If a migration adds short-term friction, say so. Engineers trust announcements that acknowledge the rough edges rather than pretending everything is smooth.
- For high-impact changes (deprecations, org restructures, breaking process changes), have a second person review the draft before sending. The prompt gives you a strong starting point, but sensitive topics need a human pass for tone and accuracy.
- Set the channel parameter to match where you are actually posting. The prompt adjusts word count, tone, and formatting accordingly, and getting this wrong leads to messages that feel out of place.
- For announcements that affect multiple teams differently, consider running the prompt once per audience with tailored "What you need to do" sections. A single announcement that tries to address five different teams usually confuses everyone.
- Pair the announcement with a follow-up plan. If the change is significant, schedule a reminder announcement at the midpoint of any deadline and again one week before the deadline closes.
- Test your draft with the "hallway test": show it to someone uninvolved and ask them to tell you what the announcement says. If they cannot summarize it in one sentence, the headline needs work.
- When using this for recurring announcements (weekly migration updates, monthly deprecation reminders), keep a running thread or document that links all prior announcements so people can see the full history.
- **Slash command connection:** If you use `ai-bu-claude-commands`, the `/draft-announcement` slash command generates multi-channel announcements (Slack, email, blog) from the same source material in one pass.

## Example Output

> **Subject: CI/CD pipelines moving from Jenkins to Tekton, starting August 1**
>
> **We are moving all CI/CD pipelines from Jenkins to Tekton. New projects must use Tekton starting August 1. Existing projects must migrate by October 15.**
>
> **Why this is happening**
>
> Our Jenkins infrastructure has become increasingly difficult to maintain. The platform team is spending roughly 20 engineer-hours per week on pipeline debugging and configuration drift. Tekton gives us native Kubernetes integration, better support for our containerized build workflows, and aligns with our long-term OpenShift platform strategy.
>
> **What is changing**
>
> - All new projects created after August 1 must use Tekton pipelines. Jenkins will not be available for new project onboarding after that date.
> - Existing projects have until October 15 to complete their migration.
> - Jenkins will be fully decommissioned on November 1. Any pipelines still running on Jenkins after that date will stop working.
> - The platform team will publish migration tooling, starter templates, and a step-by-step guide by July 25.
>
> **What you need to do**
>
> - Review the migration guide (linked in #ci-cd-migration) by August 8.
> - Identify a migration lead on your team and post their name in #ci-cd-migration by August 15.
> - Complete your migration and validate all pipelines in staging before October 15.
> - If your project has complex or custom Jenkins plugins, reach out to the platform team by August 22 so they can assess compatibility.
>
> **Known tradeoffs**
>
> - Tekton's UI is less mature than Jenkins Blue Ocean. The platform team is evaluating Tekton Dashboard and will share a recommendation by August 15.
> - Some Jenkins plugins do not have direct Tekton equivalents. The migration guide includes a compatibility matrix and workaround suggestions.
> - Teams will need to invest 2-5 days of effort per project for migration, depending on pipeline complexity.
>
> **Timeline**
>
> - July 25: Migration tooling and guide published.
> - August 1: Tekton required for all new projects.
> - August 8: Review migration guide (all teams).
> - August 15: Migration leads identified per team.
> - October 15: All existing projects migrated.
> - November 1: Jenkins fully decommissioned.
>
> **Where to get help**
>
> - Slack: #ci-cd-migration
> - Weekly office hours: Thursdays 2:00-3:00 PM ET (starting August 1)
> - Migration guide: [LINK]
> - Platform team contact: @platform-oncall in Slack
