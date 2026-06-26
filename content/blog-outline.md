# Blog Outline Generator

Create a structured outline for a technical blog post with logical flow and clear section purposes.

**Difficulty:** Beginner

## When to use

- You are starting a new blog post from scratch and need a skeleton to write against.
- You have scattered notes, bullet points, or ideas and need to organize them into a structured post.
- You are planning a multi-part blog series and want to map out what each post covers.

## When NOT to use

- You already have a clear outline and just need to write the content. Jump straight into drafting instead.
- The post is a quick update or announcement that does not need a detailed structure. Use the team-announcement prompt instead.

## Prompt

```
Create a detailed outline for a technical blog post about [TOPIC].

Context:
- Target audience: [AUDIENCE, e.g., platform engineers, Kubernetes operators, ML engineers]
- Post length: [SHORT (800-1000 words) / MEDIUM (1200-1800 words) / LONG (2000-3000 words)]
- Goal of the post: [GOAL, e.g., teach a concept, walk through a tutorial, compare approaches]

For each section, provide:
1. A heading (H2 or H3 as appropriate)
2. One sentence describing what that section covers
3. Key points or details to include (bulleted)

Structure the outline so that:
- The post builds logically from problem to solution
- Each section has a clear purpose and does not repeat prior sections
- Code examples, diagrams, or commands are called out where they belong
- The conclusion includes a concrete next step for the reader
- Do not use em dashes anywhere. Use commas, periods, or "and" instead.
```

## Usage Tips

- Setting the post length matters. A SHORT post should have 3-4 sections. A LONG post can handle 6-8.
- For tutorial posts, set the [GOAL] to something like "walk the reader through deploying X from scratch."
- For comparison posts, ask the outline to include a summary table.
- Once you have the outline, you can feed each section back to an LLM one at a time for drafting.

## Example Output

> ## Outline: Running Distributed Inference with llm-d on OpenShift
>
> ### 1. The Problem with GPU Scheduling Today
> What this section covers: Why default Kubernetes scheduling falls short for inference workloads.
> - GPU requests are binary (you get one or you don't)
> - No awareness of model size, memory requirements, or batch queuing
> - Real-world impact: wasted GPU time, failed pods, unpredictable latency
>
> ### 2. What llm-d Does Differently
> What this section covers: High-level architecture and design goals.
> - Disaggregated serving: separating prefill and decode
> - KV-cache-aware routing
> - How it integrates with the Kubernetes scheduler
>
> ### 3. Walkthrough: Deploying on OpenShift
> What this section covers: Step-by-step setup with code examples.
> - Prerequisites (OpenShift version, GPU operator, node labels)
> - Installing the llm-d operator (include YAML snippets)
> - Deploying a sample model and verifying it serves requests
>
> ### 4. What to Watch Out For
> What this section covers: Common pitfalls and how to avoid them.
> - Node affinity misconfigurations
> - Memory limits that conflict with KV-cache sizing
> - Monitoring recommendations
>
> ### 5. Next Steps
> What this section covers: Where to go from here.
> - Link to the project repo
> - Suggested follow-up: scaling to multi-node inference
> - Community resources and how to contribute
