# Code Review Prompt

A structured prompt for conducting thorough, multi-dimensional code reviews that surface correctness bugs, security gaps, performance issues, and maintainability concerns with actionable, fix-ready feedback.

**Difficulty:** Intermediate

## When to use

- Reviewing a pull request before merging, especially when the changeset touches unfamiliar code or crosses module boundaries
- Performing a self-review of your own code before requesting human review, so you catch the obvious issues first
- Checking code written in a language or framework you are less experienced with, where idiomatic patterns may not be obvious to you
- Getting a structured second opinion on a tricky changeset when no other reviewers are available
- Reviewing a patch from an external contributor who may not know your project's conventions or coding standards
- Auditing legacy code that is being modified for the first time in months or years, where hidden assumptions may lurk
- Preparing for a team code review session by generating an initial set of findings to discuss

## When NOT to use

- The code needs a full security audit with threat modeling and penetration testing. Engage your security team for that. This prompt catches surface-level security issues, not deep vulnerability chains or business logic exploits.
- You need to verify runtime behavior, timing-dependent bugs, or environment-specific failures. Write tests or run the code instead. Static review cannot catch race conditions that only manifest under load.
- The changeset is trivial (renaming a variable, fixing a typo, updating a comment). A quick read is faster than setting up this prompt.
- You need compliance verification against a specific standard (SOC 2, HIPAA, FedRAMP). Use the appropriate compliance checklist or tooling for that.

## Prompt

````
You are a senior software engineer performing a detailed, structured code review. Your goal is to identify real problems and provide actionable fixes, not to nitpick style preferences or invent issues that do not exist.

Context for this review:
- Language and framework: [LANGUAGE_AND_FRAMEWORK]
- Purpose of this code: [BRIEF_DESCRIPTION_OF_WHAT_THE_CODE_DOES]
- Any specific concerns the author wants reviewed: [SPECIFIC_CONCERNS_OR_NONE]

Review the code below and provide feedback organized into these categories, in this order:

1. **Correctness**: Logic errors, off-by-one mistakes, unhandled edge cases, race conditions, incorrect return values, broken control flow, type mismatches, and incorrect assumptions about library behavior.
2. **Security**: Injection vulnerabilities (SQL, command, XSS), improper input validation, hardcoded secrets or credentials, insecure defaults, missing authentication or authorization checks, path traversal risks, and unsafe deserialization.
3. **Performance**: Unnecessary allocations or copies, N+1 queries, missing database indexes, inefficient algorithms (especially inside loops), unbounded growth of data structures, missing pagination, and blocking calls in async contexts.
4. **Maintainability**: Unclear or misleading variable and function names, missing or outdated comments, overly complex logic that could be simplified, functions doing too many things, deep nesting that hurts readability, and violations of the project's established patterns.
5. **Error Handling**: Swallowed exceptions, missing error propagation, unclear or generic error messages, inconsistent error handling patterns, missing cleanup in error paths, and error codes that leak internal implementation details to end users.
6. **API Contract and Interface Design**: Breaking changes to public APIs, missing validation of inputs at API boundaries, inconsistent naming or parameter ordering compared to neighboring endpoints, and missing or incorrect type annotations.

Step-by-step reasoning process (follow this for each category):
1. Read through the entire code once to understand its overall structure and intent.
2. For each category, re-read the code with that specific lens. Do not try to evaluate everything at once.
3. For each issue you find, trace the execution path to confirm the issue is real. Do not flag speculative problems.
4. Consider how the issue would manifest in production. Would it cause data loss? A crash? A silent wrong result? A security breach? Rank severity accordingly.
5. Write a concrete fix. If the fix requires context you do not have (e.g., the database schema), state what you would need to confirm.

For each finding, use this format:
- **Issue title (severity: Critical / High / Medium / Low)** on the first line
- **Location**: File and line number or function name
- **Problem**: One or two sentences describing the issue
- **Impact**: What happens if this is not fixed (data corruption, crash, security exposure, etc.)
- **Fix**: A concrete code snippet showing the corrected version

If a category has no issues, write "No issues found." and move on. Do not pad the review with low-value observations to fill every category.

After completing all categories, run this self-critique checklist before presenting your final output:
- [ ] Did I confirm each finding by tracing the execution path, or did I flag something based on a hunch?
- [ ] Are my severity ratings calibrated? A cosmetic naming issue is not "High" severity. A potential data loss bug is not "Low."
- [ ] Did I provide a concrete fix for every finding, not just a description of the problem?
- [ ] Did I avoid inventing problems that are not actually present in the code?
- [ ] Did I check for issues at the boundaries (function inputs, API responses, error paths) and not just the happy path?
- [ ] Did I consider concurrency, if the code runs in a multi-threaded or async context?
- [ ] Did I check for resource leaks (unclosed files, connections, cursors)?

Anti-patterns to avoid:
1. Do not flag style preferences that are not bugs (e.g., "I would prefer a different variable name" when the current name is clear enough).
2. Do not recommend adding comments that would just restate what the code already says.
3. Do not suggest abstracting code into a separate function when the code is only used once and is already readable.
4. Do not flag missing error handling when the caller is explicitly designed to let exceptions propagate.
5. Do not recommend design pattern changes (e.g., "use the strategy pattern here") when the current code is simple and correct.
6. Do not suggest performance optimizations for code that is not on a hot path, unless the optimization also improves readability.
7. Do not hallucinate library APIs. If you are unsure whether a method exists, say so.

Edge case handling:
- If the code contains TODO or FIXME comments, flag them only if they indicate a real gap that could cause issues in production. Ignore aspirational TODOs.
- If the code uses deprecated APIs, note the deprecation and suggest the replacement, but rate it as Low severity unless the deprecated API has known bugs or security issues.
- If the code interacts with external services, check for timeout configuration, retry logic, and error handling for network failures.
- If the code handles user input, verify that all input paths are validated before use, not just the primary happy path.

Code to review:

[CODE]
````

## Usage Tips

- Replace `[LANGUAGE_AND_FRAMEWORK]` with specifics like "Python 3.11 with FastAPI and SQLAlchemy" or "Go 1.22 with standard library and chi router" so the model applies the right idioms and knows which library APIs are available.
- Replace `[BRIEF_DESCRIPTION_OF_WHAT_THE_CODE_DOES]` with a one-sentence summary of the code's purpose. This helps the reviewer understand intent and catch cases where the code does not match its stated goal.
- Replace `[SPECIFIC_CONCERNS_OR_NONE]` with any areas you want extra scrutiny on (e.g., "thread safety" or "SQL injection risk"). Write "None" if you want a general review.
- For large changesets, break the code into logical chunks and review each separately. Reviewing more than 300 lines at once tends to reduce the quality of feedback because the model loses track of earlier context.
- If you want the review focused on a single concern (for example, only security), remove the other categories from the prompt to keep the model focused.
- Run this prompt on your own code before requesting human review. It catches the mechanical issues, freeing your human reviewers to focus on design and architectural concerns.
- Pair this with the test-generator prompt to verify that the fixes you apply are covered by tests.

## Example Output

```
## Correctness

1. **Unbounded retry loop can block the worker thread indefinitely (severity: Critical)**
   **Location**: `order_service.py`, `process_order()`, line 42
   **Problem**: The retry loop around the upstream service call has no maximum attempt count and no backoff. If the upstream service stays down, this will spin forever.
   **Impact**: The worker thread is permanently consumed. Under sustained upstream failure, the entire worker pool is exhausted and the service stops processing orders.
   **Fix**:
   ```python
   MAX_RETRIES = 5
   for attempt in range(MAX_RETRIES):
       try:
           response = call_upstream()
           break
       except UpstreamError:
           if attempt == MAX_RETRIES - 1:
               raise
           time.sleep(min(2 ** attempt, 30))
   ```

2. **Off-by-one in pagination offset causes duplicate records (severity: High)**
   **Location**: `order_service.py`, `list_orders()`, line 89
   **Problem**: The offset is calculated as `page * page_size` but pages are 1-indexed. Page 1 starts at offset `page_size` instead of 0, skipping the first page of results entirely.
   **Impact**: Users never see the first page of results. The second page shows what should be on page 1.
   **Fix**:
   ```python
   offset = (page - 1) * page_size
   ```

## Security

No issues found.

## Performance

1. **Repeated database query inside loop fetches the same user on every iteration (severity: Medium)**
   **Location**: `order_service.py`, `send_notifications()`, line 67
   **Problem**: `get_user(user_id)` is called on every iteration of the message loop, but the user data does not change within the loop.
   **Impact**: Unnecessary database load. At 100 messages per batch, this produces 99 extra queries per invocation.
   **Fix**: Hoist the query above the loop:
   ```python
   user = get_user(user_id)
   for message in messages:
       send_to(user, message)
   ```

## Maintainability

1. **Variable name `d` is ambiguous (severity: Low)**
   **Location**: `order_service.py`, line 23
   **Problem**: `d` is used for the delivery status object. Without reading the surrounding code, there is no way to know what `d` represents.
   **Impact**: Increases cognitive load for future readers and reviewers.
   **Fix**: Rename to `delivery_status`.

## Error Handling

1. **Bare except swallows all exceptions including KeyboardInterrupt (severity: High)**
   **Location**: `order_service.py`, `process_batch()`, line 112
   **Problem**: The `except:` clause catches everything, including SystemExit and KeyboardInterrupt. Failed orders are silently skipped with no logging.
   **Impact**: Bugs in order processing are invisible. Failed orders are never retried and no alert fires.
   **Fix**:
   ```python
   except (UpstreamError, ValidationError) as e:
       logger.error("Failed to process order %s: %s", order.id, e)
       failed_orders.append(order.id)
   ```

## API Contract and Interface Design

No issues found.
```
