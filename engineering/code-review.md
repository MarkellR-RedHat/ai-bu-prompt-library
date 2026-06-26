# Code Review Prompt

A prompt for conducting a thorough, structured code review that checks for correctness, security, performance, and maintainability.

## Prompt

```
You are a senior software engineer performing a detailed code review. Review the following code and provide feedback organized into these categories:

1. **Correctness**: Logic errors, off-by-one mistakes, unhandled edge cases, race conditions.
2. **Security**: Injection vulnerabilities, improper input validation, hardcoded secrets, insecure defaults.
3. **Performance**: Unnecessary allocations, N+1 queries, missing indexes, inefficient algorithms.
4. **Maintainability**: Unclear naming, missing or misleading comments, overly complex logic that could be simplified.
5. **Error Handling**: Swallowed exceptions, missing error propagation, unclear error messages.

For each finding:
- State the issue clearly in one sentence.
- Explain why it matters.
- Provide a concrete fix with a code snippet.

If the code looks solid in a category, say so briefly and move on. Do not invent problems that are not there.

Language/framework context: [LANGUAGE_AND_FRAMEWORK]
Code to review:

[CODE]
```

## Usage Tips

- Replace `[LANGUAGE_AND_FRAMEWORK]` with specifics like "Python 3.11 with FastAPI" or "Go 1.22 with standard library" so the model applies the right idioms.
- Replace `[CODE]` with the actual code block you want reviewed.
- For large changesets, break the code into logical chunks and review each separately. Reviewing more than 300 lines at once tends to reduce the quality of feedback.
- If you want the review focused on a specific concern (for example, thread safety), add that as an explicit instruction before the code block.

## Example Output

```
## Correctness

1. **Unbounded loop on retry logic (line 42)**
   The retry loop has no maximum attempt count. If the upstream service stays down, this will loop forever and block the worker thread.

   Fix: Add a max retry count and exponential backoff.

   ```python
   MAX_RETRIES = 5
   for attempt in range(MAX_RETRIES):
       try:
           response = call_upstream()
           break
       except UpstreamError:
           if attempt == MAX_RETRIES - 1:
               raise
           time.sleep(2 ** attempt)
   ```

## Security

No issues found.

## Performance

1. **Repeated database query inside loop (line 67)**
   `get_user(user_id)` is called on every iteration of the message loop, but the user data does not change within the loop.

   Fix: Hoist the query above the loop and reuse the result.

## Maintainability

1. **Variable name `d` is ambiguous (line 23)**
   Rename to `delivery_status` to make the code self-documenting.
```
