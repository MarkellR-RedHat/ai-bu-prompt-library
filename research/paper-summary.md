# Technical Paper Summarizer

A prompt for distilling technical papers into structured, actionable summaries that capture the key contributions, methods, and implications.

## Prompt

```
You are a senior engineer reviewing a technical paper. Summarize the following paper in a structured format that a busy engineering team can use to decide whether to read the full paper.

Paper: [PAPER_TITLE]
Authors: [AUTHORS]
Source: [CONFERENCE_OR_JOURNAL]

Provide your summary in this format:

1. **Core Contribution** (2-3 sentences): What is the main thing this paper introduces or proves?
2. **Problem Statement**: What specific problem does this paper address, and why does it matter?
3. **Approach**: How do the authors solve the problem? Describe the method at a technical level, but keep it concise.
4. **Key Results**: List the top 3-5 quantitative or qualitative results. Include specific numbers, benchmarks, or comparisons where available.
5. **Limitations**: What does the paper not address? What assumptions does it rely on?
6. **Relevance to [TEAM_OR_PROJECT]**: How could this work apply to our current efforts? Be specific about which components or workflows it could influence.
7. **Related Work Worth Reading**: Name 1-3 cited papers that are also worth reviewing, and briefly say why.

Keep the total summary under 500 words. Use precise technical language. Do not editorialize.
```

## Usage Tips

- Paste the full paper text (or as much as context allows) directly after the prompt for best results.
- Fill in the `[TEAM_OR_PROJECT]` placeholder with your actual project name so the relevance section is grounded rather than generic.
- For longer papers, you can feed the abstract and key sections (methodology, results, discussion) rather than the full text.
- Works well as a first pass before a deeper group review. Share the summary with the team and let people self-select into reading the full paper.

## Example Output Snippet

> **Core Contribution**: This paper introduces vLLM, a high-throughput serving engine for large language models that uses PagedAttention to manage KV cache memory efficiently. It achieves 2-4x higher throughput than existing systems by reducing memory waste during inference.
>
> **Problem Statement**: LLM serving systems waste 60-80% of KV cache memory due to fragmentation and over-reservation. This limits the number of concurrent requests a single GPU can handle, driving up serving costs.
>
> **Approach**: The authors adapt virtual memory and paging concepts from operating systems to KV cache management. PagedAttention stores KV cache in non-contiguous blocks and maps them through a block table, eliminating the need for contiguous memory allocation...
