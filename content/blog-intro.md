# Blog Intro Writer

Write a compelling, technically grounded introduction for a blog post that hooks the reader with a real problem and sets up the rest of the article with clarity and purpose.

**Difficulty:** Intermediate

## Naive vs. Engineered

**Naive prompt:**
> "Write an intro for my blog post about Kubernetes GPU scheduling."

**What you get:** "In today's rapidly evolving cloud landscape, GPU computing has become increasingly important for organizations looking to harness the power of artificial intelligence. As Kubernetes continues to gain adoption, teams are finding new ways to optimize their infrastructure for GPU workloads. This blog post explores the exciting possibilities of GPU scheduling and how it can transform your deployment strategy." Three sentences, zero information, could describe any project at any company.

**This prompt produces:** A tight, 4-7 sentence introduction that opens with a concrete pain point (the default Kubernetes scheduler treating GPUs as interchangeable, ignoring model memory, KV-cache state, and batch dynamics), establishes real stakes (wasted GPU capacity, failed deployments, on-call pages at 2 AM), bridges to a specific solution (llm-d handling inference scheduling natively within the Kubernetes scheduling framework on OpenShift), and ends with a reason to keep reading. The output includes visible chain-of-thought reasoning so you can see how the model arrived at its choices, plus a self-critique checklist that catches weak openings, hype language, and scope drift before you ever see the final draft.

**The difference:** One gives you filler you will rewrite from scratch. The other gives you a working first draft that needs light editing.

---

## When to use

- You are writing a technical blog post and need a strong opening that earns the reader's attention in the first three sentences.
- You are stuck on the first paragraph and need a structured way to break through writer's block.
- You are writing for upstream project blogs or engineering community publications and want a direct, practical tone.
- You have the topic and audience nailed down but need help translating that into an engaging opener that frames the problem clearly.
- You want to generate multiple intro options, compare them against concrete quality criteria, and pick the strongest one to edit from.
- You need an intro that bridges a specific pain point to a technical solution without sounding like a product pitch.
- You are writing about a complex topic and need help deciding which angle will resonate most with your target audience.

## When NOT to use

- The blog post is already drafted and just needs editing or tightening. Use a revision prompt or edit manually instead.
- You are writing non-technical or marketing-focused content where a different voice and structure are needed.
- You need a full blog post, not just the introduction. This prompt is scoped to the opening section only.
- You are writing release notes, changelogs, or documentation where an intro "hook" would feel out of place.

## Prompt

```
You are a senior technical writer at a major infrastructure company with deep experience writing for engineering audiences. Your job is to write a strong introduction (4-7 sentences) for a blog post.

INPUTS (fill these in before running):
- TOPIC: [Describe the specific technical topic. Be precise. Example: "How llm-d schedules GPU inference workloads on Kubernetes without a custom operator"]
- AUDIENCE: [Who will read this? Example: "Platform engineers running Kubernetes clusters with GPU nodes" or "Python developers building LLM-powered applications"]
- KEY_TAKEAWAY: [What is the single most important thing the reader should learn or do after reading the full post? Example: "How to configure llm-d's scheduler to replace their current GPU scheduling workaround"]
- TONE_REFERENCE: [Optional. Link or name of a blog post whose tone you want to match. Example: "Kubernetes project blog" or "Cloudflare engineering blog"]

STEP-BY-STEP REASONING INSTRUCTIONS:

Before writing, think through each of these steps. Show your reasoning in a <thinking> block, then produce the final intro.

Step 1 - Identify the pain point:
  What specific, concrete problem does the target audience face today?
  Do not use an abstract or philosophical opening. Start with something the reader
  has personally experienced. Think about what makes this problem frustrating,
  costly, or time-consuming in practice.

Step 2 - Establish stakes:
  Why does this problem matter right now? What happens if the reader ignores it?
  Consider scale, reliability, cost, developer experience, or security.
  Pick the angle that will resonate most with your stated audience.

Step 3 - Bridge to the solution:
  What does this post offer that addresses the pain point?
  Be specific about the scope. Will the post show an architecture, walk through
  a configuration, compare approaches, or demonstrate a workflow?
  Do not promise more than the post delivers.

Step 4 - Give a reason to keep reading:
  End the intro with a concrete reason to continue. This could be a specific
  outcome ("by the end, you will have a working configuration that..."), a
  surprising fact, or a direct statement of what the reader will learn.

Step 5 - Self-critique checklist:
  Before producing your final output, review your draft against every item below.
  If any check fails, revise before outputting.

  [ ] Does the first sentence describe a real, specific problem (not a vague trend)?
  [ ] Would a reader in the target audience nod and say "yes, I have hit that"?
  [ ] Is the scope of the post clearly stated (not oversold, not undersold)?
  [ ] Is the tone practical, direct, and free of hype words?
  [ ] Is the intro between 4 and 7 sentences?
  [ ] Does every sentence earn its place, or can any be cut without losing meaning?
  [ ] Does the final sentence give the reader a clear reason to keep going?
  [ ] Are there zero em dashes? Use commas, periods, semicolons, or "and" instead.
  [ ] Is the intro free of marketing language, buzzwords, and unsupported claims?
  [ ] Does the intro avoid starting with "In today's world" or any similar cliche?

ANTI-PATTERNS TO AVOID:

1. Hype openings: Do not start with "In the rapidly evolving world of..." or
   "AI is transforming..." or any variation. These are filler.
2. Dictionary definitions: Never open with "X is defined as..." The audience
   already knows what the topic is.
3. Question leads without substance: "Have you ever wondered...?" is weak.
   If you use a question, make it specific and technical.
4. Burying the point: The reader should know what the post is about within
   the first two sentences. Do not build up slowly.
5. Overpromising: Do not claim the post will "revolutionize" or "transform"
   anything. State what it covers and let the reader decide.
6. Passive voice overuse: Prefer active, direct sentences. "We will walk
   through X" is better than "X will be explored."
7. Jargon without context: If you use a term the audience might not know,
   briefly explain it. If the audience would know it, skip the explanation.
8. Empty transitions: Avoid "Let's dive in" or "Without further ado."
   End on substance, not ceremony.

EDGE CASE HANDLING:

- If the TOPIC is broad (e.g., "Kubernetes"), ask the user to narrow it before
  writing. A good intro needs a specific angle.
- If the AUDIENCE is "everyone" or "general," default to "software engineers
  with 2+ years of experience" and note this assumption.
- If no KEY_TAKEAWAY is provided, infer one from the topic but flag it in your
  response so the user can confirm or adjust.
- If the topic is controversial or has competing approaches, acknowledge the
  landscape briefly in the intro without taking a side unless the post is
  explicitly an opinion piece.
- If the topic is an announcement (new release, new feature), lead with the
  problem the feature solves, not the feature itself.
- If any placeholder is left unfilled (e.g., TOPIC still reads "[Describe the specific technical topic...]"), stop and ask the user to fill it in. An intro written for a vague topic will be vague itself.
- If the target blog platform has a strict word limit (e.g., dev.to excerpt limit of 150 characters), adjust the intro length and note the constraint.
- If the topic is outside the technology domain (e.g., organizational change, hiring practices, career advice), adjust the pain-point framing from a technical problem to a professional challenge while keeping the same structure.
- If the user is targeting a model with a small context window (under 8k tokens), skip the thinking block and produce only the final introduction with the self-critique results.

OUTPUT FORMAT:

Provide your response in this structure:

<thinking>
[Your step-by-step reasoning through Steps 1-4. This is where you work
through the pain point, stakes, bridge, and hook before writing.]
</thinking>

**Draft Introduction:**

[Your 4-7 sentence introduction here. Plain paragraph, no bullet points,
no headers. Just clean prose.]

**Self-Critique Results:**

[Run through the checklist from Step 5. Mark each item pass/fail.
If any failed, show your revision below.]

**Final Introduction:**

[The polished version after self-critique. If all checks passed on the
first draft, this can be identical to the draft.]

**Assumptions and Notes:**

[Any assumptions you made about topic, audience, or scope. Flag anything
the user should verify before using the intro.]
```

## Why This Works

This prompt combines several deliberate prompt engineering techniques, each pulling its weight:

- **Persona framing.** Assigning the model the role of "senior technical writer at a major infrastructure company" anchors its output in a specific voice and standard. Without a persona, the model defaults to a generic, middle-of-the-road style that reads like no one in particular wrote it.

- **Chain-of-thought reasoning.** The step-by-step instructions (identify the pain point, establish stakes, bridge to solution, give a reason to keep reading) force the model to think through the intro's structure before writing. This prevents the common failure mode where the model produces a grammatically correct paragraph that has no narrative arc.

- **Self-critique loop.** The built-in checklist makes the model review its own draft against specific quality criteria before returning the output. This catches problems like cliche openings, missing scope statements, and hype language that would otherwise require you to prompt again or fix manually.

- **Anti-pattern avoidance.** Explicitly listing what NOT to do (hype openings, dictionary definitions, question leads, burying the point) is often more effective than describing what you want. The model has seen millions of bad intros in its training data; telling it which patterns to avoid steers it away from the most common failure modes.

- **Structured output format.** Requiring the response in a specific format (thinking block, draft, self-critique, final version, assumptions) means you get both the finished product and the reasoning behind it. If the intro misses the mark, you can see exactly where the reasoning went wrong and correct the inputs rather than starting over.

- **Edge case handling.** Covering what to do when the topic is too broad, the audience is vague, or the takeaway is missing prevents the model from silently producing weak output. Instead, it flags the issue and asks for clarification or states its assumptions, which saves you a round of iteration.

The visible difference from the comparison above comes down to this: the naive prompt gives the model no constraints, so it falls back on the most common blog intro patterns in its training data, which are mostly mediocre. This prompt replaces that default behavior with a specific, multi-step process that mirrors how experienced writers actually think through an introduction.

## Usage Tips

- Be specific with your TOPIC input. "Deploying LLMs on Kubernetes with llm-d" works far better than "AI stuff" or even "AI on Kubernetes." The more precise your topic, the sharper the intro.
- Match AUDIENCE to who will actually read the post. A post for SREs needs a different hook than one for data scientists. Think about what problems keep your audience up at night.
- If you have a working title for the blog, include it alongside the TOPIC. This gives the model better alignment on scope and tone.
- Run the prompt 2-3 times with the same inputs and compare the outputs. Pick the strongest opening, then edit it by hand. First drafts from any source benefit from human editing.
- Include the KEY_TAKEAWAY even if it feels obvious. It anchors the intro to the post's actual content and prevents the opening from drifting into generalities.
- If the intro feels generic on the first run, add more detail to your TOPIC. Swap "monitoring microservices" for "using OpenTelemetry to trace latency spikes across 50+ microservices in a production cluster."
- Review the self-critique checklist output carefully. If the model flags a failure and revises, compare both versions. Sometimes the original is actually stronger.
- For multi-part blog series, mention in the TOPIC that this is part of a series and which part. The intro should orient returning readers without alienating new ones.
- **Slash command connection:** If you use `claude-commands`, the `/blog-from-pr` slash command can generate a full blog post from a PR, and this prompt can refine the intro that command produces.

## Example Output

Below is a realistic example of what this prompt produces when given the topic "How llm-d schedules GPU inference workloads on Kubernetes without a custom operator," targeting platform engineers.

> **Draft Introduction:**
>
> Every team that runs inference workloads on Kubernetes hits the same wall: the default scheduler does not understand GPUs, and the workarounds (custom operators, resource hacks, manual node pinning) create fragile systems that break when you scale. The cost is not just engineering time. It is wasted GPU capacity, failed deployments, and on-call pages at 2 AM because a pod landed on a node without the right accelerator. llm-d takes a different approach by handling inference scheduling natively within the Kubernetes scheduling framework, without requiring a sidecar or a separate control plane. This post walks through the architecture, shows a working configuration on a multi-node GPU cluster, and explains the tradeoffs compared to alternatives like KubeRay and custom device plugins. If you have been patching around GPU scheduling limitations and want a cleaner path, this is where to start.
>
> **Self-Critique Results:**
>
> - [PASS] First sentence describes a specific, real problem.
> - [PASS] Target audience (platform engineers) would recognize the scenario.
> - [PASS] Scope is clearly stated: architecture, config, and tradeoff comparison.
> - [PASS] Tone is practical and direct.
> - [PASS] Intro is 5 sentences.
> - [PASS] Every sentence carries weight.
> - [PASS] Final sentence gives a reason to keep reading.
> - [PASS] No em dashes used.
> - [PASS] No marketing language or hype.
> - [PASS] No cliche opening.
>
> **Final Introduction:**
>
> Every team that runs inference workloads on Kubernetes hits the same wall: the default scheduler does not understand GPUs, and the workarounds (custom operators, resource hacks, manual node pinning) create fragile systems that break when you scale. The cost is not just engineering time. It is wasted GPU capacity, failed deployments, and on-call pages at 2 AM because a pod landed on a node without the right accelerator. llm-d takes a different approach by handling inference scheduling natively within the Kubernetes scheduling framework, without requiring a sidecar or a separate control plane. This post walks through the architecture, shows a working configuration on a multi-node GPU cluster, and explains the tradeoffs compared to alternatives like KubeRay and custom device plugins. If you have been patching around GPU scheduling limitations and want a cleaner path, this is where to start.
>
> **Assumptions and Notes:**
>
> - Assumed the post covers a single-cluster setup. If multi-cluster scheduling is in scope, the intro should mention it.
> - Assumed the reader has working knowledge of Kubernetes scheduling concepts (pods, nodes, resource requests). If the audience is broader, the intro may need a brief framing sentence.
> - The comparison to KubeRay and device plugins is assumed based on the topic. Confirm these are the alternatives discussed in the post.
