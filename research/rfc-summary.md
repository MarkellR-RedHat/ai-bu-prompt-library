# RFC Summary

Summarize an RFC, design proposal, or architecture decision record into a structured format that helps reviewers quickly understand the proposal and form an opinion.

**Difficulty:** Intermediate

## When to use

- Reviewing an RFC or design doc before a review meeting
- Sharing the key points of a long proposal with your team
- Deciding whether an RFC needs your detailed review or just an acknowledgment
- Catching up on RFCs you missed during a busy sprint

## When NOT to use

- Writing the RFC itself (that requires your own design thinking)
- The RFC is short enough to read in 5 minutes (just read it)
- You need to provide detailed technical feedback (read the full RFC and comment directly)

## Prompt

```
You are a senior engineer summarizing an RFC for your team. Provide a structured summary that helps busy engineers decide how to engage with this proposal.

RFC title: [RFC_TITLE]
Author(s): [AUTHORS]
Status: [STATUS, e.g., Draft, Under Review, Accepted, Rejected]
Link: [LINK]

Provide your summary in this format:

1. **One-line summary**: What is being proposed, in plain language.
2. **Problem statement** (2-3 sentences): What problem does this RFC solve? Why is the current state insufficient?
3. **Proposed solution** (3-5 sentences): What is the proposed approach? Include the key architectural or design decisions.
4. **Key tradeoffs**: List 2-4 tradeoffs the proposal makes. For each, note what is gained and what is given up.
5. **Open questions**: List any unresolved questions or areas where the RFC explicitly asks for feedback.
6. **Dependencies and risks**: What does this proposal depend on? What could go wrong?
7. **Impact assessment**: Who is affected by this change? What systems, teams, or workflows need to adapt?
8. **Reviewer recommendation**: Based on the content, who should review this RFC carefully, and who can skim it? Be specific about roles or teams.

Keep the total summary under 400 words. Use precise technical language. If the RFC is ambiguous on a point, flag it rather than guessing.

RFC content:
[PASTE_RFC_TEXT_OR_KEY_SECTIONS_HERE]
```

## Usage Tips

- Paste the full RFC text if the model's context window allows it. For very long RFCs, paste the abstract, proposed solution, and alternatives sections.
- Share the summary in your team's Slack channel before the review meeting so people can prepare.
- Use the "Key tradeoffs" section to structure your review discussion. Tradeoffs are where the real design decisions live.
- If the RFC has multiple alternatives, ask the model to summarize each alternative separately.

## Example Output Snippet

> **One-line summary**: Proposes replacing the current round-robin request router with a KV-cache-aware router that directs inference requests to nodes with warm caches.
>
> **Problem statement**: The current router distributes requests evenly across all serving replicas, ignoring cache state. This means most requests trigger a cold cache miss on the prefill phase, wasting 200-400ms per request and reducing throughput by approximately 30%.
>
> **Key tradeoffs**:
> - **Gain:** Lower latency and higher throughput for repeated prompts. **Give up:** Added complexity in the routing layer, which now needs to track per-node cache state.
> - **Gain:** Better GPU utilization on cache-heavy workloads. **Give up:** Less even load distribution, which could cause hot spots under certain traffic patterns.
