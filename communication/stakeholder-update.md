# Stakeholder Update Generator

A prompt for turning raw project notes into crisp, executive-ready status updates that respect your audience's time.

**Difficulty:** Intermediate

## Naive vs. Engineered

**Naive prompt:** "Write a status update for my project for leadership."

**What you get:** Something like this:

> *Status: On Track. The team has been working hard this sprint and making great progress. We continued work on the API migration and had several productive meetings about testing strategy. The new architecture is coming along nicely and we are excited about the direction. There are some risks we are monitoring but nothing major at this time. We will continue to iterate and keep stakeholders informed.*

No outcomes, no numbers, no asks. "On Track" with zero evidence. Leadership reads it, learns nothing, and schedules a follow-up meeting to find out what is actually happening.

**This prompt** produces a concise, outcome-focused update with a justified status indicator, quantified accomplishments, specific risks with mitigations, and clear asks with deadlines. For example, an llm-d project update would lead with "At Risk: KV-cache routing benchmarks missed the P99 latency target by 80ms, putting the July beta at risk unless GPU scheduling is resolved by July 10." Leadership reads it in under two minutes, knows exactly whether to worry, and can act on your asks without a follow-up meeting.

## When to use

- Writing a weekly or biweekly project status update for VP-level leadership or executive staff.
- Preparing a structured summary before a leadership review meeting or skip-level.
- Summarizing progress for cross-functional partners who are not embedded in day-to-day engineering work.
- Consolidating messy standup notes, Jira exports, Slack threads, or sprint retro notes into a single clean update.
- Catching up stakeholders after a period of heads-down execution when communication has been sparse.
- Onboarding a new executive sponsor who needs to get up to speed on project status quickly.
- Producing a written artifact to complement a live demo or presentation so attendees have a reference afterward.

## When NOT to use

- The update requires financial data, budget details, or headcount projections. Work with your PM or finance partner to get the numbers right before drafting. Inaccurate financial information erodes trust fast.
- You are writing a formal quarterly business review (QBR). QBRs require a different format, depth, sign-off process, and review cadence.
- The project is in active crisis or a Sev1/Sev2 incident is ongoing. Write an incident report or postmortem instead; a status update will feel tone-deaf in that context.
- You need to communicate a major pivot, cancellation, or organizational change. Those require direct, personal communication first, not a templated update.

## Prompt

```text
You are a senior engineering program manager at a large enterprise software company.
Your job is to transform raw, unstructured project information into a concise
stakeholder update that leadership can read in under two minutes.

You will be given project details and raw notes. Follow the step-by-step process
below carefully. Think through each step before writing the final output.

=== INPUTS ===
Project name: [PROJECT_NAME]
Reporting period: [TIME_PERIOD, e.g., "June 16-27, 2025"]
Target audience: [AUDIENCE, e.g., "VP-level leadership", "cross-functional partners", "executive staff"]
Preferred length: [WORD_COUNT, default 250-300 words]
Raw information:
[PASTE RAW NOTES, JIRA EXPORT, STANDUP SUMMARIES, OR BULLET POINTS HERE]

=== STEP-BY-STEP REASONING PROCESS ===

Step 1: Analyze the raw information.
  - Identify every distinct accomplishment, milestone, risk, blocker, and open ask.
  - Separate facts from opinions or speculation.
  - Note any gaps: are there areas where the raw notes are silent but a stakeholder
    would expect an update? Flag these for the user.

Step 2: Determine the overall project status.
  - Choose exactly one status indicator: On Track, At Risk, or Blocked.
  - "On Track" means milestones are being hit and no unmitigated risks threaten the timeline.
  - "At Risk" means one or more risks could cause a delay if not addressed soon.
  - "Blocked" means forward progress has stopped and external action is required.
  - Write one sentence (max 25 words) justifying the status you chose.

Step 3: Draft each section using the structure below.
  - Prioritize information by impact: lead each section with the most important item.
  - Quantify wherever possible (percentages, dates, counts, SLA numbers).
  - Replace jargon with plain language. If a technical term is unavoidable, add a
    brief parenthetical explanation.

Step 4: Run the self-critique checklist (see below) and revise before producing
  the final output.

=== OUTPUT FORMAT ===

Use this exact structure for the final update:

**Status: [On Track | At Risk | Blocked]**
[One-sentence justification]

**Key Accomplishments**
- [Accomplishment 1, with quantified impact if available]
- [Accomplishment 2]
- [Accomplishment 3]
(Include 3-5 bullets. Each bullet should be one sentence.)

**Upcoming Milestones**
- [Milestone 1]: [Target date]
- [Milestone 2]: [Target date]
(Include 2-4 items. Always include dates.)

**Risks and Blockers**
- [Risk/Blocker]: [Impact]. Mitigation: [Action underway or planned].
(If none, write: "No active risks or blockers at this time.")

**Asks**
- [Decision, resource, or support needed, with a deadline if applicable]
(If none, write: "No asks at this time.")

=== SELF-CRITIQUE CHECKLIST ===

Before producing the final output, verify each of the following. If any check
fails, revise the draft before returning it.

1. Is the total length within the requested word count (default 250-300)?
2. Does every accomplishment describe an outcome, not just an activity?
   Bad: "Worked on API migration." Good: "Completed API migration, reducing p99 latency by 40%."
3. Does every milestone have a concrete date, not a vague timeframe like "soon"?
4. Does every risk include both its impact and a mitigation action?
5. Are there any acronyms or jargon the target audience might not know? If so,
   expand or replace them.
6. Is the status indicator (On Track / At Risk / Blocked) honestly supported by the
   information provided? Do not default to "On Track" if the evidence is ambiguous.
7. Does the update avoid filler phrases like "Great progress this sprint" or
   "The team has been working hard"? Remove them.
8. Are the asks specific and actionable, with clear owners or deadlines?

=== ANTI-PATTERNS TO AVOID ===

1. Activity reporting instead of outcome reporting. Never list tasks the team
   "worked on" without stating what was delivered or what changed as a result.
2. Burying the lead. Do not put the most critical information in the middle or
   end of a section. Lead with what matters most.
3. Optimism bias. Do not downgrade "At Risk" to "On Track" to avoid uncomfortable
   conversations. Stakeholders lose trust when they are surprised by bad news.
4. Vague risks. "There might be some delays" is not useful. Name the specific risk,
   the specific impact, and the specific mitigation.
5. Missing asks. If the team needs something from leadership, say so clearly.
   Stakeholders cannot help if they do not know what is needed.
6. Jargon overload. Writing "we refactored the DAG orchestration layer to improve
   idempotency" for a VP audience is a failure of communication, not a display of
   technical depth.
7. Wall of text. If any single bullet exceeds two sentences, break it up or cut it.

=== EDGE CASE HANDLING ===

- If the raw notes contain contradictory information (e.g., one note says a milestone
  is complete and another says it is still in progress), flag the contradiction
  explicitly in your output and ask the user to clarify before finalizing.
- If the raw notes are extremely sparse (fewer than 3 bullet points), produce the
  best update you can and then list specific questions the user should answer to
  strengthen the update.
- If no risks or blockers are mentioned in the raw notes, still include the section
  with "No active risks or blockers at this time" rather than omitting it. Omitting
  the section makes readers wonder if risks were considered at all.
- If the reporting period is unusually long (more than 4 weeks), suggest breaking the
  update into sub-periods so the audience can see trajectory, not just a summary.
- If the audience is mixed (e.g., both technical leads and non-technical executives),
  default to the less technical register and add a "Technical Details" appendix
  section for those who want depth.
- If a placeholder is left unfilled (e.g., [PROJECT_NAME] still reads "[PROJECT_NAME]"), stop and ask the user to fill it in. A status update with no project name or reporting period cannot be sent.
- If the raw information is in a language other than English, produce the update in English but note that the source data was translated and may need verification of technical terms.
- If the user is running this on a model with a small context window (under 16k tokens) and the raw notes are extensive, recommend splitting the notes into accomplishments, risks, and asks before pasting, and run the prompt once per section.
```

## Why This Works

**Outcome-over-activity framing.** The prompt explicitly distinguishes between activity reporting ("worked on X") and outcome reporting ("completed X, reducing latency by 40%"). This distinction is baked into both the step-by-step reasoning and the self-critique checklist, so the model consistently produces accomplishments that demonstrate impact rather than effort.

**Forced status justification.** Requiring the model to choose exactly one status (On Track, At Risk, or Blocked) and justify it in one sentence prevents the optimism bias that plagues most status updates. The anti-patterns section reinforces this by calling out the tendency to downgrade "At Risk" to "On Track" to avoid uncomfortable conversations.

**Chain-of-thought with audience awareness.** The four-step reasoning process starts with analyzing raw information, then determining status, then drafting, then self-critiquing. Each step considers the audience explicitly, so the model strips jargon, quantifies claims, and front-loads the most important information for executive readers.

**Anti-pattern catalog.** Listing seven specific failure modes (activity reporting, burying the lead, optimism bias, vague risks, missing asks, jargon overload, wall of text) gives the model concrete examples of what bad looks like. This is more effective than positive instructions alone because it names the exact patterns the model would otherwise default to.

**Self-critique as quality gate.** The eight-item checklist catches the most damaging mistakes: activities without outcomes, milestones without dates, risks without mitigations, and filler phrases that waste the reader's time. This revision pass consistently elevates the output from "acceptable" to "ready to send."

## Usage Tips

- Paste in your roughest notes. Messy Jira exports, raw Slack threads, bullet-point brain dumps: the more unstructured the input, the more value you get from this prompt. Do not pre-edit your notes before feeding them in.
- Adjust the word count constraint to match your audience's tolerance. Some VPs want 150 words; some want 500. Ask once, then keep it consistent.
- For recurring updates, keep the same format every cycle. Consistency lets readers scan faster because they know where to look for what they care about.
- If you report to multiple audiences with different levels of technical depth, run the prompt twice with different audience values. A VP update and a staff-engineer update should read differently.
- Save your best outputs as few-shot examples. Append one to the prompt under a "Reference example" heading to steer future outputs toward the tone and structure you prefer.
- Use the self-critique checklist as your own review tool, too. After the AI produces a draft, read through the eight checks yourself before sending. The checklist catches the most common failure modes.
- When your project status is genuinely "At Risk" or "Blocked," do not soften the language. Direct, honest updates build more trust over time than optimistic ones that age poorly.
- Pair this prompt with a "risks and mitigations" deep-dive prompt if your risk section consistently runs long. Keep the stakeholder update concise and link to the detailed risk analysis separately.
- **Suite connection:** For recurring weekly reports, use [ai-bu-status-report](../ai-bu-status-report) instead of running this prompt manually each time. This prompt is for ad-hoc or one-off updates where you need more control over the output. If you use `ai-bu-claude-commands`, the `/draft-announcement` slash command can generate stakeholder-facing announcements, and the `/release-notes` slash command handles release-specific status communication.

## Example Output

> **Status: At Risk**
> CI pipeline stability has degraded over the past two weeks, putting the July 30 GA release date at risk if not resolved by July 10.
>
> **Key Accomplishments**
> - Completed API gateway migration to production across all three regions, reducing p99 latency by 40% (from 320ms to 190ms).
> - Onboarded 3 new partner teams (Payments, Identity, Notifications) to the shared authentication service, bringing total adoption to 11 of 14 target teams.
> - Published updated capacity planning estimates for Q3, projecting 2.1x current peak traffic by September.
> - Closed 14 of 18 open security findings from the June audit. Remaining 4 are low-severity and scheduled for the next sprint.
>
> **Upcoming Milestones**
> - Load testing at 2x projected traffic: July 15
> - Final security audit remediation complete: July 22
> - GA release of v2.1 SDK: July 30 (at risk; see below)
> - Partner onboarding complete (14/14 teams): August 8
>
> **Risks and Blockers**
> - CI pipeline flakiness has increased test failure rate from 2% to 12% over the past two weeks. Impact: developer velocity is down and merge queues are backing up. Mitigation: SRE team is investigating root cause; temporary workaround (selective test retries) deployed June 25. Resolution expected by July 10.
> - Dependency on Platform team for TLS certificate rotation in the staging environment. Impact: staging deploys are blocked until rotation is complete. Mitigation: weekly sync established, fallback date of July 12 identified, and manual rotation procedure documented as a backup plan.
>
> **Asks**
> - Need VP-Eng approval on budget allocation for a dedicated staging environment by July 5. Without this, load testing will share resources with integration testing and results will be unreliable.
> - Request 2 additional SRE hours per week through July to support CI pipeline stabilization. Contact: @jchen in #platform-sre.
