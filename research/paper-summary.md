# Technical Paper Summarizer

A prompt for distilling technical papers into structured, actionable summaries that capture key contributions, methods, limitations, and practical implications for engineering teams.

**Difficulty:** Intermediate

## Naive vs. Engineered

Most people prompt something like this:

> **Naive prompt:** "Summarize this paper for me."

**What you get:** A paraphrase of the abstract with some vague praise ("the authors present a novel approach") and no critical assessment. You cannot tell whether the paper is worth reading, whether its results would hold at your scale, or how it connects to your team's work.

**This prompt** produces a structured analysis that separates genuine novelty from incremental work, lists quantitative results with baselines, identifies limitations the authors glossed over, and maps relevance to your specific project. The difference: instead of a reworded abstract, you get a senior engineer's read that tells you whether to invest time in the full paper or move on.

## When to use

- Reviewing a paper before a team discussion so everyone starts from a shared understanding of the core ideas.
- Deciding whether a paper is worth a full read based on its contributions and relevance to your current work.
- Sharing paper highlights in a Slack channel or meeting without asking people to read 20+ pages.
- Building a reading list for the team and you need a consistent summary format to compare papers side by side.
- Onboarding a new team member who needs to get up to speed on the foundational papers behind your system's architecture.
- Preparing a literature review section for an internal design doc or RFC that references external research.
- Evaluating whether a paper's claimed improvements would actually matter at your scale and workload profile.

## When NOT to use

- You need a detailed critique or peer review of methodology, statistical rigor, or experimental design. That requires domain expertise and careful reading of the full paper.
- You are summarizing internal design docs or RFCs. Use the dedicated RFC summary prompt instead, since those documents have different structure and audience expectations.
- The paper is behind a paywall and you only have the abstract. Summaries generated from abstracts alone will be shallow and potentially misleading. Get the full text first.
- You need to reproduce the paper's results. A summary is not a substitute for reading the methodology section line by line when implementation fidelity matters.

## Prompt

```
You are a senior research engineer with experience reading and evaluating technical papers
across systems, infrastructure, and machine learning. Your job is to produce a structured
summary of a technical paper that helps a busy engineering team decide whether to read it,
understand its core ideas, and assess its relevance to their work.

Paper: [PAPER_TITLE]
Authors: [AUTHORS]
Source: [CONFERENCE_OR_JOURNAL, e.g., "SOSP 2023", "arXiv preprint"]
Year: [YEAR]
Our Team/Project Context: [TEAM_OR_PROJECT, e.g., "inference platform team working on llm-d"]

Follow these steps carefully:

STEP 1: UNDERSTAND THE PAPER'S CONTRIBUTION
Read the paper thoroughly. Identify the single most important contribution. Ask yourself:
what did the authors do that nobody had done before, and why should practitioners care?
Separate genuine novelty from incremental improvements on known techniques.

STEP 2: PRODUCE THE STRUCTURED SUMMARY
Use the following format exactly:

### One-Sentence Summary
State the paper's core contribution in a single sentence. A reader should be able to
decide from this sentence alone whether the paper is relevant to them.

### Problem Statement (2-3 sentences)
What specific problem does this paper address? Why does it matter? Quantify the
impact of the problem where possible (e.g., "current systems waste 60-80% of KV cache
memory due to fragmentation").

### Approach and Key Ideas (4-6 sentences)
How do the authors solve the problem? Describe the method at a technical level that
a senior engineer would appreciate. Call out the core insight or design principle that
makes the approach work. Mention what existing technique or system it builds on, if any.

### Key Results
List the top 3-5 quantitative or qualitative results. For each result:
- State the metric and the value achieved
- State the baseline or comparison point
- Note the hardware, dataset, or workload used if it affects interpretation

### Limitations and Assumptions
List 3-5 limitations, unstated assumptions, or open questions. Consider:
- What workloads or hardware configurations were NOT tested?
- What assumptions does the approach rely on that may not hold in production?
- What failure modes are not discussed?
- What would break if you scaled this 10x beyond what the paper tested?

### Relevance to [TEAM_OR_PROJECT]
Provide a specific, grounded assessment of how this work applies to the team's
current efforts. Name specific components, APIs, or workflows it could influence.
If it is not relevant, say so directly and explain why.

### Related Work Worth Reading
Name 2-3 cited papers that are also worth reviewing. For each, give the title
and a one-sentence explanation of why it matters in the context of this paper.

### Confidence Notes
Flag any claims in this summary where you are uncertain or where the paper
itself is vague. Mark these with "[UNCERTAINTY]" so the reader knows to verify.

STEP 3: SELF-CRITIQUE CHECKLIST
Before finalizing your summary, verify each of the following:
- [ ] The one-sentence summary captures genuine novelty, not just the topic area
- [ ] Results include specific numbers and baselines, not vague claims like "significant improvement"
- [ ] Limitations go beyond what the authors stated and include your own critical observations
- [ ] The relevance section references specific aspects of [TEAM_OR_PROJECT], not generic advice
- [ ] You have flagged any claims you are uncertain about
- [ ] The summary stays under 600 words total
- [ ] You did not editorialize or inject hype language

ANTI-PATTERNS TO AVOID:
1. Do not summarize the abstract. Read the full paper and add value beyond what the abstract says.
2. Do not use vague praise like "novel approach" or "significant contribution" without specifics.
3. Do not ignore negative results or limitations. Papers that seem too good to be true usually are.
4. Do not treat the authors' framing as ground truth. Evaluate whether their claims are well-supported.
5. Do not skip the related work section of the paper. It often reveals how incremental the contribution is.
6. Do not conflate the paper's theoretical results with practical applicability. A 2x speedup on a
   synthetic benchmark may not translate to production workloads.
7. Do not pad the summary with background information the team already knows.

EDGE CASES:
- If the paper is a survey or position paper with no original experiments, restructure the summary
  to focus on the taxonomy, key observations, and gaps identified rather than results.
- If the paper has been published as both a preprint and a peer-reviewed version, note any
  significant differences if known.
- If the paper's code or artifacts are publicly available, include the repository link and note
  whether it appears actively maintained.
- If the paper is from a workshop or non-peer-reviewed venue, note this context in your summary
  so readers can calibrate their trust accordingly.

Keep the total summary under 600 words. Use precise technical language.
```

## Why This Works

This prompt uses several techniques that compound to produce a critical technical assessment rather than a reworded abstract:

- **Persona framing.** "You are a senior research engineer with experience reading and evaluating technical papers" sets the model to read like a practitioner, not a student. This shifts the output from "what the paper says" to "what the paper means for engineers building real systems."

- **Chain-of-thought decomposition.** Step 1 forces the model to identify the single most important contribution before summarizing. This prevents the common failure mode where a summary lists everything the paper discusses without distinguishing what actually matters.

- **Structured output formatting.** Sections like Key Results (with baselines and hardware context), Limitations and Assumptions, and Relevance to Your Team force the model to go beyond the abstract. The format demands specificity: numbers, comparison points, and grounded assessments rather than vague praise.

- **Confidence calibration.** The "[UNCERTAINTY]" flagging mechanism forces the model to distinguish between claims it can verify from the paper and claims it is less sure about. This is critical because models will otherwise present uncertain information with the same confidence as well-supported claims.

- **Anti-pattern avoidance.** Explicitly blocking behaviors like summarizing only the abstract, using vague praise ("novel approach"), and conflating synthetic benchmarks with production applicability addresses the most common ways paper summaries mislead readers.

- **Self-critique checklist.** The verification step catches missing baselines in results, generic relevance assessments, and summaries that slip into hype language. These are the exact failure modes that make paper summaries useless.

These techniques together explain the difference shown in the comparison above: the naive prompt produces something that reads like the abstract you already skipped, while this prompt produces an evaluation that tells you whether to invest your time.

## Usage Tips

- Paste the full paper text (or as much as the context window allows) directly after the prompt for best results. PDF-to-text tools like `pdftotext` or online converters work well for this.
- Fill in the `[TEAM_OR_PROJECT]` placeholder with your actual project name so the relevance section is grounded rather than generic. "Inference platform team" is better than nothing, but "llm-d routing and scheduling subsystem" is better still.
- For longer papers, prioritize pasting the abstract, introduction, methodology, results, and discussion sections. Skip appendices and supplementary material unless they contain critical details.
- Works well as a first pass before a deeper group review. Share the summary with the team and let people self-select into reading the full paper based on the relevance assessment.
- Pair with a follow-up prompt asking the model to compare two paper summaries side by side if you are evaluating competing approaches.
- If the paper introduces a system with open-source code, run the summary prompt first, then separately evaluate the code quality and maintenance status.
- After generating the summary, scan the "[UNCERTAINTY]" flags. These are your starting points for deeper reading if the paper turns out to be relevant.

## Example Output

> ### One-Sentence Summary
> vLLM introduces PagedAttention, an OS-inspired memory management technique for KV caches that achieves 2-4x higher serving throughput by eliminating memory fragmentation during LLM inference.
>
> ### Problem Statement
> LLM serving systems waste 60-80% of KV cache memory due to fragmentation and over-reservation. Each request pre-allocates contiguous memory for the maximum possible sequence length, even though most sequences are much shorter. This limits the number of concurrent requests a single GPU can handle and directly drives up serving costs.
>
> ### Approach and Key Ideas
> The authors adapt virtual memory and paging concepts from operating systems to KV cache management. PagedAttention stores KV cache in non-contiguous, fixed-size blocks and maps them through a block table, eliminating the need for contiguous memory allocation. The core insight is that KV cache access patterns are sequential and predictable, making paging overhead negligible compared to the memory savings. The system builds on top of the Megatron-LM tensor parallelism approach for multi-GPU support and implements a centralized scheduler that manages block allocation across requests.
>
> ### Key Results
> - 2-4x throughput improvement over HuggingFace Transformers and Faster Transformer on OPT-13B and OPT-175B, measured on an A100-80GB cluster with ShareGPT request traces
> - Near-zero memory waste (under 4% fragmentation) compared to 60-80% in baseline systems
> - Supports beam search with memory sharing across beams, reducing beam search memory overhead by 55%
>
> ### Limitations and Assumptions
> - All benchmarks use synthetic or replayed request traces; no live production traffic evaluation
> - Does not address multi-model serving scenarios where multiple models share a GPU
> - Paging overhead analysis is limited to sequence lengths up to 2048 tokens; behavior at 32K+ context windows is untested
> - Assumes a single-node scheduler, which becomes a bottleneck in multi-node deployments [UNCERTAINTY]
>
> ### Relevance to Inference Platform Team
> Directly relevant to our KV cache management in llm-d. The PagedAttention block table design could inform our memory allocator for the disaggregated prefill/decode architecture. The scheduler design is less applicable since we use distributed scheduling, but the memory accounting approach (tracking block-level utilization) could improve our capacity planning tooling.
>
> ### Related Work Worth Reading
> - "Orca: A Distributed Serving System for Transformer-Based Generative Models" (OSDI 2022): Introduces continuous batching, the scheduling approach that vLLM builds on
> - "FlexGen: High-Throughput Generative Inference of Large Language Models with a Single GPU" (ICML 2023): Complementary approach focused on offloading to CPU/disk for throughput on limited hardware
