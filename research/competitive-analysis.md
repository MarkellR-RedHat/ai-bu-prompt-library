# Competitive Product Analysis

A prompt for producing a structured, evidence-based analysis of a competitor's product to inform positioning, engineering priorities, and go-to-market decisions.

**Difficulty:** Advanced

## Naive vs. Engineered

Most people prompt something like this:

> **Naive prompt:** "Tell me about [competitor product] and how it compares to us."

**What you get:** Something like this:

> *[Competitor] is a leading inference serving platform that offers a comprehensive set of features for deploying large language models. Pros: good performance, active community, supports multiple model formats. Cons: limited enterprise features, documentation could be better. Recommendation: we should differentiate on quality and enterprise readiness.*

No evidence for any claim. "Good performance" compared to what? "Limited enterprise features" means what, specifically? "Differentiate on quality" is advice so generic it could apply to any product in any industry. You cannot use this to win a deal, set a roadmap priority, or explain to your sales team why a customer should pick you.

**This prompt** produces an evidence-grounded analysis that rates each capability as a strength, table stakes, or weak point with citations; identifies specific differentiation opportunities based on real gaps; and assesses whether those gaps are likely to close in the next 12 months. For llm-d competing against another inference serving platform, that means findings like "No native multi-model GPU sharing; requires dedicating entire GPUs to a single model, costing 3-5x more for diverse model portfolios. Our Kubernetes-native approach with GPU scheduling and disaggregated inference directly addresses this gap." The difference: instead of a marketing-flavored comparison, you get an engineering-grade competitive brief that your product and sales teams can actually act on.

## When to use

- Preparing for a product strategy discussion and you need a structured breakdown of a specific competitor's capabilities and positioning.
- Evaluating a new entrant in your space to understand whether it changes your roadmap or positioning.
- Building a competitive positioning deck and you need consistent analysis across multiple products for side-by-side comparison.
- Informing engineering priorities based on gaps and weaknesses in a competitor's offering that you can exploit.
- Preparing for a customer conversation where the competitor has been shortlisted and you need to understand their strengths and weaknesses honestly.
- Responding to a sales team request for competitive intelligence when a deal is at risk.
- Assessing whether an open-source project is a credible alternative to your commercial offering.

## When NOT to use

- You need real-time or exact pricing data. Check the vendor's website or sales materials directly. LLMs may have outdated or approximate figures that could mislead your analysis.
- You need a formal analyst-grade market report with validated revenue numbers, market share data, or investor-facing analysis. Engage an analyst firm for that level of rigor.
- You want a broad technology landscape view across many players. Use the market-landscape prompt instead of running this prompt a dozen times.
- You are analyzing an internal product or system. This prompt is designed for external competitive analysis and the framing will not fit internal assessments.

## Prompt

```
You are a senior product strategist with deep technical expertise in enterprise infrastructure
and developer tools. You combine hands-on engineering knowledge with product strategy thinking.
Your job is to produce a rigorous, evidence-based competitive analysis of a specific product
that an engineering and product leadership team can use to make decisions.

Product: [PRODUCT_NAME]
Vendor: [COMPANY_NAME]
Product Category: [CATEGORY, e.g., "LLM inference serving platform"]
Our Comparable Offering: [OUR_PRODUCT_NAME]
Analysis Date: [DATE, for tracking freshness of the analysis]

Follow these steps carefully:

STEP 1: ESTABLISH THE FACTUAL BASELINE
Before forming opinions, gather and organize what is known. Rely only on publicly available
information: documentation, blog posts, release notes, GitHub repos, conference talks, and
community discussions. Do not speculate. If something is unknown, mark it as "[UNVERIFIED]".

STEP 2: PRODUCE THE STRUCTURED ANALYSIS
Use the following format exactly:

### Product Overview
What does this product do? Who is the primary target user (developer, platform engineer,
data scientist, etc.)? What deployment models does it support (SaaS, self-hosted, hybrid)?
What is the licensing model (open source with commercial support, proprietary, open core)?
Note the current version or most recent significant release.

### Core Technical Capabilities
List the 6-8 most important technical features. For each, provide:
- Feature name and brief description
- Assessment: "Strength" (best-in-class or notably good), "Table stakes" (meets industry
  baseline), or "Weak point" (missing, immature, or notably behind competitors)
- Evidence for your assessment (link to docs, a known limitation, community feedback, etc.)

### Architecture and Integration
- What is the underlying architecture (monolithic, microservices, plugin-based, operator pattern, etc.)?
- What platforms, clouds, or ecosystems does it integrate with natively?
- What APIs, SDKs, or extension points are available for customization?
- How does it handle upgrades and backward compatibility?
- What is the operational complexity for a platform team running this in production?

### Pricing and Licensing
Describe the pricing model (open source, freemium, per-seat, usage-based, enterprise license, etc.).
Note any lock-in risks, hidden costs, or pricing that scales poorly. If pricing is not public,
note that and describe what is known from community reports or sales conversations. Mark any
uncertain pricing data as "[UNVERIFIED]".

### Community and Ecosystem
- How large and active is the community? Cite specific metrics if available (GitHub stars,
  contributors, monthly downloads, Discord/Slack member counts).
- What is the contribution model (open governance, single-vendor controlled, foundation-backed)?
- Is there a meaningful partner ecosystem (integrations, certified operators, consulting firms)?
- How responsive are maintainers to issues and pull requests?

### Strengths (Top 5)
List the top 5 genuine strengths. Be honest and specific. For each strength, explain why
it matters to the target buyer and what evidence supports it. Do not list generic qualities
like "good documentation" unless the documentation is genuinely exceptional and you can
point to why.

### Weaknesses and Gaps (Top 5)
List the top 5 weaknesses or gaps. Focus on things that matter to enterprise buyers and
engineering teams in production. For each weakness, explain the practical impact, not just
the absence of a feature. Consider:
- Operational pain points reported by real users
- Scalability limitations
- Security or compliance gaps
- Missing integrations with common enterprise tools
- Community health and sustainability risks

### Differentiation Opportunities for [OUR_PRODUCT_NAME]
Based on the weaknesses and gaps identified above, where can we credibly differentiate?
For each opportunity:
- State the specific gap or weakness you are exploiting
- Describe what we would need to do (or already do) to capitalize on it
- Assess how defensible this differentiation would be over 12 months
Do not suggest differentiation on dimensions where we are also weak.

### Risk Assessment
What would it take for this competitor to close their gaps? How fast are they shipping?
What recent moves (funding rounds, acquisitions, partnerships, key hires) signal their
strategic direction? What is the risk that they leapfrog our position within 12 months?

STEP 3: SELF-CRITIQUE CHECKLIST
Before finalizing your analysis, verify each of the following:
- [ ] Every "Strength" and "Weakness" is backed by specific evidence, not opinion
- [ ] Pricing information is current and flagged as "[UNVERIFIED]" where uncertain
- [ ] The analysis is fair. You have not downplayed genuine competitor strengths
- [ ] Differentiation opportunities are grounded in real capabilities of [OUR_PRODUCT_NAME]
- [ ] You have flagged all uncertain claims with "[UNVERIFIED]"
- [ ] The analysis avoids marketing language and reads like engineering analysis
- [ ] You have considered the competitor's trajectory, not just their current state

ANTI-PATTERNS TO AVOID:
1. Do not dismiss competitors as inferior without evidence. Respect what they do well.
2. Do not rely on outdated information. If you are uncertain about the current state of a
   feature, say so rather than asserting based on old data.
3. Do not confuse "they do not have feature X" with "feature X is a weakness." It is only
   a weakness if their target users actually need it.
4. Do not list differentiation opportunities that require capabilities you do not have and
   cannot build in a reasonable timeframe.
5. Do not treat GitHub stars or community size as a proxy for product quality.
6. Do not ignore the competitor's roadmap signals (blog posts, conference talks, job postings).
   Today's weakness may be next quarter's feature.
7. Do not write a balanced analysis that avoids making any clear recommendations. The team
   needs your judgment, not just data.

EDGE CASES:
- If the product is open source, analyze both the community edition and any commercial
  offering separately. Note where the commercial version fills gaps the community edition has.
- If the product was recently acquired, note the acquirer, any announced integration plans,
  and the risk that the product's direction changes post-acquisition.
- If the product is very early stage (pre-1.0, limited production deployments), note this
  context and focus on trajectory and team rather than current feature completeness.
- If direct comparison with [OUR_PRODUCT_NAME] is difficult because the products target
  different segments, say so explicitly and reframe the analysis around where they overlap.
- If any bracketed placeholders (e.g., [PRODUCT_NAME], [OUR_PRODUCT_NAME], [CATEGORY])
  are left unfilled, stop and list the missing inputs rather than generating an analysis
  with placeholder values. An analysis that says "Strengths of [PRODUCT_NAME]" is useless.
- If the competitor operates in a domain you have no direct experience with (e.g., analyzing
  a hardware company when your team builds software, or analyzing a biotech platform when
  your background is cloud infrastructure), explicitly state the knowledge boundary. Focus
  the analysis on publicly observable signals (documentation quality, community engagement,
  release cadence, ecosystem integrations) rather than speculating on domain-specific
  technical depth you cannot evaluate. Flag domain-specific claims with "[UNVERIFIED]".
- If public information about the competitor is sparse (stealth-mode startup, limited
  documentation, no public GitHub repo), note this constraint at the top of your analysis.
  Base the assessment on whatever is available (job postings, conference talks, press
  releases, patents) and flag the low-confidence sections explicitly. A short, honest
  analysis is more useful than a long speculative one.

Use only publicly available information. Ground every claim in evidence.
```

## Why This Works

This prompt uses several techniques that compound to produce actionable competitive intelligence rather than a marketing-grade comparison:

- **Persona framing.** "You are a senior product strategist with deep technical expertise" sets the model to think like someone who bridges engineering depth and product strategy. This prevents the output from being either too shallow (marketing-style comparison) or too narrow (pure feature matrix with no strategic context).

- **Evidence grounding.** The "[UNVERIFIED]" flagging mechanism forces the model to distinguish between claims it can support with public evidence and claims it is guessing about. Without this, competitive analyses mix facts with assumptions, which erodes trust and leads to bad decisions.

- **Structured output formatting.** The capability assessment framework (Strength / Table stakes / Weak point) with required evidence forces the model to make and defend judgments rather than listing features neutrally. The Differentiation Opportunities section then builds on the weaknesses with specific, defensibility-assessed recommendations.

- **Anti-pattern avoidance.** Blocking dismissive language, outdated information, and differentiation suggestions that require capabilities you do not have prevents the most common failure modes in competitive analysis. The instruction to respect genuine competitor strengths produces analysis your team will actually trust.

- **Trajectory awareness.** The Risk Assessment section and the instruction to consider roadmap signals (funding, key hires, conference talks) push the model beyond a point-in-time snapshot. Competitive analysis that ignores trajectory is stale by the time you present it.

- **Self-critique checklist.** The verification step catches unsupported claims, unfair framing, and analysis that avoids making clear recommendations. These are the exact problems that make competitive analyses get filed and never referenced again.

These techniques together explain the difference shown in the comparison above: the naive prompt produces a surface-level comparison you could get from the competitor's own website, while this prompt produces an engineering-grade brief that drives real product and sales decisions.

## Usage Tips

- Run this prompt against multiple competitors in the same category, then compare the outputs side by side to spot patterns in the market. Common gaps across competitors represent the strongest differentiation opportunities.
- Pair with a web search tool or provide recent product announcements, changelogs, GitHub release notes, and documentation links for the most current results. The model's training data has a cutoff, so recent developments need to be fed in explicitly.
- The "Differentiation Opportunities" section is only useful if you fill in `[OUR_PRODUCT_NAME]` accurately. Provide a brief description of your product's current capabilities alongside the name so the model can ground its recommendations.
- Refresh the analysis quarterly or whenever the competitor ships a major release. Competitive landscapes shift fast and stale analysis is worse than no analysis.
- Share the "Strengths" section with your engineering team honestly. Understanding what a competitor does well is as valuable as knowing their weaknesses.
- Use the "[UNVERIFIED]" flags as action items. Assign someone to verify each flagged claim before the analysis informs any real decisions.
- For open-source competitors, supplement this analysis by actually deploying and testing the product. No amount of documentation review replaces hands-on experience.
- **Slash command connection:** If you use `ai-bu-claude-commands`, the `/competitive-snapshot` slash command provides a lighter-weight version for quick competitor questions in meetings.

## Example Output

> ### Core Technical Capabilities
> | Capability | Assessment | Evidence |
> |---|---|---|
> | Multi-GPU serving with tensor parallelism | Strength | Supports up to 8-way TP out of the box; documented in production at 4-GPU configs by multiple adopters |
> | Dynamic batching and continuous batching | Table stakes | Implemented since v0.2; comparable to other major serving engines |
> | Quantization support (GPTQ, AWQ, FP8) | Strength | Broadest quantization format support among open-source engines; FP8 added in v0.4 |
> | Multi-model serving on shared infrastructure | Weak point | No native support; requires separate deployments per model, wasting resources during low-traffic periods |
> | Kubernetes-native deployment | Table stakes | Helm charts available; no native operator; community-maintained configs vary in quality |
> | Built-in observability and metrics | Weak point | Limited to basic Prometheus metrics; no tracing, no request-level latency breakdowns, no OpenTelemetry integration |
> | LoRA adapter hot-swapping | Strength | Supports loading and unloading LoRA adapters without restarting the engine; unique among open-source options |
> | Disaggregated prefill/decode | Weak point | On roadmap but not yet implemented; competitor X has shipped this in production [UNVERIFIED] |
>
> ### Weaknesses and Gaps
> 1. **No multi-model GPU sharing**: Requires dedicating entire GPUs to a single model. For teams serving 10+ small models, this means 10+ GPU allocations even if total utilization is under 20%. Practical impact: 3-5x higher infrastructure cost for diverse model portfolios.
> 2. **Minimal observability**: Basic Prometheus metrics only. No built-in tracing, no request-level latency breakdowns, no OpenTelemetry integration. Platform teams report spending significant time building custom observability tooling around it.
> 3. **Documentation assumes expert users**: Getting-started guides jump directly to advanced configurations. Community reports that onboarding new operators takes 2-3x longer than competing projects with better progressive documentation.
> 4. **No native multi-tenancy**: All requests share the same priority and resource pool. Enterprise teams serving multiple internal customers lack isolation, rate limiting, and cost attribution per tenant.
> 5. **Single-vendor governance risk**: Controlled by a single VC-backed company with no foundation backing. Contribution acceptance is opaque and major architectural decisions happen internally before community input.
>
> ### Differentiation Opportunities for [OUR_PRODUCT_NAME]
> 1. **Multi-model serving with GPU sharing**: Their users are vocal about this gap. If we ship reliable multi-model serving with resource isolation, we address a top-3 user complaint. Defensibility: medium, since they will eventually build this, but we can establish best practices and community tooling first.
> 2. **Enterprise observability out of the box**: OpenTelemetry integration, request-level tracing, and per-tenant cost attribution would immediately differentiate us with platform teams. Defensibility: high, as observability is a product surface area they have consistently deprioritized.
