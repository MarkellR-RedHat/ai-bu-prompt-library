# Competitive Product Analysis

A prompt for producing a structured, evidence-based analysis of a competitor's product to inform positioning and engineering decisions.

## Prompt

```
You are a senior product strategist with deep technical expertise. Conduct a competitive analysis of the following product.

Product: [PRODUCT_NAME]
Vendor: [COMPANY_NAME]
Product Category: [CATEGORY, e.g., "LLM inference serving platform"]
Our Comparable Offering: [OUR_PRODUCT_NAME]

Structure your analysis as follows:

1. **Product Overview**: What does this product do? Who is the target user? What deployment models does it support (SaaS, self-hosted, hybrid)?

2. **Core Technical Capabilities**: List the 5-8 most important technical features. For each, note whether it is a known strength, table stakes, or a weak point based on available information.

3. **Architecture and Integration**:
   - What is the underlying architecture (monolithic, microservices, plugin-based, etc.)?
   - What platforms, clouds, or ecosystems does it integrate with?
   - What APIs, SDKs, or extension points are available?

4. **Pricing and Licensing**: Describe the pricing model (open source, freemium, per-seat, usage-based, etc.). Note any lock-in risks or hidden costs.

5. **Community and Ecosystem**: How large and active is the community? What is the contribution model? Is there a meaningful partner ecosystem?

6. **Strengths**: List the top 3-5 genuine strengths. Be honest and specific.

7. **Weaknesses and Gaps**: List the top 3-5 weaknesses or gaps. Focus on things that matter to enterprise buyers and engineering teams.

8. **Differentiation Opportunities for [OUR_PRODUCT_NAME]**: Based on the gaps above, where can we credibly differentiate? Be specific about features, positioning, or go-to-market angles.

Use only publicly available information. Flag any claims you are uncertain about. Do not speculate beyond what the evidence supports.
```

## Usage Tips

- Run this prompt against multiple competitors in the same category, then compare the outputs side by side to spot patterns.
- Pair with a web search tool or provide recent product announcements, changelogs, and documentation links for the most current results.
- The "Differentiation Opportunities" section is only useful if you fill in `[OUR_PRODUCT_NAME]` accurately. Generic placeholders produce generic advice.
- Refresh the analysis quarterly or whenever the competitor ships a major release. Competitive landscapes shift fast.

## Example Output Snippet

> **Core Technical Capabilities**:
> | Capability | Assessment |
> |---|---|
> | Multi-GPU serving with tensor parallelism | Strength |
> | Dynamic batching and continuous batching | Table stakes |
> | Quantization support (GPTQ, AWQ, FP8) | Strength |
> | Multi-model serving on shared infrastructure | Weak point |
> | Kubernetes-native deployment | Table stakes |
> | Built-in observability and metrics | Weak point |
>
> **Weaknesses and Gaps**:
> 1. No native support for serving multiple models on the same GPU cluster, requiring separate deployments and wasting resources during low-traffic periods.
> 2. Observability is limited to basic Prometheus metrics. No built-in tracing, no request-level latency breakdowns, and no integration with OpenTelemetry out of the box.
> 3. Documentation assumes deep familiarity with the codebase. Onboarding for new operators takes significantly longer than competing projects...
