# AI BU Prompt Library

A curated, tested collection of prompts for common AI Business Unit tasks. Organized by role and use case, ready to copy-paste.

## How to Use

1. Browse the categories below.
2. Open the prompt file that matches your task.
3. Copy the prompt, fill in the placeholders (marked with `[BRACKETS]`), and paste it into your LLM of choice.
4. Check the usage tips in each file for better results.

## Prompts by Category

### Content

Prompts for writing blog posts, social media, and conference materials.

| Prompt | Description |
|--------|-------------|
| [Blog Intro](content/blog-intro.md) | Write a compelling introduction for a technical blog post |
| [Blog Outline](content/blog-outline.md) | Structure a full technical blog post with sections and key points |
| [LinkedIn Post](content/social-linkedin.md) | Write a LinkedIn post about technical content |
| [Twitter/X Thread](content/social-twitter.md) | Write a Twitter/X thread about technical content |
| [Abstract Writer](content/abstract-writer.md) | Write an abstract for a paper or conference talk |

### Research

Prompts for summarizing papers, analyzing competitors, and mapping technology landscapes.

| Prompt | Description |
|--------|-------------|
| [Paper Summary](research/paper-summary.md) | Summarize a technical paper into key findings and relevance |
| [Competitive Analysis](research/competitive-analysis.md) | Analyze a competitor's product for strengths, gaps, and differentiation |
| [Market Landscape](research/market-landscape.md) | Map a technology landscape with key players and trends |

### Engineering

Prompts for code review, debugging, architecture review, and test generation.

| Prompt | Description |
|--------|-------------|
| [Code Review](engineering/code-review.md) | Run a thorough code review covering correctness, security, and performance |
| [Debug Helper](engineering/debug-helper.md) | Systematically debug an issue by reproducing, isolating, and fixing it |
| [Architecture Review](engineering/architecture-review.md) | Review system architecture for scalability, reliability, and simplicity |
| [Test Generator](engineering/test-generator.md) | Generate test cases covering happy paths, edge cases, and failure modes |

### Communication

Prompts for stakeholder updates, incident reports, and team announcements.

| Prompt | Description |
|--------|-------------|
| [Stakeholder Update](communication/stakeholder-update.md) | Write a concise executive update on project status |
| [Incident Report](communication/incident-report.md) | Write a blameless post-mortem for an incident |
| [Team Announcement](communication/team-announcement.md) | Write an internal announcement for your team or org |

### DevRel

Prompts for demos, tutorials, and community engagement.

| Prompt | Description |
|--------|-------------|
| [Demo Script](devrel/demo-script.md) | Create a time-boxed demo script with setup, steps, and talking points |
| [Tutorial Outline](devrel/tutorial-outline.md) | Structure a tutorial with prerequisites, sections, and checkpoints |
| [Community Response](devrel/community-response.md) | Draft a helpful response to a community question |

## Contributing

Want to add a prompt? Here is how:

1. Pick the right category folder (or propose a new one).
2. Create a new `.md` file with this structure:
   - **Title** (H1): A short name for the prompt.
   - **Description** (one line): What it does.
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

## License

Apache License 2.0
