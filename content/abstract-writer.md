# Abstract Writer

Write a concise, well-structured abstract for a conference talk, paper, or technical presentation.

## Prompt

```
Write an abstract (150-250 words) for [FORMAT, e.g., a conference talk, a technical paper, a workshop session] about [TOPIC].

Context:
- Conference/venue (if known): [VENUE, e.g., KubeCon, FOSDEM, internal tech talk]
- Target audience: [AUDIENCE, e.g., platform engineers, ML practitioners, open source maintainers]
- What the audience will learn or take away: [TAKEAWAY]
- Any constraints: [CONSTRAINTS, e.g., "must mention OpenShift," "word limit is 200," "needs to fit the AI/ML track"]

Requirements:
- First sentence: state the problem or challenge clearly.
- Second section: describe what you did, built, or discovered.
- Third section: explain what the audience will take away or be able to do after.
- Use concrete details (numbers, tool names, architectures) instead of vague claims.
- Keep the tone direct and confident, but not salesy.
- Do not use em dashes. Use commas, periods, or "and" instead.
- Avoid phrases like "in this talk we will explore" or "join us as we dive into." Just say what the talk covers.
```

## Usage Tips

- Check the CFP (call for papers) for word limits and required fields before generating. Some venues cap at 150 words.
- Include the venue name in the prompt so the tone matches. A KubeCon abstract reads differently than an internal brown bag.
- After generating, read the abstract out loud. If you stumble, it is too complex.
- Many reviewers skim. Put the most important sentence first.
- If the CFP asks for "what attendees will learn," make that explicit in the TAKEAWAY field.

## Example Output

> Running large language models in production on Kubernetes exposes a fundamental mismatch: the default scheduler treats GPUs as interchangeable, ignoring model memory requirements, batch queuing, and cache state. This leads to wasted capacity, unpredictable latency, and frustrated platform teams.
>
> This talk presents llm-d, an open source disaggregated inference platform built for OpenShift. llm-d separates prefill and decode phases, enabling KV-cache-aware routing that places requests on nodes with hot caches instead of cold-starting each time. In benchmarks on a 32-GPU cluster, this approach reduced p99 latency by 35% and improved GPU utilization from 45% to 78%.
>
> Attendees will learn how disaggregated serving works, see a live deployment on OpenShift, and walk away with a working configuration they can adapt for their own inference workloads. No prior experience with llm-d is required, but familiarity with Kubernetes and basic ML serving concepts will be helpful.
