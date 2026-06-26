# Debug Helper Prompt

A structured prompt for systematic debugging that enforces root cause analysis before jumping to fixes, using a hypothesis-driven approach modeled on the scientific method.

**Difficulty:** Intermediate

## Naive vs. Engineered

Most people hit a bug and type something like:

> **Naive prompt:** "I'm getting this error, how do I fix it?"

**What you get:** The model guesses at a fix based on the error message alone. Something like:

> This error usually happens when the database connection times out. Try these steps:
> 1. Make sure your database is running.
> 2. Check your connection string in the config file.
> 3. Try increasing the timeout value.
> 4. Restart the service and try again.
> 5. If none of that works, try reinstalling the database driver.

No root cause analysis. No hypotheses. No diagnostic steps. You try each suggestion, none of them work, you paste the new error, and you are now three rounds into a trial-and-error loop that is no better than Stack Overflow.

**This prompt** produces a structured investigation: restating the bug to confirm understanding, isolating the failure domain, generating ranked hypotheses with supporting evidence, and designing specific diagnostic steps you can run right now to confirm or eliminate each hypothesis. Instead of "check your connection string," you get: "Add `logger.debug(f"pool_size={pool.size()}, active={pool.active()}")` at line 34 of `db/connection.py`, then send the failing request with `curl -X POST http://localhost:8000/api/v1/orders -d '{"sku":"W1"}'`. If pool active count equals pool size, hypothesis 1 (connection pool exhaustion) is confirmed."

## When to use

- You have been stuck on a bug for more than 30 minutes and need a structured approach to break out of trial-and-error guessing
- You are dealing with a cryptic error message or stack trace that does not clearly point to a root cause
- You want to debug methodically instead of randomly changing code and hoping something works
- You are debugging in an unfamiliar codebase where you do not know the code paths, conventions, or failure modes
- You have multiple possible causes and need help narrowing them down efficiently using targeted diagnostic steps
- The bug is intermittent or environment-specific and you need to reason about what conditions trigger it
- You are pair-debugging with a colleague and want a shared framework to structure your investigation

## When NOT to use

- The bug is a simple typo or syntax error you can spot by reading the code. Just fix it.
- You need to debug a live production system in real time under active incident response. Use your observability tools (dashboards, traces, logs) first. Bring findings here for analysis after the fire is out.
- The issue is flaky test infrastructure unrelated to your application code. Fix the test environment instead.
- The problem is a known issue with a documented fix (check your issue tracker and release notes first).

## Prompt

````
You are an experienced software debugger helping me systematically diagnose a software issue. Your job is to guide me through root cause analysis, not to guess at fixes. Do not skip ahead to a solution before we have confirmed the root cause through evidence.

Context for this debugging session:
- Error message or symptom: [ERROR_MESSAGE]
- Relevant code (function or module where the error occurs, plus callers if known): [CODE]
- Environment details (OS, language version, runtime, container, dependency versions): [ENVIRONMENT]
- Steps that trigger the issue: [REPRODUCTION_STEPS]
- What has already been tried (if anything): [WHAT_YOU_ALREADY_TRIED_OR_NONE]

Follow this structured debugging process. Complete each step before moving to the next.

**Step 1: Reproduce and Clarify**
Based on the information I provided, restate your understanding of the bug in your own words. Specifically:
- What is the expected behavior?
- What is the actual behavior?
- Is the issue deterministic (happens every time) or intermittent?
- What are the minimum conditions required to reproduce it?
If any of this is unclear from the information I gave you, ask clarifying questions before proceeding. Do not guess at reproduction steps.

**Step 2: Isolate the Failure Domain**
Determine which component, layer, or boundary is most likely responsible. Analyze:
- Where in the call stack does the error originate?
- Is this a problem in our code, a dependency, the runtime, or the environment?
- Can we rule out entire subsystems based on the error type or location?
- Does the error correlate with a recent change (deployment, config update, dependency bump)?

**Step 3: Generate Ranked Hypotheses**
List the top 3 to 5 most probable root causes, ranked from most to least likely. For each hypothesis:
- State the hypothesis in one sentence
- Explain what evidence supports it (from the error message, stack trace, code, or environment)
- Explain what evidence would confirm it
- Explain what evidence would rule it out
- Rate your confidence: High, Medium, or Low

**Step 4: Design Diagnostic Steps**
For the most likely hypothesis, suggest 1 to 3 specific, concrete diagnostic steps I can take right now to confirm or eliminate it. Each step should be:
- A specific command to run (log statement, debugger breakpoint, curl command, database query, environment variable check, etc.)
- What to look for in the output
- What the result means (if you see X, the hypothesis is confirmed; if you see Y, move to hypothesis 2)

**Step 5: Fix and Verify**
Once we have confirmed the root cause through diagnostic evidence:
- Provide a targeted fix with a code snippet
- Explain why this fix addresses the root cause, not just the symptom
- Identify any regression risks the fix introduces
- Suggest a test case that would catch this bug if it were reintroduced

Self-critique checklist (apply before presenting your analysis):
- [ ] Did I base my hypotheses on evidence from the error message, stack trace, and code, or did I guess based on common bugs I have seen elsewhere?
- [ ] Did I consider environmental factors (version mismatches, config differences, resource limits) and not just code bugs?
- [ ] Are my diagnostic steps concrete and actionable? Can the developer run them right now without additional setup?
- [ ] Did I avoid jumping to a fix before the root cause was confirmed?
- [ ] Did I consider whether the bug could be a symptom of a deeper issue (e.g., a memory corruption bug manifesting as a null pointer)?
- [ ] Did I check whether the error message itself could be misleading (e.g., a timeout reported as a connection refused)?

Anti-patterns to avoid:
1. Do not suggest "add more logging everywhere" as a diagnostic step. Be specific about what to log, where, and what you expect to see.
2. Do not recommend restarting the service as a diagnostic step. Restarting may mask the root cause and destroy useful state.
3. Do not suggest upgrading dependencies unless you have specific evidence that the current version has a relevant known bug.
4. Do not blame "race condition" without explaining the specific interleaving of operations that would cause the observed behavior.
5. Do not suggest rewriting the code from scratch. Focus on understanding and fixing the actual bug.
6. Do not assume the bug is in the most recently changed code. Correlation is not causation; verify before concluding.

Edge case handling:
- If the error message is empty or generic (e.g., "Internal Server Error" or "Something went wrong"), focus on isolating which layer generated it by checking logs at each tier (load balancer, application, database).
- If the bug is intermittent, ask about load patterns, concurrency, time-of-day correlation, and resource utilization. Intermittent bugs are often caused by resource contention, timing-dependent code, or external service instability.
- If the stack trace points to library or framework code (not your application code), trace backwards to find the application code that called the library with incorrect arguments or in an incorrect state.
- If the environment details are missing or incomplete, ask for them. Many bugs are caused by version mismatches, missing environment variables, or incorrect configuration.
- If multiple errors are happening at the same time, determine whether they share a common cause or are independent. Look for a shared dependency or resource.
````

## Why This Works

This prompt applies a hypothesis-driven debugging methodology that prevents the model from jumping to conclusions:

- **Structured multi-step process** (five explicit steps from reproduction through verification): Forces the model to complete root cause analysis before suggesting fixes. This mirrors how experienced debuggers actually work, and it is the single biggest improvement over the naive approach, where the model skips straight to a guess.
- **Hypothesis ranking with evidence requirements**: Requiring the model to list what would confirm and what would rule out each hypothesis transforms vague hunches into testable predictions. This is the scientific method applied to debugging.
- **Persona framing** ("experienced software debugger" whose job is to "guide through root cause analysis, not guess at fixes"): The explicit instruction not to guess changes the model's behavior fundamentally. Without it, the model defaults to "here is the most common fix for this error."
- **Anti-pattern avoidance** (six specific rules like "do not suggest restarting the service" and "do not blame race condition without explaining the interleaving"): These block the lazy diagnostic shortcuts that waste your time and mask root causes.
- **Concrete diagnostic design**: Requiring each diagnostic step to include a specific command, what to look for, and what the result means gives you an actionable investigation plan instead of vague advice like "check the logs."
- **Multi-turn conversation design**: The prompt is built for iterative refinement. You run a diagnostic step, paste the results, and the model updates its hypothesis ranking. This feedback loop converges on the root cause much faster than the naive pattern of guessing, failing, and guessing again.

The core insight is that debugging is an information-gathering process, not a guessing game. The naive prompt treats it as guessing. This prompt treats it as investigation.

## Usage Tips

- Replace `[ERROR_MESSAGE]` with the exact error output, including the full stack trace if available. Partial stack traces often omit the most useful frames.
- Replace `[CODE]` with the relevant code. You do not need to include the entire file. Include the function where the error occurs, its callers, and any shared state it accesses.
- Replace `[ENVIRONMENT]` with runtime details like OS, language version, container runtime and version, dependency versions, and whether you are running locally, in CI, or in production.
- Replace `[REPRODUCTION_STEPS]` with the specific actions that trigger the bug. Include the exact input data if possible, since the bug may be input-dependent.
- Replace `[WHAT_YOU_ALREADY_TRIED_OR_NONE]` with any fixes or diagnostic steps you have already attempted. This prevents the model from suggesting things you have already ruled out.
- If you do not have all the input fields, fill in what you have and write "Not yet available" for the rest. The model will ask follow-up questions for missing information.
- This prompt works best in a multi-turn conversation. After the model suggests a diagnostic step, run it and paste the results back. The model will update its hypothesis ranking based on the new evidence and suggest the next step.
- Keep a running log of what you tried and what you saw. This is useful both for the debugging session and for documenting the fix later.

## Example Output

```
## Step 1: Reproduce and Clarify

Based on your description, here is my understanding of the bug:
- **Expected behavior**: POST /api/v1/orders with a `shipping_address` field containing
  accented characters (e.g., "Renee Lefevre") should create the order successfully and
  return HTTP 201.
- **Actual behavior**: The service returns HTTP 500 with no useful error message in the
  response body. The stack trace in the application logs points to
  `OrderSerializer.validate()` at line 34.
- **Deterministic**: Yes, this happens every time the `shipping_address` contains
  non-ASCII characters. ASCII-only addresses work fine.
- **Minimum reproduction**: Send any POST to /api/v1/orders where `shipping_address`
  contains at least one non-ASCII character.

## Step 2: Isolate the Failure Domain

The stack trace points to `OrderSerializer.validate()` at line 34, which calls
`ascii_check()`. This is in the validation layer, before the request ever reaches the
database or any external service. The failure domain is the input validation code in our
application.

I can rule out:
- Database encoding issues (the error occurs before the DB call)
- Upstream proxy header problems (other endpoints handle Unicode fine)
- Network or infrastructure issues (the error is deterministic and input-dependent)

## Step 3: Ranked Hypotheses

1. **`ascii_check()` raises an unhandled UnicodeEncodeError** (Confidence: High)
   The function calls `.encode('ascii')` without a try/except. Any non-ASCII input would
   throw here. The stack trace ends on exactly this line. Evidence to confirm: add a log
   line before the encode call and inspect the raw input value. Evidence to rule out:
   if the log shows the input is already ASCII, the error is elsewhere.

2. **The validation schema rejects non-ASCII input by design, but the error response
   is not being serialized properly** (Confidence: Low)
   If `ascii_check()` is intentionally rejecting non-ASCII input, the bug might be
   that the rejection is not caught and returned as a 400 instead of causing a 500.
   Evidence to confirm: check whether `ascii_check()` is documented as a deliberate
   constraint. Evidence to rule out: if no such documentation exists and other string
   fields accept Unicode, this was not intentional.

3. **A middleware or framework interceptor is re-encoding the request body before it
   reaches the serializer** (Confidence: Low)
   Some frameworks re-encode request bodies if the Content-Type charset is missing.
   Evidence to confirm: log `request.content_type` and check whether charset=utf-8
   is present. Evidence to rule out: if charset is present and correct, the framework
   is not re-encoding.

## Step 4: Diagnostic Steps

For hypothesis 1, do the following:

**Step A**: Add this log line immediately before the `.encode('ascii')` call in
`ascii_check()` at line 34:

    logger.debug(f"ascii_check input: {repr(address)}, type: {type(address)}")

**Step B**: Send the failing request:

    curl -X POST http://localhost:8000/api/v1/orders \
      -H "Content-Type: application/json" \
      -d '{"shipping_address": "Renee Lefevre", "items": [{"sku": "W1", "qty": 1}]}'

**Step C**: Check the application logs for the debug line.

- If you see the non-ASCII characters in the repr output and the next log line is
  the UnicodeEncodeError traceback, hypothesis 1 is confirmed.
- If the repr shows only ASCII characters, the input is being transformed before
  reaching this function. Move to hypothesis 3.
```
