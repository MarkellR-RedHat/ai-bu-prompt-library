# AI BU Prompt Library

**35+ engineered prompts for the work you already do, tuned to produce output you actually ship.**

## The Problem

You type a reasonable prompt. You get a reasonable result. You spend the next 20 minutes rewriting it before you can send it to anyone.

That is the default AI experience for most teams, and it is a massive waste of time. The gap between a naive prompt and an engineered one is not incremental. It is the difference between output you throw away and output you ship.

## Naive Prompt vs. Engineered Prompt

Same task. Two approaches. One of them is ready to send.

<table>
<tr>
<th width="50%">What most people type</th>
<th width="50%">What this library gives you</th>
</tr>
<tr>
<td>

```
Write a status update on my project.
```

</td>
<td>

Uses the [Stakeholder Update](communication/stakeholder-update.md) prompt with role setting, output format specification, self-critique checklist, and anti-pattern avoidance.

</td>
</tr>
<tr>
<td>

**Result:**

"The team has been working hard on several fronts this quarter. We made good progress on the API migration and are continuing to onboard partners. There have been some challenges with CI but we are working through them. Overall things are on track and we are optimistic about hitting our deadlines."

Accomplishments, risks, and plans mashed into one paragraph. The CI problem (which could slip your GA date) is buried behind "some challenges." No status indicator, no dates, no asks. You rewrite it before sending.

</td>
<td>

**Result:**

**Status: At Risk**
CI pipeline stability has degraded, putting the July 30 GA release at risk if not resolved by July 10.

**Key Accomplishments**
- Completed API gateway migration across all three regions, reducing p99 latency by 40%
- Onboarded 3 new partner teams to shared auth service (11 of 14 target teams)

**Risks and Blockers**
- CI pipeline flakiness increased test failure rate from 2% to 12%. Mitigation: SRE investigating; resolution expected July 10.

**Asks**
- Need VP-Eng approval on staging environment budget by July 5.

Scannable. Consistent. Status at the top, risks with mitigations, asks with deadlines. Ready to send.

</td>
</tr>
</table>

Every prompt in this library produces this kind of difference because every prompt uses the same engineering techniques. The [Prompt Engineering Guide](meta/prompt-engineering-guide.md) explains exactly what those techniques are.

## Quick Start

```bash
# Clone the library
git clone https://github.com/MarkellR-RedHat/ai-bu-prompt-library.git
cd ai-bu-prompt-library

# Or run the installer to set it up in one step
curl -fsSL https://raw.githubusercontent.com/MarkellR-RedHat/ai-bu-prompt-library/main/install.sh | bash
```

Then pick a prompt, fill in the `[BRACKETED]` placeholders, and paste it into your LLM of choice.

**First time?** Start with one of these:

1. **[Blog Intro](content/blog-intro.md)** (Beginner) - Paste your topic, get a strong opening paragraph.
2. **[Stakeholder Update](communication/stakeholder-update.md)** (Beginner) - Paste messy notes, get a clean executive update.
3. **[Code Review](engineering/code-review.md)** (Intermediate) - Paste a diff, get structured feedback across correctness, security, and performance.
4. **[Prompt Engineering Guide](meta/prompt-engineering-guide.md)** - Learn the techniques behind every prompt.

## All Prompts

### Content

| Prompt | What it does | Difficulty |
|--------|-------------|------------|
| [Blog Intro](content/blog-intro.md) | Compelling intro for a technical blog post | Beginner |
| [Blog Outline](content/blog-outline.md) | Full blog structure with sections and key points | Intermediate |
| [Abstract Writer](content/abstract-writer.md) | Abstract for a paper or conference talk | Intermediate |
| [Case Study Outline](content/case-study-outline.md) | Customer case study from raw notes | Intermediate |
| [Newsletter Blurb](content/newsletter-blurb.md) | 2-3 sentence newsletter blurb | Beginner |
| [LinkedIn Post](content/social-linkedin.md) | LinkedIn post about technical content | Intermediate |
| [Twitter/X Thread](content/social-twitter.md) | Twitter/X thread about technical content | Intermediate |

### Engineering

| Prompt | What it does | Difficulty |
|--------|-------------|------------|
| [Code Review](engineering/code-review.md) | Thorough review covering correctness, security, performance | Intermediate |
| [Debug Helper](engineering/debug-helper.md) | Systematic debugging: reproduce, isolate, fix | Intermediate |
| [Architecture Review](engineering/architecture-review.md) | Architecture review for scalability, reliability, simplicity | Advanced |
| [Test Generator](engineering/test-generator.md) | Test cases: happy paths, edge cases, failure modes | Intermediate |
| [PR Description](engineering/pr-description.md) | Clear PR description from a diff | Beginner |
| [Incident Timeline](engineering/incident-timeline.md) | Incident timeline from logs and Slack messages | Intermediate |

### Research

| Prompt | What it does | Difficulty |
|--------|-------------|------------|
| [Paper Summary](research/paper-summary.md) | Technical paper into key findings and relevance | Intermediate |
| [Competitive Analysis](research/competitive-analysis.md) | Competitor strengths, gaps, and differentiation | Advanced |
| [Market Landscape](research/market-landscape.md) | Technology landscape with key players and trends | Advanced |
| [RFC Summary](research/rfc-summary.md) | RFC or design proposal summary for busy reviewers | Intermediate |
| [Meeting Prep](research/meeting-prep.md) | Meeting prep from relevant docs and context | Beginner |

### Communication

| Prompt | What it does | Difficulty |
|--------|-------------|------------|
| [Stakeholder Update](communication/stakeholder-update.md) | Concise executive update on project status | Beginner |
| [Incident Report](communication/incident-report.md) | Blameless post-mortem for an incident | Intermediate |
| [Team Announcement](communication/team-announcement.md) | Internal announcement for your team or org | Beginner |
| [Executive Brief](communication/exec-brief.md) | Complex topic distilled into a 1-page executive brief | Intermediate |

### DevRel

| Prompt | What it does | Difficulty |
|--------|-------------|------------|
| [Demo Script](devrel/demo-script.md) | Time-boxed demo script with setup, steps, talking points | Intermediate |
| [Tutorial Outline](devrel/tutorial-outline.md) | Tutorial with prerequisites, sections, checkpoints | Intermediate |
| [Community Response](devrel/community-response.md) | Helpful response to a community question | Beginner |
| [Workshop Outline](devrel/workshop-outline.md) | Hands-on workshop with timed sections and exercises | Advanced |

### Strategy

| Prompt | What it does | Difficulty |
|--------|-------------|------------|
| [OKR Writer](strategy/okr-writer.md) | Measurable OKRs with baselines and targets | Intermediate |
| [Decision Matrix](strategy/decision-matrix.md) | Decision with weighted criteria and sensitivity analysis | Advanced |
| [Stakeholder Map](strategy/stakeholder-map.md) | Stakeholders mapped by influence, interest, engagement | Intermediate |

### Leadership

| Prompt | What it does | Difficulty |
|--------|-------------|------------|
| [1:1 Prep](leadership/one-on-one-prep.md) | Prepare for 1:1 meetings with reports | Intermediate |
| [Feedback Draft](leadership/feedback-draft.md) | Specific, actionable feedback using the SBI framework | Advanced |
| [Team Health Check](leadership/team-health-check.md) | Team health across delivery, collaboration, sustainability | Advanced |

### Analysis

| Prompt | What it does | Difficulty |
|--------|-------------|------------|
| [Root Cause Analysis](analysis/root-cause.md) | 5 Whys + Fishbone for blameless incident analysis | Intermediate |
| [Trade-off Analysis](analysis/trade-off.md) | Structured trade-off analysis for technical decisions | Advanced |
| [Cost-Benefit Analysis](analysis/cost-benefit.md) | Three-point estimates for project proposals | Advanced |

### Prompt Chains

Multi-step workflows where each prompt feeds into the next. These produce better results than a single prompt because each step focuses on one task.

| Chain | Steps | What it does | Difficulty |
|-------|-------|-------------|------------|
| [Blog to Talk](prompt-chains/blog-to-talk.md) | 4 | Blog post into a conference talk and CFP submission | Advanced |
| [Incident to Retro](prompt-chains/incident-to-retro.md) | 5 | Incident into timeline, root cause, retro, prevention plan | Advanced |
| [Idea to Proposal](prompt-chains/idea-to-proposal.md) | 5 | Raw idea into validated proposal with executive summary | Advanced |

### Meta

| Guide | What it covers |
|-------|---------------|
| [Prompt Engineering Guide](meta/prompt-engineering-guide.md) | Every technique used in this library, with examples and before/after comparisons |
| [Testing Prompts](meta/testing-prompts.md) | How to evaluate whether a prompt is actually good |

## Why These Prompts Work

Every prompt applies these techniques consistently:

| Technique | What it does | Why it matters |
|-----------|-------------|----------------|
| **Role and context setting** | Assigns a specific expert role and names the audience | Determines vocabulary, depth, and framing for the entire response |
| **Chain-of-thought reasoning** | Walks the model through the thinking process step by step | Reduces errors and catches considerations a direct answer would miss |
| **Self-critique checklist** | Verification checklist the model runs before delivering output | Catches severity miscalibration, missing evidence, vague recommendations |
| **Anti-pattern avoidance** | Explicit instructions on what NOT to do | Blocks filler phrases, optimism bias, jargon overload, generic output |
| **Edge case handling** | Instructions for unusual inputs and missing context | Model asks clarifying questions instead of hallucinating answers |
| **Output format specification** | Detailed structure for consistent, scannable output | Same prompt produces structurally identical output every time |

For a deep dive into each technique: [Prompt Engineering Guide](meta/prompt-engineering-guide.md).

## Workflow: How This Fits the AI BU Suite

The prompt library is the starting point. Use a prompt in any LLM chat interface. When you want to automate the same task inside Claude Code, reach for the matching tool.

| Prompt | AI BU Tool | How they connect |
|--------|-----------|------------------|
| [Abstract Writer](content/abstract-writer.md) | [cfp-generator](../ai-bu-cfp-generator) | Generate the abstract here, then build the full CFP submission |
| [Blog Intro](content/blog-intro.md) / [Blog Outline](content/blog-outline.md) | [claude-commands](../ai-bu-claude-commands) `/blog-from-pr` | Refine the intro or structure content before drafting |
| [Stakeholder Update](communication/stakeholder-update.md) | [status-report](../ai-bu-status-report) | Prompt for ad-hoc updates, tool for recurring weekly reports |
| [Code Review](engineering/code-review.md) | [claude-commands](../ai-bu-claude-commands) `/review` | Automates code review on your current diff |
| [PR Description](engineering/pr-description.md) | [shipped-digest](../ai-bu-shipped-digest) | PR descriptions feed into weekly shipped digests |
| [Competitive Analysis](research/competitive-analysis.md) | [competitive-watch](../ai-bu-competitive-watch) | Deep one-off analysis here, continuous monitoring there |
| [Incident Report](communication/incident-report.md) | [claude-commands](../ai-bu-claude-commands) `/retro` | Generates retros, extracts incident data |
| [Team Announcement](communication/team-announcement.md) | [claude-commands](../ai-bu-claude-commands) `/draft-announcement` | Multi-channel announcements |
| [Demo Script](devrel/demo-script.md) | [claude-commands](../ai-bu-claude-commands) `/demo-prep` | Automates demo preparation with environment checks |
| [Community Response](devrel/community-response.md) | [claude-commands](../ai-bu-claude-commands) `/explain-for-customer` | Customer-facing explanations in support contexts |
| [Architecture Review](engineering/architecture-review.md) | [claude-commands](../ai-bu-claude-commands) `/tldr-repo` | Summarizes an unfamiliar codebase before review |
| [Meeting Prep](research/meeting-prep.md) | [daily-briefing](../ai-bu-daily-briefing) | Prompt for specific meetings, tool for daily context |

Each prompt's Usage Tips section notes the specific connections. The prompts work in any LLM chat interface. The tools work in Claude Code. Use whichever fits, or combine them.

## Real-World Tip

The biggest time savings come from the prompts you did not expect to reuse. The [Stakeholder Update](communication/stakeholder-update.md) prompt, for example, was built for weekly status emails. In practice, the team uses it before every cross-functional meeting: paste your messy notes, get a structured brief in 30 seconds, walk in with talking points instead of scrambling to recall what happened last sprint. One engineer reported cutting meeting prep from 15 minutes to under 2 by keeping a running notes file and running the prompt right before standup.

## Contributing

1. Pick the right category folder (or propose a new one).
2. Read the [Prompt Engineering Guide](meta/prompt-engineering-guide.md) for structure and technique requirements.
3. Create a `.md` file with: title, description, difficulty, when to use (5+ bullets), when NOT to use (3+ bullets), prompt (with role setting, chain-of-thought, output format, self-critique, anti-patterns, edge cases), usage tips (5+), and example output.
4. Test your prompt at least three times using the [Testing Prompts](meta/testing-prompts.md) methodology.
5. Open a pull request.

**Style rules:** Direct, practical voice. No em dashes. No marketing language. All variable inputs use `[BRACKET]` placeholders. Every prompt includes a self-critique checklist and at least 5 anti-patterns.

## License

Apache License 2.0
