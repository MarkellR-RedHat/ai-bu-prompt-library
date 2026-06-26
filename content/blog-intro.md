# Blog Intro Writer

Write a compelling introduction for a technical blog post that hooks the reader and sets up the rest of the article.

## Prompt

```
You are a technical writer at Red Hat. Write an introduction (3-5 sentences) for a blog post about [TOPIC].

The target audience is [AUDIENCE, e.g., platform engineers, developers, SREs].

Requirements:
- Open with a concrete problem or scenario the reader recognizes.
- State what the post will cover and why it matters.
- Keep the tone practical and direct. No hype, no filler.
- End the intro with a clear reason to keep reading.
- Do not use em dashes. Use commas, periods, or "and" instead.
- Avoid jargon unless the audience would expect it.
```

## Usage Tips

- Be specific with [TOPIC]. "Deploying LLMs on Kubernetes" works better than "AI stuff."
- Match [AUDIENCE] to who will actually read the post. A post for SREs needs a different hook than one for data scientists.
- If you have a working title for the blog, include it in the prompt for better alignment.
- Run it 2-3 times and pick the strongest opening, then edit from there.

## Example Output

> Every team that runs inference workloads on Kubernetes hits the same wall: GPU scheduling is not built into the default scheduler, and bolting it on after the fact creates more problems than it solves. This post walks through how llm-d handles distributed inference scheduling natively, without requiring a custom operator or sidecar. We will cover the architecture, show a working configuration, and explain the tradeoffs compared to other approaches. If you have been fighting with GPU resource requests and limits, this is the post you have been looking for.
