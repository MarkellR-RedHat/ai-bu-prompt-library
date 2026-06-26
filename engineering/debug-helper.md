# Debug Helper Prompt

A prompt for systematic debugging that walks through root cause analysis instead of jumping to guesses.

**Difficulty:** Intermediate

## When to use

- You have been stuck on a bug for more than 30 minutes and need a structured approach
- You are dealing with a cryptic error message or stack trace that does not clearly point to a root cause
- You want a systematic, methodical process instead of random trial-and-error guessing
- You are debugging in an unfamiliar codebase where you do not know the code paths well
- You have multiple possible causes and need help narrowing them down efficiently

## When NOT to use

- The bug is a simple typo or syntax error you can spot by reading the code. Just fix it.
- You need to debug a live production system in real time. Use your observability tools (dashboards, traces, logs) first, then bring findings here for analysis.
- The issue is flaky test infrastructure unrelated to your application code. Fix the test environment instead.

## Prompt

```
You are an experienced debugger helping me diagnose a software issue. Walk through this problem systematically using the following approach:

1. **Reproduce**: Based on the information I provide, confirm your understanding of when and how the bug manifests. Ask clarifying questions if the reproduction steps are unclear.
2. **Isolate**: Identify which component or layer is most likely responsible. Narrow down by analyzing the error message, stack trace, and surrounding code.
3. **Hypothesize**: List the top 3 most probable root causes, ranked by likelihood. For each hypothesis, explain what evidence supports it and what evidence would rule it out.
4. **Verify**: For the most likely hypothesis, suggest a specific diagnostic step I can take right now (a log statement, a query, a debugger breakpoint, a curl command, etc.) to confirm or eliminate it.
5. **Fix**: Once we identify the root cause, provide a targeted fix with an explanation of why it works.

Do not skip ahead to a fix before we have confirmed the root cause.

Error message or symptom: [ERROR_MESSAGE]
Relevant code: [CODE]
Environment details: [ENVIRONMENT]
Steps that trigger the issue: [REPRODUCTION_STEPS]
```

## Usage Tips

- Replace `[ERROR_MESSAGE]` with the exact error output, including stack traces if available.
- Replace `[CODE]` with the relevant code. You do not need to include the entire file, just the function or module where the error occurs plus any callers.
- Replace `[ENVIRONMENT]` with runtime details like OS, language version, container runtime, and dependency versions.
- Replace `[REPRODUCTION_STEPS]` with the specific actions that trigger the bug.
- If you do not have all four pieces of information, fill in what you have and leave the others as "not yet available." The model will ask follow-up questions.
- This prompt works well in a multi-turn conversation. After the model suggests a diagnostic step, run it and paste the results back for the next round of analysis.

## Example Output

```
## Reproduce

Based on your description, the service returns a 500 error on POST /api/v1/orders
when the `shipping_address` field contains non-ASCII characters (for example,
accented names like "Renee"). This happens consistently, not intermittently.
Let me know if that understanding is correct.

## Isolate

The stack trace points to `OrderSerializer.validate()` at line 34, which calls
`ascii_check()`. This is in the validation layer, before the request ever
reaches the database.

## Hypothesize

1. **`ascii_check()` raises an unhandled UnicodeEncodeError** (most likely).
   The function calls `.encode('ascii')` without a try/except. Any non-ASCII
   input would throw here. Evidence: the stack trace ends on that exact line.

2. **Database column encoding mismatch.** The `shipping_address` column might
   be defined as ASCII-only. Evidence against: the error occurs before the
   DB call.

3. **Upstream proxy is mangling the Content-Type header.** If charset is
   missing, the framework might default to ASCII. Evidence against: other
   endpoints handle Unicode fine.

## Verify

Add this log line right before the `.encode('ascii')` call to confirm
hypothesis 1:

    logger.debug(f"Raw address value: {repr(address)}")

Then re-send the failing request and check the log output.
```
