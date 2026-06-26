# Case Study Outline

Transform raw customer notes, call transcripts, and scattered data points into a publication-ready case study outline with quantified results and a clear narrative arc.

**Difficulty:** Intermediate

## When to use

- Turning messy customer interview notes or call transcripts into a structured case study outline
- Building a reference story for sales enablement, marketing campaigns, or analyst briefings
- Documenting an internal success story for leadership review or quarterly business reports
- Preparing a customer spotlight for a conference talk, webinar, or blog post
- Consolidating information from multiple sources (emails, Slack threads, support tickets, meeting notes) into one coherent narrative
- Creating a draft outline to share with the customer for their review and approval before writing the full case study
- Onboarding a new writer or marketer who needs to understand the story structure before drafting

## When NOT to use

- You need a fully written, polished case study (use this outline as input, then draft each section separately)
- The customer has not approved sharing their story publicly (get explicit written approval first)
- The results are not yet measurable or the deployment is too early to show impact (wait until you have concrete data)
- You are writing a product datasheet or feature comparison (use a product marketing template instead)

## Prompt

```
You are a senior technical writer at an enterprise infrastructure company. You specialize in
writing customer case studies that are specific, honest, and grounded in measurable outcomes.
Your audience includes engineering leaders, procurement teams, and technical practitioners who
are evaluating solutions. They are skeptical of vague marketing language and respond to concrete
evidence.

Your task: create a structured, publication-ready outline for a customer case study using the
raw notes provided below.

== CONTEXT (fill these in before running) ==

Customer: [CUSTOMER_NAME_OR_ANONYMOUS_LABEL]
Industry: [INDUSTRY, e.g., financial services, healthcare, retail, telecommunications]
Product used: [PRODUCT_NAME]
Deployment environment: [ENVIRONMENT, e.g., on-prem OpenShift, AWS, Azure, hybrid cloud]
Your role: [YOUR_RELATIONSHIP, e.g., solutions architect, account engineer, support engineer]
Engagement duration: [HOW_LONG, e.g., 6 months, 1 year]

== STEP-BY-STEP REASONING INSTRUCTIONS ==

Before writing the outline, work through these steps internally. Do not skip any step.

Step 1 - Extract and categorize raw data
  Read all the raw notes carefully. Pull out every fact, metric, quote, and technical detail.
  Sort them into categories: customer background, problem/pain points, evaluation process,
  solution architecture, quantified results, and future plans. If a fact does not fit any
  category, note it separately for possible inclusion.

Step 2 - Identify the narrative arc
  Every strong case study follows a clear arc: situation, complication, resolution, result.
  Determine the single most compelling transformation. What changed, and why does it matter?
  The narrative should make a skeptical engineering leader think, "That is relevant to my
  problem."

Step 3 - Validate the metrics
  For every metric you plan to include, check whether the raw notes provide the source,
  the baseline (before), and the result (after). If any metric lacks a clear before/after
  comparison or a credible source, flag it with [NEEDS VALIDATION] rather than presenting
  it as fact.

Step 4 - Check for gaps
  Review each section of the outline structure below. If the raw notes do not contain
  enough information to fill a section with specific, useful content, mark the gap with
  [NEEDS DATA: brief description of what is missing] so the writer knows exactly what
  to follow up on.

Step 5 - Draft the outline
  Write the outline following the structure below. Be direct. Use plain language. Write
  for engineers, not for a press release.

== OUTLINE STRUCTURE ==

1. **Title**
   A concise, results-focused headline (under 15 words). Lead with the outcome or
   transformation, not the product name. Format: "How [CUSTOMER] achieved [RESULT]
   with [PRODUCT]" or a variation that puts the result first.

2. **Executive summary** (3-4 sentences)
   The entire story in a short paragraph. A reader who only sees this section should
   understand the problem, what was done, and the key result. Include one headline metric.

3. **Customer snapshot** (3-4 bullets)
   Who the customer is, their scale (revenue range, employee count, user base), their
   industry, and what they do. Keep it factual. No superlatives.

4. **Challenge**
   What specific problem was the customer facing? Describe the business or technical pain
   in concrete terms. Include metrics that quantify the problem: downtime hours, cost
   overruns, manual effort in person-hours, latency percentiles, error rates. Explain why
   the status quo was unsustainable.

5. **Evaluation and selection**
   What alternatives did the customer evaluate? What criteria mattered most (performance,
   cost, support, ecosystem compatibility, security, compliance)? Why did they choose
   this solution over the alternatives? Be honest about trade-offs if they exist.

6. **Solution architecture**
   How was the product deployed? Describe the architecture, configuration, and integration
   points. Include enough technical detail that an engineer could understand the approach
   and assess whether it applies to their environment. Mention cluster sizes, model counts,
   hardware specs, or network topology where relevant.

7. **Implementation timeline**
   Break the deployment into phases if applicable. Note key milestones, any unexpected
   challenges during rollout, and how they were resolved. Include time durations for
   each phase.

8. **Results**
   Quantified outcomes only. Use before/after comparisons for every metric. Include at
   least 3 specific, measurable results. Good categories: latency reduction, cost savings,
   time saved, reliability improvement (uptime percentage), resource utilization, deployment
   velocity, and error rate reduction.

   Format each result as:
   - [METRIC]: [BEFORE] -> [AFTER] ([PERCENTAGE OR ABSOLUTE CHANGE])

9. **Key quote**
   Suggest a pull quote from the customer (or write a placeholder marked [DRAFT QUOTE])
   that captures the single most compelling result in their own words. The quote should be
   specific, not generic praise. Bad: "We love the product." Good: "We went from three-day
   deployments to 45 minutes, and our team finally stopped dreading release week."

10. **Lessons learned** (2-3 bullets)
    What would the customer do differently? What surprised them? What advice would they
    give to someone starting a similar project?

11. **What is next**
    What is the customer planning to do next with the product? Expansion to new teams,
    new use cases, deeper integration, contribution to upstream open source?

== SELF-CRITIQUE CHECKLIST ==

Before presenting your final outline, review it against every item below. Fix any issues
you find before returning the output.

- [ ] Every metric has a before/after comparison or is flagged with [NEEDS VALIDATION]
- [ ] The title leads with outcomes, not the product name
- [ ] The challenge section explains WHY the problem mattered, not just what it was
- [ ] The solution section has enough technical detail for an engineer to assess relevance
- [ ] No section relies on vague language ("improved performance", "better efficiency",
      "significant savings") without backing it up with a number
- [ ] Every gap in the raw notes is flagged with [NEEDS DATA] and a specific description
      of what is missing
- [ ] The narrative arc is clear: problem, evaluation, solution, result
- [ ] The key quote sounds like a real person, not a marketing blurb
- [ ] The outline does not oversell or exaggerate. If something is unclear, say so.
- [ ] No em dashes appear anywhere. Use commas, periods, semicolons, colons, or "and" instead.

== ANTI-PATTERNS TO AVOID ==

1. Vague outcomes. Never write "improved performance" or "reduced costs" without a specific
   number attached. If you do not have the number, write [NEEDS DATA] instead.

2. Product-first narrative. The story is about the customer's transformation, not about the
   product's features. The product is the tool, not the hero.

3. Jargon without context. If you use a technical term (e.g., "LoRA adapters", "KV cache
   routing", "prefill disaggregation"), include a brief parenthetical explanation or ensure
   the surrounding context makes the meaning clear.

4. Missing the "why." Every challenge section must explain why the problem mattered to the
   business, not just describe the technical symptom. "High latency" is a symptom.
   "High latency causing 12% cart abandonment" is a business problem.

5. Generic quotes. Placeholder quotes like "The product exceeded our expectations" add
   nothing. Write quotes that reference specific results or experiences.

6. Ignoring failure or difficulty. If the deployment hit a snag, include it. Honest case
   studies are more credible than perfect ones.

7. Burying the lead. The single most impressive result should appear in the title, the
   executive summary, and the results section. Do not make the reader hunt for it.

== EDGE CASE HANDLING ==

- If the customer must remain anonymous: use a descriptive label like "a Fortune 500
  financial services firm" and remove any details that could identify them (unique product
  names, geographic specifics, exact employee counts). Round metrics to avoid fingerprinting.

- If the deployment is ongoing and final results are not available: clearly label the
  outline as "Preliminary" in the title, report interim results with the measurement date,
  and note which metrics are expected to change.

- If the raw notes are from multiple sources with conflicting data: flag the conflict
  explicitly with [CONFLICTING DATA: source A says X, source B says Y] and recommend
  which source to verify.

- If the customer used multiple products: focus the case study on the primary product
  and mention others only in the context of integration. Do not try to cover everything.

- If results are qualitative rather than quantitative (e.g., "the team is happier"):
  include them in a separate "Qualitative outcomes" subsection but push for any proxy
  metrics (reduced on-call pages, fewer escalations, lower attrition).

- If the raw notes are extremely sparse (fewer than 5 substantive data points): flag this
  at the top of your output with a warning that the outline will be mostly [NEEDS DATA]
  placeholders, and list the specific questions to ask in a follow-up conversation.

== RAW NOTES ==

[PASTE_RAW_NOTES_HERE]
```

## Usage Tips

- Paste raw notes from customer calls, emails, Slack threads, or support tickets. The messier and more scattered the input, the more value you get from the structured output.
- If you have notes from multiple conversations, paste them all together with a separator line between each source. The prompt handles consolidation.
- If the customer is anonymous, replace identifiable details in your raw notes before pasting. The prompt will also scrub, but defense in depth matters.
- After generating the outline, schedule a follow-up call with the customer to fill in every [NEEDS DATA] and [NEEDS VALIDATION] gap before drafting.
- Pair this with an executive brief prompt if you need a one-page version for leadership or a short version for analyst briefings.
- Run the prompt twice with the same notes and compare the outputs. Differences between runs often highlight areas where the notes are ambiguous and need clarification.
- Share the generated outline with the customer contact for accuracy review before investing time in a full draft. This catches errors early and builds trust.
- Keep a running document of resolved [NEEDS DATA] items across case studies. Patterns in missing data reveal gaps in your customer interview process that you can fix upstream.

## Example Output

> **Title:** How a Fortune 500 retailer cut inference costs by 60% with llm-d on OpenShift AI
>
> **Executive summary**
> A Fortune 500 retailer running 15+ large language models for product recommendations, search, and customer support was spending $2.4M annually on GPU infrastructure while utilizing only 40% of capacity. After deploying llm-d on OpenShift AI, the team increased GPU utilization to 82%, reduced inference costs by 60%, and cut model deployment time from 2-3 days to 45 minutes.
>
> **Customer snapshot**
> - Fortune 500 retailer with 2,000+ stores and $48B in annual revenue
> - AI/ML platform team of 22 engineers supporting 6 business units
> - Running 15+ LLMs for product recommendations, search ranking, and customer support automation
> - Previous infrastructure: self-managed vLLM instances on bare-metal GPU servers across two data centers
>
> **Challenge**
> The platform team was spending $2.4M/year on GPU infrastructure but utilizing only 40% of available capacity. Each model required a dedicated GPU allocation because the existing serving layer could not share GPUs across models safely. Scaling for peak traffic (Black Friday, holiday season) required over-provisioning by 3x for two months of the year, with that capacity sitting idle the rest of the time. New model deployments took 2-3 days due to manual configuration of networking, storage, and GPU affinity rules. The team was also losing roughly 6 hours per week to debugging inference failures caused by mismatched CUDA driver versions across nodes.
>
> **Evaluation and selection**
> The team evaluated three options: upgrading their existing vLLM setup with custom autoscaling scripts, adopting a managed inference service from their cloud provider, and deploying llm-d on OpenShift AI. The managed service was ruled out due to data residency requirements and the per-token pricing model, which projected higher costs at their query volume. The custom vLLM upgrade was prototyped but abandoned after two months because the engineering effort to build reliable multi-model GPU sharing exceeded the team's capacity. llm-d was selected because it provided KV cache-aware routing and prefix-aware scheduling natively, ran on their existing OpenShift clusters, and did not require sending data off-premises.
>
> **Solution architecture**
> The team deployed llm-d on a 3-node OpenShift AI cluster, each node equipped with 8x NVIDIA A100 80GB GPUs. The architecture uses disaggregated prefill and decode, with dedicated prefill workers handling prompt processing and decode workers handling token generation. KV cache-aware routing ensures that repeated prompts (common in product recommendation queries) hit cached prefill results. Models are packaged as container images and deployed through the standard OpenShift CI/CD pipeline. A Prometheus and Grafana stack provides real-time observability into per-model latency, throughput, and GPU memory utilization.
>
> **Implementation timeline**
> - Weeks 1-2: Cluster provisioning and GPU driver standardization across all nodes
> - Weeks 3-4: Migration of the three highest-traffic models (product recommendations, search ranking, customer support chatbot)
> - Weeks 5-6: Migration of remaining 12 models and decommissioning of legacy bare-metal servers
> - Week 7: Performance tuning, including adjustment of KV cache size and prefill worker ratios
> - Week 8: Production cutover with traffic gradually shifted from legacy to new infrastructure over 5 days
>
> **Results**
> - GPU utilization: 40% -> 82% (+105% improvement)
> - Annual inference infrastructure cost: $2.4M -> $960K (60% reduction)
> - Model deployment time: 2-3 days -> 45 minutes (96% reduction)
> - P99 inference latency for product recommendations: 320ms -> 180ms (44% reduction)
> - Engineering hours spent on inference debugging: 6 hours/week -> under 1 hour/week (83% reduction)
> - Peak season over-provisioning factor: 3x -> 1.4x (53% reduction)
>
> **Key quote**
> "We went from mass texting the on-call channel every time a model deployment failed to just clicking a button in our CI pipeline. Our engineers actually volunteer for the inference on-call rotation now, which tells you everything."
> [DRAFT QUOTE, pending customer review]
>
> **Lessons learned**
> - Standardizing GPU drivers and CUDA versions across all nodes before migration saved significant debugging time later. The team wished they had done this first instead of in parallel with model migration.
> - Starting with the three highest-traffic models, rather than low-risk ones, was counterintuitive but meant the biggest cost savings were realized in the first month, which secured continued executive support for the project.
> - The team underestimated how much time they would spend tuning KV cache sizes. They recommend allocating a full sprint for performance tuning after migration.
>
> **What is next**
> The team plans to expand llm-d to serve their computer vision models for in-store inventory scanning by Q3. They are also evaluating LoRA adapter hot-swapping to support per-region model personalization without deploying separate model instances for each geography. Two engineers from the platform team have begun contributing upstream to the llm-d project, focusing on improved metrics export for their Grafana dashboards.
