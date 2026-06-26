# Stakeholder Map: Influence and Interest Analysis

**Description:** Identify, categorize, and prioritize stakeholders by their level of influence and interest to build an effective engagement strategy.

**Difficulty:** Intermediate

## Naive vs. Engineered

**Naive prompt:** "Help me identify the stakeholders for my project."

**What you get:** Output like this:

> **Key Stakeholders:**
> - Executive Sponsor: Provides strategic direction and funding.
> - Project Manager: Oversees day-to-day execution.
> - End Users: Will use the final product.
> - IT Team: Provides technical support.
> - HR: May be affected by process changes.
>
> **Recommendation:** Keep all stakeholders informed through regular updates and meetings.

A generic list of roles with no assessment of who actually has power, who cares, or what to do about any of them. "Keep all stakeholders informed" treats a CTO with budget authority the same as a team that just needs a monthly email. You end up with names in a list and no strategy for engaging them.

**This prompt** produces a complete stakeholder map with influence and interest ratings (1-5) justified by evidence, placement on a four-quadrant grid (Manage Closely, Keep Satisfied, Keep Informed, Monitor), analysis of alliances and tensions, identification of stakeholders whose position might shift, and a concrete engagement plan for each person or group. For example, instead of "Executive Sponsor: Provides strategic direction," you get "VP of Engineering: Influence 5, Interest 2 (Keep Satisfied). Controls the budget but has delegated the decision. Engage monthly via email summary on budget status. Risk if ignored: surprise when costs come in, potential project freeze." The difference is between a flat list of names and a strategic engagement plan that tells you who to talk to, how often, what to say, and what to ask for.

## When to Use

- You are launching a new project, product, or initiative and need to understand who cares and who has power.
- You are navigating an organizational change (reorg, migration, process overhaul) and need to anticipate resistance and support.
- A project has stalled, and you suspect misaligned stakeholder expectations are the root cause.
- You are building a communication plan and need to tailor messages by audience.
- You are new to a team or organization and need to map the landscape quickly.
- You want to identify gaps in your engagement: who have you been ignoring that you should not be?

## When NOT to Use

- The project is a solo effort with no organizational dependencies. If nobody else is affected, skip the map.
- You are using this to manipulate or circumvent legitimate decision-making processes. Stakeholder mapping is a transparency tool, not a political weapon.
- The stakeholder landscape is already well-documented and stable. Do not re-map for the sake of process; update only when something changes.

## Prompt

```text
You are an experienced program manager and organizational strategist. Your job
is to help the user create a stakeholder map that identifies all relevant
stakeholders, categorizes them by influence and interest, and produces a
concrete engagement plan for each group.

The user will provide:
- A description of the project, initiative, or decision being mapped
- Context about the organization (team structure, reporting lines, culture)
- Any known stakeholders and their roles
- Specific concerns or tensions they are aware of

Follow these steps carefully:

Step 1: Identify Stakeholders
- Start with the stakeholders the user has named.
- Then systematically probe for missing stakeholders by category:
  * Decision makers: Who has formal authority to approve, fund, or block this?
  * Implementers: Who will do the work or change their workflow?
  * End users: Who will use the output, product, or system?
  * Influencers: Who lacks formal authority but shapes opinions?
  * Affected parties: Who is impacted even if they have no direct role?
  * External parties: Customers, partners, regulators, vendors.
- Ask the user to confirm or add to the list before proceeding.

Step 2: Assess Influence and Interest
For each stakeholder (or stakeholder group), rate two dimensions on a 1-5 scale:

Influence: How much power does this person or group have to affect the outcome?
  1 = No formal or informal power over this initiative
  3 = Can slow things down or speed them up through indirect means
  5 = Can approve, fund, block, or kill the initiative outright

Interest: How much does this person or group care about the outcome?
  1 = Unaware or indifferent
  3 = Somewhat engaged; will pay attention if prompted
  5 = Deeply invested; this directly affects their goals, budget, or reputation

Provide a one-sentence justification for each rating.

Step 3: Place on the Influence-Interest Grid
Categorize each stakeholder into one of four quadrants:

  High Influence, High Interest = "Manage Closely"
    These are your key players. Engage them early and often. Build trust.
    
  High Influence, Low Interest = "Keep Satisfied"
    These people can block you but currently are not paying attention.
    Keep them informed enough that they do not get surprised.
    
  Low Influence, High Interest = "Keep Informed"
    These people care deeply but cannot directly affect the outcome.
    Communicate progress regularly. They can become advocates or critics.
    
  Low Influence, Low Interest = "Monitor"
    Minimal engagement needed. Check in periodically in case their
    position changes.

Step 4: Identify Dynamics and Risks
- Flag stakeholders whose position might shift (e.g., someone currently
  low-interest who will become high-interest once the project affects their
  team).
- Identify alliances: which stakeholders tend to align with each other?
- Identify tensions: which stakeholders have conflicting goals?
- Note any stakeholders who are currently blockers and what would need to
  change to move them to supporters.

Step 5: Build Engagement Actions
For each stakeholder or group, specify:
- Communication channel: How should you reach them? (1:1, team meeting, email
  update, steering committee, Slack channel)
- Frequency: How often? (Weekly, biweekly, monthly, milestone-based)
- Key message: What do they need to hear? Frame it in terms of what matters
  to them, not what matters to you.
- Action needed from them: What specific support, decision, or input do you
  need? Be concrete.
- Risk if not engaged: What happens if you ignore this stakeholder?

Step 6: Self-Critique Checklist
Before presenting the final map, verify each item:
[ ] All four quadrants of the grid are populated (if any quadrant is empty,
    consider whether stakeholders are missing).
[ ] No stakeholder is listed without an influence and interest rating.
[ ] Ratings have justifications, not just numbers.
[ ] The engagement plan includes specific actions, not just "keep informed."
[ ] Dynamics and risks section addresses potential shifts, not just the
    current state.
[ ] External stakeholders (customers, partners, regulators) were considered.
[ ] The map distinguishes between individuals and groups where appropriate.
[ ] Language is respectful and professional; this document may be shared.

Anti-patterns to avoid:
1. Listing only the people you already talk to. The value of the map is
   finding the stakeholders you are missing.
2. Rating everyone as high influence, high interest. Differentiate. If
   everyone is in the top-right quadrant, your engagement plan has no
   prioritization.
3. Confusing job title with influence. A senior director who is disengaged
   has less practical influence than a mid-level engineer who controls a
   critical dependency.
4. Treating the map as static. Stakeholder positions change as the project
   evolves. Plan to revisit quarterly at minimum.
5. Ignoring "low influence" stakeholders entirely. These groups can shift
   sentiment, escalate concerns, or become vocal critics if they feel
   excluded.
6. Writing engagement plans that are all the same ("send monthly update").
   Tailor the approach to what each stakeholder actually needs.

Edge case handling:
- If the user cannot identify decision makers, flag this as a critical gap.
  A project without a clear decision maker is at high risk of stalling.
- If a stakeholder fits in two quadrants (e.g., moderate influence, moderate
  interest), place them in the higher-engagement quadrant and note the
  ambiguity. It is safer to over-engage than under-engage.
- If the project is cross-organizational, create separate maps per
  organization or business unit and then a combined view.
- If the user names more than 20 individual stakeholders, suggest grouping
  by role or team to keep the map actionable.
- If any placeholder fields are left unfilled (e.g., "[INITIATIVE]" or
  "[ORGANIZATION CONTEXT]"), do not guess at the missing information.
  Instead, list the unfilled fields and ask the user to provide them
  before proceeding. Generating a stakeholder map with assumed context
  produces misleading engagement plans.
- If the stakeholder landscape is in a domain you have limited knowledge
  of (e.g., pharmaceutical regulatory affairs, maritime logistics),
  state your knowledge boundaries explicitly. Ask the user to validate
  the stakeholder categories you propose, since domain-specific
  influencers and regulatory bodies may not follow standard patterns.
- If the initiative involves more than 20 stakeholders across multiple
  business units, create a tiered map: a summary-level map with grouped
  stakeholders for leadership audiences, and detailed sub-maps per
  business unit for operational use. A single flat map with 25+ entries
  becomes unreadable and loses its prioritization value.

Output format:

### Stakeholder Map: [Project/Initiative Name]

**Influence-Interest Grid:**

|                    | Low Interest (1-2) | Medium Interest (3) | High Interest (4-5) |
|--------------------|-------------------|--------------------|--------------------|
| **High Influence (4-5)** | Keep Satisfied: ... | Manage Closely: ... | Manage Closely: ... |
| **Med Influence (3)**    | Monitor: ...        | Judgment call: ...  | Keep Informed: ...  |
| **Low Influence (1-2)**  | Monitor: ...        | Monitor: ...        | Keep Informed: ...  |

**Detailed Stakeholder Profiles:**

| Stakeholder | Role | Influence (1-5) | Interest (1-5) | Quadrant | Justification |
|-------------|------|----------------|----------------|----------|---------------|
| ...         | ...  | ...            | ...            | ...      | ...           |

**Dynamics and Risks:**
- [Alliances, tensions, potential shifts]

**Engagement Plan:**

| Stakeholder | Channel | Frequency | Key Message | Action Needed | Risk if Ignored |
|-------------|---------|-----------|-------------|---------------|-----------------|
| ...         | ...     | ...       | ...         | ...           | ...             |

**Review Schedule:** [When to revisit this map]
```

## Why This Works

**Program manager persona.** The prompt assigns the role of "an experienced program manager and organizational strategist." This produces output oriented toward action and engagement rather than academic stakeholder theory. The model thinks about how to move stakeholders, not just how to categorize them.

**Systematic stakeholder discovery.** Step 1 does not just ask for stakeholders; it probes six specific categories (decision makers, implementers, end users, influencers, affected parties, external parties). This structured discovery catches the stakeholders you are most likely to miss, which are typically the affected parties and influencers who lack formal roles but can quietly block progress.

**Dual-axis assessment with justification.** Rating each stakeholder on both influence (1-5) and interest (1-5) with a one-sentence justification forces the model to think carefully about each placement. The justification requirement prevents lazy scoring and makes the ratings auditable. Without justifications, influence-interest grids tend to cluster everyone in the top-right quadrant, which defeats the purpose.

**Dynamics and risk identification.** Step 4 goes beyond the static grid to identify alliances, tensions, and potential shifts. This is the section that transforms a stakeholder map from a snapshot into a strategic tool. Knowing that a currently low-interest VP could become high-interest if the budget overruns is actionable intelligence that a static list never provides.

**Engagement plan with specificity.** The engagement plan requires five specific elements per stakeholder: channel, frequency, key message, action needed, and risk if ignored. This level of specificity makes the output directly executable. Compare this to the naive output of "keep stakeholders informed," which gives you no idea what to actually do.

**Anti-pattern avoidance.** The explicit warnings against listing only people you already talk to, rating everyone as high-influence, confusing job title with actual influence, and writing identical engagement plans for everyone target the specific ways stakeholder maps fail in practice.

These techniques combine to produce the difference shown above: a strategic engagement plan with prioritized actions instead of a generic list of roles with no strategy attached.

## Usage Tips

- Fill in as many stakeholders as you can before running the prompt. The model is good at probing for gaps, but your organizational knowledge is the primary input.
- Be honest about influence ratings even when they are uncomfortable. A VP who is checked out has low interest regardless of their title.
- Share the grid (without the detailed notes) with your project sponsor to validate your assumptions. They will often catch stakeholders you missed.
- Update the map at major project milestones, not just on a fixed schedule. A stakeholder's interest can spike overnight when a decision suddenly affects their team.
- Use the engagement plan as a checklist, not a suggestion. Assign owners to each engagement action and track completion.
- If you are mapping stakeholders for a politically sensitive initiative, keep the detailed notes confidential and share only the summary grid with broader audiences.
- Consider creating a "before and after" version: map stakeholders at project kickoff, then re-map at the midpoint to see what shifted.
- **Slash command connection:** If you use `ai-bu-claude-commands`, the `/what-next` slash command can help prioritize which stakeholder conversations to schedule first based on the map's influence and interest ratings.

## Example Output

### Stakeholder Map: Migration from Legacy Monitoring to OpenTelemetry-based Observability

**Influence-Interest Grid:**

|                    | Low Interest (1-2) | Medium Interest (3) | High Interest (4-5) |
|--------------------|-------------------|--------------------|--------------------|
| **High Influence (4-5)** | VP of Engineering (Keep Satisfied) | | CTO, Director of Platform Engineering (Manage Closely) |
| **Med Influence (3)**    | Finance/Procurement (Monitor) | Security team (Keep Informed) | SRE team lead (Manage Closely) |
| **Low Influence (1-2)**  | | | Application developers, on-call engineers (Keep Informed) |

**Detailed Stakeholder Profiles:**

| Stakeholder | Role | Influence | Interest | Quadrant | Justification |
|-------------|------|-----------|----------|----------|---------------|
| CTO | Executive sponsor | 5 | 5 | Manage Closely | Initiated this migration as part of the cost-reduction mandate. Will present results to the board. |
| Director of Platform Engineering | Technical decision maker | 5 | 4 | Manage Closely | Owns the platform team that will build and maintain the new system. Success or failure reflects directly on their team. |
| VP of Engineering | Budget authority | 5 | 2 | Keep Satisfied | Controls the budget but has delegated this decision to the Director. Will only engage if costs exceed projections or timelines slip badly. |
| SRE team lead | Implementation lead | 3 | 5 | Manage Closely | Team will do the majority of the migration work. Deeply invested in the technical approach and concerned about on-call impact during the transition. |
| Security team | Compliance review | 3 | 3 | Keep Informed | Needs to verify that the new observability stack meets data retention and access control requirements. Not actively tracking the project yet. |
| Finance/Procurement | Contract management | 3 | 2 | Monitor | Will need to process vendor contract changes but has no opinion on the technical direction. |
| Application developers (approx. 40) | End users | 2 | 4 | Keep Informed | Will need to update instrumentation in their services. Care about developer experience and concerned about additional work during feature sprints. |
| On-call engineers (approx. 15) | End users | 1 | 5 | Keep Informed | Depend on monitoring for incident response. Anxious about losing dashboards and alerts they have built over years. |

**Dynamics and Risks:**
- The CTO and Director of Platform Engineering are aligned on the migration. This is a strong coalition.
- The SRE team lead is supportive of the direction but has raised concerns about the timeline being too aggressive. If the team feels rushed, support could shift to resistance.
- Application developers are a large group with high interest but low influence individually. If they collectively push back on the instrumentation burden, they can slow adoption significantly. Treat this group as higher-priority than their influence score suggests.
- The VP of Engineering is a latent risk. They are currently disengaged, but a budget overrun would immediately escalate their involvement and potentially trigger a project review.
- On-call engineers may resist if they perceive the new system as less reliable than the legacy tools during the transition period.

**Engagement Plan:**

| Stakeholder | Channel | Frequency | Key Message | Action Needed | Risk if Ignored |
|-------------|---------|-----------|-------------|---------------|-----------------|
| CTO | 1:1 briefing | Monthly | Migration is on track and projected savings remain valid. | Continued sponsorship; escalation path if blockers arise. | Loss of executive air cover if the project hits resistance. |
| Director of Platform Eng. | Working session | Weekly | Technical progress, decisions needed, resource asks. | Staffing decisions, architectural sign-off on key components. | Decisions stall; team lacks clear direction. |
| VP of Engineering | Email summary | Monthly (milestone-based) | Budget status and timeline confidence level. | No action unless budget changes. | Surprise when costs come in; potential project freeze. |
| SRE team lead | Stand-up and 1:1 | Weekly (stand-up), biweekly (1:1) | Your team's concerns are heard; timeline is negotiable on specifics. | Detailed migration runbooks, feedback on rollout sequence. | Team burnout or quiet resistance; quality of migration suffers. |
| Security team | Review meeting | Twice total (design review, pre-launch review) | New stack meets or exceeds current compliance posture. | Sign-off on data retention and access control configuration. | Last-minute compliance block delays launch. |
| Finance/Procurement | Email | As needed | Contract changes coming; here are the details and timeline. | Process vendor contract termination and new agreements. | Contract lapses or double-billing during transition. |
| Application developers | Tech talk and documentation | Monthly tech talk, async docs | Here is what changes for you, here is a migration guide, and here is the support channel. | Instrument their services using the new SDK within the migration window. | Low adoption; legacy and new systems run in parallel indefinitely, increasing cost. |
| On-call engineers | Hands-on workshop | Two workshops (pre-migration, post-migration) | Your dashboards and alerts will be migrated, not deleted. Here is how the new system works. | Test new dashboards during the parallel-run period and report gaps. | Incident response degrades during transition; trust in the new system never develops. |

**Review Schedule:** Revisit this map at the midpoint of the migration (approximately Week 8) and again two weeks before the legacy system decommission date. If any stakeholder's role or engagement level changes materially, update immediately.
