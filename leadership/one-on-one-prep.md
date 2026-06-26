# One-on-One Meeting Prep

**Description:** Generate a structured preparation document for 1:1 meetings with your direct reports, covering priorities, blockers, growth topics, and follow-ups.

**Difficulty:** Intermediate

## Naive vs. Engineered

**Naive prompt:** "Help me prepare for my 1:1 with my direct report tomorrow."

**What you get:** A generic list of conversation starters like "How are things going?" and "Any blockers?" with no connection to your actual team context, no time structure, and no follow-up tracking. You could have written that list yourself in two minutes.

**This prompt** produces a complete, context-specific prep document with an anchor topic, categorized open-ended questions drawn from your real inputs, a time-blocked agenda with buffer, a difficult-conversation script when needed, and a self-critique pass to catch vague or unusable output. The difference is between walking into a 1:1 with generic small talk and walking in with a focused plan that makes the conversation actually productive.

## When to use

- You have a recurring 1:1 coming up and want to make the most of the time
- A report has been quiet lately and you want to prepare thoughtful check-in questions
- You need to deliver difficult news or discuss a performance concern in a 1:1 setting
- You are a new manager building the habit of structured 1:1 preparation
- You want to revisit action items from previous meetings and ensure accountability
- You are preparing for a skip-level meeting and need a tighter agenda
- A report recently changed roles, teams, or responsibilities and you want to check in on the transition

## When NOT to use

- You need to write a formal performance review (use a performance review prompt instead)
- The meeting is a group retrospective or team standup, not a 1:1
- You are looking for HR policy guidance or legal advice on a personnel matter
- You want to avoid doing the thinking yourself; this prompt helps you prepare, not replace your judgment

## Prompt

```text
You are an experienced engineering manager preparing for a 1:1 meeting with a direct report.
Your goal is to produce a focused, practical prep document that helps the manager
make the most of a 30-minute conversation.

CONTEXT (fill in before running):
- Report's name: [NAME]
- Their role and current project: [ROLE / PROJECT]
- How long you have managed them: [DURATION]
- Last 1:1 key takeaways or action items: [SUMMARY OR "none"]
- Any specific concerns or topics you want to address: [TOPICS OR "none"]
- Recent wins or notable contributions: [WINS OR "none"]
- Upcoming milestones or deadlines relevant to them: [MILESTONES OR "none"]

STEP-BY-STEP REASONING INSTRUCTIONS:

1. Start by reviewing the context provided. Identify any gaps in information and note
   what assumptions you are making. If critical context is missing (like the report's
   current project), flag it clearly rather than guessing.

2. Categorize the meeting topics into these buckets:
   a. Follow-ups from last meeting (accountability check)
   b. Current work status and blockers
   c. Career growth and development
   d. Team dynamics and collaboration
   e. Wellbeing and engagement
   f. Manager-driven topics (things you need to communicate)

3. For each bucket, draft 2-3 open-ended questions. Avoid yes/no questions.
   Favor "what" and "how" over "why" (which can feel interrogative).

4. Identify one topic that deserves the most time and mark it as the
   "anchor topic." This should be the thing that, if you only had 10 minutes,
   you would still cover.

5. Draft a loose time allocation across the 30 minutes. Leave 5 minutes of
   buffer; do not schedule the full 30 tightly.

6. If there are difficult topics (performance concerns, organizational changes,
   role shifts), draft a brief script for how to open that conversation.
   Use direct, respectful language. Do not soften the message to the point
   of ambiguity.

7. List 2-3 things you want to actively listen for during the meeting
   (signals of disengagement, excitement, confusion, etc.).

OUTPUT FORMAT:

## 1:1 Prep: [Report Name] - [Date]

### Anchor Topic
[The single most important topic and why it matters]

### Follow-Ups from Last Meeting
- [ ] Action item 1: status check question
- [ ] Action item 2: status check question

### Questions by Category
**Current Work**
- Question 1
- Question 2

**Growth and Development**
- Question 1
- Question 2

**Team Dynamics**
- Question 1

**Wellbeing**
- Question 1

### Time Allocation (30 min)
| Block        | Minutes | Topic               |
|--------------|---------|---------------------|
| Opening      | 3       | Check-in            |
| ...          | ...     | ...                 |
| Buffer       | 5       | Overflow / wrap-up  |

### Difficult Conversation Script (if applicable)
> Opening line: "I want to talk about [X] because..."
> Key point: ...
> Ask for their perspective: ...

### Signals to Listen For
- Signal 1
- Signal 2

### My Notes (blank, fill during meeting)
-

SELF-CRITIQUE CHECKLIST (run before giving final output):
- [ ] Are all questions open-ended, not yes/no?
- [ ] Is there a clear anchor topic identified?
- [ ] Does the time allocation leave buffer room?
- [ ] If a difficult topic exists, is the script direct and not vague?
- [ ] Are follow-up items from the last meeting included?
- [ ] Is the tone respectful but honest, not corporate-speak?
- [ ] Would a real manager find this useful in the next 10 minutes?

ANTI-PATTERNS TO AVOID:
1. Do not generate generic questions like "How are things going?" without
   tying them to specific context the manager provided.
2. Do not pad the document with filler. If a category has nothing relevant,
   skip it and say so.
3. Do not use corporate jargon ("synergy," "leverage," "align on,"
   "circle back"). Use plain language.
4. Do not assume the report's emotional state. Prepare questions that
   surface it rather than projecting.
5. Do not create an agenda so rigid that there is no room for the report
   to bring their own topics.
6. Do not write a script for the entire meeting. This is prep, not a
   teleprompter.

EDGE CASE HANDLING:
- If no previous action items are provided, skip the follow-up section and note
  that establishing recurring follow-ups is itself a good topic.
- If the manager indicates a concern but gives no detail, ask one clarifying
  question before generating the difficult conversation script.
- If the report is new (less than 30 days), shift the emphasis toward
  onboarding check-in, relationship building, and learning their communication
  preferences.
- If multiple difficult topics exist, recommend splitting them across two
  meetings rather than cramming them into one session.
```

## Why This Works

**Persona framing.** The prompt opens by assigning the model the role of "an experienced engineering manager." This constrains the output to practical, management-specific advice rather than generic productivity tips. Without a persona, the model defaults to a bland assistant voice that produces surface-level suggestions.

**Structured chain-of-thought.** The seven numbered steps force the model to reason through the preparation in a deliberate sequence: review context, categorize topics, draft questions, identify the anchor, allocate time, handle difficult conversations, and define listening signals. Each step builds on the previous one, which prevents the model from jumping straight to a list of generic questions.

**Output formatting.** By specifying the exact sections, table structure, and checklist format, the prompt ensures the output is immediately usable. You can paste it into your notes app and walk into the meeting. Without format constraints, the model produces a wall of prose that requires extra work to turn into something actionable.

**Self-critique checklist.** The checklist at the end forces the model to evaluate its own output against quality criteria before presenting it. This catches common failures like yes/no questions, missing follow-ups, or overly rigid agendas. It functions as a built-in quality gate.

**Anti-pattern avoidance.** Explicitly listing what NOT to do (generic questions, corporate jargon, scripting the entire meeting) is as important as listing what to do. Models tend to default to safe, bland output. Naming the specific failure modes steers the output away from those defaults.

These techniques combine to produce the difference shown above: instead of a generic question list, you get a structured, context-aware document that respects your time and your report's.

## Usage Tips

1. Fill in the context section honestly. The more specific your input, the more useful the output. "They seem disengaged" is better than leaving the concerns field blank.
2. Run this prompt the day before your 1:1, not five minutes before. Give yourself time to read the output and adjust it.
3. Pair this with your own notes from Slack, pull requests, or standups. The prompt works best when you feed it real observations, not vibes.
4. Do not read the prep document to your report like a script. Use it as a reference, then have a real conversation.
5. After the meeting, revisit the "Signals to Listen For" section and jot down what you actually noticed. This builds your pattern-recognition over time.
6. If you use this weekly, keep a running document and paste previous action items into the "Last 1:1 key takeaways" field. Continuity matters.

## Example Output

## 1:1 Prep: Priya Sharma - 2026-06-27

### Anchor Topic
The migration to the new CI pipeline has been her primary focus for three weeks. She mentioned blockers in Slack last Tuesday but did not follow up. Understanding where the migration stands and whether she needs help is the priority.

### Follow-Ups from Last Meeting
- [ ] She was going to draft an RFC for the caching layer redesign. Did she get to it, or did the CI work take over?
- [ ] She asked about attending a conference in Q3. Have you looked into the budget for that?

### Questions by Category
**Current Work**
- What is the current state of the CI migration? Where are you spending most of your time on it?
- You mentioned some blockers last week in the #platform channel. Are those resolved, or do you need me to clear something?

**Growth and Development**
- You mentioned interest in tech-leading a project next quarter. What kind of project would feel like a good stretch for you?
- Is there anything in your current work that feels repetitive or below your skill level?

**Team Dynamics**
- How is the collaboration with the QE team going on the migration? Anything I should know?

**Wellbeing**
- You have had a heavy few weeks. How is your workload feeling right now, honestly?

### Time Allocation (30 min)
| Block        | Minutes | Topic                        |
|--------------|---------|------------------------------|
| Opening      | 3       | General check-in             |
| Follow-ups   | 5       | RFC and conference budget    |
| Anchor topic | 10      | CI migration status/blockers |
| Growth       | 5       | Tech lead aspirations        |
| Wellbeing    | 2       | Workload check               |
| Buffer       | 5       | Overflow or her topics       |

### Difficult Conversation Script
Not applicable this session.

### Signals to Listen For
- Does she seem frustrated or energized when discussing the CI migration?
- Does she mention other team members in a way that suggests collaboration issues?
- Is she bringing her own topics, or just answering your questions?

### My Notes (blank, fill during meeting)
-
