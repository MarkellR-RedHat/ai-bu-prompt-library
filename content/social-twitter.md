# Twitter/X Thread Writer

Create a concise Twitter/X thread that breaks down technical content into a series of punchy, self-contained tweets.

## Prompt

```
Write a Twitter/X thread (5-8 tweets) about [TOPIC].

Context:
- This thread is about: [CONTENT, e.g., a technical concept, a project update, a conference talk, a tutorial]
- Target audience: [AUDIENCE, e.g., ML engineers, cloud-native developers, open source contributors]
- Key point to land: [KEY POINT, e.g., "disaggregated inference reduces GPU waste by routing requests based on KV-cache state"]
- Link to include (optional): [URL]

Requirements:
- Tweet 1 must hook the reader. Lead with a bold claim, a surprising fact, or a question.
- Each tweet should be under 280 characters.
- Number the tweets (1/, 2/, etc.).
- Make each tweet understandable on its own, since people often see threads out of order.
- End with a clear call to action (try it, read the post, check the repo).
- Keep the tone sharp and technical. No fluff, no "hot take" energy.
- Do not use em dashes. Use commas, periods, or "and" instead.
- Use 1-2 hashtags max, only in the last tweet.
```

## Usage Tips

- Write the hook tweet (1/) last. Once you know the full thread, the best opening becomes obvious.
- If a tweet feels too long, it probably contains two ideas. Split it.
- Threads work best when each tweet adds one new piece of information.
- Avoid emoji-heavy formatting. One or two are fine, but a wall of emoji hurts credibility.
- Test the thread by reading each tweet in isolation. If it does not make sense alone, rewrite it.

## Example Output

> 1/ Most Kubernetes clusters waste 30-50% of their GPU capacity on inference workloads. The problem is not the hardware. It is the scheduler.
>
> 2/ The default kube-scheduler treats GPUs like CPUs: you request one, you get one. It has no concept of model size, memory pressure, or how long a request will take.
>
> 3/ llm-d fixes this by disaggregating inference. It separates prefill (processing the prompt) from decode (generating tokens) and routes each phase independently.
>
> 4/ Why does that matter? Because prefill is compute-heavy and decode is memory-heavy. Scheduling them the same way guarantees you are wasting one resource or the other.
>
> 5/ The routing layer is KV-cache-aware. It knows which nodes have hot caches for a given model and sends requests there first, instead of cold-starting every time.
>
> 6/ We built it to run natively on OpenShift. No custom operators, no sidecars. Install the component, deploy your model, and the scheduler handles the rest.
>
> 7/ Walkthrough and architecture details here: [link]
>
> If you are running LLMs on Kubernetes, take a look. #OpenSource #Kubernetes
