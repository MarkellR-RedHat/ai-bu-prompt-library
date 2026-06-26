# AI BU Prompt Library

A curated, tested collection of prompts for common AI Business Unit tasks. Each prompt is engineered for consistent, high-quality output with chain-of-thought reasoning, self-critique loops, and explicit anti-pattern avoidance. Organized by role and use case, ready to copy-paste.

## Start Here

**New to this library?** Start with these prompts to get a feel for how they work:

1. **[Blog Intro](content/blog-intro.md)** (Beginner) - Quick win. Paste your topic and audience, get a strong opening paragraph.
2. **[Stakeholder Update](communication/stakeholder-update.md)** (Beginner) - Paste your messy notes, get a clean executive update.
3. **[Code Review](engineering/code-review.md)** (Intermediate) - Paste a diff, get structured feedback across correctness, security, and performance.
4. **[OKR Writer](strategy/okr-writer.md)** (Intermediate) - Turn vague goals into measurable OKRs.
5. **[Prompt Engineering Guide](meta/prompt-engineering-guide.md)** - Learn the techniques behind every prompt in this library.

**Want to chain prompts together?** Check the [Prompt Chains](#prompt-chains) section for multi-step workflows like turning a blog post into a conference talk, or an incident into a full retrospective.

## How to Use

1. Browse the categories below or use the table to find the right prompt.
2. Open the prompt file that matches your task.
3. Copy the prompt, fill in the placeholders (marked with `[BRACKETS]`), and paste it into your LLM of choice.
4. Check the "When to use" and "When NOT to use" sections to make sure you picked the right prompt.
5. Review the self-critique checklist in each prompt to evaluate the output quality.
6. See the usage tips in each file for better results.

### Difficulty Ratings

- **Beginner** - Straightforward prompts that work well with minimal customization. Good starting points.
- **Intermediate** - Requires more context and careful placeholder filling. Benefits from iteration.
- **Advanced** - Complex prompts that need domain expertise and detailed input to produce strong results.

## Prompts by Category

### Content

Prompts for writing blog posts, social media, newsletters, and conference materials.

| Prompt | Description | Difficulty |
|--------|-------------|------------|
| [Blog Intro](content/blog-intro.md) | Write a compelling introduction for a technical blog post | Beginner |
| [Blog Outline](content/blog-outline.md) | Structure a full technical blog post with sections and key points | Intermediate |
| [Abstract Writer](content/abstract-writer.md) | Write an abstract for a paper or conference talk | Intermediate |
| [Case Study Outline](content/case-study-outline.md) | Structure a customer case study from raw notes | Intermediate |
| [Newsletter Blurb](content/newsletter-blurb.md) | Write a 2-3 sentence newsletter blurb about a topic | Beginner |
| [LinkedIn Post](content/social-linkedin.md) | Write a LinkedIn post about technical content | Intermediate |
| [Twitter/X Thread](content/social-twitter.md) | Write a Twitter/X thread about technical content | Intermediate |

### Research

Prompts for summarizing papers, analyzing competitors, mapping technology landscapes, and preparing for meetings.

| Prompt | Description | Difficulty |
|--------|-------------|------------|
| [Paper Summary](research/paper-summary.md) | Summarize a technical paper into key findings and relevance | Intermediate |
| [Competitive Analysis](research/competitive-analysis.md) | Analyze a competitor's product for strengths, gaps, and differentiation | Advanced |
| [Market Landscape](research/market-landscape.md) | Map a technology landscape with key players and trends | Advanced |
| [RFC Summary](research/rfc-summary.md) | Summarize an RFC or design proposal for busy reviewers | Intermediate |
| [Meeting Prep](research/meeting-prep.md) | Prepare for a meeting by summarizing relevant docs and context | Beginner |

### Engineering

Prompts for code review, debugging, architecture review, test generation, PR descriptions, and incident timelines.

| Prompt | Description | Difficulty |
|--------|-------------|------------|
| [Code Review](engineering/code-review.md) | Run a thorough code review covering correctness, security, and performance | Intermediate |
| [Debug Helper](engineering/debug-helper.md) | Systematically debug an issue by reproducing, isolating, and fixing it | Intermediate |
| [Architecture Review](engineering/architecture-review.md) | Review system architecture for scalability, reliability, and simplicity | Advanced |
| [Test Generator](engineering/test-generator.md) | Generate test cases covering happy paths, edge cases, and failure modes | Intermediate |
| [PR Description](engineering/pr-description.md) | Write a clear PR description from a diff | Beginner |
| [Incident Timeline](engineering/incident-timeline.md) | Build an incident timeline from logs and Slack messages | Intermediate |

### Communication

Prompts for stakeholder updates, incident reports, team announcements, and executive briefs.

| Prompt | Description | Difficulty |
|--------|-------------|------------|
| [Stakeholder Update](communication/stakeholder-update.md) | Write a concise executive update on project status | Beginner |
| [Incident Report](communication/incident-report.md) | Write a blameless post-mortem for an incident | Intermediate |
| [Team Announcement](communication/team-announcement.md) | Write an internal announcement for your team or org | Beginner |
| [Executive Brief](communication/exec-brief.md) | Distill a complex topic into a 1-page executive brief | Intermediate |

### DevRel

Prompts for demos, tutorials, community engagement, and workshops.

| Prompt | Description | Difficulty |
|--------|-------------|------------|
| [Demo Script](devrel/demo-script.md) | Create a time-boxed demo script with setup, steps, and talking points | Intermediate |
| [Tutorial Outline](devrel/tutorial-outline.md) | Structure a tutorial with prerequisites, sections, and checkpoints | Intermediate |
| [Community Response](devrel/community-response.md) | Draft a helpful response to a community question | Beginner |
| [Workshop Outline](devrel/workshop-outline.md) | Structure a hands-on workshop with timed sections and exercises | Advanced |

### Strategy

Prompts for OKRs, decision-making frameworks, and stakeholder mapping.

| Prompt | Description | Difficulty |
|--------|-------------|------------|
| [OKR Writer](strategy/okr-writer.md) | Write OKRs that are actually measurable with baselines and targets | Intermediate |
| [Decision Matrix](strategy/decision-matrix.md) | Structure a decision with weighted criteria and sensitivity analysis | Advanced |
| [Stakeholder Map](strategy/stakeholder-map.md) | Map stakeholders by influence, interest, and engagement strategy | Intermediate |

### Leadership

Prompts for 1:1 prep, feedback drafting, and team health assessment.

| Prompt | Description | Difficulty |
|--------|-------------|------------|
| [1:1 Prep](leadership/one-on-one-prep.md) | Prepare for 1:1 meetings with reports | Intermediate |
| [Feedback Draft](leadership/feedback-draft.md) | Write specific, actionable feedback using the SBI framework | Advanced |
| [Team Health Check](leadership/team-health-check.md) | Assess team health across delivery, collaboration, sustainability, and purpose | Advanced |

### Analysis

Prompts for root cause analysis, trade-off evaluation, and cost-benefit analysis.

| Prompt | Description | Difficulty |
|--------|-------------|------------|
| [Root Cause Analysis](analysis/root-cause.md) | 5 Whys + Fishbone diagram for blameless incident analysis | Intermediate |
| [Trade-off Analysis](analysis/trade-off.md) | Structured trade-off analysis for technical decisions | Advanced |
| [Cost-Benefit Analysis](analysis/cost-benefit.md) | Cost-benefit analysis with three-point estimates for project proposals | Advanced |

### Prompt Chains

Multi-step workflows where each prompt feeds into the next. These produce dramatically better results than a single prompt because each step focuses on one task.

| Chain | Steps | Description | Difficulty |
|-------|-------|-------------|------------|
| [Blog to Talk](prompt-chains/blog-to-talk.md) | 4 | Summarize blog, extract key points, build talk structure, generate CFP | Advanced |
| [Incident to Retro](prompt-chains/incident-to-retro.md) | 5 | Timeline, root cause, action items, retro doc, prevention plan | Advanced |
| [Idea to Proposal](prompt-chains/idea-to-proposal.md) | 5 | Brainstorm, validate, outline, full proposal, executive summary | Advanced |

### Meta

Guides on prompt engineering techniques and how to evaluate prompt quality.

| Guide | Description |
|-------|-------------|
| [Prompt Engineering Guide](meta/prompt-engineering-guide.md) | How to write great prompts, with the techniques used in this library |
| [Testing Prompts](meta/testing-prompts.md) | How to evaluate whether a prompt is actually good |

## What Makes These Prompts Different

Every prompt in this library uses these techniques:

1. **Role and context setting** - Each prompt starts with a clear role ("You are a senior SRE...") and context, so the model knows what expertise to apply.
2. **Chain-of-thought reasoning** - Step-by-step instructions that walk the model through the thinking process, not just the output format.
3. **Self-critique checklist** - Each prompt includes a verification checklist the model runs before delivering output, catching common mistakes.
4. **Anti-pattern avoidance** - Explicit instructions about what NOT to do, based on real failure modes we have observed.
5. **Edge case handling** - Instructions for unusual inputs (empty data, ambiguous requirements, missing context).
6. **Output format specification** - Detailed structure so output is consistent and scannable.

For a deep dive, read the [Prompt Engineering Guide](meta/prompt-engineering-guide.md).

## Contributing

Want to add a prompt? Here is how:

1. Pick the right category folder (or propose a new one).
2. Read the [Prompt Engineering Guide](meta/prompt-engineering-guide.md) for the structure and techniques to use.
3. Create a new `.md` file with this structure:
   - **Title** (H1): A short name for the prompt.
   - **Description** (one line): What it does.
   - **Difficulty**: Beginner, Intermediate, or Advanced.
   - **When to use**: 5+ bullet points describing good use cases.
   - **When NOT to use**: 3+ bullet points describing when to skip this prompt.
   - **Prompt** (in a code block): The actual prompt with role setting, chain-of-thought steps, output format, self-critique checklist, anti-patterns, and edge case handling.
   - **Usage Tips**: 5+ practical tips for getting better results.
   - **Example Output**: A realistic snippet showing what good output looks like.
4. Test your prompt using the methodology in [Testing Prompts](meta/testing-prompts.md).
5. Open a pull request with your new file.

### Guidelines

- Keep prompts specific and actionable. Vague prompts produce vague output.
- Include placeholders for all variable inputs using `[BRACKET]` syntax.
- Test your prompt at least three times before submitting. If the output is inconsistent, the prompt needs more constraints.
- Write in a direct, practical voice. Skip the marketing language.
- Do not use em dashes. Use commas, periods, or "and" instead.
- Include "When to use" and "When NOT to use" sections so users pick the right prompt.
- Tag every prompt with a difficulty level (Beginner, Intermediate, or Advanced).
- Include a self-critique checklist in every prompt.
- Include at least 5 anti-patterns to avoid.

## License

Apache License 2.0
