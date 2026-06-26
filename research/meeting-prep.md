# Meeting Prep

A prompt for preparing for a meeting by organizing relevant context, identifying key questions, drafting talking points, and anticipating decisions so you walk in ready to contribute effectively.

**Difficulty:** Beginner

## Naive vs. Engineered

Most people prompt something like this:

> **Naive prompt:** "Help me prepare for my meeting tomorrow about the routing proposal."

**What you get:** A generic list of things to think about ("review the agenda," "prepare questions," "be ready to take notes") that could apply to any meeting in any industry. You walk in no more prepared than before.

**This prompt** produces a prep document tailored to your specific meeting: who has the most at stake, what tensions will surface, what questions will move the group toward a decision, and what landmines to watch for. The difference: instead of generic advice you could have written yourself, you get a stakeholder-aware briefing that makes you the most prepared person in the room.

## When to use

- Preparing for a meeting where you need to be up to speed on multiple topics and want a structured way to organize your thinking.
- Joining a meeting on a project you have not been following closely and need to get oriented quickly.
- Preparing for a 1:1 with your manager or a skip-level and you want to make the most of the time.
- Getting ready for a cross-team sync where you represent your team and need clear talking points.
- Attending a design review or architecture discussion where you need to ask informed questions.
- Preparing for an external meeting (customer call, partner sync, vendor evaluation) where you need to project competence and preparation.

## When NOT to use

- The meeting is a casual standup or daily sync that does not need formal preparation. Over-preparing for lightweight meetings wastes time.
- You are the one presenting and need to build a full deck or workshop plan. Use the exec-brief or workshop-outline prompts instead, since those are designed for content creation rather than preparation.
- The meeting is a sensitive HR conversation, performance review, or disciplinary discussion. Do not send details of those conversations to an external AI service.
- You have no context at all about the meeting (no agenda, no prior notes, no background). The model cannot prepare you for a meeting it knows nothing about. Gather some context first.

## Prompt

```
You are an experienced engineering leader who is excellent at preparing for meetings.
You know that the most valuable thing in meeting prep is not summarizing what happened
before, but anticipating what will happen next: what questions will come up, what
decisions need to be made, what tensions exist, and what the person attending the meeting
should be ready to say.

Meeting: [MEETING_TITLE]
Date/Time: [DATE_AND_TIME]
Duration: [DURATION, e.g., "30 minutes", "1 hour"]
Attendees: [KEY_ATTENDEES_AND_THEIR_ROLES, e.g., "Jane (Tech Lead), Bob (PM), Sara (SRE Lead)"]
Meeting Purpose: [PURPOSE, e.g., "design review", "sprint planning", "strategy discussion",
  "1:1 with manager", "cross-team sync", "customer call"]
My Role in the Meeting: [YOUR_ROLE, e.g., "presenting a proposal", "providing technical input",
  "representing my team", "listening and taking notes", "making a decision"]

Background Context:
[PASTE_RELEVANT_CONTEXT: agenda, prior meeting notes, Slack threads, doc links, email threads,
relevant decisions that were made recently, any known tensions or disagreements]

Follow these steps carefully:

STEP 1: ANALYZE THE MEETING DYNAMICS
Before creating the prep document, think through:
- What is the real purpose of this meeting? (The stated purpose and the actual purpose
  sometimes differ.)
- Who has the most at stake in this meeting? What do they want to accomplish?
- What tensions or disagreements might surface?
- What decisions are likely to be made, and who is the decision maker?
- Given my role, what does a successful meeting look like for me?

STEP 2: CREATE THE PREP DOCUMENT
Use the following format exactly:

### Meeting Context (3-4 sentences)
What is this meeting about and why is it happening now? What triggered it?
What happened in the previous meeting or recent discussions that sets the stage?
Note any time pressure or deadlines driving the conversation.

### Key Topics and What I Need to Know
For each agenda item or likely discussion topic:
- **Topic**: [Name of the topic]
- **Current state**: What has been decided, proposed, or discussed so far (2-3 sentences)
- **Contentious points**: What is unresolved, disputed, or likely to generate debate
- **What I should know**: The specific facts, numbers, or context I need to have ready

If the agenda is not provided, infer the likely topics from the background context and
state that you are inferring.

### Questions I Should Ask (5-7)
List specific, pointed questions I should raise. For each question:
- State the question
- Explain briefly why it matters (what decision or understanding it unlocks)
- Note when to ask it (e.g., "ask early to set context" or "ask after the demo")

Prioritize questions that:
- Surface hidden assumptions
- Force clarity on vague proposals
- Identify risks that others may not have considered
- Move the group toward a decision rather than more discussion

Do not include generic questions like "what are the next steps?" unless there is a
specific reason why next steps are unclear.

### My Talking Points (3-5)
Based on my role and the background context, draft concise talking points I can use.
Each talking point should be:
- 1-2 sentences maximum
- Specific and grounded in facts from the context
- Framed for the audience (technical depth for engineers, business impact for leadership)

If I am presenting, include an opening statement and a closing recommendation.
If I am providing input, focus on the strongest points I can make.
If I am listening, include clarifying questions disguised as talking points.

### Decisions Expected
List each decision that should come out of this meeting. For each:
- What the decision is
- Who is the decision maker
- What information is needed to make the decision
- What the likely options are and which one seems strongest based on the context

If no decisions are expected, note that explicitly and describe what the meeting
should produce instead (alignment, information sharing, action items).

### Stakeholder Map
For each key attendee, note:
- Their likely perspective or position on the main topics
- What they care about most (technical excellence, timeline, cost, risk, team impact)
- How to engage them effectively (data-driven arguments, demos, risk framing, etc.)

This helps you tailor your communication to the room.

### Risks and Landmines
What could go wrong in this meeting? Consider:
- Topics that could derail the discussion into unproductive territory
- Questions that might be directed at me that I am not prepared to answer
- Political dynamics or interpersonal tensions that might surface
- Decisions that could be made prematurely without sufficient information

For each risk, suggest a brief mitigation (e.g., "redirect to the parking lot",
"offer to follow up with data", "suggest a time-boxed discussion").

### Follow-Up Items to Watch For
What should I pay attention to after the meeting?
- Likely action items that might come my way
- Deadlines that could be set in this meeting
- Decisions that need to be documented and communicated
- People I should follow up with individually after the meeting

STEP 3: SELF-CRITIQUE CHECKLIST
Before finalizing the prep document, verify each of the following:
- [ ] The meeting context explains why this meeting is happening now, not just what it is about
- [ ] Questions are specific and actionable, not generic placeholders
- [ ] Talking points are grounded in the provided context, not generic advice
- [ ] The stakeholder map reflects what I know about each attendee, not assumptions
- [ ] Decisions expected are realistic for the meeting duration and attendee list
- [ ] The prep document can be reviewed in 5 minutes or less
- [ ] Nothing in the prep is information I would be embarrassed to have on screen during the meeting

ANTI-PATTERNS TO AVOID:
1. Do not pad the prep with generic advice like "be prepared" or "listen actively."
   Every sentence should contain specific, actionable information.
2. Do not summarize background context I already provided. I gave you the context;
   use it to generate new insights, not to echo it back to me.
3. Do not include questions I already know the answer to. Questions should surface
   unknowns and drive decisions.
4. Do not assume I am the most senior person in the room. Frame talking points and
   questions appropriately for my stated role.
5. Do not ignore the meeting duration. A 30-minute meeting can realistically cover
   2-3 topics and make 1-2 decisions. Do not prep as if it were a half-day workshop.
6. Do not write talking points that sound scripted or corporate. They should sound
   like something a real engineer would actually say.
7. Do not skip the risks section. The most valuable prep anticipates what could go
   wrong, not just what should go right.

EDGE CASES:
- If this is a 1:1 with a manager, restructure the prep to focus on: (1) updates I want
  to share, (2) blockers I need help with, (3) career or growth topics I want to raise,
  (4) questions for my manager. Skip the stakeholder map.
- If this is an external meeting (customer, partner, vendor), add a section on
  "company/product background" summarizing what I should know about the other party.
- If no agenda is provided, state that clearly and build the prep around what you can
  infer from the background context. Flag topics as "inferred" so I know they might
  not come up.
- If I am joining a recurring meeting for the first time, include a section on
  "meeting norms" based on what can be inferred (format, cadence, typical outcomes).
- If the meeting involves a decision with significant technical risk, include a brief
  "decision framework" suggesting what criteria should guide the decision.

Keep the total prep document under 500 words (excluding the stakeholder map).
Be specific and actionable. Every sentence should help me walk into the meeting ready.
```

## Why This Works

This prompt uses several techniques that compound to produce meeting prep that is genuinely useful, not a checklist of obvious advice:

- **Persona framing.** "You are an experienced engineering leader who is excellent at preparing for meetings" sets the model's perspective as someone who understands meeting dynamics, organizational politics, and how decisions actually get made. This shifts the output from generic preparation tips to context-aware tactical guidance.

- **Role-aware output.** The prompt explicitly captures your role in the meeting and tailors the output accordingly. Talking points for a presenter look different from talking points for someone providing input or just listening. Without this signal, the model defaults to one-size-fits-all advice.

- **Structured output formatting.** Sections like Stakeholder Map, Decisions Expected, and Risks and Landmines force the model to think beyond "what topics will be discussed" and into "what dynamics will play out and how should I navigate them." This is the difference between knowing the agenda and being ready for the meeting.

- **Anti-pattern avoidance.** Blocking generic filler ("be prepared," "listen actively") and script-sounding talking points pushes the model to generate specific, grounded content. The constraint against ignoring meeting duration prevents over-preparation for short syncs.

- **Edge case handling.** Dedicated instructions for 1:1s, external meetings, and first-time recurring meetings prevent the model from using a single template for fundamentally different meeting types.

- **Self-critique checklist.** The verification step catches common failures like questions that are really just restatements of what you already know, or prep documents that take longer to read than the meeting itself.

These techniques together explain the difference shown in the comparison above: the naive prompt produces advice you already knew, while this prompt produces a briefing document you would actually review in the five minutes before the meeting.

## Usage Tips

- Paste actual meeting agendas, prior meeting notes, or relevant Slack threads into the context section. The more context you provide, the more specific and useful the prep will be. Vague input produces vague output.
- For 1:1s with your manager, include your recent accomplishments, current blockers, and any topics you want to raise. The prompt will restructure these into an effective 1:1 agenda.
- If you do not have a formal agenda, describe what you expect the meeting to cover based on recent conversations, Slack threads, or email exchanges. The model can work with informal context.
- Review the "Questions I Should Ask" section carefully. Good questions are often more valuable than good talking points. They demonstrate preparation and move discussions forward.
- For recurring meetings, save your prep documents and reference them in future prompts. This gives the model context about past discussions and decisions, which improves the prep over time.
- Use the "Risks and Landmines" section to mentally rehearse difficult scenarios. Even if the risks do not materialize, thinking through them makes you more confident in the meeting.
- For customer or partner meetings, supplement the prompt with the other party's recent press releases, product announcements, or LinkedIn profiles of key attendees. This context powers the stakeholder map.

## Example Output

> ### Meeting Context
> This is the weekly architecture review for the inference platform team. The main agenda item is the proposed switch from round-robin to KV-cache-aware routing, which was introduced in last week's RFC (authored by Alex). The team needs to decide whether to proceed with implementation this sprint or request additional benchmarking first. There is time pressure because the Q3 performance targets assume this optimization is in place by mid-quarter.
>
> ### Key Topics and What I Need to Know
> **Topic**: KV-cache-aware routing proposal
> - **Current state**: Alex submitted the RFC last Tuesday. Three reviewers have commented. General agreement on the problem statement but disagreement on the cache state reporting mechanism (push vs. pull).
> - **Contentious points**: Sara (SRE Lead) raised concerns about the operational complexity of real-time cache state reporting. Alex's RFC does not address node scaling events.
> - **What I should know**: Our current P99 prefill latency is 420ms. The RFC claims a 200-400ms reduction for cache-hit requests. Our cache hit rate on production traffic is approximately 35% based on last month's analysis.
>
> ### Questions I Should Ask
> 1. "What is our expected cache hit rate on production traffic, and how sensitive is the latency improvement to that number?" (Unlocks whether the claimed benefit is realistic for our workload. Ask early.)
> 2. "What happens to routing quality during a scale-up event when new nodes have empty caches?" (Surfaces an unaddressed edge case in the RFC. Ask after Alex presents.)
> 3. "Have we considered a hybrid approach where cache-aware routing is used for known-high-reuse workloads and round-robin for everything else?" (Opens a middle-ground option if the team is split. Ask if the discussion stalls.)
>
> ### Decisions Expected
> - **Go/no-go on implementing cache-aware routing this sprint.** Decision maker: Jordan (Tech Lead). Needs: agreement on push vs. pull for cache state, and confidence in the expected latency improvement. Likely outcome: conditional go, pending one more benchmarking run.
> - **Whether to run a shadow deployment before cutting over production traffic.** Decision maker: Sara (SRE Lead). Needs: risk assessment of the cache state reporting mechanism. Likely outcome: yes, shadow deployment required.
>
> ### Stakeholder Map
> - **Alex (RFC Author)**: Wants approval to proceed. Cares about technical elegance and performance wins. Engage with data; challenge assumptions gently.
> - **Sara (SRE Lead)**: Concerned about operational complexity and production risk. Cares about reliability and rollback plans. Engage with risk mitigation framing.
> - **Jordan (Tech Lead)**: Decision maker. Balancing performance goals against sprint capacity. Cares about making progress without taking on excessive risk. Engage with clear options and tradeoffs.
