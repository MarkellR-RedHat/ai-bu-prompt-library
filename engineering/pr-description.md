# PR Description Writer

A structured prompt for generating clear, well-organized pull request descriptions from diffs or changesets that help reviewers understand what changed, why it changed, and how to review it effectively.

**Difficulty:** Beginner

## Naive vs. Engineered

Most people open a PR and type something like:

> **Naive prompt:** "Write a PR description for this diff."

**What you get:** A summary that restates the file names that changed with no useful context. Something like:

> ## Changes
> - Updated `gateway/router.go`
> - Modified `config/defaults.yaml`
> - Added tests in `gateway/router_test.go`
> - Fixed typo in `gateway/metrics.go`
>
> ## Testing
> Tested locally and it works.
>
> ## Risk
> Low risk.

No explanation of why anything changed. No guidance for reviewers on where to focus. "Low risk" with no supporting reasoning. The reviewer still has to read every line of the diff blind, which is exactly the problem a good description is supposed to solve.

**This prompt** produces a structured description with a clear summary, motivation linked to the actual issue, changes grouped by component with explanations of why each change was made, a specific review order telling reviewers where to start and what to scrutinize, testing details, and an honest risk assessment with rollback instructions. Instead of "Updated `gateway/router.go`," you get: "Replaced round-robin replica selection in `selectReplica()` with cache-aware selection that queries each replica's KV-cache state, reducing cold-start latency by up to 40%. Start your review at `gateway/router.go` lines 45 to 92, then check the 12 new test cases covering cache-hit routing, cache-miss fallback, and stale state handling."

## When to use

- Opening a pull request and you need a clear description that helps reviewers understand the full scope of the change
- The diff is large (100+ lines) and reviewers need a guided tour of the changes to review efficiently
- You want to document the reasoning behind a refactor, migration, or architectural change so the context is preserved in the PR record
- Writing descriptions for PRs in a codebase you recently joined, where you may not know the team's conventions for PR communication
- The change spans multiple files or components and the connections between the changes are not obvious from the diff alone
- You are opening a PR against an open source project and want to make a strong first impression with thorough documentation

## When NOT to use

- The PR is a one-line typo fix, dependency version bump, or formatting change that needs no explanation. A single sentence is fine for those.
- You need a full design document or RFC to justify the change. Write that separately; the PR description should reference it, not replace it.
- The PR is a draft or work-in-progress that you are sharing for early feedback. A brief note about what is done and what is not is sufficient.

## Prompt

````
You are a senior engineer writing a pull request description that will be read by code reviewers, team leads, and future engineers who need to understand why this change was made. Your goal is to make the reviewer's job as easy as possible: help them understand the purpose, navigate the changes efficiently, and identify what to scrutinize most carefully.

Context:
- Repository: [REPO_NAME]
- Branch: [BRANCH_NAME]
- Related issue, ticket, or design doc: [ISSUE_LINK_OR_TICKET_NUMBER]
- Target audience for this PR description: [AUDIENCE_OR_YOUR_TEAM]

Structure the description using these sections:

**1. Summary (2 to 3 sentences)**
What does this PR do? State the change in plain, specific language. Avoid vague phrases like "refactored the service" or "improved performance." Instead, write something like "Replaced the round-robin request router with a cache-aware router that prefers replicas with warm KV caches."

**2. Motivation**
Why is this change needed? Link to the issue, bug report, customer feedback, or design document that prompted it. If this is paying down tech debt, explain what problem the debt was causing. If this is a new feature, explain what user need it addresses. The reviewer should understand the "why" before they read the "what."

**3. What Changed (grouped by component or file)**
A bulleted list of the specific changes, grouped logically (by file, component, or layer). For each change:
- State what was modified
- Explain why it was modified (not just "updated X," but "updated X to handle the new Y requirement")
- If a change is mechanical or trivial (renaming, formatting, import reordering), call it out so the reviewer does not waste time scrutinizing it

If the diff includes changes that are unrelated to the main purpose of the PR (e.g., an opportunistic cleanup), call them out in a separate "Unrelated changes" subsection so the reviewer knows they are not part of the core change.

**4. How to Review**
Suggest a review order. Which files should the reviewer look at first? What is the most important logic change to scrutinize? What can be skimmed? Example: "Start with gateway/router.go, specifically the selectReplica() function, where the core routing logic changed. Then check the test file. The config changes are straightforward."

This section is the most valuable part of a PR description for large changes. Put thought into it.

**5. Testing**
What tests were added, updated, or removed? How was this change validated? Include:
- Names or descriptions of new test cases
- Commands to run the tests locally (e.g., `pytest tests/test_router.py -v`)
- Any manual verification steps the reviewer should follow
- Whether the change was tested in a staging environment, if applicable

**6. Risks and Rollback**
What could go wrong? Consider:
- Is this change backward compatible? If not, what breaks?
- Does this change affect database schemas, API contracts, or configuration formats?
- How would you roll this back if it causes problems in production? Is it a simple revert, or are there data migration concerns?
- Are there feature flags or configuration knobs that allow disabling the new behavior without a revert?

**7. Screenshots or Output (if applicable)**
Include terminal output, API responses, UI screenshots, or before/after metrics that demonstrate the change working. For API changes, show example request and response payloads.

Step-by-step reasoning process:
1. Read the entire diff to understand the full scope of changes before writing anything.
2. Identify the primary purpose of the PR. If the diff includes unrelated changes, separate them.
3. Group the changes by component or logical unit, not just by file.
4. For each group, explain both the "what" and the "why."
5. Determine the optimal review order based on which changes are most important and which are dependencies of others.
6. Identify risks by considering what assumptions the code makes about its environment, data, and dependencies.

Self-critique checklist (apply before presenting the final description):
- [ ] Does the Summary accurately describe the change in specific language? Would a new team member understand what this PR does?
- [ ] Does the Motivation explain why this change is needed, not just what it does?
- [ ] Does the "What Changed" section explain the purpose of each change, not just list the files?
- [ ] Does the "How to Review" section actually help a reviewer, or does it just say "review the changed files"?
- [ ] Did I call out any unrelated changes so the reviewer does not confuse them with the core change?
- [ ] Did I identify the realistic risks, not just write "low risk" to avoid scrutiny?
- [ ] Is the description proportional to the size of the change? (A 10-line fix does not need 500 words.)

Anti-patterns to avoid:
1. Do not write "Refactored X" or "Improved Y" without explaining what specifically changed and why.
2. Do not write "No risks" when there are clearly risks. Every non-trivial change has risks. Identify them honestly.
3. Do not just list the files that changed. Explain the purpose of each change.
4. Do not write the PR description as a stream-of-consciousness narrative about how you developed the feature. Organize it for the reader, not the author.
5. Do not duplicate the commit messages. The PR description should provide context and structure that individual commit messages do not.
6. Do not write "Tested locally and it works." Describe what you tested, how you tested it, and what the results were.
7. Do not bury the most important information. If there is a breaking change or a migration step, put it near the top, not in the last bullet point.

Edge case handling:
- If the diff is very large (500+ lines), recommend splitting the PR and explain how to split it. Generate the description for the current diff, but note where a split would be cleaner.
- If the diff includes generated code (protobuf, OpenAPI stubs, migration files), call it out so reviewers know they can skim those sections.
- If the diff includes dependency updates (go.sum, package-lock.json, requirements.txt), summarize what changed and why rather than listing every line.
- If the PR fixes a bug, include the reproduction steps for the bug and explain how this change prevents it from recurring.
- If a placeholder is left unfilled (e.g., [REPO_NAME] still reads "[REPO_NAME]"), still generate the description but note which fields need filling in before the PR is opened.
- If the diff is empty or contains only whitespace changes, say so and suggest the user check their git diff command rather than generating a meaningless description.
- If the diff spans multiple unrelated concerns (a feature addition, a bug fix, and a dependency bump in one PR), recommend splitting into separate PRs and explain the boundaries.
- If the diff is against an open source project with contribution guidelines (CONTRIBUTING.md), remind the user to check those guidelines for required PR sections or sign-off requirements.

Diff:
[PASTE_DIFF_HERE]
````

## Why This Works

This prompt turns a diff into a reviewer-optimized document by combining several techniques:

- **Audience-aware framing** ("read by code reviewers, team leads, and future engineers"): Telling the model who will read the output changes what it writes. A description for reviewers emphasizes what to scrutinize. A description for future engineers emphasizes why the change was made. This prompt addresses both audiences explicitly.
- **Seven-section structure** (Summary, Motivation, What Changed, How to Review, Testing, Risks, Screenshots): Each section serves a distinct purpose in the review process. Motivation prevents "why did we do this?" questions. How to Review prevents wasted time on unimportant files. Risks prevents post-merge surprises. Without this structure, the model produces a flat narrative that buries the important information.
- **Chain-of-thought reasoning** (six-step process starting with "read the entire diff before writing anything"): Forces the model to understand the full scope before it starts writing, which prevents descriptions that peter out or miss connections between related changes across files.
- **Anti-pattern avoidance** (seven rules including "do not write 'No risks' when there are clearly risks" and "do not just list the files that changed"): These target the specific ways PR descriptions fail. The "No risks" anti-pattern is particularly important because it forces honest risk assessment instead of the reflexive "low risk" that reviewers have learned to ignore.
- **Unrelated change separation**: Explicitly requiring a separate subsection for opportunistic cleanups prevents reviewers from confusing a typo fix with the core logic change, which is a common source of review friction.
- **Review order guidance**: The "How to Review" section is the highest-value part of the description for large PRs. By requiring the model to suggest which files to read first and what logic to scrutinize, it transforms the reviewer's experience from "wade through 500 lines" to "start here, then check this."

The fundamental shift is that a naive prompt produces a description for the author (what I did). This prompt produces a description for the reviewer (what you need to know).

## Usage Tips

- Paste the actual diff output from `git diff`, `git diff main...HEAD`, or your PR tool. The model produces better descriptions from real diffs than from verbal descriptions of changes.
- For large PRs (500+ lines), consider splitting the diff into logical chunks and running the prompt per chunk, then assembling the results.
- Review the generated "How to Review" section carefully. Good review guidance dramatically improves both review quality and review speed. If the suggested order does not match how you think about the change, adjust it.
- Pair this with the code-review prompt to self-review your PR before requesting human reviewers. The description helps you catch scope creep (unrelated changes) and missing test coverage.
- If your team has a PR template, include it in the prompt context so the model follows the same structure.
- Add the related issue or ticket number so the model can frame the motivation around the actual problem being solved, not a generic explanation.
- **Related tool:** If you use `claude-commands`, the `/changelog` and `/release-notes` slash commands can generate release-facing summaries from the same diff.

## Example Output

```markdown
## Summary

This PR adds KV-cache-aware routing to the inference gateway. Requests are now
routed to serving replicas that have warm caches for the requested model, reducing
cold-start latency by up to 40% for repeated model invocations.

## Motivation

Issue #347: Users reported high latency on inference requests that should have been
fast (warm model, low batch size). Investigation showed that round-robin routing was
distributing requests across all replicas evenly, regardless of cache state. Replicas
without a warm cache had to reload the model weights, adding 2 to 4 seconds of latency
per request.

## What Changed

**gateway/router.go**
- Replaced round-robin replica selection in `selectReplica()` with cache-aware selection.
  The new logic queries each replica's cache state and prefers replicas with warm caches
  for the requested model. Falls back to round-robin if no replica has a warm cache.
- Added `CacheStateTracker` struct that polls serving replicas for their cache occupancy
  every 5 seconds via HTTP health endpoints.

**gateway/router_test.go**
- Added 12 new test cases covering: cache-hit routing, cache-miss fallback to round-robin,
  stale cache state handling (tracker has not refreshed yet), and replica health check
  failure.

**config/defaults.yaml**
- Added `cache_poll_interval` (default: 5s) and `cache_miss_fallback` (default:
  "round-robin") configuration options.

**Unrelated changes**
- Fixed a typo in `gateway/metrics.go` comment (line 14). Not related to the routing change.

## How to Review

Start with `gateway/router.go`, specifically the `selectReplica()` function (lines 45 to 92).
This is where the core routing logic changed. Pay attention to the fallback behavior when
no replica has a warm cache.

Then read `CacheStateTracker` (lines 94 to 140) to understand how cache state is collected.
The key question is whether the polling interval and staleness handling are correct.

After that, check `gateway/router_test.go` to verify edge cases are covered. The config
changes in `defaults.yaml` are straightforward and can be skimmed.

## Testing

- 12 new unit tests in `gateway/router_test.go` covering happy path, fallback, staleness,
  and health check failure scenarios.
- Run locally: `go test ./gateway/ -v -run TestCacheAwareRouting`
- Manually tested against a 3-replica staging cluster. Verified that requests for a warm
  model consistently route to the replica with the warm cache (checked via request logs).

## Risks and Rollback

- **Backward compatible**: Yes. The new behavior is additive. Existing config files without
  the new keys will use the default values (round-robin fallback).
- **Network overhead**: Cache polling adds one HTTP request per replica every 5 seconds.
  For a 100-replica cluster, that is 20 requests/second of polling traffic. This is
  negligible, but monitor if replica count grows significantly.
- **Rollback**: Set `cache_miss_fallback: "round-robin"` in config to disable cache-aware
  routing without redeploying. For a full rollback, revert this PR. No data migrations
  or schema changes are involved.
```
