# Newsletter Blurb Writer

Write a 2-3 sentence newsletter blurb that makes a reader want to click through and learn more.

**Difficulty:** Beginner

## When to use

- Writing a blurb for an internal or external newsletter
- Summarizing a blog post, talk, or release for a newsletter audience
- Need a quick, punchy summary that fits in a newsletter layout
- Promoting a team's work to a broader audience

## When NOT to use

- Writing the full article (use blog-outline and blog-intro instead)
- The content needs a detailed summary with technical depth (use paper-summary instead)

## Prompt

```
Write a newsletter blurb (2-3 sentences) about the following content.

Content to summarize: [CONTENT_TITLE_AND_LINK]
What the content covers: [BRIEF_DESCRIPTION]
Target newsletter audience: [AUDIENCE, e.g., engineering org, open source community, AI/ML practitioners]
Tone: [TONE, e.g., technical, conversational, executive-level]

Requirements:
- First sentence: state the core insight or result. Make the reader curious.
- Second sentence: add one specific detail (a number, a tool name, a concrete outcome) that makes the content credible.
- Third sentence (optional): give the reader a reason to click through. What will they learn or be able to do?
- Keep it under 60 words total.
- Do not use em dashes. Use commas, periods, or "and" instead.
- No buzzwords. No "excited to share" or "we are thrilled." Just say what the content is about.
```

## Usage Tips

- Paste the actual title and link so the blurb matches the content precisely.
- If the newsletter has a character limit, add that as a constraint in the prompt.
- Run it twice and pick the version with the strongest opening line.
- Works well for both internal engineering newsletters and external community digests.

## Example Output

> GPU scheduling on Kubernetes wastes 30-50% of capacity because the default scheduler ignores model memory and cache state. This post walks through how llm-d fixes that with KV-cache-aware routing on OpenShift, cutting p99 latency by 35%. Worth a read if you are running inference workloads at scale.
