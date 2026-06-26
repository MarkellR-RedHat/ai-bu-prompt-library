# AI BU Prompt Library

A curated, tested collection of prompts for common AI Business Unit tasks. Organized by role and use case, ready to copy-paste.

## How to Use

1. Browse the categories below.
2. Open the prompt file that matches your task.
3. Copy the prompt, fill in the placeholders (marked with `[BRACKETS]`), and paste it into your LLM of choice.
4. Check the "When to use" and "When NOT to use" sections to make sure you picked the right prompt.
5. Review the usage tips in each file for better results.

### Difficulty Ratings

Each prompt is tagged with a difficulty level:

- **Beginner** - Straightforward prompts that work well with minimal customization. Good starting points.
- **Intermediate** - Requires more context and careful placeholder filling. Benefits from iteration.
- **Advanced** - Complex prompts that need domain expertise and detailed input to produce strong results.

## Prompts by Category

### Content

Prompts for writing blog posts, social media, newsletters, and conference materials.

| Prompt | Description | Difficulty |
|--------|-------------|------------|
| [Blog Intro](content/blog-intro.md) | Write a compelling introduction for a technical blog post | Beginner |
| [Blog Outline](content/blog-outline.md) | Structure a full technical blog post with sections and key points | Beginner |
| [LinkedIn Post](content/social-linkedin.md) | Write a LinkedIn post about technical content | Beginner |
| [Twitter/X Thread](content/social-twitter.md) | Write a Twitter/X thread about technical content | Beginner |
| [Abstract Writer](content/abstract-writer.md) | Write an abstract for a paper or conference talk | Intermediate |
| [Newsletter Blurb](content/newsletter-blurb.md) | Write a 2-3 sentence newsletter blurb about a topic | Beginner |
| [Case Study Outline](content/case-study-outline.md) | Structure a customer case study from raw notes | Intermediate |

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
| [Test Generator](engineering/test-generator.md) | Generate test cases covering happy paths, edge cases, and failure modes | Beginner |
| [PR Description](engineering/pr-description.md) | Write a good PR description from a diff | Beginner |
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

## Contributing

Want to add a prompt? Here is how:

1. Pick the right category folder (or propose a new one).
2. Create a new `.md` file with this structure:
   - **Title** (H1): A short name for the prompt.
   - **Description** (one line): What it does.
   - **Difficulty**: Beginner, Intermediate, or Advanced.
   - **When to use**: 3-5 bullet points describing good use cases.
   - **When NOT to use**: 2-3 bullet points describing when to skip this prompt.
   - **Prompt** (in a code block): The actual prompt, ready to copy. Use `[PLACEHOLDER]` syntax for inputs.
   - **Usage Tips**: Practical advice for getting better results.
   - **Example Output**: A short snippet showing what good output looks like.
3. Open a pull request with your new file.

### Guidelines

- Keep prompts specific and actionable. Vague prompts produce vague output.
- Include placeholders for all variable inputs.
- Test your prompt at least twice before submitting. If the output is inconsistent, the prompt needs more constraints.
- Write in a direct, practical voice. Skip the marketing language.
- Do not use em dashes. Use commas, periods, or "and" instead.
- Include "When to use" and "When NOT to use" sections so users pick the right prompt.
- Tag every prompt with a difficulty level (Beginner, Intermediate, or Advanced).

## License

Apache License 2.0
