# Demo Script Generator

Create a structured, time-boxed demo script that walks through a real engineering workflow, anticipates failure points, and lands a clear technical takeaway for your audience.

**Difficulty:** Intermediate

## When to use

- Preparing a live demo for a conference talk, meetup, or workshop where you will run real commands in a terminal or interact with a live system.
- Creating a recorded demo for a blog post, video tutorial, or social media clip that needs tight pacing and clear narration cues.
- Building a demo for a customer or partner meeting where showing a working system is more persuasive than slides.
- Rehearsing a demo and you need a structured script with talking points, expected outputs, and timing markers so you can practice against the clock.
- Building a demo that includes a deliberate failure scenario to show resilience, error handling, or recovery behavior.
- Onboarding a teammate who needs to deliver the same demo you have given before, and you want a reproducible, self-contained script they can follow.
- Preparing a backup plan: you want a pre-recorded version of the demo in case the live environment has issues on stage.

## When NOT to use

- You need a full tutorial with step-by-step explanations, prerequisite setup, and conceptual background. Use the tutorial-outline prompt instead.
- The presentation is purely slides-based with no live interaction, terminal work, or UI walkthrough.
- You are writing a product data sheet, feature comparison, or marketing collateral. That is a different format entirely.
- The "demo" is actually a hands-on lab where the audience follows along. Use a workshop or lab prompt instead, since pacing and structure differ significantly.

## Prompt

```text
You are a senior developer advocate at an infrastructure software company. You specialize
in creating live technical demos that are clear, reproducible, and tightly scoped to a
single takeaway. You have deep experience presenting at conferences like KubeCon, DevConf,
and Red Hat Summit. You understand that a good demo respects the audience's time, shows
real commands against real systems, and never relies on hand-waving or "imagine this works."

Your task is to write a complete demo script for the following inputs:

- Product or project: [PRODUCT]
- Demo topic: [TOPIC]
- Target audience: [AUDIENCE, e.g., platform engineers, ML engineers, application developers]
- Time limit: [DURATION, e.g., 10 minutes]
- Environment: [ENVIRONMENT, e.g., OpenShift cluster, local laptop, cloud sandbox]
- Key takeaway: [ONE_SENTENCE_TAKEAWAY, e.g., "llm-d can serve multiple LoRA adapters from a single base model, cutting GPU memory by 60%."]

Follow these steps carefully, thinking through each one before writing your output:

Step 1: Understand the audience.
Consider what the target audience already knows and what they care about. Platform engineers
care about operations, reliability, and resource efficiency. ML engineers care about model
performance, iteration speed, and tooling. Application developers care about APIs, SDKs,
and integration patterns. Tailor your language, commands, and talking points accordingly.

Step 2: Define the narrative arc.
Every demo needs a story: what problem exists, what solution you are showing, and what the
audience should walk away believing. Write a one-sentence problem statement and a
one-sentence resolution before you draft any steps. The demo should feel like a journey
from problem to proof, not a disconnected list of commands.

Step 3: Build the pre-demo checklist.
List every prerequisite: running services, installed CLIs, authenticated sessions, deployed
resources, environment variables, and test data. Be exhaustive. A demo that fails because
of a missing prerequisite is a demo that fails entirely. Include version numbers where they
matter.

Step 4: Write the numbered steps.
For each step, include exactly these four elements:
  a) The command or UI action (exact, copy-pasteable, no pseudocode).
  b) The expected output or visible behavior (what the audience sees on screen).
  c) A one-line talking point explaining why this step matters to the audience.
  d) A timing estimate in seconds or minutes for this step.
Keep the total time within the stated time limit. If your steps exceed the limit, cut scope
rather than rushing. A shorter demo done well beats a rushed demo that loses the audience.

Step 5: Add a failure scenario.
Include one intentional "what if" moment. Show what happens when something breaks, and how
the product handles it gracefully. This builds credibility. Choose a failure that is
realistic and relevant, not contrived. Show the recovery path.

Step 6: Write the closing.
Summarize the key takeaway in one sentence. Provide a concrete next step: a URL, a repo to
clone, a doc to read, or a command to try. Do not end with vague statements like "there is
so much more to explore." Give the audience a specific action.

Step 7: Self-critique checklist.
Before finalizing your output, verify each of the following. If any check fails, revise
your script before presenting it:
  [ ] Every command is exact and copy-pasteable, with no placeholder syntax left unresolved
      except the original bracketed inputs.
  [ ] The total estimated time fits within the stated time limit, with at least 60 seconds
      of buffer for unexpected delays.
  [ ] The narrative arc is clear: problem, solution, proof, takeaway.
  [ ] The talking points use plain, technical language with no marketing buzzwords.
  [ ] The failure scenario is realistic and the recovery is demonstrated, not just described.
  [ ] The pre-demo checklist is complete enough that a teammate could set up the environment
      from scratch using only this list.
  [ ] Each step's expected output is specific enough that you would notice if something
      went wrong.
  [ ] The closing includes a concrete, specific next step, not a vague call to action.

Anti-patterns to avoid:
  1. DO NOT use marketing language ("revolutionary," "game-changing," "seamless,"
     "next-generation"). Use engineering language ("reduces memory usage by 60%,"
     "eliminates the need to deploy separate model instances," "cuts cold-start time
     from 45s to 8s").
  2. DO NOT include steps that require the audience to "imagine" an outcome. Every step
     must produce visible, verifiable output on screen.
  3. DO NOT skip error handling. If a command could fail in a live setting, acknowledge it
     and include a recovery step or a note about what to check.
  4. DO NOT write a demo longer than the stated time limit. Scope down aggressively. A
     focused five-minute demo is better than a scattered fifteen-minute one.
  5. DO NOT assume the audience has context you have not provided. State versions, URLs,
     and configuration values explicitly.
  6. DO NOT use filler talking points like "as you can see" or "this is really cool."
     Every talking point should convey information the audience did not already have.
  7. DO NOT combine multiple concepts into a single step. One step, one action, one
     observable result.

Edge case handling:
  - If the time limit is under 5 minutes, skip the failure scenario and note that it was
    omitted due to time constraints. Focus entirely on the happy path.
  - If the environment is "local laptop," include OS-specific notes for macOS and Linux
    where commands differ (e.g., brew vs. dnf).
  - If the audience is mixed (e.g., "developers and operations"), add a brief note at each
    step indicating who cares most about that step and why.
  - If the product is pre-release or alpha, flag any commands or APIs that may change and
    note the version you tested against.
  - If the demo involves GPUs or specialized hardware, include a fallback path using CPU
    or simulation mode so the demo can be rehearsed without the hardware.

Output format:
  Use markdown. Structure the output with these exact headings:
  ## Setup (one-sentence problem statement)
  ## Pre-Demo Checklist (bulleted list)
  ## Demo Steps (numbered, with Command, Expected Output, Talking Point, and Time for each)
  ## Failure Scenario (what breaks, what the audience sees, how you recover)
  ## Closing (takeaway sentence and specific next step)
  ## Total Estimated Time (sum of all step times, compared to the time limit)
```

## Usage Tips

- Fill in every bracketed placeholder before running the prompt. The more specific you are about your audience, environment, and takeaway, the more useful the output will be.
- If your demo exceeds 15 minutes, split it into two separate prompts, one per segment. Each segment should have its own takeaway.
- After generating the script, do a full dry run against your actual environment. The prompt produces realistic commands, but they need validation against your specific versions, configurations, and credentials.
- Pair this prompt with a screen recording session. Pre-record a backup video of the demo working correctly so you have a fallback if the live environment has issues on stage.
- Review the talking points out loud before presenting. Written talking points often sound stiff when spoken. Adjust them to match your natural speaking style.
- Time yourself during the dry run. If you are consistently running over the limit, cut a step rather than talking faster. Rushed demos lose audiences.
- If you are demoing for a customer, add their specific use case or data to the demo inputs. Generic demos are less convincing than ones that reference the audience's actual problem.

## Example Output

```markdown
## Setup
Platform teams running multiple fine-tuned models today must deploy each one as a separate
inference server, wasting GPU memory on duplicated base model weights. This demo shows how
llm-d serves multiple LoRA adapters from a single base model on OpenShift AI, cutting GPU
memory usage by 60% compared to running separate model instances.

## Pre-Demo Checklist
- OpenShift 4.15+ cluster with at least one GPU node (NVIDIA A100 or equivalent)
- llm-d operator installed (v0.1.0 or later)
- Two LoRA adapters ("customer-support-v2" and "code-review-v1") uploaded to the model registry
- Terminal with `oc` CLI v4.15+ authenticated to the cluster
- `curl` installed for sending inference requests
- Namespace `llm-d-demo` created and set as the current project
- Base model weights (Llama 3.1 8B) available in the connected model storage

## Demo Steps

### Step 1: Deploy the base model
**Command:**
  oc apply -f base-model-serving.yaml

**Expected output:**
  servingruntime.serving.kserve.io/llama-base created

**Talking point:** "We start with a single base model. No adapters loaded yet. This is
your cost baseline: one GPU, one model, one inference endpoint."

**Time:** 30 seconds (including talking)

### Step 2: Verify the base model is running
**Command:**
  oc get pods -l app=llama-base -w

**Expected output:**
  llama-base-predictor-0   2/2   Running   0   45s

**Talking point:** "The model is loaded and serving. This took about 45 seconds for an 8B
parameter model. Now let us add adapters without restarting anything."

**Time:** 60 seconds (waiting for pod readiness)

### Step 3: Attach the first LoRA adapter
**Command:**
  oc apply -f lora-customer-support.yaml

**Expected output:**
  loradeployment.llm-d.io/customer-support-v2 created

**Talking point:** "This LoRA adapter was fine-tuned for customer support responses. It is
roughly 50MB, a fraction of the 16GB base model. llm-d loads it into the same GPU memory
alongside the base weights."

**Time:** 30 seconds

### Step 4: Attach the second LoRA adapter
**Command:**
  oc apply -f lora-code-review.yaml

**Expected output:**
  loradeployment.llm-d.io/code-review-v1 created

**Talking point:** "Now we have two specialized models running on one GPU. Without llm-d,
this would require two separate inference servers and two full copies of the base model
weights."

**Time:** 30 seconds

### Step 5: Send a request to the customer support adapter
**Command:**
  curl -s -X POST https://llm-d-demo.apps.cluster.example.com/v1/completions \
    -H "Content-Type: application/json" \
    -d '{"model": "customer-support-v2", "prompt": "Customer asks: my order has not arrived. Response:", "max_tokens": 100}' | jq .

**Expected output:**
  A JSON response with a completion that uses customer-support tone and language patterns.

**Talking point:** "The request specifies which adapter to use by name. The routing happens
at the serving layer. Your application code just picks a model name."

**Time:** 30 seconds

### Step 6: Send a request to the code review adapter
**Command:**
  curl -s -X POST https://llm-d-demo.apps.cluster.example.com/v1/completions \
    -H "Content-Type: application/json" \
    -d '{"model": "code-review-v1", "prompt": "Review this function:\ndef add(a, b): return a + b", "max_tokens": 150}' | jq .

**Expected output:**
  A JSON response with a completion that provides code review feedback in a technical,
  structured format.

**Talking point:** "Same GPU, same base model, completely different behavior. The adapter
selection is transparent to the caller."

**Time:** 30 seconds

### Step 7: Show GPU memory usage
**Command:**
  oc exec llama-base-predictor-0 -c model-server -- nvidia-smi --query-gpu=memory.used,memory.total --format=csv

**Expected output:**
  memory.used [MiB], memory.total [MiB]
  18432 MiB, 40960 MiB

**Talking point:** "We are using 18GB for one base model plus two adapters. Without llm-d,
two separate deployments would need roughly 32GB. That is a 40% reduction, and it improves
as you add more adapters."

**Time:** 30 seconds

## Failure Scenario

**What breaks:** Delete the customer-support adapter while requests are in flight.

**Command:**
  oc delete loradeployment customer-support-v2

**What the audience sees:** Requests to the "customer-support-v2" model return a clear
error: `{"error": "model 'customer-support-v2' not found"}`. Requests to "code-review-v1"
continue working without interruption.

**Talking point:** "Removing an adapter does not crash the base model or affect other
adapters. Each adapter is independently managed. In production, this means you can roll
out, roll back, or retire adapters without downtime for your other models."

**Recovery:** Re-apply the adapter with `oc apply -f lora-customer-support.yaml`. It
reloads within seconds.

**Time:** 60 seconds

## Closing

**Takeaway:** llm-d lets you serve multiple specialized models from a single base model
deployment, cutting GPU memory costs and simplifying operations for platform teams managing
multiple fine-tuned models.

**Next step:** Clone the repo at github.com/llm-d/llm-d and follow the quickstart guide
to deploy your own multi-adapter setup on OpenShift AI or any Kubernetes cluster with GPU
nodes.

## Total Estimated Time
5 minutes 20 seconds out of a 10-minute limit. Remaining buffer: 4 minutes 40 seconds
for audience questions, unexpected delays, or deeper exploration of any step.
```
