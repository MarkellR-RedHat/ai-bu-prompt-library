# Newsletter Blurb Writer

Generate a tight, high-signal newsletter blurb (2-4 sentences) that earns the click by leading with substance, not hype.

**Difficulty:** Intermediate

## Naive vs. Engineered

**Naive prompt:**
> "Write a short summary of this blog post for our newsletter."

**What you get:** "Check out this great post about GPU scheduling on Kubernetes! We are excited to share some new insights on how to optimize your inference workloads. Read more to learn about the latest developments in this space." Three sentences, no metric, no tool name, no reason to click. It could describe any blog post about any infrastructure topic.

**This prompt produces:** A 2-4 sentence blurb that opens with a concrete insight (GPU scheduling on Kubernetes wastes 30-50% of cluster capacity because the default scheduler ignores KV-cache state), names llm-d and its cache-aware routing on OpenShift, includes a specific metric (p99 latency cut by 35%), and gives the reader a clear reason to click through. The output also includes the key detail the blurb anchored on and an audience fit note so you can quickly validate whether the angle landed.

**The difference:** One fills space in the newsletter. The other earns the click.

---

## When to use

- Writing a blurb for an internal engineering newsletter, external community digest, or cross-org roundup
- Summarizing a blog post, conference talk, release announcement, or case study for a newsletter audience
- You need a punchy summary that fits a constrained newsletter layout (under 80 words)
- Promoting a team's work, an upstream contribution, or an open source milestone to a broader audience
- Drafting multiple blurbs for a curated newsletter and you need consistent quality and tone across entries
- Condensing a long-form piece into a teaser that respects the reader's time
- Adapting a single piece of content for different audience segments (engineering, executive, community)

## When NOT to use

- Writing the full article or blog post (use `blog-outline` and `blog-intro` instead)
- The content needs a detailed technical summary with depth and nuance (use `paper-summary` instead)
- You need a social media post; newsletters and social have different cadence and character constraints
- The content is confidential or embargoed and should not be summarized externally

## Prompt

```
You are a senior technical editor at a large open source engineering organization.
Your job is to write newsletter blurbs that are specific, credible, and worth
reading. You value the reader's time above everything else.

== INPUTS ==

Content title: [CONTENT_TITLE]
Content link: [CONTENT_LINK]
Brief description of what the content covers: [BRIEF_DESCRIPTION]
Target newsletter audience: [AUDIENCE, e.g., platform engineering org, open source community, AI/ML practitioners, executive leadership]
Desired tone: [TONE, e.g., technical-conversational, executive-brief, community-friendly]
Word limit: [WORD_LIMIT, default 60]
Any additional context or angle to emphasize: [OPTIONAL_CONTEXT]

== STEP-BY-STEP REASONING ==

Before writing, work through these steps internally:

1. Identify the single most important takeaway from the content. What would
   make an engineer stop scrolling? Write it down in one sentence.

2. Find one concrete, specific detail that makes the takeaway credible. This
   should be a number, a tool name, a benchmark result, a before-and-after
   comparison, or a named technology. Vague claims do not count.

3. Determine the reader's motivation. Why should someone in this audience care
   enough to click? What will they learn, be able to do, or understand
   differently after reading?

4. Consider the tone. Match the register to the audience. An engineering
   audience wants precision. An executive audience wants outcomes. A community
   audience wants relevance and accessibility.

5. Draft the blurb:
   - Sentence 1: State the core insight or result. Lead with the "so what,"
     not the "what." Make the reader curious.
   - Sentence 2: Add the specific, credible detail you identified in step 2.
     This is what separates a good blurb from a generic one.
   - Sentence 3 (optional): Give the reader a concrete reason to click through.
     What will they learn or be able to do? Frame it as a benefit, not a
     description.

6. Run the self-critique checklist (see below) and revise before outputting.

== OUTPUT FORMAT ==

Return your output in this structure:

**Blurb:**
> [Your 2-4 sentence blurb here, under the specified word limit]

**Word count:** [number]

**Key detail used:** [The specific number, name, or outcome you anchored on]

**Audience fit note:** [One sentence on why this framing works for the
specified audience]

== SELF-CRITIQUE CHECKLIST ==

Before finalizing, verify each of these. If any check fails, revise the blurb:

- [ ] Does the first sentence state a result or insight, not just a topic?
- [ ] Is there at least one specific, concrete detail (number, tool, outcome)?
- [ ] Is the blurb under the word limit?
- [ ] Would a busy engineer actually want to click through after reading this?
- [ ] Is the tone consistent with the target audience?
- [ ] Are there zero buzzwords, zero filler phrases, and zero hype language?
- [ ] Does every sentence add new information (no redundancy)?
- [ ] Is the blurb self-contained enough to make sense without prior context?

== ANTI-PATTERNS TO AVOID ==

1. Do NOT open with "Excited to share," "We are thrilled," "Check out," or
   any throat-clearing. Start with the substance.
2. Do NOT use vague language like "innovative," "cutting-edge," "next-gen,"
   "game-changing," or "groundbreaking." Say what it actually does.
3. Do NOT just restate the title. The blurb must add value beyond the headline.
4. Do NOT use em dashes anywhere. Use commas, periods, semicolons, colons,
   or the word "and" instead.
5. Do NOT include more than one call to action. One "read more" or "check it
   out" is fine. Two is clutter.
6. Do NOT write a blurb that could apply to any content by swapping one noun.
   It must be specific to this piece.
7. Do NOT front-load the blurb with the author's name or team name. Lead with
   the insight, not the attribution.

== EDGE CASE HANDLING ==

- If the content is a release announcement with no single "insight," lead with
  the most impactful change and mention the release version.
- If the content is a talk or video, mention the format so the reader knows
  what to expect (e.g., "In this 20-minute talk..." or "This walkthrough
  demonstrates...").
- If multiple audiences are specified, write one blurb per audience and label
  each clearly.
- If the content is primarily visual (demo, diagram, architecture overview),
  call out what the reader will see, not just what they will read.
- If no word limit is specified, default to 60 words.
- If the content is behind a login or paywall, note that in the audience fit
  section so the newsletter editor can add appropriate access instructions.
- If a placeholder is left unfilled (e.g., [TITLE] still reads "[TITLE]"), stop and ask the user to provide it. A blurb with no title or link is not publishable.
- If the content is in a language other than English, write the blurb in English but note the source language so the editor can add a translation note.
- If the topic is outside the technology domain (company news, hiring announcement, event recap), adjust the "so what" framing from technical value to professional relevance.
```

## Why This Works

Newsletter blurbs are deceptively hard to write well because the format is so short that every word choice matters. This prompt uses several techniques calibrated for that constraint:

- **Persona with editorial values.** The model is cast as a senior technical editor who "values the reader's time above everything else." This single constraint shapes every sentence the model writes, biasing it toward density and signal over padding and pleasantries.

- **Chain-of-thought compressed to four steps.** For a 60-word output, a 10-step reasoning process would be overkill. The four steps (identify takeaway, find a concrete detail, determine reader motivation, match tone) focus the model's reasoning on the four decisions that actually determine blurb quality. Each step is small enough to execute well but specific enough to prevent shortcuts.

- **"So what" as the opening principle.** Step 5 instructs the model to lead with the "so what," not the "what." This single instruction corrects the most common blurb failure, which is restating the article title as a sentence and calling it a summary.

- **Self-critique checklist tuned for brevity.** The eight checklist items are chosen for short-form writing specifically. "Does every sentence add new information?" catches redundancy that is tolerable in a blog post but fatal in a 60-word blurb. "Would a busy engineer want to click through?" is the ultimate test for newsletter content.

- **Anti-pattern catalog for newsletter-specific sins.** "Do NOT open with 'Excited to share'" and "Do NOT just restate the title" target the two patterns responsible for most weak newsletter blurbs. These are so common that without explicit avoidance instructions, the model defaults to them.

- **Structured output with diagnostic fields.** The "Key detail used" and "Audience fit note" fields serve a practical purpose: they let you assess blurb quality in seconds without re-reading the source content. If the key detail is vague or the audience fit note feels off, you know to regenerate before publishing.

The comparison above comes down to information density. A naive prompt produces output at the density the model defaults to, which is low for short-form content. This prompt raises the density floor by requiring specific details, banning filler, and making the model justify its framing choices before writing.

## Usage Tips

- Paste the actual title and link so the blurb matches the content precisely. The AI will anchor on the title if you leave the description vague, so be specific about what makes this piece worth featuring.
- If your newsletter has a strict character or word limit, set that in the `[WORD_LIMIT]` field. The self-critique checklist will enforce it.
- Run the prompt twice with different tones (e.g., "technical-conversational" and "executive-brief") to get two versions you can choose between or combine.
- When writing blurbs for a curated newsletter with multiple entries, run the prompt once per entry but keep the audience and tone fields consistent. This gives you a uniform voice across the whole issue.
- **Slash command connection:** If you use `ai-bu-claude-commands`, the `/draft-announcement` slash command generates multi-channel announcements, and this prompt can produce the newsletter-specific version from the same source material.
- Use the "Key detail used" and "Audience fit note" fields in the output to quickly validate whether the blurb hit the right angle. If the key detail is weak, your source content may need a stronger hook.
- For community-facing newsletters, set the tone to "community-friendly" and mention the open source project name in the description. This helps the AI frame the blurb around contribution and adoption, not just internal impact.
- If the blurb still feels generic after one pass, add a line to `[OPTIONAL_CONTEXT]` like "Emphasize the performance improvement" or "Focus on the developer experience angle." Constraints produce better output.

## Example Output

**Blurb:**
> GPU scheduling on Kubernetes wastes 30-50% of cluster capacity because the default scheduler ignores model memory footprint and KV-cache state. This post walks through how llm-d fixes that with cache-aware routing on OpenShift, cutting p99 latency by 35% in production benchmarks. Worth a read if you run inference workloads at scale and want to stop paying for idle GPUs.

**Word count:** 55

**Key detail used:** 35% p99 latency reduction, 30-50% wasted capacity

**Audience fit note:** This framing leads with the cost and performance problem, which resonates with platform engineers who own GPU infrastructure budgets and SLOs.
