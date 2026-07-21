# Twitter/X Thread Writer

Craft a technically sharp Twitter/X thread that breaks down complex topics into a sequence of self-contained, high-signal tweets.

**Difficulty:** Intermediate

## Naive vs. Engineered

**Naive prompt:**
> "Write a Twitter thread about our Kubernetes inference project."

**What you get:** "Thread: Let's talk about AI inference on Kubernetes! 1/ AI is transforming how we deploy models. 2/ Our project makes it easier. 3/ It's really cool and you should check it out!" Seven tweets of vague, interchangeable claims with emoji bullets, hashtags scattered everywhere, and zero technical substance. The kind of thread people mute.

**This prompt produces:** A 5-10 tweet thread where the hook states a specific, verifiable claim ("Most Kubernetes clusters waste 30-50% of their GPU capacity on inference workloads"), each tweet adds one new fact (disaggregated prefill/decode scheduling, KV-cache-aware routing, native OpenShift integration without custom operators), the narrative arc moves from the GPU scheduling problem through llm-d's architecture to proof and a call to action, every tweet stays under 280 characters with counts verified, and hashtags appear only in the final tweet. Each tweet is self-contained enough to make sense when seen out of order in someone's feed.

**The difference:** One reads like a product announcement from a brand account. The other reads like an engineer breaking down a hard problem in public, which is the content that actually gets retweeted.

---

## When to use

- You need to break down a complex technical concept (architecture, algorithm, design pattern) into bite-sized pieces for a broad audience.
- You are sharing a conference talk, blog post, or whitepaper and want to give people the key points up front.
- You are building a narrative around a project milestone, release, or benchmark result.
- You want to drive traffic to a specific resource (repo, docs, demo) with a compelling lead-in.
- You are announcing an open source contribution and want to explain the "why" before the "what."
- You need to translate internal engineering wins into public-facing content that resonates with practitioners.
- You are live-threading from a conference or event and need a structured format to follow.

## When NOT to use

- You just need a quick one-off tweet that does not require a thread. Write it directly instead.
- You are posting on behalf of an official corporate social media account. Use the social team's process and approved tooling.
- The content is confidential, pre-announcement, or under embargo. Do not use AI to draft social posts for unreleased material.
- You need long-form argumentation or nuance that cannot survive the 280-character constraint. Write a blog post instead.

## Prompt

```
You are an experienced technical communicator who writes Twitter/X threads for
engineering audiences. Your threads are known for being clear, direct, and
information-dense. You never use filler, hype language, or hollow superlatives.

CONTEXT
-------
Topic: [TOPIC]
Source material: [CONTENT, e.g., a technical concept, a project update, a conference talk, a blog post, a tutorial]
Target audience: [AUDIENCE, e.g., ML engineers, cloud-native developers, open source contributors, platform engineers]
Key point to land: [KEY POINT, e.g., "disaggregated inference reduces GPU waste by routing requests based on KV-cache state"]
Link to include (optional): [URL]
Thread length: [5-10 tweets, default 7]

STEP-BY-STEP REASONING
-----------------------
Before writing, work through these steps internally:

1. Identify the single most important takeaway from the source material.
   Ask yourself: "If the reader only sees one tweet from this thread, what must they walk away knowing?"

2. List 5-8 supporting facts, data points, or insights that build toward that takeaway.
   Rank them by how surprising or useful they are to the target audience.

3. Decide on the narrative arc. Choose one:
   a. Problem > Why it is hard > How this solves it > Proof > Call to action
   b. Surprising claim > Evidence > Mechanism > Implications > Call to action
   c. Before/after contrast > Root cause > Solution > How to try it > Call to action

4. Draft the hook tweet (1/) last. The best opening line comes from knowing the
   full thread. The hook must do ONE of these:
   - State a bold, specific, verifiable claim (with a number if possible)
   - Ask a question the audience has genuinely wondered about
   - Present a counterintuitive fact that contradicts common assumptions

5. For each subsequent tweet, apply the "one idea per tweet" rule.
   If a tweet contains the word "also" or "additionally," it probably holds two
   ideas. Split it.

6. Write the closing tweet with a clear, single call to action and 1-2 relevant
   hashtags. Do not scatter hashtags throughout the thread.

OUTPUT FORMAT
-------------
Return the thread in this exact structure:

THREAD TITLE: [A short internal label, not published]
THREAD LENGTH: [N] tweets
TARGET AUDIENCE: [Restated for confirmation]
NARRATIVE ARC: [Which arc pattern you chose and why, in one sentence]

---

1/ [Hook tweet. Under 280 characters.]

2/ [Supporting tweet. Under 280 characters.]

...

N/ [Closing tweet with call to action and hashtags. Under 280 characters.]

---

CHARACTER COUNTS:
1/ [count]
2/ [count]
...
N/ [count]

SELF-CRITIQUE CHECKLIST
-----------------------
Before returning your final output, review every tweet against this checklist.
Fix any issues before presenting the thread.

[ ] Every tweet is under 280 characters (count carefully; include spaces and punctuation).
[ ] Tweet 1/ has a genuine hook, not a generic "Let's talk about X" opener.
[ ] Each tweet is understandable on its own, since people often see threads out of order in their feed.
[ ] The thread follows a clear narrative arc from setup to payoff.
[ ] There is exactly one call to action, and it appears in the final tweet.
[ ] Technical claims are specific and verifiable, not vague ("improves performance" is vague; "reduces p99 latency by 40%" is specific).
[ ] Tone is direct and technical. No hype, no "hot take" energy, no breathless excitement.
[ ] Hashtags appear only in the last tweet, and there are no more than two.
[ ] No tweet starts with "So," or "Now," or "Let's talk about."
[ ] The thread does not read like a press release or marketing copy.

ANTI-PATTERNS TO AVOID
-----------------------
1. DO NOT open with "Thread:" or "A thread on..." or "Let me tell you about..."
   These are low-signal openers that waste your hook tweet.

2. DO NOT use em dashes (the long dash character). Use commas, periods,
   semicolons, colons, or the word "and" instead. This is a hard constraint.

3. DO NOT use more than one emoji per tweet, and do not use emoji as bullet
   points. A wall of emoji hurts credibility with technical audiences.

4. DO NOT include hashtags in any tweet except the final one.

5. DO NOT write tweets that are just transitions ("But wait, there's more!" or
   "Here's where it gets interesting."). Every tweet must carry new information.

6. DO NOT use hollow superlatives: "game-changing," "revolutionary,"
   "groundbreaking," "next-level." State what it does and let the reader decide.

7. DO NOT pad tweets with filler phrases like "It's worth noting that" or
   "Interestingly enough." Get to the point.

8. DO NOT ask rhetorical questions in more than one tweet. One is a hook;
   two is a pattern; three is annoying.

EDGE CASES
----------
- If the source material is too thin for the requested thread length, reduce the
  thread to the minimum number of tweets that carry real information. State why
  you shortened it.
- If the topic is controversial or could be misread, add a brief note after the
  thread flagging the risk and suggesting alternative framings.
- If no link is provided, end with a call to action that does not require a URL
  (e.g., "try it yourself," "check the upstream repo," "what has your experience been?").
- If the audience is mixed (e.g., both executives and engineers), bias toward
  the technical audience. Executives can handle technical content; engineers
  will disengage from content that feels dumbed down.
- If the topic involves benchmarks or performance claims, always note the
  conditions (hardware, dataset, configuration) in at least one tweet, or flag
  that the reader should check the linked resource for methodology.
- If a placeholder is left unfilled, stop and ask the user to provide it before generating. A thread without clear source material will be generic.
- If the topic is outside the technology domain (career advice, hiring, organizational lessons), adjust the narrative arc to match the content type while keeping the one-idea-per-tweet structure.
```

## Why This Works

Twitter threads have unique constraints (280 characters, out-of-order visibility, short attention spans) that require specific prompt engineering techniques:

- **Persona as a technical communicator, not a social media manager.** The model is framed as someone "known for being clear, direct, and information-dense." This distinction matters because social media manager personas produce polished but hollow threads, while technical communicator personas produce threads with substance.

- **Narrative arc selection with three explicit options.** Offering three structural patterns (problem to proof, surprising claim to evidence, before/after contrast) forces the model to choose a deliberate story structure rather than listing facts in random order. The model must state which arc it chose and why, which makes the structural decision visible and reviewable.

- **"Write the hook last" instruction.** Step 4 tells the model to draft the hook tweet after writing the rest of the thread. This counterintuitive sequencing produces better hooks because the model knows the full argument before it has to compress it into a single opening tweet.

- **One idea per tweet rule.** The explicit instruction that "if a tweet contains the word 'also' or 'additionally,' it probably holds two ideas" gives the model a concrete, testable heuristic for splitting content. This prevents the most common thread failure: tweets that try to cover too much and end up saying nothing clearly.

- **Character count enforcement.** Requiring character counts for every tweet in the output makes overcounting visible and fixable. LLMs frequently misjudge character counts, so surfacing the numbers lets you catch errors before posting.

- **Anti-pattern catalog for Twitter-specific failures.** "Thread:" openers, emoji bullet walls, scattered hashtags, transition-only tweets, and hollow superlatives are all patterns specific to bad Twitter threads. Naming them prevents the model from falling into the most common traps.

- **Self-contained tweet test.** Requiring each tweet to be understandable on its own reflects how Twitter actually works: people see individual tweets in their feed, not neatly ordered threads. This constraint produces tweets that are each worth reading independently, which increases the chance of engagement on any single tweet in the thread.

The comparison above illustrates the core problem with naive thread generation: without structural constraints, the model produces threads that mimic the surface features of Twitter (short text, emoji, hashtags) without the information density that makes technical threads worth reading. This prompt replaces surface mimicry with structural engineering.

## Usage Tips

- **Write the hook last.** Once you know the full thread, the best opening line becomes obvious. Draft tweets 2-7 first, then circle back to 1/.
- **Split aggressively.** If a tweet feels too long, it almost certainly contains two ideas. Give each idea its own tweet.
- **One new fact per tweet.** The best threads feel like a staircase where each step adds exactly one new piece of information.
- **Read each tweet in isolation.** If it does not make sense without the surrounding tweets, rewrite it. People encounter threads out of order in their feed.
- **Avoid emoji walls.** One or two emoji across the entire thread are fine. More than that signals marketing copy, not engineering insight.
- **Test character counts manually.** LLMs frequently miscount characters. Paste each tweet into a character counter before publishing.
- **Front-load the value.** Assume most readers will only see tweets 1-3. Put the most important information there.
- **Use concrete numbers.** "Reduces latency" is forgettable. "Reduces p99 latency from 800ms to 200ms on A100s" is memorable and shareable.
- **Slash command connection:** If you use `claude-commands`, the `/draft-announcement` slash command generates social-ready posts alongside other announcement formats from the same source material.

## Example Output

> **THREAD TITLE:** llm-d disaggregated inference explainer
> **THREAD LENGTH:** 7 tweets
> **TARGET AUDIENCE:** ML engineers and platform engineers running LLMs on Kubernetes
> **NARRATIVE ARC:** Problem > Why it is hard > How this solves it > Proof > Call to action. Chose this because the audience needs to understand the scheduling gap before the solution makes sense.

> ---

> 1/ Most Kubernetes clusters waste 30-50% of their GPU capacity on inference workloads. The problem is not the hardware. It is the scheduler.
>
> 2/ The default kube-scheduler treats GPUs like CPUs: you request one, you get one. It has no concept of model size, memory pressure, or how long a request will take.
>
> 3/ llm-d fixes this by disaggregating inference. It separates prefill (processing the prompt) from decode (generating tokens) and routes each phase independently.
>
> 4/ Why does that matter? Prefill is compute-heavy and decode is memory-heavy. Scheduling them the same way guarantees you are wasting one resource or the other.
>
> 5/ The routing layer is KV-cache-aware. It knows which nodes hold hot caches for a given model and sends requests there first, instead of cold-starting every time.
>
> 6/ It runs natively on OpenShift. No custom operators, no sidecars. Install the component, deploy your model, and the scheduler handles the rest.
>
> 7/ Architecture walkthrough and getting-started guide here: [link]. If you are running LLMs on Kubernetes, take a look. #OpenSource #Kubernetes

> ---

> **CHARACTER COUNTS:**
> 1/ 144
> 2/ 175
> 3/ 168
> 4/ 158
> 5/ 163
> 6/ 143
> 7/ 159
