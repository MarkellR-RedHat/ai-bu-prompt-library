# Team Health Check

**Description:** Assess team health by analyzing observable signals across delivery, collaboration, morale, and technical practices to surface patterns and recommended actions.

**Difficulty:** Advanced

## Naive vs. Engineered

**Naive prompt:** "Assess the health of my engineering team."

**What you get:** Output like this:

> **Team Health Assessment:**
>
> - **Morale:** Monitor team morale regularly through check-ins and surveys.
> - **Velocity:** Track sprint velocity to identify trends over time.
> - **Communication:** Ensure open communication channels exist for the team.
> - **Technical Debt:** Allocate time to address technical debt regularly.
> - **Work-Life Balance:** Watch for signs of burnout and adjust workloads accordingly.
>
> **Recommendation:** Consider implementing regular retrospectives to surface issues early.

A generic checklist that reads like a blog post about team health. Nothing is connected to your team's actual situation. You finish reading it and still do not know what to do on Monday.

**This prompt** produces a structured diagnostic with a signal-by-signal dashboard (GREEN/YELLOW/RED), assessments across four dimensions (Delivery, Collaboration, Sustainability, Purpose), a ranked list of the top 3 issues with both quick actions and structural fixes, strengths worth protecting, and a data-gathering plan for any gaps. For example, instead of "Track sprint velocity," you get "Velocity: YELLOW. Decreasing over last 3 sprints (42, 38, 31 points). Root cause is unplanned work consuming 40% of sprint capacity. Quick action: designate one engineer per sprint as the interrupt shield. Structural fix: audit the top two sources of interrupt work and automate them." The difference is between reading a generic article about team health and getting a specific, evidence-based assessment that tells you what is wrong, what is right, and what to do next.

## When to use

- You suspect something is off with your team but cannot pinpoint what it is
- You are preparing for a quarterly planning cycle and want to take stock of how the team is actually doing
- You recently joined as a new manager and need a structured way to assess the team's current state
- Attrition has increased or engagement survey scores dropped and you want to dig deeper
- You want to have a structured conversation with your leadership chain about team health and need data-backed talking points
- You are scaling the team (hiring, reorgs, or new projects) and want a baseline before the change
- A major incident or missed deadline prompted questions about systemic issues versus one-off problems

## When NOT to use

- You want to evaluate an individual's performance; use a feedback or review prompt for that
- You are looking for a tool to replace actually talking to your team; this helps you prepare, not substitute for direct conversation
- The team just formed last week; you do not have enough signal yet to assess health meaningfully

## Prompt

```text
You are an experienced engineering director who assesses team health with the rigor of a
site reliability engineer diagnosing a system. You look at leading indicators, not just
lagging ones. You distinguish between symptoms and root causes. You give practical
recommendations, not platitudes.

CONTEXT (fill in before running):
- Team name and size: [NAME, NUMBER OF PEOPLE]
- Your role relative to the team: [direct manager / skip-level / new manager]
- How long this team has existed in its current form: [DURATION]
- Team's primary mission or product area: [DESCRIPTION]
- Current delivery status: [on track / slipping / blocked / unclear]

SIGNAL INVENTORY (fill in as many as you can; leave blank if unknown):
- Sprint/iteration velocity trend (last 3 cycles): [stable / increasing / decreasing / erratic]
- Number of unplanned work items or interrupts in the last cycle: [COUNT or ESTIMATE]
- How often does the team meet its own commitments: [almost always / sometimes / rarely]
- Recent attrition or transfer requests: [YES/NO, details if yes]
- Engagement survey highlights (if available): [KEY SCORES or "not available"]
- On-call or incident load: [light / moderate / heavy / crushing]
- Code review turnaround time: [hours / days / "reviews pile up"]
- How often do team members pair or collaborate versus work in isolation: [frequently / sometimes / rarely]
- Psychological safety signals: do people disagree openly in meetings: [yes / somewhat / no / unsure]
- Technical debt sentiment: does the team feel they can address tech debt: [yes / somewhat / no]
- Last time the team shipped something they were proud of: [WHEN and WHAT, or "cannot recall"]
- Manager's gut feeling in one sentence: [YOUR HONEST ASSESSMENT]

STEP-BY-STEP REASONING INSTRUCTIONS:

1. Review every signal provided. For each one, classify it as:
   - GREEN: healthy, no action needed
   - YELLOW: worth watching, early warning sign
   - RED: needs attention now, likely contributing to problems
   - UNKNOWN: not enough data to assess (flag for the manager to investigate)

2. Group the signals into four health dimensions:
   a. DELIVERY: Can the team ship reliably? (velocity, commitments, unplanned work)
   b. COLLABORATION: Does the team work well together? (code reviews, pairing,
      psychological safety, conflict resolution)
   c. SUSTAINABILITY: Is the pace maintainable? (on-call load, tech debt,
      attrition, wellbeing)
   d. PURPOSE: Does the team feel connected to meaningful work? (pride in
      shipping, engagement, clarity of mission)

3. For each dimension, write a 2-4 sentence assessment. Ground every claim in
   the specific signals provided. Do not invent signals that were not given.

4. Identify the top 3 issues, ranked by severity and urgency. For each:
   a. State the problem clearly in one sentence.
   b. Explain why it matters (second-order effects if left unaddressed).
   c. Recommend one concrete action the manager can take in the next two weeks.
   d. Recommend one structural change that addresses the root cause over
      the next quarter.

5. Identify 1-2 strengths the team should protect. These are things going well
   that could erode if neglected during a push to fix problems.

6. If there are significant unknowns (signals left blank), list them as a
   "data gathering plan" with specific suggestions for how the manager can
   collect that information.

OUTPUT FORMAT:

## Team Health Assessment: [Team Name] - [Date]

### Signal Dashboard

| Signal                        | Status  | Notes                    |
|-------------------------------|---------|--------------------------|
| Velocity trend                | GREEN   | Stable over 3 sprints    |
| Commitment accuracy           | YELLOW  | Hit 60% last two cycles  |
| ...                           | ...     | ...                      |

### Dimension Assessments

**Delivery**
[2-4 sentences grounded in signals]

**Collaboration**
[2-4 sentences grounded in signals]

**Sustainability**
[2-4 sentences grounded in signals]

**Purpose**
[2-4 sentences grounded in signals]

### Top 3 Issues

**1. [Issue title]**
- Problem: [one sentence]
- Why it matters: [second-order effects]
- Quick action (next 2 weeks): [specific step]
- Structural fix (next quarter): [root cause intervention]

**2. [Issue title]**
...

**3. [Issue title]**
...

### Strengths to Protect
- [Strength 1]: why it matters and what could erode it
- [Strength 2]: why it matters and what could erode it

### Data Gathering Plan (if unknowns exist)
- [Unknown signal]: how to gather this data (specific question, metric, or conversation)

### Recommended Conversation Starters
[3-4 questions the manager can bring to the team to validate or challenge
this assessment collaboratively]

SELF-CRITIQUE CHECKLIST (run before giving final output):
- [ ] Is every assessment grounded in a signal the manager provided, not invented?
- [ ] Are the issues ranked by actual severity, not just what is easiest to fix?
- [ ] Are the recommended actions specific enough to execute, not vague advice?
- [ ] Did you distinguish between symptoms and root causes?
- [ ] Are the strengths real strengths, not just "absence of problems"?
- [ ] If data is missing, did you flag it rather than filling in assumptions?
- [ ] Is the overall tone honest and practical, not alarmist or dismissive?
- [ ] Would a director reading this understand the situation without extra context?

ANTI-PATTERNS TO AVOID:
1. Do not catastrophize. A team with one red signal is not "in crisis."
   Be proportionate in your language.
2. Do not recommend vague actions like "improve communication" or
   "build trust." Name the specific practice, meeting, or habit to change.
3. Do not assume that low velocity means low effort. Investigate what is
   consuming capacity before judging output.
4. Do not ignore the sustainability dimension because delivery looks fine.
   A team shipping fast while burning out is not healthy.
5. Do not treat engagement survey scores as ground truth. They are one
   signal among many and can lag reality by months.
6. Do not project your own biases onto unknown signals. If you do not
   have data, say so.
7. Do not recommend adding process as the default fix. Sometimes the
   answer is removing process, not adding more.

EDGE CASE HANDLING:
- If fewer than half the signals are filled in, state clearly that the
  assessment is preliminary and emphasize the data gathering plan. Do not
  present tentative conclusions as confident findings.
- If all signals are green, do not manufacture problems. Instead, focus
  the output on what the team should invest in next (growth, stretch goals,
  knowledge sharing) and what risks could emerge.
- If the team is brand new (less than 2 months), shift the assessment
  from "health" to "formation progress" and focus on norming, role clarity,
  and early collaboration patterns.
- If there has been recent attrition, separate the assessment of current
  team state from the impact of attrition. Losing someone strong can
  temporarily worsen every signal; that is different from systemic dysfunction.
- If the manager's gut feeling contradicts the signals, flag the
  discrepancy explicitly and recommend investigating which one is more
  accurate.
```

## Why This Works

**Persona framing with analogical reasoning.** The prompt casts the model as "an experienced engineering director who assesses team health with the rigor of a site reliability engineer diagnosing a system." This analogy is deliberate: it tells the model to look at leading indicators, distinguish symptoms from root causes, and give actionable recommendations rather than platitudes. The SRE framing produces sharper, more systematic output than a generic management advisor persona would.

**Structured signal inventory.** Instead of asking the model to guess at team health, the prompt provides a detailed inventory of 12 specific signals for the user to fill in. This forces the analysis to be grounded in real data rather than speculation. The model cannot hallucinate problems when the inputs are explicit.

**Multi-dimensional assessment framework.** The four dimensions (Delivery, Collaboration, Sustainability, Purpose) ensure the analysis covers the full picture. Without this structure, both humans and models tend to fixate on delivery metrics and miss sustainability or purpose issues that are equally important but less visible.

**Two-tier remediation (quick action plus structural fix).** For each issue, the prompt requires both a two-week tactical action and a quarter-level structural change. This prevents the common failure of recommending only short-term patches that treat symptoms, or only long-term changes that offer no immediate relief.

**Self-critique and anti-pattern avoidance.** The checklist catches common diagnostic errors: inventing signals, catastrophizing one red indicator, recommending vague actions like "improve communication," or ignoring sustainability because delivery looks fine. These are the exact mistakes that make most team health assessments useless.

**Edge case handling.** The prompt explicitly addresses situations like sparse data, an all-green dashboard, brand-new teams, and gut-feeling contradictions. This prevents the model from forcing a template onto situations where the template does not fit.

These techniques combine to produce the difference shown above: a real diagnostic with ranked, actionable findings instead of a generic article that tells you what team health is without telling you anything about your team.

## Usage Tips

1. Fill in the signal inventory honestly. If you do not know the answer to a signal, leave it blank rather than guessing. The prompt handles unknowns well, and false data produces misleading assessments.
2. Run this quarterly at minimum. Team health changes slowly enough that weekly checks add noise, but fast enough that annual reviews miss important shifts.
3. After getting the output, validate it with your team. Share the dimension assessments (not the raw signal data) and ask: "Does this match your experience? What am I missing?" This builds trust and surfaces blind spots.
4. Pair the "quick actions" with your existing 1:1s and team meetings rather than creating new forums. The goal is to weave health improvements into work you are already doing.
5. Track your top 3 issues over time. If the same issue appears in consecutive quarters, the structural fix is not working and you need to escalate or try a different approach.
6. Use the "Strengths to Protect" section when making tradeoffs. If a proposed change threatens a known strength, that is a real cost to weigh.
7. If you manage multiple teams, run this for each one and compare the patterns. Cross-team issues (like heavy on-call load or unclear priorities) often point to organizational problems, not team-level ones.

## Example Output

## Team Health Assessment: Platform Services - 2026-06-27

### Signal Dashboard

| Signal                        | Status  | Notes                                             |
|-------------------------------|---------|---------------------------------------------------|
| Velocity trend                | YELLOW  | Decreasing over last 3 sprints (42, 38, 31 pts)   |
| Unplanned work                | RED     | 40% of last sprint was unplanned interrupt work    |
| Commitment accuracy           | YELLOW  | Hit commitments once in the last three sprints     |
| Attrition                     | RED     | Senior engineer left last month, one more exploring options |
| Engagement survey             | YELLOW  | "Manageable workload" score dropped from 4.1 to 3.2 |
| On-call load                  | RED     | 3-4 pages per week, two overnight in the last month |
| Code review turnaround        | GREEN   | Reviews completed within a few hours typically     |
| Pairing/collaboration         | GREEN   | Team pairs frequently, especially on complex work  |
| Psychological safety          | GREEN   | Disagreements happen openly in design reviews      |
| Tech debt sentiment           | RED     | Team has a backlog of 30+ tech debt items, none addressed in Q2 |
| Last proud ship               | YELLOW  | "The auth migration in March" (3 months ago)       |
| Manager gut feeling           | YELLOW  | "Good people, drowning in interrupt work"          |

### Dimension Assessments

**Delivery**
Velocity is trending down, and the root cause appears to be unplanned work consuming 40% of sprint capacity. The team is not slowing down by choice; they are being pulled off planned work by operational interrupts. Commitment accuracy has dropped accordingly, which risks eroding stakeholder trust if the pattern continues.

**Collaboration**
This is a genuine bright spot. Code reviews are fast, the team pairs on hard problems, and people disagree openly. These habits are valuable and should be protected, especially during a stressful period. The collaboration patterns suggest a team that trusts each other.

**Sustainability**
This is the most concerning dimension. On-call load is heavy, with overnight pages occurring regularly. A senior engineer recently left, and another is exploring options. The engagement survey's workload score dropped meaningfully. Tech debt is accumulating with no time allocated to address it. The team is running on fumes.

**Purpose**
The team has not shipped something they are proud of since March. Three months without a meaningful, planned delivery erodes motivation. The current work feels reactive rather than intentional, which disconnects the team from its mission.

### Top 3 Issues

**1. Unsustainable interrupt load**
- Problem: 40% of sprint capacity is consumed by unplanned work, which is driving down velocity, breaking commitments, and exhausting the team.
- Why it matters: If unaddressed, this will accelerate attrition. The remaining team members absorb more load, creating a downward spiral. Stakeholders will also lose confidence as planned work continues to slip.
- Quick action (next 2 weeks): Implement a weekly interrupt budget. Designate one engineer per sprint as the "interrupt shield" who handles all incoming requests while the rest of the team focuses on planned work. Rotate the role each sprint.
- Structural fix (next quarter): Audit the sources of interrupt work. Categorize every unplanned request from the last 6 weeks by source and type. The top two categories likely account for most of the load. Invest in automation, self-service tooling, or documentation to eliminate them at the source.

**2. On-call burden**
- Problem: 3-4 pages per week with overnight incidents is too high for a team this size, especially after losing a senior engineer.
- Why it matters: Chronic on-call stress is a primary driver of attrition in platform teams. It also degrades the quality of daytime work when engineers are sleep-deprived.
- Quick action (next 2 weeks): Review the last month of pages. Identify which alerts are actionable and which are noise. Suppress or auto-resolve the noise alerts immediately.
- Structural fix (next quarter): Set an on-call load target (e.g., fewer than 2 actionable pages per week) and treat exceeding it as a reliability investment trigger, the same way you would treat an SLO breach.

**3. Tech debt accumulation**
- Problem: 30+ tech debt items have accumulated with none addressed this quarter.
- Why it matters: Unaddressed tech debt makes every future change slower and riskier. It also signals to the team that quality does not matter, which affects morale and code review standards over time.
- Quick action (next 2 weeks): Pick the single highest-impact tech debt item and schedule it in the next sprint as a non-negotiable commitment. Completing one item breaks the psychological pattern of "we never fix anything."
- Structural fix (next quarter): Allocate 20% of sprint capacity to tech debt and operational improvements. Protect this allocation the same way you protect feature commitments.

### Strengths to Protect
- **Collaboration culture**: The team's pairing habits and psychological safety are rare and valuable. During stressful periods, managers sometimes cancel "optional" practices like pairing to free up individual capacity. Do not do that here. Pairing is part of what keeps this team resilient.
- **Fast code reviews**: Quick review turnaround keeps work flowing and prevents context-switching. As the team gets busier, there will be pressure to let reviews sit. Resist that and keep the current norm.

### Data Gathering Plan
All signals were provided. No major unknowns to investigate at this time.

### Recommended Conversation Starters
- "I have been looking at our interrupt load and I think it is higher than it should be. What is your experience? What types of requests burn the most time?"
- "We have not shipped a planned feature we are proud of since March. Does that match how you all feel? What would need to change for us to get back to that?"
- "I want to start protecting time for tech debt. If you could fix one thing in our codebase or infrastructure this quarter, what would it be?"
- "How is on-call feeling right now? Be honest. I want to know if it is sustainable or if we need to make changes."
