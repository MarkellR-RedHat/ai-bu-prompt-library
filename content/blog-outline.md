# Blog Outline Generator

Generate a structured, publication-ready outline for a technical blog post with logical narrative flow, clear section purposes, and built-in quality checks.

**Difficulty:** Intermediate

## Naive vs. Engineered

**Naive prompt:**
> "Create an outline for a blog post about deploying LLMs on Kubernetes."

**What you get:** "1. Introduction. 2. Background on LLMs and Kubernetes. 3. Implementation Details. 4. Results. 5. Conclusion and Future Work." Five headings, no key points, no audience definition, no supporting material callouts. You stare at it, realize you still need to figure out what each section actually says, and do the structural thinking yourself anyway.

**This prompt produces:** A complete, publication-ready outline with specific section headings like "Why Default GPU Scheduling Wastes Cluster Resources" and "How llm-d Rethinks Inference Scheduling," a stated audience (platform engineers running GPU clusters on OpenShift), key points and supporting material callouts for every section (architecture diagrams for disaggregated prefill/decode, YAML for KV-cache-aware routing configuration), transition sentences linking each section to the next, and word count estimates that keep the post on target. The output follows a deliberate narrative arc chosen to match your post's goal.

**The difference:** One gives you a skeleton you still need to design. The other gives you a blueprint an author can start writing from immediately.

---

## When to use

- You are starting a new blog post from scratch and need a solid skeleton before you write a single paragraph.
- You have scattered notes, bullet points, or raw ideas and need to organize them into a coherent narrative arc.
- You are planning a multi-part blog series and want to map out what each post covers without overlap or gaps.
- You need to align a post with a specific audience (engineers, decision-makers, community contributors) and want the outline to reflect that from the start.
- You are writing a tutorial or walkthrough and need to sequence prerequisites, steps, and validation checkpoints in the right order.
- You want to identify where code examples, diagrams, architecture visuals, or CLI output should appear before you start drafting.
- You are collaborating with other authors and need a shared structural contract for the post before anyone starts writing sections.

## When NOT to use

- You already have a clear outline and just need to write the content. Jump straight into drafting instead.
- The post is a quick update or announcement (under 500 words) that does not need detailed structure. Use the team-announcement prompt instead.
- You are writing opinion or editorial content where a rigid outline would constrain the natural flow of the argument. Start with a thesis statement and free-write instead.
- The content is a changelog, release note, or structured reference document. Those have fixed formats that do not benefit from outline generation.

## Prompt

```
You are a senior technical editor at a major enterprise software company. You specialize
in structuring blog posts that are clear, scannable, and useful to working engineers.
Your job is to produce a detailed outline, not to write the post itself.

INPUTS (fill in all bracketed fields before submitting):

- Topic: [TOPIC, e.g., "Running distributed inference with llm-d on OpenShift"]
- Target audience: [AUDIENCE, e.g., platform engineers, Kubernetes operators, ML engineers]
- Post length: [SHORT (800-1000 words) / MEDIUM (1200-1800 words) / LONG (2000-3000 words)]
- Goal of the post: [GOAL, e.g., teach a concept, walk through a tutorial, compare approaches]
- Key takeaway: [ONE SENTENCE the reader should remember after finishing the post]
- Constraints: [Any style guide rules, tone requirements, or topics to avoid. Default: direct
  and practical engineering voice, no marketing language, no em dashes.]

STEP-BY-STEP REASONING INSTRUCTIONS:

Follow these steps in order. Think through each one carefully before moving to the next.

Step 1: Audience analysis
- Who specifically will read this? What do they already know? What do they not know yet?
- What problem or question brought them to this post?
- What level of jargon is appropriate?
- Write 2-3 sentences summarizing your audience assumptions. Include these in the outline
  under an "Audience Assumptions" header so the author can verify them.

Step 2: Narrative arc
- Identify the core tension or knowledge gap the post resolves.
- Decide on the structural pattern that fits best:
  - Problem, Solution, Implementation, Results (for tutorials and walkthroughs)
  - Context, Comparison, Recommendation (for comparison posts)
  - Concept, Deep Dive, Practical Application (for explainer posts)
  - Story, Technical Detail, Lessons Learned (for case studies)
- Write one sentence explaining why you chose that pattern.

Step 3: Section breakdown
- Based on the chosen post length, determine the number of sections:
  - SHORT: 3-4 sections
  - MEDIUM: 5-6 sections
  - LONG: 6-8 sections
- For each section, provide:
  a. A specific, descriptive heading (H2 or H3 as appropriate). Avoid generic headings
     like "Introduction" or "Background." Use headings that tell the reader what they
     will learn, e.g., "Why Default GPU Scheduling Wastes Cluster Resources."
  b. One sentence describing the purpose of this section and what it accomplishes in
     the overall narrative.
  c. 3-5 bullet points listing the key details, arguments, or data to include.
  d. A note on any supporting material needed: code snippets, CLI output, diagrams,
     tables, screenshots, or architecture visuals. If none are needed, say "None."
  e. The estimated word count for this section.

Step 4: Transition mapping
- For each pair of adjacent sections, write one sentence describing how the reader
  moves from one to the next. Good transitions prevent the post from reading like a
  list of disconnected topics.

Step 5: Call-to-action and next steps
- Define a concrete, actionable next step for the reader at the end of the post.
  This should not be vague ("learn more"). It should be specific ("clone this repo
  and run the quickstart in under 10 minutes" or "open an issue if your use case
  is not covered").

OUTPUT FORMAT:

Return the outline using this exact structure:

## Outline: [Post Title]

### Audience Assumptions
[2-3 sentences from Step 1]

### Structural Pattern
[Pattern name and one-sentence justification from Step 2]

### Sections

#### 1. [Heading]
**Purpose:** [one sentence]
**Key points:**
- [point]
- [point]
- [point]
**Supporting material:** [what is needed or "None"]
**Estimated word count:** [number]
**Transition to next section:** [one sentence]

[Repeat for each section]

### Call to Action
[Specific next step from Step 5]

### Estimated Total Word Count
[Sum of section estimates]

SELF-CRITIQUE CHECKLIST (run through all of these before giving your final output):

1. Does every section heading tell the reader what they will learn? Replace any
   generic headings like "Introduction" or "Conclusion."
2. Are there any sections that repeat information already covered in an earlier
   section? Merge or cut them.
3. Does the outline build logically so that each section depends on what came before
   it? A reader should never need to skip ahead to understand the current section.
4. Is the estimated word count realistic for each section? A section with 5 key
   points probably needs 300-500 words, not 100.
5. Are code examples, diagrams, and CLI output called out in the right places?
   Tutorials should have at least 2-3 code blocks. Explainers should have at least
   one diagram or visual.
6. Does the call to action give the reader something specific to do, not just
   something to "think about"?
7. Is the tone direct and practical throughout? Remove any hype, buzzwords, or
   inflated language.
8. Does the outline avoid em dashes? Use commas, periods, semicolons, colons,
   or "and" instead.

ANTI-PATTERNS TO AVOID:

1. The "wall of text" outline: Do not create sections with 8+ bullet points each.
   If a section has too many points, split it into two sections.
2. The "buried lede" outline: Do not put the most important insight in section 4
   of 5. Lead with the core value proposition or key insight early.
3. The "no code" tutorial: If the post is a tutorial or walkthrough, every
   implementation section must include at least one code example, CLI command,
   or configuration snippet callout.
4. The "vague heading" trap: Never use headings like "Overview," "Details," or
   "More Information." Every heading should be specific enough that a reader
   scanning the table of contents knows exactly what that section contains.
5. The "missing audience" outline: Do not skip the audience assumptions section.
   If the outline does not state who it is for and what they already know, the
   author will make inconsistent assumptions across sections.
6. The "infinite scroll" outline: Do not exceed the section count guidance for
   the chosen post length. More sections does not mean a better post. It usually
   means a less focused one.
7. The "no exit" ending: Do not end with a summary that just restates the
   introduction. End with a specific action the reader can take right now.

EDGE CASE HANDLING:

- If the topic is too broad for the chosen post length, say so explicitly and
  suggest how to narrow it. For example: "This topic covers both architecture
  and deployment. Consider splitting into two posts: one on design decisions
  and one on the deployment walkthrough."
- If the audience field is vague (e.g., "developers"), ask for clarification
  before generating the outline. State what assumptions you would make if no
  clarification is given.
- If the goal is "general awareness" or similarly vague, default to the
  Concept, Deep Dive, Practical Application pattern and note that you did so.
- If the topic is a product announcement, adjust the pattern to:
  What changed, Why it matters, How to try it, What is next.
- If no constraints are provided, default to: direct engineering voice, no
  marketing language, no em dashes, and flag this default in your output.
- If any placeholder is left unfilled, stop and list the unfilled fields before generating. An outline built on assumed inputs produces assumed structure.
- If the topic is outside the technology domain (organizational change, hiring, process improvement), adjust the narrative arc options to match the content type rather than forcing a technical tutorial structure.
- If the user is running this on a model with a small context window (under 16k tokens), recommend the SHORT post format and skip the transition mapping step to stay within limits.
```

## Why This Works

This prompt layers multiple prompt engineering techniques to produce outlines that are structurally sound, not just topically relevant:

- **Persona framing.** Casting the model as "a senior technical editor" shifts its output from generic content generation to editorial thinking. Editors think about structure, flow, and audience fit, which is exactly what an outline requires.

- **Chain-of-thought with staged reasoning.** The five-step process (audience analysis, narrative arc selection, section breakdown, transition mapping, call-to-action) forces the model to make structural decisions in the right order. Audience assumptions inform the arc. The arc determines the sections. Sections determine transitions. Without this sequencing, the model tends to generate sections in isolation, producing outlines that read like topic lists rather than connected narratives.

- **Constrained output format.** Requiring a specific format for each section (heading, purpose, key points, supporting material, word count, transition) prevents the model from producing shallow, heading-only outlines. Each constraint forces a concrete decision that makes the outline more useful to the eventual author.

- **Self-critique checklist.** The eight-item review catches the most common outline failures: generic headings, missing code examples in tutorials, unrealistic word counts, and vague calls to action. Running this check before output means you get a cleaner first draft.

- **Anti-pattern catalog.** Naming specific failure modes ("the wall of text outline," "the buried lede outline," "the vague heading trap") gives the model concrete examples of what to avoid. This is more effective than general instructions like "make it good" because it targets the exact patterns that make outlines unusable.

- **Edge case handling.** Covering overly broad topics, vague audiences, and product announcements prevents the model from guessing silently. Instead, it either adapts its approach or flags the issue, which saves you from discovering the problem after the outline is written.

The core insight behind the comparison above: a naive prompt asks the model to produce an outline, but it provides no criteria for what makes an outline good. This prompt encodes those criteria directly, from section granularity to transition logic, so the model's output reflects editorial judgment rather than surface-level topic listing.

## Usage Tips

- **Fill in every bracketed field.** Leaving fields as defaults (especially audience and goal) produces generic outlines. The more specific your inputs, the more useful the output.
- **Set the post length before anything else.** A SHORT post should have 3-4 sections. A LONG post can handle 6-8. If you skip this, the model will guess and may over-scope or under-scope your post.
- **Use the "Key takeaway" field to stay focused.** If you cannot state the takeaway in one sentence, your topic may be too broad. Split it into multiple posts.
- **For tutorial posts**, set the goal to something specific: "Walk the reader through deploying X on Y from a fresh cluster" is better than "explain X."
- **For comparison posts**, add a constraint asking the outline to include a summary comparison table. The model will place it in the right section.
- **Check the audience assumptions section first.** If the model's assumptions about your reader do not match your intent, correct them and regenerate. A misaligned audience assumption will throw off the entire outline.
- **Feed sections to a drafting prompt one at a time.** Once you have the outline, use each section's heading, purpose, and key points as the input for a separate drafting prompt. This keeps each section focused and prevents drift.
- **Use the transition sentences as a revision tool.** If a transition feels forced or awkward, the two sections it connects may be in the wrong order or may not belong next to each other.
- **Run the self-critique checklist yourself too.** The model checks its own work, but a human pass catches things the model misses, especially around audience tone and organizational priorities.
- **Slash command connection:** If you use `claude-commands`, the `/blog-from-pr` slash command generates a full blog post from a PR, and this outline prompt can structure the content before drafting.

## Example Output

> ## Outline: Running Distributed Inference with llm-d on OpenShift
>
> ### Audience Assumptions
> The primary readers are platform engineers and Kubernetes operators who manage GPU-equipped clusters on OpenShift. They understand Kubernetes scheduling, resource requests, and node management, but they may not be familiar with inference-specific concepts like KV-cache routing or disaggregated serving. They are evaluating llm-d as a solution for improving GPU utilization in production inference workloads.
>
> ### Structural Pattern
> Problem, Solution, Implementation, Results. This is a tutorial-style post that needs to establish the pain point before walking through the fix, so readers understand both the "why" and the "how."
>
> ### Sections
>
> #### 1. Why Default GPU Scheduling Wastes Cluster Resources
> **Purpose:** Establish the problem so readers who manage GPU clusters recognize their own pain points.
> **Key points:**
> - GPU requests in Kubernetes are binary: a pod gets a GPU or it does not, with no partial allocation
> - The scheduler has no awareness of model size, VRAM requirements, or inference batch dynamics
> - Real-world impact: wasted GPU hours, pods stuck in Pending, and unpredictable tail latency
> - Brief data point: teams commonly report 30-50% GPU idle time under default scheduling
> **Supporting material:** One diagram showing a timeline of GPU allocation under default scheduling versus optimized scheduling.
> **Estimated word count:** 350
> **Transition to next section:** Now that the problem is clear, here is how llm-d addresses each of these gaps at the architecture level.
>
> #### 2. How llm-d Rethinks Inference Scheduling
> **Purpose:** Explain the core architectural decisions that make llm-d different from default Kubernetes scheduling.
> **Key points:**
> - Disaggregated serving: separating prefill and decode phases so each can be scheduled independently
> - KV-cache-aware routing: the scheduler knows which nodes hold cached context and routes requests accordingly
> - Integration with the Kubernetes scheduler through a custom scheduling plugin, not a replacement
> - Design goal: maximize GPU utilization without requiring application-level changes
> **Supporting material:** Architecture diagram showing the llm-d components and their relationship to the Kubernetes control plane.
> **Estimated word count:** 400
> **Transition to next section:** With the architecture covered, let us set it up on an actual cluster.
>
> #### 3. Prerequisites and Cluster Setup
> **Purpose:** List everything the reader needs before they start the deployment, so they do not hit blockers mid-walkthrough.
> **Key points:**
> - OpenShift version requirements (4.14+) and GPU Operator version
> - Node labeling strategy for GPU nodes
> - Required RBAC permissions for the llm-d operator
> - Storage considerations for model weights
> **Supporting material:** YAML snippet for node labels. CLI commands for verifying GPU Operator status.
> **Estimated word count:** 300
> **Transition to next section:** With the cluster ready, install the operator and deploy a model.
>
> #### 4. Deploying llm-d and Serving Your First Model
> **Purpose:** Step-by-step deployment walkthrough that the reader can follow on their own cluster.
> **Key points:**
> - Installing the llm-d operator via Helm chart or OLM
> - Creating an InferencePool custom resource for a sample model (e.g., Granite 3.3 8B)
> - Sending a test request and verifying the response
> - Checking logs and metrics to confirm the scheduler is routing as expected
> **Supporting material:** Three code blocks: Helm install command, InferencePool YAML, and a curl test request. One CLI output block showing expected log lines.
> **Estimated word count:** 500
> **Transition to next section:** The deployment works, but there are a few things that can go wrong in production.
>
> #### 5. Common Pitfalls and How to Avoid Them
> **Purpose:** Save the reader debugging time by covering the mistakes that teams hit most often.
> **Key points:**
> - Node affinity misconfigurations that silently prevent scheduling on GPU nodes
> - Memory limits that conflict with KV-cache sizing, causing OOMKilled pods
> - Forgetting to set up monitoring: recommended Prometheus metrics and Grafana dashboards
> - Model weight storage permissions that block the serving container at startup
> **Supporting material:** Table listing each pitfall, its symptom, and the fix.
> **Estimated word count:** 350
> **Transition to next section:** With the deployment stable, here is where to go next.
>
> #### 6. Next Steps and Getting Involved
> **Purpose:** Give the reader a concrete action to take and connect them to the community.
> **Key points:**
> - Scale up: try multi-node inference with model parallelism across GPUs
> - Contribute: the project is open source; link to the repo and the "good first issue" label
> - Join the community: Slack channel, mailing list, and upcoming community calls
> **Supporting material:** None.
> **Estimated word count:** 200
>
> ### Call to Action
> Clone the llm-d repo, deploy the quickstart on a test cluster, and run the included benchmark script to see GPU utilization improvements on your own hardware. The quickstart takes under 15 minutes.
>
> ### Estimated Total Word Count
> 2,100 (fits within the LONG post range of 2,000-3,000 words)
