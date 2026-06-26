# Blog Post to Conference Talk

Transform an existing blog post into a polished conference talk proposal. This chain walks you through summarizing the core argument, extracting the points that matter most to a live audience, structuring a talk around them, and drafting a CFP submission that reviewers will actually read.

**Difficulty:** Intermediate

---

## Naive vs. Engineered

**What most people do:** Paste their blog post into a single prompt and ask "turn this into a conference talk proposal." The result looks like this:

> **Title:** Migrating from Monolith to Microservices: Lessons Learned
>
> **Abstract:** In this talk, we will explore the challenges and benefits of migrating from a monolithic architecture to microservices. We will cover key considerations, best practices, and lessons learned from real-world experience. Attendees will walk away with practical insights they can apply to their own migration journeys.
>
> **Outline:**
> 1. Introduction (5 min)
> 2. Background and Motivation (10 min)
> 3. Migration Approach (15 min)
> 4. Conclusion and Q&A (10 min)

The abstract is a topic description, not a talk description. "We will explore" and "practical insights" could be about any migration at any company. The outline is "intro, body, conclusion" with no narrative arc, and the proposal does not demonstrate why this talk would be good on stage rather than on a screen.

**Why that falls flat:** Blog posts and conference talks are fundamentally different media. A blog post can include dense code blocks, detailed comparisons, and nuanced caveats that readers absorb at their own pace. A talk has to hold attention in real time, build understanding progressively, and leave the audience with memorable takeaways. A single prompt cannot perform the translation between these formats because it tries to preserve everything from the blog post instead of making hard editorial choices about what to keep, cut, and transform.

**What this workflow produces instead:** Four focused steps that mirror what an experienced speaker actually does. First, extract the core argument and evidence from the blog post. Second, make ruthless editorial decisions about what works on stage and what does not. Third, design a talk structure with timing, transitions, and a narrative arc. Fourth, write the CFP submission grounded in all of that preparation.

The difference is obvious to CFP reviewers. Single-prompt proposals describe a topic. Workflow-built proposals describe a talk.

## When to Use

- You have a published blog post (or draft) and want to submit a talk based on it.
- You need to translate written, long-form content into a format that works on stage.
- You want a CFP submission that is tight, specific, and grounded in real content rather than vague promises.

## When NOT to Use

- You do not have a blog post or similar written artifact to start from. Use the idea-to-proposal chain instead.
- The blog post covers a topic you are not prepared to present on. A chain cannot fix a knowledge gap.
- You need a full slide deck. This chain produces a talk structure and CFP, not finished slides.

## Workflow Recipe

### What You Start With

- A published blog post (or solid draft) that you want to turn into a conference talk
- A target conference or CFP deadline in mind
- Knowledge of the talk slot length (25, 40, or 50 minutes)

### What You End With

- A complete, ready-to-submit CFP proposal with title, abstract, detailed description, and outline
- A structured talk design with timing, transitions, opening lines, and closing lines
- Clear editorial decisions about what to keep, cut, and transform from the blog post
- Speaker preparation notes for practicing and refining the talk

### The Steps

This workflow has four steps. Each one builds directly on the output of the previous step, so order matters.

1. **Summarize the blog post.** Compress the full post into a structured summary that captures the argument, evidence, and audience. This gives the model (and you) a clean, portable representation of the content to work from in later steps. *Output: core argument, supporting evidence, audience profile, key takeaways, and gaps.*

2. **Extract key points for a live audience.** Blog posts and talks have different strengths. Readers can re-read a paragraph; an audience cannot. This step identifies which points will land in a talk setting and flags what needs to be cut or restructured. *Output: keep/cut/transform lists with specific reasoning, audience hook, and missing elements.*

3. **Build talk structure.** Arrange the surviving points into a talk arc with timing estimates. This is where the content becomes a presentation rather than an article. *Output: title options, narrative arc, section breakdown with timing, opening and closing lines, and a backup plan.*

4. **Generate CFP submission.** Write the actual proposal text, abstract, and speaker notes using everything produced so far. *Output: a complete, polished CFP submission ready to paste into a submission form.*

Running the steps in order means each prompt has the right context. Skipping the extraction step, for example, tends to produce talks that read like someone narrating their blog post, which is a common and painful failure mode.

---

## Step 1: Summarize the Blog Post

```
You are a technical content analyst. Your job is to produce a structured summary
of a blog post that will be used as input for later steps in a content
transformation pipeline. Accuracy and completeness matter more than style.

Here is the blog post to summarize:

<blog_post>
[PASTE FULL BLOG POST HERE]
</blog_post>

Produce a structured summary with the following sections:

1. CORE ARGUMENT (2-3 sentences): What is the author's main claim or thesis?
   State it plainly. Do not editorialize.

2. SUPPORTING EVIDENCE (bulleted list): What specific examples, data points,
   benchmarks, code samples, or case studies does the post use? List each one
   with a one-line description.

3. TARGET AUDIENCE: Who is the intended reader? Be specific about role,
   experience level, and what they likely already know.

4. KEY TAKEAWAYS (3-5 bullets): What should the reader walk away knowing
   or believing that they did not before?

5. TECHNICAL DEPTH: Rate as one of: conceptual overview, practitioner guide,
   deep dive, or expert reference. Justify your rating in one sentence.

6. GAPS AND ASSUMPTIONS: What does the post assume the reader already knows?
   What counterarguments or limitations does it skip over?

OUTPUT FORMAT: Use the exact section headers above. Keep the total summary
under 500 words. Do not add sections beyond what is listed.

ANTI-PATTERNS TO AVOID:
- Do not rewrite the blog post in shorter form. Extract structure, not prose.
- Do not inject opinions about the topic. Report what the author wrote.
- Do not use marketing language or hype words like "revolutionary" or
  "game-changing." If the author used them, translate to plain language.
- Do not use em dashes. Use commas, semicolons, or separate sentences instead.
```

---

> **CHECKPOINT: Verify the summary before proceeding.** Does the core argument match what you actually want to talk about, or did the model latch onto a secondary point? Is the target audience description accurate for the conference you are targeting? Are there pieces of supporting evidence that the summary missed? If the summary does not represent your blog post accurately, correct it now. Every subsequent step builds on this summary. Once it is right, paste it into Step 2.

## Step 2: Extract Key Points for a Live Audience

```
You are a conference talk coach who helps speakers adapt written content for
the stage. You understand that talks and blog posts are different media with
different strengths, and you are practical about what works in front of a
live audience.

Here is a structured summary of a blog post that the speaker wants to turn
into a conference talk:

<blog_summary>
[PASTE OUTPUT FROM STEP 1 HERE]
</blog_summary>

Your task is to identify which points from this summary will work well in a
talk and which will not. Evaluate each point against these criteria:

- Can it be explained verbally in under 2 minutes without requiring the
  audience to read along?
- Does it have a concrete example, demo, or story attached to it?
- Will it hold attention, or is it the kind of detail that works better
  in writing?

Produce the following output:

1. KEEP (bulleted list): Points that translate well to a live talk. For each,
   note WHY it works on stage (e.g., "has a clear before/after demo,"
   "involves a relatable pain point").

2. CUT (bulleted list): Points that should be dropped or moved to a
   supplementary blog link. For each, note WHY it does not work on stage
   (e.g., "requires reading a code block line by line," "too much setup
   for a verbal explanation").

3. TRANSFORM (bulleted list): Points that could work on stage but need to
   be reshaped. For each, describe the specific transformation needed
   (e.g., "replace the benchmark table with a single comparison slide,"
   "turn the architecture diagram into a live drawing").

4. AUDIENCE HOOK: In 1-2 sentences, describe the single most compelling
   reason this audience would attend this talk. What pain or curiosity
   does it address?

5. MISSING ELEMENTS: What does a good talk on this topic need that the
   blog post did not provide? Think about: live demos, audience
   participation, war stories, or "lessons learned" framing.

OUTPUT FORMAT: Use the exact section headers above. Be direct and specific.
Avoid vague advice like "make it more engaging."

ANTI-PATTERNS TO AVOID:
- Do not say "this is great content!" Evaluate; do not compliment.
- Do not suggest adding humor or jokes. That is a speaker decision, not
  a content decision.
- Do not recommend specific slide tools or design choices.
- Do not use em dashes anywhere in your output.
```

---

> **CHECKPOINT: Make your editorial decisions before proceeding.** This is where you exercise judgment as the speaker. Review the keep, cut, and transform lists. Do you agree with the cuts? Some points that work poorly as verbal explanations might be essential to your argument; if so, move them back to "keep" and note that they need a strong visual or demo. Do you agree with the transformations? Override anything that does not feel right. You know your material and your audience better than the model does. Once you have finalized your editorial decisions, paste the outputs from Steps 1 and 2 into Step 3.

## Step 3: Build Talk Structure

```
You are a technical talk architect. You design talk structures that respect
the audience's time, build understanding progressively, and end with clear
takeaways. You favor practical, engineering-minded talks over inspirational
keynotes.

Here is the blog summary and the audience analysis from previous steps:

<blog_summary>
[PASTE OUTPUT FROM STEP 1 HERE]
</blog_summary>

<audience_analysis>
[PASTE OUTPUT FROM STEP 2 HERE]
</audience_analysis>

Design a talk structure for a [25 / 40 / 50]-minute slot (adjust as needed).
Include the following:

1. TALK TITLE: Propose 2-3 title options. Good titles are specific, hint at
   the value the audience gets, and avoid buzzwords. Bad titles are vague
   or clickbait.

2. TALK ARC: Describe the narrative shape of the talk in 2-3 sentences.
   What question does it open with? What tension does it build? What
   resolution does it offer?

3. SECTION BREAKDOWN: List each section of the talk with:
   - Section name
   - Time allocation (in minutes)
   - Key point covered
   - Delivery method (slides, live demo, code walkthrough, audience poll,
     whiteboard, storytelling)
   - Transition sentence to the next section

4. OPENING (3-4 sentences): Write the actual opening lines the speaker
   could use. The opening should establish relevance to the audience within
   the first 30 seconds. Do not start with "Hi, my name is" or a joke.

5. CLOSING (3-4 sentences): Write the actual closing lines. The closing
   should restate the core takeaway and give the audience a specific
   next step.

6. BACKUP PLAN: If the talk runs long, which section can be shortened
   or cut without breaking the narrative? Explain why.

OUTPUT FORMAT: Use the exact section headers above. Be concrete, not abstract.
Every section should reference specific content from the summary and analysis.

ANTI-PATTERNS TO AVOID:
- Do not create a structure that is just "intro, body, conclusion." That is
  not a structure; it is a template.
- Do not allocate more than 3 minutes to introductions or speaker background.
- Do not suggest "Q&A" as the final section. If Q&A is included, it should
  not be the climax of the talk.
- Do not use em dashes. Use commas, semicolons, colons, or periods instead.
- Do not pad sections to fill time. If the content fits in 25 minutes,
  say so, even if the slot is 40.
```

---

> **CHECKPOINT: Test the talk structure before proceeding.** Read through the section breakdown and imagine delivering it. Does the timing feel realistic? (A common mistake is underestimating how long live demos take.) Does the narrative arc build tension and deliver resolution? Try reading the opening and closing lines out loud. If they feel stiff or unnatural, rewrite them in your own voice. Adjust the time slot in Step 3 if you realize 25 minutes is not enough or 50 minutes is too many. Once the structure feels deliverable, paste all previous outputs into Step 4.

## Step 4: Generate CFP Submission

```
You are a CFP reviewer turned ghostwriter. You have read hundreds of talk
proposals. You know what makes reviewers say yes: specificity, demonstrated
expertise, a clear audience benefit, and a structure that promises a
well-prepared talk. You also know what makes reviewers say no: vague
descriptions, topic-shopping, and proposals that describe a subject area
instead of a talk.

Here is the full context from previous steps:

<blog_summary>
[PASTE OUTPUT FROM STEP 1 HERE]
</blog_summary>

<audience_analysis>
[PASTE OUTPUT FROM STEP 2 HERE]
</audience_analysis>

<talk_structure>
[PASTE OUTPUT FROM STEP 3 HERE]
</talk_structure>

Produce a complete CFP submission with the following fields:

1. TITLE: Choose the strongest title from Step 3, or refine it. Keep it
   under 80 characters.

2. ABSTRACT (150-300 words): This is what appears in the conference program.
   Write it for attendees deciding which talk to attend. It should answer:
   - What will I learn?
   - Why does this matter right now?
   - What will the speaker actually show me?
   Do not write in first person unless the conference requires it.

3. DETAILED DESCRIPTION (300-500 words): This is for reviewers only. It
   should demonstrate:
   - The speaker knows this topic deeply (reference specific technical
     details or experiences).
   - The talk has been thought through (reference the structure and timing).
   - The audience will leave with actionable knowledge.

4. AUDIENCE LEVEL: One of: beginner, intermediate, advanced. Justify in
   one sentence.

5. PREREQUISITES: What should attendees know before walking in?

6. OUTLINE (bulleted): Section names and time allocations from Step 3,
   reformatted for a CFP submission form.

7. KEY TAKEAWAYS (3-5 bullets): What attendees will be able to do after
   this talk that they could not do before.

8. SPEAKER NOTES (for your own use): 3-5 bullets on what to prepare,
   practice, or research before delivering this talk.

OUTPUT FORMAT: Use the exact field names above as headers. The abstract and
description should be polished, ready-to-submit prose.

ANTI-PATTERNS TO AVOID:
- Do not write an abstract that is just a topic overview. "This talk covers
  Kubernetes" is not an abstract.
- Do not promise things the blog content cannot support. Stay grounded in
  the material.
- Do not use filler phrases like "In this talk, we will explore..." Get to
  the point.
- Do not use em dashes anywhere. Use commas, periods, semicolons, or colons.
- Do not use hype language: "cutting-edge," "next-generation,"
  "revolutionary." Describe what it does, not how exciting it is.
```

---

## Why This Works

Prompt chaining produces better CFP submissions than a single prompt for three specific reasons.

**Editorial decisions happen explicitly.** Step 2 forces you (and the model) to make specific keep/cut/transform decisions about every piece of content. In a single prompt, these decisions happen implicitly and badly: the model tries to include everything, which produces a talk outline that is really just a compressed blog post.

**The talk structure is designed, not generated.** Step 3 builds the talk arc from curated points rather than from the raw blog post. This means the structure serves the audience's experience rather than mirroring the blog's structure. Conference talks that follow the same outline as the blog post they are based on are almost always worse than talks designed for the stage.

**The CFP is grounded in preparation.** CFP reviewers can tell the difference between "I will talk about X" and "I have structured a talk about X with these specific sections, this timing, and this narrative arc." Step 4 writes the CFP submission with three steps of preparation behind it, which makes the proposal specific and credible rather than vague and aspirational.

## Tips for Running This Workflow

- **Copy the full output** of each step into the placeholder for the next step. Do not summarize or edit between steps unless you spot a factual error.
- **Adjust the time slot** in Step 3 before running it. A 25-minute talk and a 50-minute talk have very different structures.
- **Review Step 2 carefully.** This is where the most important editorial decisions happen. If the "CUT" list feels wrong, override it before moving to Step 3.
- **Run Step 4 twice** if the first output feels generic. The second pass is usually tighter because the model has more context about what you want.
- **Keep the blog post link handy.** Many CFP forms ask for supporting material, and a published post is strong evidence that you know the topic.
- **If the blog post is very long (3000+ words),** summarize it to under 2000 words before running Step 1, or run Step 1 on the first half and second half separately and merge the summaries. Long posts can cause the model to lose detail in later steps.
- **If the blog post is about a non-technical topic** (team culture, career growth, process change), adjust "live demo" references in Steps 2 and 3 to "case study" or "audience exercise" to match the content type.
- **Slash command connection:** If you use `ai-bu-claude-commands`, the `/blog-from-pr` slash command can generate the blog post that feeds into this chain, and the `/demo-prep` slash command can build the live demo portion of the resulting talk.

## Example

Below is an abbreviated example showing output from Steps 1 and 2 for a hypothetical blog post about migrating from monolith to microservices.

### Example Step 1 Output

> **CORE ARGUMENT:** Migrating from a monolith to microservices is not primarily a technical challenge; it is an organizational one. Teams that focus on service boundaries before addressing team boundaries end up with distributed monoliths.
>
> **SUPPORTING EVIDENCE:**
> - Case study: 18-month migration at a mid-size SaaS company (200 engineers)
> - Comparison of two migration approaches (API-first vs. strangler fig)
> - Metrics: deployment frequency before and after (2/week to 15/day)
> - Code example: shared database anti-pattern and the refactor that fixed it
>
> **TARGET AUDIENCE:** Backend engineers and engineering managers at companies with 50-500 engineers who are considering or actively doing a microservices migration.
>
> **KEY TAKEAWAYS:**
> - Draw team boundaries before service boundaries
> - The strangler fig pattern reduces risk compared to a full rewrite
> - Shared databases are the most common source of coupling in early migrations
> - Deployment frequency is a better success metric than number of services
>
> **TECHNICAL DEPTH:** Practitioner guide. The post includes code examples but focuses on decision-making rather than implementation details.
>
> **GAPS AND ASSUMPTIONS:** Assumes familiarity with basic microservices concepts. Does not address cost implications or infrastructure complexity.

### Example Step 2 Output

> **KEEP:**
> - Case study narrative (works well as a story arc; audience can follow without reading)
> - Deployment frequency metrics (single stat, easy to show on one slide)
> - "Draw team boundaries first" principle (memorable, quotable takeaway)
>
> **CUT:**
> - Shared database code example (requires reading 40+ lines of SQL; better as a blog reference)
> - Detailed comparison of API-first vs. strangler fig (too much nuance for a verbal explanation; link to the blog post instead)
>
> **TRANSFORM:**
> - The two-approach comparison could become a simple "we tried X, it failed, then we tried Y" story instead of a side-by-side analysis
> - Deployment frequency metrics could become a live dashboard screenshot or a before/after slide pair
>
> **AUDIENCE HOOK:** Engineers at companies about to start a microservices migration want to avoid the mistakes that others have already made. This talk gives them a specific, experience-tested playbook.
>
> **MISSING ELEMENTS:** The blog does not include any "what went wrong" stories. A talk version would benefit from at least one honest failure moment to build credibility and hold attention.
