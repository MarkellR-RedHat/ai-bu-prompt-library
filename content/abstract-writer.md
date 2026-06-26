# Abstract Writer

Write a concise, well-structured abstract for a conference talk, paper, or technical presentation using expert-level prompt engineering with chain-of-thought reasoning and self-critique.

**Difficulty:** Intermediate

## When to use

- You are submitting a proposal to a CFP and need a polished abstract that stands out from hundreds of competing entries.
- You are writing a paper abstract and want to nail the problem-solution-takeaway structure on the first draft.
- You are creating a description for an internal tech talk, brown bag session, or lunch-and-learn.
- You need to hit a specific word count and want a draft that lands close to the limit without excessive editing.
- You want a structured starting point that you can iterate on rather than staring at a blank page.
- You are mentoring someone through their first CFP submission and want to show them what a strong abstract looks like.
- You have the technical substance but struggle to compress it into a tight, compelling summary.

## When NOT to use

- You are writing a full paper introduction. An abstract and an introduction serve different purposes. Use the blog-intro prompt or write the introduction manually.
- The CFP requires a specific format you already have a template for. Fill in the template directly instead of generating from scratch.
- You need marketing copy, a product announcement, or a press release. Those require a different tone and structure entirely.
- The content is speculative or not yet built. Abstracts work best when grounded in real work, real numbers, and real outcomes.

## Prompt

```
You are a senior technical writer who specializes in conference abstracts and academic paper summaries. You have reviewed thousands of CFP submissions across venues like KubeCon, FOSDEM, DevConf, Red Hat Summit, and top-tier academic conferences. You know what review committees look for and what makes them stop skimming and start reading.

Your task: write an abstract (150-250 words unless otherwise specified) for [FORMAT, e.g., a conference talk, a technical paper, a workshop session, a poster] about [TOPIC].

Context (fill in all fields; leave none blank):
- Conference or venue (if known): [VENUE, e.g., KubeCon, FOSDEM, internal tech talk]
- Target audience: [AUDIENCE, e.g., platform engineers, ML practitioners, open source maintainers]
- Key takeaway for the audience: [TAKEAWAY, e.g., "how to deploy disaggregated LLM inference on Kubernetes"]
- Constraints: [CONSTRAINTS, e.g., "must mention OpenShift," "word limit is 200," "needs to fit the AI/ML track"]
- Technical depth level: [DEPTH, e.g., beginner-friendly, intermediate, expert-level]
- One or two specific results, metrics, or proof points (if available): [RESULTS, e.g., "reduced p99 latency by 35%"]

Step-by-step reasoning (think through each step before writing):

Step 1: Identify the core tension or problem.
- What is broken, missing, hard, or misunderstood in the current state of things?
- Why should the audience care about this problem right now?
- Frame the problem in terms the target audience already thinks about.

Step 2: Articulate the contribution.
- What was built, discovered, measured, or proposed?
- What makes this approach different from the obvious alternatives?
- Include at least one concrete detail: a tool name, an architecture choice, a metric, or a design decision.

Step 3: Define the takeaway.
- What will the audience know, be able to do, or think differently about after reading or attending?
- Be specific. "Learn about Kubernetes" is too vague. "Deploy a KV-cache-aware routing layer on OpenShift" is concrete.

Step 4: Draft the abstract following this structure.
- Sentence 1-2: State the problem or challenge. Be direct. No throat-clearing.
- Sentences 3-5: Describe what you did, built, or discovered. Include specifics.
- Sentences 6-8: Explain the takeaway and what the audience gains. If relevant, state prerequisites.

Step 5: Self-critique checklist. Before producing the final output, verify each of the following:
- [ ] The first sentence names a real problem, not a vague topic area.
- [ ] At least one concrete detail (number, tool name, architecture) appears in the body.
- [ ] The abstract passes the "so what?" test. A reader can answer why this matters.
- [ ] The word count falls within the specified range.
- [ ] The tone is direct and confident without being salesy or breathless.
- [ ] No filler phrases appear (see anti-patterns below).
- [ ] No em dashes appear anywhere. Use commas, periods, semicolons, or "and" instead.
- [ ] The takeaway sentence is specific enough that a reviewer could repeat it back.
- [ ] The abstract works as a standalone paragraph without needing the talk slides for context.
- [ ] If a venue is specified, the tone and depth match that venue's norms.

Anti-patterns to avoid:
1. Do not use "In this talk, we will explore..." or any variant of "join us as we dive into." Just state what the talk covers.
2. Do not use vague buzzwords without grounding them. "Leverage AI to transform workflows" says nothing. Name the AI system, the workflow, and the transformation.
3. Do not bury the lead. The first sentence must be the problem or the key claim, not background context.
4. Do not write an abstract that could apply to five different talks. If you swap out the topic and the abstract still reads fine, it is too generic.
5. Do not use em dashes anywhere. Replace with commas, periods, semicolons, colons, or the word "and."
6. Do not use passive voice when active voice is clearer. "We built X" beats "X was built" in most cases.
7. Do not promise outcomes you cannot back up. If you do not have benchmark numbers, do not imply you do.
8. Do not front-load credentials or context before stating the problem. Reviewers want the substance first.

Edge case handling:
- If the topic is highly specialized (e.g., a kernel subsystem or a niche protocol), add one sentence of accessible context so reviewers outside the subfield can follow.
- If no metrics or proof points are available yet, focus on methodology and expected outcomes. Use language like "preliminary results show" or "this approach is designed to" rather than making unsupported claims.
- If the word limit is very tight (under 100 words), cut the takeaway section to a single sentence and focus on problem and contribution.
- If the format is a workshop or tutorial rather than a talk, shift the emphasis from "what we discovered" to "what participants will build or practice."
- If multiple authors are involved, use "we" consistently rather than switching between "I" and "we."

Output format:
Provide the abstract as a single block of text with no headers, bullet points, or markdown formatting inside it. Follow it with a brief "Revision notes" section that lists any trade-offs you made (e.g., "cut the prerequisites sentence to stay under 200 words") and one suggestion for how the author could strengthen the abstract further.
```

## Usage Tips

- Check the CFP for word limits and required fields before generating. Some venues cap at 150 words, and others want separate "what attendees will learn" fields that change what the abstract itself needs to cover.
- Include the venue name in the prompt so the tone matches. A KubeCon abstract reads differently than an internal brown bag. A peer-reviewed paper abstract is different from both.
- After generating, read the abstract out loud. If you stumble on a sentence, it is too long or too complex. Break it apart.
- Many reviewers skim 50+ abstracts in a sitting. Put the most important sentence first. Do not make them dig for the point.
- If the CFP asks for "what attendees will learn," make that explicit in the TAKEAWAY field so the model addresses it directly.
- Run the output through a word counter before submitting. LLMs often overshoot or undershoot word limits by 10-15%.
- Iterate. Use the first output as a draft, then ask the model to tighten specific sentences or swap in stronger verbs. One round of revision usually improves the result noticeably.
- If you are submitting to multiple venues, regenerate with each venue's name and audience rather than reusing the same abstract. Review committees notice when an abstract feels generic.

## Example Output

> Running large language models in production on Kubernetes exposes a fundamental mismatch: the default scheduler treats GPUs as interchangeable, ignoring model memory requirements, batch queuing, and cache state. This leads to wasted capacity, unpredictable latency, and frustrated platform teams who lack visibility into why their inference workloads underperform.
>
> This talk presents llm-d, an open source disaggregated inference platform built for OpenShift. llm-d separates prefill and decode phases into independently scalable components, enabling KV-cache-aware routing that places requests on nodes with hot caches instead of cold-starting each time. In benchmarks on a 32-GPU cluster running Llama 3 70B, this approach reduced p99 latency by 35% and improved GPU utilization from 45% to 78%. The architecture integrates with existing Kubernetes tooling, including the Gateway API and Kubernetes-native autoscalers, so platform teams do not need to rip and replace their current stack.
>
> Attendees will learn how disaggregated serving works at an architectural level, see a live deployment on OpenShift with real traffic, and walk away with a working configuration they can adapt for their own inference workloads. No prior experience with llm-d is required, but familiarity with Kubernetes concepts and basic ML serving patterns will help attendees get the most from the session.
>
> **Revision notes:**
> - Expanded the contribution section to name the specific model (Llama 3 70B) and mention Gateway API integration for concreteness.
> - Added "who lack visibility into why their inference workloads underperform" to sharpen the problem framing beyond generic frustration.
> - Word count is approximately 220, within the 150-250 range.
> - Suggestion for strengthening: if you have data on cost savings (e.g., "reduced GPU spend by X% per month"), adding one cost figure would make the business case even stronger for reviewers who are not purely technical.
