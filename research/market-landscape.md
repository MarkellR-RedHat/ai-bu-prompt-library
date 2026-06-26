# Technology Landscape Mapper

A prompt for mapping out the players, trends, and dynamics in a technology area to support strategic planning and investment decisions.

**Difficulty:** Advanced

## When to use

- Planning a new product or feature investment and need to understand who else is building in the space.
- Preparing a strategy presentation for leadership that requires a clear view of the competitive and technical terrain.
- Onboarding onto an unfamiliar technology area and need a structured orientation to the key players and trends.
- Identifying partnership or acquisition targets by mapping where gaps exist and who is filling them.

## When NOT to use

- You need a narrow competitive analysis of a single product. Use the competitive-analysis prompt instead, which goes deeper on one player.
- You need validated market sizing with revenue numbers, TAM/SAM/SOM breakdowns, or investor-grade financial data. Engage an analyst firm for that level of rigor.

## Prompt

```
You are a technology analyst with enterprise infrastructure expertise. Map the current landscape for the following technology area.

Technology Area: [TECHNOLOGY_AREA, e.g., "Kubernetes-native LLM inference"]
Scope: [SCOPE, e.g., "open source and commercial projects targeting production deployments"]
Time Horizon: [TIME_HORIZON, e.g., "current state plus 12-month outlook"]

Structure your analysis as follows:

1. **Landscape Overview** (3-5 sentences): What is this technology area, why does it matter now, and what is driving adoption?

2. **Market Segments**: Break the landscape into 3-5 distinct segments or categories. For each segment, name the key players and briefly describe what differentiates that segment.

3. **Key Players**: For the top 8-12 projects or products, provide:
   - Name and vendor (or maintainer for open source)
   - One-line description
   - Maturity level (early stage, growth, mature)
   - Notable adopters or production deployments, if known

4. **Technology Trends**: Identify 3-5 technical trends shaping this space. For each, explain what is changing, why it matters, and which players are leading.

5. **Adoption Patterns**: Who is adopting this technology today? What are the common entry points, and what does a typical adoption path look like?

6. **Gaps and Unmet Needs**: What problems remain unsolved or underserved? Where are practitioners still stitching together workarounds?

7. **Outlook**: Based on current trajectory, what will this landscape look like in [TIME_HORIZON]? Which segments will consolidate, which will fragment, and where are new entrants most likely to appear?

8. **Implications for [ORGANIZATION_OR_PROJECT]**: Given this landscape, what should we be paying attention to? What decisions should we make in the next quarter?

Be specific. Name projects, cite version numbers where relevant, and ground claims in observable evidence rather than hype. If you are uncertain about a data point, say so.
```

## Usage Tips

- Adjust the `[SCOPE]` placeholder to control breadth. A narrow scope like "open source only, Kubernetes-native" produces a more focused and useful map than a broad one like "all AI infrastructure."
- The `[TIME_HORIZON]` placeholder shapes the outlook section. Use "6 months" for tactical planning and "18-24 months" for strategic bets.
- Feed recent conference talks, blog posts, or funding announcements into the context alongside this prompt to get the most current picture.
- Use the output as a starting point for a team discussion, not as a finished deliverable. The real value comes from debating the gaps and implications sections with your team.

## Example Output Snippet

> **Market Segments**:
>
> | Segment | Description | Key Players |
> |---|---|---|
> | Inference Engines | Core runtime for executing model forward passes efficiently | vLLM, TensorRT-LLM, TGI, llama.cpp |
> | Serving Platforms | Orchestration layer that manages model routing, scaling, and multi-tenancy | KServe, Triton Inference Server, Ray Serve, llm-d |
> | Gateway and Routing | API gateways purpose-built for LLM traffic with model-aware routing | LiteLLM, Portkey, Kong AI Gateway |
> | Optimization Tooling | Tools for quantization, distillation, and compilation that reduce serving cost | GPTQ, vLLM (AWQ support), TensorRT Model Optimizer |
>
> **Gaps and Unmet Needs**:
> 1. Multi-model GPU sharing with strong isolation is still largely unsolved. Most platforms require dedicating entire GPUs to a single model, which wastes capacity for smaller or bursty workloads.
> 2. Cost attribution at the request level is difficult. Teams serving multiple internal customers from shared infrastructure lack tooling to accurately charge back usage.
> 3. Standardized benchmarking across inference engines does not exist. Each project publishes its own benchmarks with different workloads, hardware, and metrics, making apples-to-apples comparison nearly impossible...
