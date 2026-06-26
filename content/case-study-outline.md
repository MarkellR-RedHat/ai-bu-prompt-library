# Case Study Outline

Structure a customer case study from raw notes into a clear narrative that shows the problem, solution, and measurable results.

**Difficulty:** Intermediate

## When to use

- Turning customer interview notes into a structured case study
- Building a reference story for sales or marketing
- Documenting an internal success story for leadership
- Preparing a customer spotlight for a conference talk

## When NOT to use

- You need a full written case study (use this outline as input, then draft each section)
- The customer has not approved sharing their story (get approval first)
- The results are not yet measurable (wait until you have concrete data)

## Prompt

```
You are a technical writer at an enterprise software company. Create a structured outline for a customer case study using the raw notes below.

Customer: [CUSTOMER_NAME_OR_ANONYMOUS_LABEL]
Industry: [INDUSTRY]
Product used: [PRODUCT_NAME]
Your role: [YOUR_RELATIONSHIP, e.g., solutions architect, account engineer, support engineer]

Structure the outline as follows:

1. **Title**: A concise, results-focused headline. Lead with the outcome, not the product name.
2. **Customer snapshot** (2-3 bullets): Who the customer is, their scale, and what they do. Keep it brief.
3. **Challenge**: What problem was the customer facing? Be specific about the business or technical pain. Include any metrics that quantify the problem (downtime, cost, manual effort).
4. **Why they chose [PRODUCT_NAME]**: What alternatives did they evaluate? What criteria mattered most? Why did they pick this solution?
5. **Solution**: How was the product deployed? What architecture or configuration did they use? Include enough technical detail for an engineer to understand the approach.
6. **Results**: Quantified outcomes. Use before/after comparisons where possible. Include at least 2-3 specific metrics (latency reduction, cost savings, time saved, reliability improvement).
7. **Key quote**: Suggest a pull quote from the customer (or a placeholder for one) that captures the most compelling result in their words.
8. **What is next**: What is the customer planning to do next with the product? Expansion, new use cases, deeper integration?

Constraints:
- Be specific. Vague outcomes like "improved performance" are not useful. Push for numbers.
- If the raw notes are missing data for a section, flag it with [NEEDS DATA] so the writer knows to follow up.
- Do not use em dashes. Use commas, periods, or "and" instead.

Raw notes:
[PASTE_RAW_NOTES_HERE]
```

## Usage Tips

- Paste raw notes from customer calls, emails, or Slack conversations. The messier the input, the more value you get from the structure.
- If the customer is anonymous, use a label like "Large financial services company" instead of the real name.
- After generating the outline, schedule a follow-up call with the customer to fill in any [NEEDS DATA] gaps.
- Pair this with the exec-brief prompt if you need a short version for leadership.

## Example Output Snippet

> **Title:** How a Fortune 500 retailer cut inference costs by 60% with llm-d on OpenShift
>
> **Customer snapshot**
> - Fortune 500 retailer with 2,000+ stores and a growing AI/ML platform team
> - Running 15+ LLMs for product recommendations, search, and customer support
> - Previous infrastructure: self-managed vLLM on bare-metal GPU servers
>
> **Challenge**
> The team was spending $2.4M/year on GPU infrastructure but only utilizing 40% of capacity. Each model required dedicated GPU allocation, and scaling up for peak traffic meant over-provisioning by 3x. Deployments took 2-3 days due to manual configuration.
>
> **Results**
> - GPU utilization increased from 40% to 82%
> - Inference costs reduced by 60% ($2.4M to $960K annually)
> - Model deployment time reduced from 2-3 days to 45 minutes
