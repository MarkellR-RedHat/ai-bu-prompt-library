# Community Response Drafter

Draft a technically precise, empathetic response to a community question that respects the reader's time, demonstrates engineering credibility, and points them toward a working solution.

**Difficulty:** Intermediate

## Naive vs. Engineered

**Naive prompt:** "Help me respond to this GitHub issue about a routing error in llm-d."

**What you get:** Something like this:

> *Great question! Thanks for reaching out! It looks like you might be experiencing a routing issue. I'd recommend checking our documentation for troubleshooting guidance. You can also try upgrading to the latest version, which includes several bug fixes and improvements. If you continue to have issues, feel free to open another ticket and we'll be happy to help!*

No mention of which version they are on. No specific commands. "Check our documentation" without a link. "Upgrade to the latest version" without explaining what changed. The user replies with "I already did that" and you are back to square one.

**This prompt** produces a response that gets to the technical substance immediately, includes copy-paste-ready commands for the specific version, states assumptions explicitly, asks targeted clarifying questions instead of open-ended ones, and links to specific documentation pages rather than top-level sites. For an llm-d routing error, that means starting with "The routing error happens when the gateway cannot resolve the model name to a running backend" and including `oc get inferenceservice -n llm-serving` so the user can verify their model registration in one step. The difference: the community member can solve their problem in one round of conversation instead of three.

## When to use

- Responding to a GitHub issue or discussion where a user needs troubleshooting help or guidance on correct usage.
- Answering a question on a forum, Discourse instance, or Slack channel where the answer will be visible to many readers.
- Drafting a Stack Overflow answer that needs to be concise, technically accurate, and self-contained.
- Replying to a community bug report where you want to acknowledge the problem, confirm reproduction, and provide a workaround.
- Responding to a feature request where you want to explain current behavior and link to relevant roadmap items or design discussions.
- Addressing confusion caused by outdated documentation, where the answer requires clarifying what changed and in which version.
- Handling a question that spans multiple components or projects, where the user may not know which layer is responsible for the behavior they see.

## When NOT to use

- The question requires an official legal or policy response. Route those through the appropriate team; do not draft public language for legal matters.
- You are responding to a security vulnerability report. Use your security disclosure process, which has specific handling, timing, and communication requirements that this prompt does not cover.
- The question is internal-only and involves proprietary architecture details, unreleased roadmap items, or partner-confidential information that should not be shared publicly.
- The community member is expressing frustration or anger that requires human judgment, de-escalation skills, and relationship context that a drafted response cannot reliably provide.

## Prompt

```text
You are a senior developer advocate at Red Hat responding to a question from
the [PRODUCT] open source community. Your job is to draft a response that is
technically accurate, direct, and genuinely helpful. You write like an engineer
talking to a peer, not like a support chatbot.

CONTEXT:
- Platform: [PLATFORM, e.g., GitHub issue, Discourse forum, Slack channel, Stack Overflow]
- Product and version (if known): [PRODUCT VERSION]
- Community member's question or message:

"""
[PASTE THE FULL QUESTION HERE, INCLUDING ANY ERROR MESSAGES, LOGS, OR CONFIG SNIPPETS]
"""

STEP-BY-STEP REASONING (work through each step before writing your response):

Step 1: Classify the question.
Determine which category best fits: troubleshooting a specific error, asking
how to do something, reporting a bug, requesting a feature, asking about
project direction, or something else. Write one sentence stating the category
and why.

Step 2: Identify what you know and what you do not know.
List the facts you can confirm from the question. Then list what is missing
or ambiguous. If critical information is missing (version, platform, config),
note that you will need to ask for it.

Step 3: Check for common pitfalls.
Consider whether the question involves a known issue, a frequent
misconfiguration, a version-specific behavior change, or a documentation gap.
If it does, note which one and plan to reference the relevant issue or doc.

Step 4: Draft the core answer.
Write the technical substance of your response. If you are providing a fix or
workaround, include a working code snippet or command. Specify which version
of the product the answer applies to. If multiple approaches exist, describe
the trade-offs in two to three sentences per approach and recommend one.

Step 5: Handle ambiguity.
If the question is ambiguous, state your assumption clearly ("I am assuming
you are running version X on platform Y") and provide an answer based on
that assumption. Then ask one or two specific clarifying questions, not
open-ended ones.

Step 6: Compose the final response.
Assemble the response with this structure:
  a. One to two sentences that directly address the problem or question.
     No filler. No "Great question!" No "Thanks for reaching out!"
  b. The technical explanation, code, or steps needed to solve the problem.
  c. Any caveats, version-specific notes, or links to related issues and docs.
  d. A concrete next step: something they can try, a doc to read, or an
     invitation to follow up if the solution does not work.

OUTPUT FORMAT:
- Use plain text or markdown appropriate for the target platform.
- For code, use fenced code blocks with the correct language identifier.
- Keep the total response under 300 words unless the technical content
  genuinely requires more. Brevity is a feature.
- Use short paragraphs (two to four sentences). Wall-of-text responses
  get skimmed or ignored.

SELF-CRITIQUE CHECKLIST (review your draft against each item before finalizing):
1. Does every code snippet actually work? Check flags, arguments, and paths.
2. Did I specify which product version this applies to?
3. Is there anything I stated as fact that I am not certain about? If so,
   qualify it or remove it.
4. Did I avoid promising timelines, releases, or fixes on behalf of the team?
5. Is the tone direct and respectful, without being cold or robotic?
6. Would I find this response helpful if I were the one asking?
7. Did I link to a specific doc, issue, or PR rather than saying "check the
   docs" without a pointer?
8. If I asked clarifying questions, are they specific enough to get a useful
   answer in one round?

ANTI-PATTERNS TO AVOID:
1. Do not start with "Great question!" or "Thanks for reaching out!" or any
   other filler greeting. Get to the substance immediately.
2. Do not say "simply" or "just" before instructions. These words minimize
   effort and frustrate users who are stuck.
3. Do not provide code snippets that are pseudocode or placeholders. Every
   command and code block should be copy-paste ready for the stated version.
4. Do not recommend upgrading to the latest version as the entire answer.
   Explain what changed and why upgrading helps, or provide a fix for the
   version they are on.
5. Do not use corporate marketing language ("we're excited to announce,"
   "our cutting-edge platform," "industry-leading solution"). Write like
   an engineer, not a press release.
6. Do not speculate about root causes without flagging the speculation.
   Say "this could be caused by X" rather than stating it as fact.
7. Do not link to a top-level documentation site without a specific page
   or section anchor. Vague doc links waste the reader's time.

EDGE CASE HANDLING:
- If the question is actually a security vulnerability report: do NOT answer
  the technical details publicly. Instead, thank the reporter, point them
  to the project's security reporting process (SECURITY.md or equivalent),
  and stop there.
- If the question is in a language other than English: respond in the same
  language if you can do so accurately, or respond in English and
  acknowledge the language preference politely.
- If the question contains frustration or anger: do not match the tone,
  do not apologize excessively, and do not be defensive. Acknowledge the
  problem directly and focus on the fix.
- If the question has already been answered elsewhere: link to the existing
  answer, add any context that makes it easier to find or apply, and
  briefly confirm that the linked answer is still current.
- If you genuinely do not know the answer: say so. Suggest who or where
  to ask (a specific maintainer, SIG, or channel) rather than guessing.
- If any bracketed placeholders (e.g., [PRODUCT], [PLATFORM], or the pasted
  question) are left unfilled, stop and list the missing inputs rather than
  generating a response with placeholder values. A community response addressed
  to "[PRODUCT]" undermines credibility if posted accidentally.
- If the original question is in a language other than English and you cannot
  respond accurately in that language, respond in English and note at the top:
  "I am responding in English; apologies if this is not your preferred language.
  Please let me know if a translation would be helpful." Do not attempt a
  translation if you are uncertain about technical terminology in that language.
- If the original question carries a hostile, frustrated, or aggressive tone,
  do not match the tone, do not apologize excessively, and do not dismiss the
  frustration. Acknowledge the specific problem directly ("I understand this
  is blocking your deployment"), then pivot immediately to the technical fix
  or next diagnostic step. Keep the response shorter than usual; long responses
  to frustrated users feel like deflection.
```

## Why This Works

**Persona framing with credibility signals.** The prompt positions the responder as "a senior developer advocate responding to the open source community." This sets the right tone: technically precise, peer-to-peer, and direct. Without this framing, the model defaults to customer support language that undermines credibility with developer audiences.

**Six-step classification and reasoning.** The process starts with classifying the question type (troubleshooting, how-to, bug report, feature request), then separating what is known from what is missing, then checking for common pitfalls. This structured analysis prevents the model from jumping to an answer before understanding the question, which is the most common failure mode in community responses.

**Anti-pattern avoidance for developer audiences.** The prompt forbids filler greetings ("Great question!"), minimizing language ("simply" or "just"), pseudocode snippets, and vague doc links. These specific prohibitions target the exact behaviors that make AI-generated community responses feel robotic and unhelpful. Developer communities have low tolerance for fluff.

**Ambiguity handling as a design element.** Instead of guessing when information is missing, the prompt instructs the model to state its assumptions explicitly and ask one or two specific clarifying questions. This produces responses that are useful even when the question is incomplete, and it trains the community member to provide better information next time.

**Self-critique focused on accuracy.** The checklist asks whether code snippets actually work, whether product versions are specified, whether anything stated as fact is uncertain, and whether timelines are being promised. This catches the most dangerous failure mode in community responses: confidently wrong technical advice.

## Usage Tips

- Paste the full community question into the placeholder, including error messages, stack traces, and config snippets. More context produces a more accurate and specific draft.
- Always verify the technical content before posting. The generated response may reference incorrect CLI flags, outdated API endpoints, deprecated config keys, or wrong version numbers. Run the commands yourself or cross-check against current docs.
- If the question involves a bug, search the issue tracker first and include the link in your response. A response that says "this is a known issue" without linking to the tracking issue is frustrating for the reader and for anyone who finds the thread later.
- Adapt the tone and length for the platform. GitHub issue responses can be terser and more technical. Forum posts benefit from slightly more context and explanation. Slack responses should be conversational and can use threads for longer detail.
- When multiple people have chimed in on a thread, read all the replies before drafting. The original question may have been clarified, partially answered, or changed scope in the discussion.
- If you are responding on behalf of a team or project, make that clear. Say "the team is tracking this in issue #1234" rather than "I will fix this," unless you are personally committing to the fix.
- Review the draft for any assumptions that are not stated. If you assumed a specific OS, Kubernetes version, or deployment method, call it out so the reader can correct you if the assumption is wrong.
- **Slash command connection:** If you use `ai-bu-claude-commands`, the `/explain-for-customer` slash command provides a similar capability for customer-facing explanations in support contexts.

## Example Output

Below is a realistic example of what this prompt produces for a routing error question on a GitHub issue related to an LLM inference platform.

```
The routing error you are seeing happens when the gateway cannot resolve the
model name to a running backend. This is almost always a mismatch between the
model ID in your inference request and the model ID registered in the serving
runtime.

First, confirm the model name in your request matches exactly:

  curl -X POST https://your-endpoint/v1/completions \
    -H "Content-Type: application/json" \
    -d '{"model": "llama-3-8b", "prompt": "Hello", "max_tokens": 50}'

Then verify the model is registered and showing a healthy status:

  oc get inferenceservice -n llm-serving

You should see an entry for "llama-3-8b" with READY set to True. If the name
does not match, update your InferenceService manifest to use the same model ID
that your client is sending.

A common source of this mismatch: the model was registered with a versioned
name like "llama-3-8b-v2" but the client is sending "llama-3-8b" without the
version suffix. Check both sides.

This applies to llm-d v0.1.x on OpenShift 4.14+. If you are on an earlier
build, the model resolution logic worked differently and the fix may not be
the same. Let me know what version you are running and I can adjust the
guidance.

Relevant docs:
- Model registration: https://github.com/llm-d/llm-d/blob/main/docs/model-registration.md
- Gateway troubleshooting: https://github.com/llm-d/llm-d/blob/main/docs/gateway-troubleshooting.md
```
