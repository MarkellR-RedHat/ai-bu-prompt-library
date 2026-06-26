# LinkedIn Post Writer

Craft a LinkedIn post that shares technical content in a professional, engineering-first voice without sounding like marketing copy or corporate filler.

**Difficulty:** Intermediate

## Naive vs. Engineered

**Naive prompt:**
> "Write a LinkedIn post about our new open source inference project."

**What you get:** "I'm excited to share that we just launched an amazing new open source project! It's a game-changing tool for AI inference that will revolutionize how teams deploy models. Check it out! #AI #Innovation #Excited" Plus three paragraphs of vague claims that could describe any project at any company.

**This prompt produces:** A 150-250 word post that opens with a specific technical fact (the default Kubernetes scheduler cannot see KV-cache pressure, batch queue depth, or prefill vs. decode phase), names the project and architecture (llm-d's disaggregated inference on OpenShift, separating prefill and decode for independent routing and scaling), includes a concrete metric (p99 latency dropped 35% once requests stopped being treated identically), and closes with a genuine question that invites real discussion from practitioners. The post sounds like an engineer talking to peers, not a brand account broadcasting announcements.

**The difference:** One sounds like every other corporate LinkedIn post and gets scrolled past. The other sounds like a person with something specific to say and earns engagement from practitioners who actually work in the space.

---

## When to use

- You are sharing a blog post, project release, or technical writeup and want a thoughtful post framed around the substance.
- You are announcing a conference talk, workshop, or event and want to give people a concrete reason to attend.
- You are sharing a lesson learned from engineering work and want to frame it for a broad technical audience.
- You are promoting open source work and want the post to focus on what the project actually does, not hype.
- You need to translate a dense technical topic into something accessible to a mixed audience of engineers and engineering managers.
- You want to highlight a contributor, collaborator, or community effort without it reading like a press release.
- You are sharing benchmark results, architecture decisions, or tradeoffs and want to start a real discussion.

## When NOT to use

- You are writing official Red Hat corporate communications. Use approved channels and the corporate social media process instead.
- You are posting about sensitive topics like layoffs, acquisitions, or organizational changes. These require review from comms and legal.
- You need a multi-post campaign or a thread strategy. This prompt targets a single standalone post.
- You are drafting content for someone else's account without their input on voice and perspective. Get their notes first, then use the prompt.

## Prompt

```
You are a LinkedIn ghostwriter for a senior engineer at a major technology company.
Your job is to draft a single LinkedIn post that reads like it was written by the
engineer themselves: direct, technically grounded, and free of marketing language.

CONTEXT (fill in each field before running):
- Topic: [TOPIC, e.g., "disaggregated inference scheduling on Kubernetes"]
- Content being shared: [CONTENT, e.g., a blog post, a talk, a project release, a lesson learned]
- Key takeaway for the reader: [TAKEAWAY, e.g., "you can now run distributed inference on Kubernetes without custom schedulers"]
- Link to include (if any): [URL or "none"]
- Author's role and perspective: [ROLE, e.g., engineer on the project, conference speaker, community member]
- Target audience: [AUDIENCE, e.g., platform engineers, ML practitioners, open source contributors]
- Tone preference: [TONE, e.g., conversational, reflective, matter-of-fact]

STEP-BY-STEP REASONING (follow this chain of thought before writing):

Step 1 - Identify the hook.
  Ask yourself: what is the single most concrete, surprising, or useful thing the
  reader will take away? This is your opening line. It should NOT be a greeting,
  an announcement phrase, or a statement about your emotions. It should be a fact,
  a result, a problem statement, or a question the reader already has in their head.

Step 2 - Build the narrative arc.
  Structure the post as: Hook > Context > Insight > Evidence or Detail > Call to action.
  Each section should be 1 to 3 sentences. The entire post should be 150 to 250 words.
  Short paragraphs are critical for mobile readability.

Step 3 - Ground every claim.
  For each sentence, ask: "Is this specific enough that the reader learns something,
  or is it vague filler?" Remove any sentence that could appear in any company's post
  about any product. Replace it with a concrete detail, metric, or architectural choice.

Step 4 - Strip the marketing.
  Scan for and remove: "excited to announce," "thrilled to share," "game-changing,"
  "cutting-edge," "revolutionary," "delighted," "proud to," "incredible,"
  "next-generation," "best-in-class," and any similar filler. Replace each one with
  a factual statement about what happened or what changed.

Step 5 - Check the voice.
  Read the post aloud. Does it sound like an engineer talking to a peer at a
  conference hallway? If it sounds like a press release or a product page, rewrite
  the offending sentences.

Step 6 - Add the call to action.
  If there is a link, introduce it naturally ("I wrote up the details here:" or
  "The full walkthrough is here:"). Do not say "check out" or "don't miss."
  If there is no link, close with a question or an invitation to share experiences.

Step 7 - Add hashtags.
  Append 3 to 5 relevant hashtags at the end. Use hashtags that engineers actually
  search for (e.g., #Kubernetes, #OpenSource, #MLOps), not branded campaign tags.

OUTPUT FORMAT:
Return the post as plain text, ready to paste into LinkedIn. Use this structure:

  [Opening hook: 1-2 sentences, no greeting or announcement phrasing]

  [Context: what the project/post/talk is and why it matters, 2-3 sentences]

  [Insight or surprising detail: 1-3 sentences]

  [Link sentence, if applicable]

  [Closing: question or invitation, 1-2 sentences]

  [Hashtags]

SELF-CRITIQUE CHECKLIST (run through each item before returning the final post):
1. Does the opening line state a fact, result, or problem instead of an emotion?
2. Is every sentence specific enough that it could NOT appear in a generic company post?
3. Is the post between 150 and 250 words (excluding hashtags)?
4. Are paragraphs short (1-3 sentences each) for mobile readability?
5. Does it sound like a person, not a brand account?
6. Are there zero instances of "excited," "thrilled," "proud," "game-changing,"
   "cutting-edge," or other marketing filler?
7. Are there zero em dashes? Use commas, periods, semicolons, or "and" instead.
8. Is the call to action natural and low-pressure?
9. Are the hashtags relevant to the technical topic, not generic (#innovation, #leadership)?
10. Would you, as an engineer, actually want to read this post in your feed?

ANTI-PATTERNS TO AVOID:
1. Opening with "I'm excited to share..." or any emotion-first opener.
   Instead, open with the technical result, the problem you solved, or a question.
2. Writing a summary of the linked content instead of adding your own perspective.
   The post should include at least one detail, opinion, or reflection not in the link.
3. Using corporate buzzwords: "leverage," "synergy," "ecosystem play," "unlock value,"
   "digital transformation." Say what the thing actually does in plain language.
4. Writing a wall of text. If any paragraph exceeds 3 sentences, split it.
5. Ending with a vague "Let me know what you think!" without framing a specific question.
   Instead, ask something concrete: "Has anyone else hit this issue with GPU scheduling?"
6. Using em dashes anywhere. They are banned. Restructure the sentence with commas,
   periods, semicolons, or the word "and."
7. Tagging people or companies excessively. One or two mentions is fine; tagging every
   person on the team reads as engagement farming.
8. Using all-caps or excessive exclamation points for emphasis. Let the content do the work.

EDGE CASE HANDLING:
- If the topic is about a product release: focus on what problem it solves and for whom,
  not on the release itself. Engineers care about "what does this let me do" more than
  "version 2.3 is now available."
- If the topic is a conference talk: give the audience one concrete thing they will learn
  by attending. "I'll be speaking at [event]" by itself is not a post.
- If the topic is a lesson learned with no link: the post should teach that lesson in
  full. The reader should walk away having learned something, not needing to click
  somewhere else.
- If the author's role is community member (not the project creator): frame the post
  around your experience using or contributing to the project. Do not write as if you
  built it.
- If the content is highly technical and the audience is mixed: lead with the problem
  in plain language, put the technical details in the middle, and close with the
  practical impact. Do not assume the reader knows the acronyms.
- If no link is provided: do NOT fabricate one. End with a discussion question instead.
- If any placeholder is left unfilled, stop and ask the user to provide it. A LinkedIn post without a clear topic will default to generic filler.
- If the topic is about a competitor's product or technology, keep the tone neutral and fact-based. Frame it as engineering observation, not positioning.
```

## Why This Works

LinkedIn posts are uniquely vulnerable to sounding corporate and hollow, so this prompt applies targeted techniques to keep the output grounded and human:

- **Ghostwriter persona with voice constraint.** The model writes as a ghostwriter for "a senior engineer," and the voice test is explicit: "Does it sound like an engineer talking to a peer at a conference hallway?" This framing produces output that reads as personal and technical rather than institutional and promotional.

- **Seven-step chain-of-thought.** The steps are ordered to match how a good post comes together: hook first, then narrative arc, then grounding every claim, then stripping marketing language, then voice check, then call to action, then hashtags. This sequence matters because each step builds on and constrains the previous one.

- **Marketing language kill list.** Step 4 provides an explicit list of banned phrases: "excited to announce," "thrilled to share," "game-changing," "cutting-edge," "revolutionary," "delighted," "proud to," "incredible," "next-generation," "best-in-class." This is not a style preference; these phrases are the primary signal that causes technical readers to disengage. Banning them forces the model to replace each one with a factual statement.

- **"Read it aloud" voice test.** Step 5 tells the model to check whether the post sounds like a press release or a product page and rewrite if it does. This meta-instruction acts as a second filter beyond the kill list, catching marketing-adjacent language that is not on the explicit list but still feels corporate.

- **Specificity enforcement.** Step 3 asks, for each sentence: "Is this specific enough that the reader learns something, or is it vague filler?" and instructs the model to replace any sentence that "could appear in any company's post about any product." This constraint is what produces the concrete metrics, architecture details, and named technologies that make the post worth reading.

- **Anti-pattern catalog for LinkedIn-specific failure modes.** Opening with emotions, summarizing instead of adding perspective, corporate buzzwords, wall-of-text formatting, vague engagement questions, and excessive tagging are all patterns that are common on LinkedIn specifically. Naming them prevents the model from reproducing them.

The comparison above captures the fundamental problem: LinkedIn's culture encourages a posting style that technical audiences find hollow. This prompt systematically overrides that default by encoding the norms of engineer-to-engineer communication instead.

## Usage Tips

- **Lead with what changed, not what you feel.** The strongest LinkedIn posts open with a result ("We cut inference latency by 40%") or a problem ("GPU scheduling on Kubernetes is broken"). Your emotions about the topic are not the hook.
- **Add something the link does not contain.** If you are sharing a blog post, include a detail that did not make the final draft, a lesson from the process, or your honest reaction to the results. Otherwise, people have no reason to read the post and the blog.
- **Use specific numbers whenever possible.** "3 things I learned," "reduced p99 latency from 800ms to 200ms," "took 6 weeks to build and 2 days to deploy." Specificity signals credibility and stops the scroll.
- **Keep it under 250 words.** LinkedIn truncates posts behind a "see more" fold after roughly 3 lines on mobile. Your hook must land before that fold, and the full post should respect people's time.
- **Read it aloud before posting.** If it sounds like something a VP of Marketing would say on stage, rewrite it. If it sounds like something you would say to a coworker over coffee, ship it.
- **Vary your post structure over time.** Not every post needs to be "problem, solution, link." Try asking a genuine question, sharing a tradeoff you wrestled with, or highlighting someone else's work.
- **Do not over-hashtag.** Three to five targeted hashtags (#Kubernetes, #OpenSource, #MLOps) outperform ten generic ones (#innovation, #technology, #leadership, #motivation).
- **Slash command connection:** If you use `ai-bu-claude-commands`, the `/draft-announcement` slash command can generate LinkedIn-ready posts alongside Slack and email versions from the same source material.

## Example Output

> GPU scheduling on Kubernetes does not understand your model. It does not know the difference between a 7B parameter model and a 70B one. It cannot see KV-cache pressure, batch queue depth, or whether a request is in prefill or decode phase. You end up over-provisioning GPUs and hoping for the best.
>
> We built llm-d to fix this. It is a disaggregated inference platform that runs natively on OpenShift and schedules GPU workloads based on actual model state, not just static resource requests. The core idea is to separate the prefill and decode phases of inference so each can be routed and scaled independently.
>
> I wrote up the full architecture and a deployment walkthrough here: [link]
>
> The result that surprised me most: p99 latency dropped by 35% once we stopped treating every inference request identically. A short prompt hitting a warm KV-cache and a cold 2,000-token prompt have completely different resource needs, and the scheduler should know that.
>
> One tradeoff worth noting: disaggregated scheduling adds routing complexity. You need an endpoint picker that understands cache locality, and that is a new component to operate. We think the latency and utilization gains are worth it, but it is not free.
>
> If you are running LLM inference on Kubernetes and fighting GPU allocation, I would be curious to hear how you are handling scheduling today. Are you using static resource requests, custom schedulers, or something else entirely?
>
> #Kubernetes #OpenShift #MLOps #InferenceServing #OpenSource
