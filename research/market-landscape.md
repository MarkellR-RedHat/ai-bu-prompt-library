# Technology Landscape Mapper

A prompt for mapping out the players, trends, and dynamics in a technology area to support strategic planning, investment decisions, and competitive positioning.

**Difficulty:** Advanced

## Naive vs. Engineered

Most people prompt something like this:

> **Naive prompt:** "What are the main players in [technology area]?"

**What you get:** Something like this:

> *The Kubernetes-native LLM inference space has several key players. vLLM is an open-source inference engine with high performance. TensorRT-LLM is NVIDIA's optimized solution. KServe provides model serving on Kubernetes. Ray Serve offers distributed serving capabilities. TGI is Hugging Face's inference solution. The market is growing rapidly with increasing interest from enterprises.*

A list you could build from 10 minutes of Googling. No segmentation between inference engines, serving platforms, and gateway/routing layers. No trend analysis. No assessment of which gaps matter. No recommendation on what your team should actually build, watch, or ignore.

**This prompt** produces a segmented landscape map with maturity assessments, technology trends with adoption timelines, specific gaps and unmet needs scored by practitioner pain level, and actionable recommendations for your organization. For Red Hat AI building llm-d, that means recommendations like "Invest in multi-model serving with GPU sharing and isolation, since this is the highest-pain unmet need and aligns directly with our Kubernetes-native, OpenShift-integrated approach. Watch the gateway/routing segment but do not build our own; integrate with LiteLLM and Kong instead." The difference: instead of a directory of names, you get a strategic terrain map that tells your leadership team where to invest, what to watch, and which threats require a near-term response.

## When to use

- Planning a new product or feature investment and you need to understand who else is building in the space and where the gaps are.
- Preparing a strategy presentation for leadership that requires a clear view of the competitive and technical terrain.
- Onboarding onto an unfamiliar technology area and you need a structured orientation to the key players, trends, and dynamics.
- Identifying partnership or acquisition targets by mapping where gaps exist and who is filling them.
- Evaluating whether to build, buy, or integrate when entering a new technology segment.
- Conducting a quarterly strategic review to track how the landscape has shifted since your last assessment.
- Preparing for a conference or customer advisory board where you need to speak credibly about the broader ecosystem.

## When NOT to use

- You need a narrow competitive analysis of a single product. Use the competitive-analysis prompt instead, which goes deeper on one player.
- You need validated market sizing with revenue numbers, TAM/SAM/SOM breakdowns, or investor-grade financial data. Engage an analyst firm for that level of rigor.
- The technology area is so new that fewer than 3-4 projects exist. A landscape map is not useful when there is no landscape yet; instead, write a technology assessment focused on the emerging approach.
- You need to make a specific vendor selection decision. Landscape maps show the terrain, not which path to take. Follow up with the competitive-analysis prompt for shortlisted options.

## Prompt

```
You are a technology analyst with deep expertise in enterprise infrastructure, cloud-native
systems, and developer platforms. Your job is to produce a structured landscape map of a
technology area that a product and engineering leadership team can use for strategic planning.

Technology Area: [TECHNOLOGY_AREA, e.g., "Kubernetes-native LLM inference"]
Scope: [SCOPE, e.g., "open source and commercial projects targeting production deployments"]
Time Horizon: [TIME_HORIZON, e.g., "current state plus 12-month outlook"]
Our Position: [ORGANIZATION_OR_PROJECT, e.g., "Red Hat AI, building llm-d"]

Follow these steps carefully:

STEP 1: ESTABLISH THE LANDSCAPE BOUNDARIES
Before mapping, define what is in scope and what is out of scope for this landscape.
Technology areas often have blurry boundaries. State explicitly which adjacent areas you
are including and which you are excluding, and why. This prevents the landscape from
becoming an unfocused list of everything remotely related.

STEP 2: PRODUCE THE STRUCTURED LANDSCAPE MAP
Use the following format exactly:

### Landscape Overview (4-6 sentences)
What is this technology area? Why does it matter now? What is the primary driver of adoption
(cost pressure, performance requirements, regulatory changes, new capabilities)?
What stage is this market in (emerging, growth, consolidation, mature)?

### Scope and Boundaries
State what this landscape includes and excludes. Name 2-3 adjacent technology areas that
are explicitly out of scope and explain why you drew the line there.

### Market Segments
Break the landscape into 3-6 distinct segments or categories. For each segment:
- Segment name and one-sentence definition
- What differentiates this segment from others
- Key players (3-5 per segment)
- Maturity assessment: emerging, growing, or consolidating
- Brief note on competitive dynamics within the segment

Present this as a table for easy scanning.

### Key Players (Top 10-15)
For each major project or product, provide:
- Name and vendor (or maintainer for open source projects)
- One-line description of what it does
- Maturity level: early stage, growth, or mature
- Licensing model: open source, open core, proprietary, etc.
- Notable adopters or production deployments, if known
- Key differentiator: the one thing that sets it apart
- Recent momentum signals: funding, releases, adoption announcements, key hires

### Technology Trends (4-6)
Identify the most important technical trends shaping this space. For each trend:
- What is changing and why
- Which players are leading this trend
- What is the timeline for mainstream adoption
- What does this mean for practitioners and platform teams

### Adoption Patterns
Who is adopting this technology today? Break this down by:
- Organization profile (hyperscalers, large enterprises, mid-market, startups)
- Use case patterns (what problems drive initial adoption)
- Common entry points and landing zones
- Typical adoption path from evaluation to production
- Barriers to adoption that slow or block progress

### Gaps and Unmet Needs (5-7)
What problems remain unsolved or underserved? For each gap:
- Describe the unmet need specifically
- Explain the current workaround (if any)
- Assess how painful this gap is for practitioners (low, medium, high)
- Note whether any player is actively working to close it

These gaps represent opportunities for new products, features, or open-source contributions.

### Consolidation and Fragmentation Dynamics
Which segments are consolidating (fewer players, standards emerging, winner-take-most dynamics)?
Which segments are fragmenting (new entrants, no clear standard, user confusion)?
What forces are driving each direction?

### Outlook ([TIME_HORIZON])
Based on current trajectory, what will this landscape look like in [TIME_HORIZON]?
For each prediction:
- State the prediction clearly
- Explain the evidence supporting it
- Assign a confidence level: high, medium, or low
- Note what would invalidate this prediction

### Implications for [ORGANIZATION_OR_PROJECT]
Given this landscape, provide specific, actionable recommendations:
1. What should we invest in or accelerate?
2. What should we watch but not act on yet?
3. What partnerships or integrations should we pursue?
4. What competitive threats require a response in the next quarter?
5. Where can we contribute to open-source projects to shape the landscape in our favor?

STEP 3: SELF-CRITIQUE CHECKLIST
Before finalizing your landscape map, verify each of the following:
- [ ] The landscape boundaries are clearly defined and justified
- [ ] Every player listed is real and correctly categorized
- [ ] Segments are mutually exclusive and collectively exhaustive for the defined scope
- [ ] Trends are grounded in observable evidence, not hype cycles
- [ ] Gaps reflect real practitioner pain, not theoretical feature wishlists
- [ ] The outlook section includes confidence levels and falsification criteria
- [ ] Implications are specific to [ORGANIZATION_OR_PROJECT], not generic strategy advice
- [ ] You have flagged any uncertain claims with "[UNVERIFIED]"

ANTI-PATTERNS TO AVOID:
1. Do not list every project you can think of. A landscape map with 40 players is a
   directory, not an analysis. Focus on the 10-15 that matter most.
2. Do not treat all segments as equally important. Call out which segments are most
   relevant to the reader and why.
3. Do not confuse activity with maturity. A project with frequent commits and lots of
   GitHub stars may still be pre-production quality.
4. Do not describe trends using hype language ("revolutionary", "game-changing",
   "paradigm shift"). Describe what is actually changing in measurable terms.
5. Do not write an outlook that hedges everything. Make clear predictions and defend them.
   Being wrong with reasoning is more useful than being vague.
6. Do not ignore open-source projects when mapping a commercial landscape, or vice versa.
   Enterprise buyers evaluate both.
7. Do not assume the current landscape structure is stable. Explicitly consider how
   segments might merge, split, or disappear.

EDGE CASES:
- If the technology area is very new (less than 2 years old), focus the analysis on
  trajectories and team strengths rather than current feature sets. Early markets are
  won by teams, not features.
- If a major player has been acquired or is in the process of being acquired, note the
  acquirer, expected integration timeline, and the risk that the product's direction
  changes significantly post-acquisition.
- If there is an active standards effort (CNCF project, IETF draft, industry working group),
  describe its status and which players are participating. Standards shape landscapes
  more than features do.
- If the landscape spans both infrastructure and application layers, structure the
  segments along this axis so readers can orient themselves vertically.
- If you are uncertain whether a project is still actively maintained, check for
  recent commits, issue responses, and release cadence. Flag abandoned or stalled
  projects explicitly.

Be specific. Name projects, cite version numbers where relevant, and ground claims in
observable evidence. If you are uncertain about a data point, say so.
```

## Why This Works

This prompt uses several techniques that compound to produce a strategic landscape map rather than a flat list of players:

- **Persona framing.** "You are a technology analyst with deep expertise in enterprise infrastructure, cloud-native systems, and developer platforms" sets the model to analyze like someone who understands how enterprise technology markets evolve. This shifts the output from a directory of names to a structured analysis of competitive dynamics.

- **Chain-of-thought decomposition.** Step 1 forces the model to define scope boundaries before mapping. This is critical because technology landscapes have blurry edges, and without explicit boundaries, the model produces unfocused lists that mix relevant and irrelevant players.

- **Structured output formatting.** The format demands segmentation (not just listing), maturity assessments, trend analysis with timelines, gap scoring by pain level, and consolidation dynamics. Each section forces a different type of analysis. A flat list tells you who is in the space; this structure tells you how the space works.

- **Falsifiable predictions.** The outlook section requires confidence levels and conditions that would invalidate each prediction. This forces the model to make real claims rather than hedging everything with "it depends." Hedged predictions are useless for strategic planning.

- **Anti-pattern avoidance.** Blocking hype language ("revolutionary," "game-changing"), listing every project that exists, and confusing GitHub activity with production maturity prevents the most common ways landscape analyses mislead leadership teams.

- **Self-critique checklist.** The verification step catches segments that overlap, trends without evidence, and implications that are generic strategy advice rather than specific recommendations for your organization.

These techniques together explain the difference shown in the comparison above: the naive prompt produces a list you could build from a conference expo hall, while this prompt produces a strategic map that tells you where to invest and what to ignore.

## Usage Tips

- Adjust the `[SCOPE]` placeholder to control breadth. A narrow scope like "open source only, Kubernetes-native, targeting production deployments" produces a more focused and useful map than a broad scope like "all AI infrastructure."
- The `[TIME_HORIZON]` placeholder shapes the outlook section. Use "6 months" for tactical planning, "12 months" for roadmap decisions, and "18-24 months" for strategic bets.
- Feed recent conference talks, blog posts, funding announcements, and CNCF project updates into the context alongside this prompt to get the most current picture. The model's training data has a cutoff date.
- Use the output as a starting point for a team discussion, not as a finished deliverable. The real value comes from debating the gaps and implications sections with your team.
- Run this prompt quarterly with the same scope parameters to track how the landscape evolves. Compare the outputs to identify new entrants, exits, and shifts in competitive dynamics.
- Cross-reference the "Gaps and Unmet Needs" section with your product roadmap. Gaps that align with your existing capabilities or planned features are the highest-value opportunities.
- Share the landscape map with your sales and solutions engineering teams. They encounter competitive dynamics daily and can validate or challenge the analysis with field experience.

## Example Output

> ### Market Segments
>
> | Segment | Description | Key Players | Maturity |
> |---|---|---|---|
> | Inference Engines | Core runtime for executing model forward passes efficiently on GPU hardware | vLLM, TensorRT-LLM, TGI, llama.cpp, SGLang | Growing |
> | Serving Platforms | Orchestration layer managing model routing, scaling, scheduling, and multi-tenancy | KServe, Triton Inference Server, Ray Serve, llm-d | Growing |
> | Gateway and Routing | API gateways purpose-built for LLM traffic with model-aware routing and policy enforcement | LiteLLM, Portkey, Kong AI Gateway | Emerging |
> | Optimization Tooling | Tools for quantization, distillation, and compilation that reduce serving cost and latency | GPTQ, AutoAWQ, TensorRT Model Optimizer, llm-compressor | Growing |
> | Orchestration Frameworks | Frameworks for building multi-step LLM applications with tool use, RAG, and agent patterns | LangChain, LlamaIndex, Semantic Kernel, CrewAI | Consolidating |
>
> ### Gaps and Unmet Needs
> 1. **Multi-model GPU sharing with strong isolation**: Most platforms require dedicating entire GPUs to a single model, which wastes capacity for smaller or bursty workloads. Current workaround: over-provisioning GPUs and accepting low utilization. Pain level: high.
> 2. **Request-level cost attribution**: Teams serving multiple internal customers from shared infrastructure lack tooling to accurately charge back usage per team or application. Current workaround: proportional allocation based on request counts, which ignores token length and model size. Pain level: medium.
> 3. **Standardized benchmarking across inference engines**: Each project publishes its own benchmarks with different workloads, hardware, and metrics, making fair comparison nearly impossible. Current workaround: teams run their own benchmarks, investing days of engineering time. Pain level: high.
> 4. **Graceful model updates without downtime**: Rolling out a new model version without dropping in-flight requests or requiring manual traffic shifting remains difficult across most platforms. Current workaround: blue-green deployments with manual cutover scripts. Pain level: medium.
> 5. **Unified observability across the inference stack**: Tracing a request from API gateway through router, scheduler, and inference engine requires stitching together multiple observability tools. No single solution provides end-to-end visibility. Pain level: high.
>
> ### Implications for Red Hat AI / llm-d
> 1. **Invest in multi-model serving with GPU sharing and isolation**: This is the highest-pain unmet need and aligns directly with our Kubernetes-native approach. We should prioritize this for the next two releases.
> 2. **Watch the gateway/routing segment but do not build our own**: This segment is fragmenting and no winner is clear. Integrate with LiteLLM and Kong rather than building a competing gateway.
> 3. **Partner with the vLLM community on standardized benchmarking**: Contributing to an industry benchmarking standard positions us as a neutral player and gives us influence over how serving platforms are evaluated.
> 4. **Respond to SGLang's momentum**: SGLang has shipped three major releases in the past six months and is gaining adoption among researchers. Ensure our engine integration layer supports SGLang as a backend alongside vLLM to avoid lock-in risk.
