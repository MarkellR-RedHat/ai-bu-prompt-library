# Testing Prompts

A practical guide to evaluating whether a prompt actually works. Writing the prompt
is half the job. Testing it is the other half.

## Why Testing Prompts Matters

A prompt that works once proves nothing. Prompts need to work reliably across
multiple runs, varied inputs, and (ideally) different models. Without testing, you
are shipping untested code.

The problems that testing catches:
- **Inconsistency:** The prompt produces good output sometimes and garbage other times.
- **Format drift:** The model ignores your format instructions on certain inputs.
- **Hallucination:** The model invents facts when the input is ambiguous or sparse.
- **Tone mismatch:** The output sounds like a marketing brochure when you needed
  an engineering document.
- **Over-sensitivity:** Small changes in input produce wildly different outputs.
- **Under-specification:** The prompt leaves too much to the model's discretion,
  producing unpredictable results.

Testing is how you catch these problems before someone else does.

## Testing Methodology

### Step 1: Define What "Good" Looks Like

Before running a single test, write down what a successful output includes:
- What information must be present?
- What format must it follow?
- What tone is appropriate?
- What should NOT appear in the output?
- How long should the output be (roughly)?

This gives you a rubric. Without a rubric, you are evaluating by gut feel, which
does not scale and does not transfer to other reviewers.

### Step 2: Run the Prompt Multiple Times (N >= 5)

Run the same prompt with the same input at least five times. This is the minimum
needed to assess consistency.

**What to look for across runs:**
- Does the structure stay the same?
- Do the key points remain consistent?
- Does the tone hold steady?
- Are there any runs that are clearly worse than others?

**Record your results.** A simple table works:

| Run | Format Correct | Key Points Present | Tone Match | Issues |
|-----|---------------|-------------------|------------|--------|
| 1   | Yes           | 4/5               | Yes        | None   |
| 2   | Yes           | 5/5               | Yes        | None   |
| 3   | Partial       | 3/5               | No         | Hedging, missing section |
| 4   | Yes           | 5/5               | Yes        | None   |
| 5   | Yes           | 4/5               | Yes        | Minor  |

If more than one run out of five fails your criteria, the prompt needs work.

### Step 3: Vary the Inputs

Test with different inputs to check robustness:
- **Typical input:** The expected, well-formed case.
- **Minimal input:** The bare minimum someone might provide.
- **Messy input:** Poorly formatted, typos, mixed languages.
- **Edge case input:** Empty fields, extremely long content, unexpected formats.
- **Adversarial input:** Inputs designed to break the prompt or cause the model
  to ignore instructions.

A good prompt handles all of these gracefully. It does not need to produce perfect
output for adversarial inputs, but it should fail safely (e.g., ask for clarification
rather than hallucinate).

### Step 4: Compare Against a Baseline

If you are improving an existing prompt, run both the old and new versions on the
same inputs. Compare:
- Does the new version produce better output?
- Does it produce more consistent output?
- Does it handle edge cases better?
- Did you lose anything that the old version did well?

### Step 5: Get a Second Opinion

Have someone else review the outputs without telling them which prompt version
produced which output. Fresh eyes catch problems that you have gone blind to.

## Evaluation Criteria

Use these six criteria to evaluate prompt outputs. Not every criterion applies to
every prompt, but most prompts should be evaluated on at least four of them.

### 1. Accuracy

The output is factually correct and technically sound.

**Check for:**
- Are claims supported by the input data?
- Are technical details correct (API names, command syntax, version numbers)?
- Does the output distinguish between facts and inferences?
- Are there any hallucinated details?

**Red flags:**
- Specific numbers or dates that were not in the input
- Tool names or flags that do not exist
- Confident statements about ambiguous situations

### 2. Consistency

The output is stable across multiple runs with the same input.

**Check for:**
- Does the structure remain the same?
- Do the main conclusions stay consistent?
- Is the level of detail similar across runs?

**Red flags:**
- Contradictory recommendations between runs
- Wildly different lengths (one run is 3 paragraphs, another is 15)
- Some runs include sections that others omit entirely

### 3. Format Compliance

The output follows the specified format exactly.

**Check for:**
- Are all requested sections present?
- Are headers, lists, and tables formatted correctly?
- Does the output stay within length constraints?
- Are placeholders properly filled in (no leftover `[BRACKETS]`)?

**Red flags:**
- Missing sections
- Extra sections the format did not request
- Prose where bullets were specified (or vice versa)
- Output significantly longer or shorter than specified

### 4. Tone

The output matches the intended voice and register.

**Check for:**
- Does it match the target audience's expectations?
- Is it appropriately technical (or non-technical)?
- Is it direct and actionable, or vague and hedging?

**Red flags:**
- Marketing language in a technical document
- Casual tone in a formal context
- Excessive qualifiers ("might", "could potentially", "it's worth noting that")
- Filler phrases ("Great question!", "Certainly!", "Absolutely!")

### 5. Actionability

The output gives the reader something concrete to do next.

**Check for:**
- Are recommendations specific enough to act on?
- Do action items have clear owners and timelines?
- Can someone follow the instructions without additional research?

**Red flags:**
- Vague advice ("consider improving performance")
- Recommendations without context on how to implement them
- Lists of options without a clear recommendation

### 6. Completeness

The output covers the full scope of the task without significant gaps.

**Check for:**
- Are all aspects of the question addressed?
- Are edge cases mentioned?
- Are trade-offs discussed where relevant?

**Red flags:**
- Entire categories of the question ignored
- Only the easy parts addressed
- "And more..." or similar hand-waving at the end

## How to Spot a Bad Prompt

### Symptom: Output quality varies wildly between runs

**Likely cause:** The prompt is too vague or has too many degrees of freedom.
**Fix:** Add more structure. Specify the format. Constrain the length. Add examples
of what good output looks like.

### Symptom: The model ignores parts of the prompt

**Likely cause:** The prompt is too long, or the ignored instructions are buried
in the middle.
**Fix:** Move critical instructions to the beginning and end of the prompt (recency
and primacy effects). Break long prompts into sections with clear headers. Repeat
the most important constraints.

### Symptom: The output is generic and could apply to anything

**Likely cause:** The prompt does not provide enough context or does not require
the model to use the specific input.
**Fix:** Add explicit instructions like "Reference specific details from the provided
[INPUT]." Add a verification step: "Confirm that every recommendation directly
addresses something in the input."

### Symptom: The model adds information that was not in the input

**Likely cause:** The prompt does not constrain the model to the provided information.
**Fix:** Add constraints: "Base your analysis only on the information provided. If
the input is insufficient to answer a question, say so rather than filling in gaps
with assumptions."

### Symptom: The tone is wrong

**Likely cause:** The role setting is missing or too generic.
**Fix:** Be specific about the role and audience. Add anti-pattern instructions for
the specific tone problems you see. Include a brief example of the desired tone.

### Symptom: The output is too long or too short

**Likely cause:** No length constraints in the prompt.
**Fix:** Specify length explicitly: "Provide 3-5 bullet points," "Keep the summary
under 200 words," "Write 2-3 paragraphs." Be specific about which sections should
be longer and which should be brief.

## Prompt Review Checklist

Use this checklist before committing a prompt to the library. Every item does not
need to be checked for every prompt, but you should be able to justify skipping any
item you leave unchecked.

### Structure
- [ ] The prompt has a clear role assignment
- [ ] Context is provided (audience, situation, constraints)
- [ ] The task is specific and unambiguous
- [ ] Output format is explicitly specified
- [ ] Length constraints are stated where relevant

### Quality Controls
- [ ] Anti-patterns are explicitly blocked (filler, hedging, etc.)
- [ ] Edge cases are handled (empty input, ambiguous input)
- [ ] A verification/self-check step is included for complex tasks
- [ ] The prompt has been tested at least 5 times with the same input
- [ ] The prompt has been tested with at least 3 different inputs

### Documentation
- [ ] All placeholders use [BRACKET] notation with descriptive names
- [ ] Placeholders are documented in a table with descriptions and examples
- [ ] Usage notes explain when and how to use the prompt
- [ ] An example output is provided

### Consistency
- [ ] Output format is stable across multiple runs
- [ ] Key conclusions are consistent across runs
- [ ] The prompt works with minimal input (does not require perfect input)
- [ ] Tone is appropriate and stable

## Iterating and Improving Prompts

Prompt engineering is iterative. Here is a process for systematic improvement.

### Round 1: Get the basics working

Write the prompt with role, task, and format. Run it 3 times. Check if the
output is in the right ballpark. At this stage, focus on getting the structure
and scope right. Do not optimize for edge cases yet.

### Round 2: Fix the obvious problems

Review the outputs from Round 1. Identify the biggest issues:
- Is the format wrong? Add more specific format instructions.
- Is the tone off? Adjust the role or add anti-pattern constraints.
- Is it missing key information? Make the task description more explicit.

Run 3 more times. Compare to Round 1 outputs.

### Round 3: Stress test

Now test with varied inputs: minimal, messy, edge case. Fix any failures.
This is where you add edge case handling instructions and input validation
guidance.

### Round 4: Polish and validate

Run the final version 5 times with your standard test input. Run it 2-3 times
each with varied inputs. Confirm that all evaluation criteria are met.
Document the prompt with placeholders, usage notes, and example output.

### Round 5: Peer review

Have someone else use the prompt without your guidance. Watch where they
struggle or get unexpected results. Those are your remaining gaps.

### When to stop iterating

You are done when:
- 4 out of 5 runs with the same input meet all your evaluation criteria
- The prompt handles minimal and messy inputs gracefully
- Someone else can use the prompt successfully without your help
- The output is useful without further editing in most cases

Perfection is not the goal. Reliability is.

## Testing Tools and Approaches

### Manual testing

For most prompts in this library, manual testing is sufficient. Run the prompt
in your preferred interface, compare the outputs, and record results in a
simple table or spreadsheet.

### Side-by-side comparison

When iterating on a prompt, keep the previous version. Run both versions on
the same input and compare outputs directly. This prevents regression and
makes improvements visible.

### Checklist-based evaluation

For each test run, score the output against your evaluation criteria using a
simple pass/fail for each criterion. This makes it easy to spot patterns:
if "format compliance" fails on 3 out of 5 runs, you know exactly what to fix.

### Collecting feedback

If other people use the prompt, collect their feedback systematically:
- Did the output answer their question?
- Did they need to edit the output before using it?
- What did they wish the output included?
- What did they wish the output excluded?

This feedback is the most valuable input for prompt improvement.

## Final Notes

Testing prompts is not glamorous work, but it is the difference between a prompt
library that people trust and one they abandon. Every prompt in this library should
be tested before it is committed.

The process does not need to be heavy. Five runs with the same input, three varied
inputs, and a quick pass through the checklist is enough for most prompts. Save
the thorough stress testing for prompts that will be used in critical workflows.

When in doubt, test one more time. The cost of running a prompt is low. The cost
of shipping a bad prompt is high, because people will use it, get bad results, and
stop trusting the library.

See [prompt-engineering-guide.md](prompt-engineering-guide.md) for guidance on
writing prompts that pass these tests.
