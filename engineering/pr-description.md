# PR Description Writer

Write a clear, well-structured pull request description from a diff or changeset that helps reviewers understand what changed and why.

**Difficulty:** Beginner

## When to use
- Opening a PR and need a clear description for reviewers
- The diff is large and reviewers need a guided tour of the changes
- You want to document the reasoning behind a refactor or architectural change
- Writing descriptions for PRs in a codebase you recently joined

## When NOT to use
- The PR is a one-line typo fix that needs no explanation
- You need a full design doc or RFC to justify the change (write that separately)

## Prompt

```
Write a pull request description based on the following diff. The description should help a reviewer understand what changed, why it changed, and how to review it effectively.

Repository: [REPO_NAME]
Branch: [BRANCH_NAME]
Related issue or ticket: [ISSUE_LINK_OR_TICKET_NUMBER]

Structure the description as follows:

1. **Summary** (2-3 sentences): What does this PR do? State the change in plain language.
2. **Motivation**: Why is this change needed? Link to the issue, bug report, or design doc that prompted it.
3. **What changed**: A bulleted list of the specific changes, grouped by file or component. For each change, explain what was modified and why.
4. **How to review**: Suggest a review order. Which files should the reviewer look at first? What is the most important change to scrutinize?
5. **Testing**: What tests were added or updated? How was this change validated? Include commands to run tests locally if relevant.
6. **Risks and rollback**: What could go wrong? Is this change backward compatible? How would you roll it back if needed?
7. **Screenshots or output** (if applicable): Include terminal output, API responses, or UI screenshots that show the change working.

Constraints:
- Be specific about what changed. "Refactored the service" is not useful. "Moved retry logic from the handler into a shared middleware" is.
- If the diff includes changes that are unrelated to the main purpose, call them out separately.
- Do not use em dashes. Use commas, periods, or "and" instead.

Diff:
[PASTE_DIFF_HERE]
```

## Usage Tips

- Paste the actual diff output from `git diff` or your PR tool. The model does better with real diffs than with verbal descriptions of changes.
- For large PRs (500+ lines), consider splitting the diff into logical chunks and running the prompt per chunk.
- Review the generated "How to review" section carefully. Good review guidance dramatically improves review quality and speed.
- Pair this with the code-review prompt to self-review your PR before requesting human reviewers.

## Example Output Snippet

> **Summary**: This PR adds KV-cache-aware routing to the inference gateway. Requests are now routed to serving replicas that have warm caches for the requested model, reducing cold-start latency.
>
> **What changed**:
> - `gateway/router.go`: Replaced round-robin selection with cache-aware selection. Added a `CacheStateTracker` that polls serving replicas for their cache occupancy every 5 seconds.
> - `gateway/router_test.go`: Added 12 new test cases covering cache-hit routing, cache-miss fallback, and stale cache state handling.
> - `config/defaults.yaml`: Added `cache_poll_interval` and `cache_miss_fallback` configuration options.
>
> **How to review**: Start with `gateway/router.go`, specifically the `selectReplica()` function. That is where the core routing logic changed. Then check the test file to verify edge cases are covered. The config changes are straightforward.
>
> **Risks and rollback**: The cache polling adds a small amount of network overhead (one HTTP call per replica every 5 seconds). If cache-aware routing causes issues, set `cache_miss_fallback: "round-robin"` in the config to revert to the previous behavior without redeploying.
