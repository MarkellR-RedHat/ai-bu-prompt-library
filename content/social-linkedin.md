# LinkedIn Post Writer

Craft a LinkedIn post that shares technical content in a professional, informative way without sounding like marketing copy.

**Difficulty:** Beginner

## When to use

- You are sharing a blog post or project release and want to write a thoughtful post around it.
- You are announcing a talk or event and want to give people a reason to attend.
- You are sharing a lesson learned from engineering work and want to frame it for a broad technical audience.
- You are promoting open source work and want the post to focus on the substance, not the hype.

## When NOT to use

- You are writing official Red Hat corporate communications. Use approved channels and the corporate social media process instead.
- You are posting about sensitive topics like layoffs, acquisitions, or organizational changes. These require review from comms and legal.

## Prompt

```
Write a LinkedIn post about [TOPIC].

Context:
- This post is promoting/sharing: [CONTENT, e.g., a blog post, a talk, a project release, a lesson learned]
- Key takeaway for the reader: [TAKEAWAY, e.g., "you can now run distributed inference on Kubernetes without custom schedulers"]
- Link to include (if any): [URL]
- My role/perspective: [ROLE, e.g., engineer on the project, conference speaker, community member]

Requirements:
- Keep it under 300 words. Aim for 150-200.
- Open with the key insight or result, not "I'm excited to announce..."
- Write in first person. Sound like an engineer sharing what they learned, not a press release.
- Use short paragraphs (1-3 sentences each) for readability on mobile.
- Include 3-5 relevant hashtags at the end.
- Do not use em dashes. Use commas, periods, or "and" instead.
- No buzzwords. Say what the thing actually does.
```

## Usage Tips

- The best LinkedIn posts teach something. Lead with what you learned or what changed.
- Avoid starting with "Excited to share" or "Thrilled to announce." Start with the substance.
- If you are sharing a blog post, do not just summarize it. Add your own take or a detail that did not make the final draft.
- Posts with a specific number ("3 things I learned," "reduced latency by 40%") tend to perform better.

## Example Output

> GPU scheduling on Kubernetes has been a pain point for every team running inference workloads. The default scheduler does not understand model sizes, memory pressure, or batch queuing. You end up fighting resource requests and hoping for the best.
>
> We built llm-d to fix this. It is a disaggregated inference platform that handles GPU-aware scheduling natively on OpenShift. The key idea: separate prefill and decode phases so you can route requests based on actual KV-cache state, not just static resource limits.
>
> I wrote up how it works and how to deploy it in this walkthrough: [link]
>
> The part that surprised me most was how much latency dropped once we stopped treating every request the same. Not every prompt needs the same resources, and the scheduler should know that.
>
> If you are running LLMs on Kubernetes and fighting with GPU allocation, this might save you some headaches.
>
> #Kubernetes #OpenShift #MLInfra #InferenceServing #OpenSource
