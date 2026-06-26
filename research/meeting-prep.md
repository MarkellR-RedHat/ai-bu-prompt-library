# Meeting Prep

Prepare for a meeting by organizing relevant context, identifying key questions, and drafting talking points so you walk in ready to contribute.

**Difficulty:** Beginner

## When to use

- Preparing for a meeting where you need to be up to speed on multiple topics
- Joining a meeting on a project you have not been following closely
- Preparing for a 1:1 with your manager or a skip-level
- Getting ready for a cross-team sync where you represent your team

## When NOT to use

- The meeting is a casual standup that does not need formal prep
- You are the one presenting and need to build a full deck (use exec-brief or workshop-outline instead)

## Prompt

```
Help me prepare for an upcoming meeting. Using the context below, create a structured prep document I can review in 5 minutes.

Meeting: [MEETING_TITLE]
Date/time: [DATE_AND_TIME]
Attendees: [KEY_ATTENDEES_AND_THEIR_ROLES]
Meeting purpose: [PURPOSE, e.g., design review, sprint planning, strategy discussion, 1:1]
My role in the meeting: [YOUR_ROLE, e.g., presenting a proposal, providing input, listening and taking notes]

Background context:
[PASTE_RELEVANT_CONTEXT, e.g., agenda, prior meeting notes, Slack threads, doc links, email threads]

Create this prep document:

1. **Meeting context** (2-3 sentences): What is this meeting about and why is it happening now?
2. **Key topics and what I need to know about each**: For each agenda item or likely topic, summarize the current state in 2-3 sentences. Flag anything that is contentious or unresolved.
3. **Questions I should ask**: List 3-5 specific questions I should raise, based on gaps in the context or decisions that need to be made.
4. **My talking points**: Based on my role, draft 2-4 concise talking points I can use. Each should be 1-2 sentences.
5. **Decisions expected**: List any decisions that should come out of this meeting, and note who is the decision maker.
6. **Follow-up items to watch for**: What should I pay attention to for after the meeting? Any deadlines or action items that might come my way?

Keep the total prep document under 400 words. Be specific and actionable. Do not pad with generic advice.
```

## Usage Tips

- Paste actual meeting agendas, prior meeting notes, or relevant Slack threads into the context section. More context produces better prep.
- For 1:1s, include your recent accomplishments and any blockers you want to raise.
- If you do not have a formal agenda, describe what you expect the meeting to cover based on recent conversations.
- Review the "Questions I should ask" section carefully. Good questions are often more valuable than good talking points.

## Example Output Snippet

> **Meeting context**: This is the weekly architecture review for the inference platform team. The main agenda item is the proposed switch from round-robin to KV-cache-aware routing, which was introduced in last week's RFC. The team needs to decide whether to proceed with implementation this sprint.
>
> **Questions I should ask**:
> - What is the rollback plan if cache-aware routing increases tail latency under bursty traffic?
> - Have we benchmarked this against the current router on our production traffic patterns, or only synthetic loads?
> - Who owns the cache state tracking component, and is that team resourced to support it?
>
> **Decisions expected**:
> - Go/no-go on implementing cache-aware routing this sprint. Decision maker: [TECH_LEAD].
> - Whether to run a shadow deployment before cutting over production traffic. Decision maker: [SRE_LEAD].
