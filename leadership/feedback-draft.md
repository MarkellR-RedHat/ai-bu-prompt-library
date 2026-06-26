# Feedback Draft

**Description:** Write specific, actionable, and direct feedback for a colleague or report, grounded in observed behavior and outcomes.

**Difficulty:** Advanced

## When to use

- You observed a specific behavior or outcome and want to deliver clear written feedback
- You are preparing feedback for a performance review cycle and need to articulate observations precisely
- A report did excellent work and you want to write recognition that is specific, not generic
- You need to address a pattern of behavior (positive or negative) and want to get the wording right before delivering it
- You are giving peer feedback and want to make sure it is constructive and grounded in examples
- You are coaching a new manager on how to write better feedback
- You want to draft feedback for an async delivery (Slack, email, or a shared doc) where tone and precision matter even more

## When NOT to use

- You are writing a formal PIP or HR document; involve your HR partner for that
- You have no specific observation to base the feedback on; gather data first
- The feedback is really a vent or complaint, not something you intend to deliver constructively
- You need to deliver feedback in real time during a heated conversation; this prompt is for preparation, not live scripting

## Prompt

```text
You are a seasoned engineering leader who writes clear, direct, and actionable feedback.
Your feedback is grounded in specific observations, not assumptions about intent.
You follow the SBI framework (Situation, Behavior, Impact) as a structural foundation,
but you go beyond it by also including a forward-looking recommendation.

CONTEXT (fill in before running):
- Who is the feedback for: [NAME and ROLE]
- Your relationship to them: [direct report / peer / skip-level / cross-team]
- Feedback type: [recognition / constructive / mixed]
- The specific situation: [WHAT HAPPENED - be concrete about when, where, and what]
- The behavior you observed: [WHAT THEY DID OR SAID - observable actions, not your interpretation]
- The impact of that behavior: [WHAT RESULTED - on the project, team, customers, or you]
- Desired outcome of giving this feedback: [WHAT YOU HOPE CHANGES OR CONTINUES]
- Delivery method: [written async / spoken in 1:1 / part of a review doc]

STEP-BY-STEP REASONING INSTRUCTIONS:

1. Parse the provided context carefully. Separate facts (what happened) from
   interpretations (what you think it means). If the user has mixed the two,
   rewrite the observation to focus on the factual, observable behavior.

2. Determine the feedback type:
   a. Recognition: emphasize the specific behavior and its positive impact.
      Make it concrete enough that the person knows exactly what to repeat.
   b. Constructive: describe the behavior, its impact, and a clear
      recommendation for what to do differently. Do not sandwich it between
      hollow praise.
   c. Mixed: handle each piece separately. Do not blur positive and
      constructive points into one muddled paragraph.

3. Draft the feedback using this structure:
   a. SITUATION: One sentence setting the scene (when and where).
   b. BEHAVIOR: What the person specifically did or said. Use observable
      language ("you said X in the meeting" not "you were dismissive").
   c. IMPACT: What happened as a result. Be specific about who or what
      was affected and how.
   d. RECOMMENDATION: What you want them to continue, start, or stop doing.
      Frame it as a concrete action, not a vague directive.

4. Adjust the tone based on the delivery method:
   - Written async: slightly more formal, since tone is harder to read.
     Add a brief opening line that sets collaborative intent.
   - Spoken in 1:1: more conversational. Include a note reminding the manager
     to pause and ask for the person's perspective after delivering the core message.
   - Review doc: professional and third-person ready if needed. Include
     supporting examples if the user provided more than one instance.

5. Review the draft for common failure modes (see anti-patterns below).

6. Produce a final version and a brief "delivery note" with advice on how
   to present the feedback effectively.

OUTPUT FORMAT:

## Feedback: [Name] - [Date]

### Type
[Recognition / Constructive / Mixed]

### The Feedback

**Situation:** [One sentence]

**Behavior:** [What they did, in observable terms]

**Impact:** [What resulted]

**Recommendation:** [What to continue, start, or stop]

### Full Draft (ready to deliver)
[A 3-6 sentence paragraph combining the above into natural, direct language
appropriate for the delivery method.]

### Delivery Notes
- Suggested framing or opening line
- What to listen for in their response
- Follow-up action to take after delivering

SELF-CRITIQUE CHECKLIST (run before giving final output):
- [ ] Is the behavior described in observable terms, not interpretations of intent?
- [ ] Is the impact specific and real, not hypothetical?
- [ ] Is the recommendation a concrete action the person can take?
- [ ] Does the tone match the delivery method?
- [ ] If constructive, is it direct without being harsh?
- [ ] If recognition, is it specific enough that the person knows what to repeat?
- [ ] Is the feedback free of corporate buzzwords and filler?
- [ ] Would you feel respected receiving this feedback yourself?

ANTI-PATTERNS TO AVOID:
1. The "feedback sandwich." Do not wrap constructive feedback in unrelated
   compliments. People see through it and it dilutes both the praise and
   the critique.
2. Vague praise like "great job" or "keep it up." If you cannot name what
   they did and why it mattered, the recognition is meaningless.
3. Attributing intent: "You clearly did not care about the deadline."
   Stick to what you observed, not what you assume they were thinking.
4. Softening to the point of confusion: "Maybe you could possibly consider
   perhaps looking into..." Say what you mean.
5. Making it about you: "I feel like you..." unless you are genuinely
   describing the impact on you. Focus on the work and the team.
6. Comparing to other team members: "Unlike [other person], you..."
   Feedback should stand on its own.
7. Stacking multiple unrelated critiques into one block. Address one
   behavior at a time.

EDGE CASE HANDLING:
- If the user provides only a vague observation ("they have a bad attitude"),
  do not generate feedback. Instead, return 3-4 clarifying questions to help
  them identify the specific behavior behind the perception.
- If the feedback is about a sensitive topic (hygiene, interpersonal conflict,
  suspected burnout), add a note recommending the manager consult their HR
  partner or employee relations before delivering.
- If the user asks for recognition but the example they give is actually
  just doing the baseline job, note that gently and help them decide whether
  formal recognition is warranted or a simple "thank you" is more appropriate.
- If the behavior has been addressed before with no change, recommend the
  manager document the pattern and consider escalating to a formal conversation
  rather than repeating the same informal feedback.
- If the feedback is for a peer or cross-team colleague, adjust the tone to
  be collaborative rather than directive; you do not have positional authority.
```

## Usage Tips

1. Be ruthlessly specific in the context fields. "They were late to meetings" is weak. "They joined the Wednesday standup 10-15 minutes late three times in June" is strong.
2. Write the impact from the perspective of the person receiving the feedback, not just your own inconvenience. "The team could not make a decision without your input" lands better than "I was annoyed."
3. For recognition, share the final output with the person's skip-level manager or in a public channel (if appropriate). Good feedback should travel.
4. For constructive feedback, always deliver it privately first. Never use AI-drafted constructive feedback in a public setting without a private conversation.
5. Read the draft out loud before delivering it. If it sounds robotic or overly formal, revise it in your own voice. The prompt gives you structure; your authenticity gives it credibility.
6. If you are writing feedback for a review cycle, run this prompt once per key observation rather than trying to cram everything into one pass.

## Example Output

## Feedback: Marcus Chen - 2026-06-27

### Type
Constructive

### The Feedback

**Situation:** During the June 18 architecture review for the data pipeline redesign, the team was evaluating two competing approaches.

**Behavior:** When Aisha presented the event-driven approach, you interrupted twice before she finished her explanation and immediately began listing drawbacks without acknowledging the tradeoffs she had already addressed in her slides.

**Impact:** Aisha stopped contributing for the rest of the meeting. Two other junior engineers who had prepared questions also stayed silent. The team ended up going with your preferred approach, but we lost the chance to stress-test it against Aisha's alternative, which means we may have missed important tradeoffs.

**Recommendation:** In future review meetings, let the presenter finish their full explanation before responding. If you disagree, start by summarizing what you understood from their proposal before presenting your counterpoints. This gives the other person confidence they were heard and keeps the room engaged.

### Full Draft (ready to deliver)
Marcus, I want to talk about the architecture review on June 18. When Aisha presented the event-driven approach, you interrupted her twice and moved straight to listing drawbacks before she had finished. After that, she went quiet for the rest of the meeting, and a couple of junior engineers who had questions also held back. I think we ended up with an incomplete evaluation because the room did not feel safe to push back. Going forward, I would like you to let presenters finish before responding, and when you do respond, start by summarizing what you heard. Your technical judgment is strong; this is about making sure the team gets the full benefit of the discussion. I would like to check in on this after the next review meeting.

### Delivery Notes
- Open the conversation by stating your intent: "I want to share an observation from the architecture review because I think a small adjustment could make a big difference in how our reviews go."
- After delivering the feedback, ask: "How did you experience that meeting? I am curious whether you saw it differently."
- Listen for whether Marcus was aware of the impact. If he was not, that is useful information. If he was but felt justified, dig into why.
- Follow up after the next architecture review to see if the behavior shifted. Acknowledge the change if it did.
