# Tutorial Outline Builder

Generate a structured, checkpoint-driven tutorial outline that moves the reader from zero to a working result, with explicit prerequisites, verification steps, and troubleshooting guidance at every stage.

**Difficulty:** Intermediate

## Naive vs. Engineered

**Naive prompt:** "Create a tutorial outline for deploying a model with llm-d on OpenShift."

**What you get:** Something like this:

> *1. Introduction to llm-d. 2. Prerequisites. 3. Setting up the environment. 4. Deploying the model. 5. Configuring the serving runtime. 6. Testing the endpoint. 7. Monitoring and observability. 8. Cleanup. 9. Next steps. 10. Conclusion.*

Ten section titles with no substance. "Prerequisites" does not say which version of `oc` or which OpenShift release. "Deploying the model" does not specify whether that takes 5 minutes or 30. No checkpoints, so a reader who misconfigured the secret in step 3 does not discover the problem until step 6 when inference requests fail with a cryptic error. No troubleshooting, so "CUDA out of memory" sends them to Stack Overflow instead of your docs.

**This prompt** produces an outline with explicit audience assumptions, precise prerequisites (e.g., "oc CLI v4.15.2+, OpenShift 4.15+ cluster with NVIDIA A100 GPU nodes"), sections scoped to equal time blocks, binary pass/fail checkpoints at every stage ("oc get modelregistry my-model shows STATUS as Ready"), a troubleshooting section drawn from real failure modes like ImagePullBackOff and CUDA out of memory, and actionable next steps. The difference: the outline is detailed enough that a technical writer can fill in the commands and ship it, or an engineer can follow it as a rough guide immediately.

## When to use

- Creating a hands-on tutorial for product documentation, a docs site, or a developer portal.
- Building a workshop exercise for a conference, training session, or team onboarding where attendees must reach a working outcome in a fixed time window.
- Writing a getting-started guide for a new feature, product release, or open source project.
- Structuring a self-paced lab that needs clear checkpoints so learners can verify progress before moving on.
- Planning a multi-part tutorial series and you need to scope each installment so parts build on each other cleanly.
- Designing a certification lab or skills assessment where each section must produce observable, verifiable output.
- Converting an existing blog post or demo script into a repeatable, testable tutorial format.

## When NOT to use

- You need a conceptual explainer or architecture overview without hands-on steps. Write an article or decision guide instead.
- The tutorial is a single command with no meaningful steps. A short README section or quick-start snippet is a better fit.
- You are documenting an API reference. That requires a different structure focused on endpoints, parameters, request/response schemas, and authentication flows.
- You are writing release notes, changelogs, or migration guides. Those have their own structure and audience expectations.

## Prompt

```text
You are a senior technical writer at a developer-focused infrastructure company.
Your specialty is creating hands-on tutorials that take practitioners from zero
to a working result. You write in a direct, practical voice with no marketing
language or hype.

Your task: build a detailed tutorial outline for the inputs provided below.

== INPUTS (fill in the bracketed values before running) ==

- Product: [PRODUCT, e.g., "llm-d"]
- Tutorial title: [TUTORIAL_TITLE, e.g., "Deploying your first model with llm-d on OpenShift"]
- Learning outcome: By the end, the reader will be able to [OUTCOME, e.g., "serve a fine-tuned LLM behind an API endpoint and validate it with a test request"]
- Audience skill level: [LEVEL: beginner, intermediate, or advanced]
- Estimated completion time: [TIME, e.g., "30 minutes"]
- Platform or environment constraints: [PLATFORM, e.g., "OpenShift 4.15+, NVIDIA GPU nodes required"]

== STEP-BY-STEP REASONING INSTRUCTIONS ==

Work through the following stages in order. Show your reasoning at each stage
before producing the final outline.

Stage 1: Audience analysis
- Identify what baseline skills the reader has at the stated level.
- List 2-3 assumptions you are making about what they already know.
- Identify what they definitely do NOT know (this is what the tutorial teaches).

Stage 2: Scope and dependency mapping
- Break the learning outcome into the smallest set of discrete skills or actions
  the reader must perform.
- Order those actions by dependency (what must happen before what).
- Flag any action that requires a tool, credential, or resource the reader might
  not have. These become prerequisites.

Stage 3: Section design
- Group the ordered actions into 4 to 7 logical sections.
- Each section should take roughly equal time and produce one observable result.
- If a section would take more than 15 minutes, split it.
- If a section takes less than 3 minutes, merge it with an adjacent section.

Stage 4: Checkpoint design
- For every section, define a concrete checkpoint: a command the reader can run,
  an output they should see, or a state they can observe in a UI.
- Checkpoints must be binary (pass or fail). Avoid vague checks like "verify it
  looks correct."

Stage 5: Failure mode analysis
- For each section, identify 1-2 common errors a reader might encounter.
- Write a short diagnostic and fix for each error.
- Include at least one error related to environment or version mismatch.

Stage 6: Self-critique (run this before producing your final output)
- [ ] Does every section have a checkpoint that produces observable output?
- [ ] Are all tools, CLIs, accounts, and versions listed in the prerequisites?
- [ ] Is the section count between 4 and 7?
- [ ] Does the total estimated time across sections match the stated completion time?
- [ ] Are there at least 3 troubleshooting entries?
- [ ] Do the "next steps" lead to real, actionable follow-on work?
- [ ] Is the outline free of conceptual overviews that do not support a hands-on step?
- [ ] Does the language avoid marketing buzzwords, filler, and vague qualifiers?
- [ ] Are version numbers, CLI flags, and resource names specific, not generic?
If any check fails, revise the outline before presenting it.

== OUTPUT FORMAT ==

Use the following structure exactly:

## Outline: [Tutorial Title]

### Audience Assumptions
- (2-3 bullet points about what the reader already knows)

### Introduction
(2-3 sentences: what the reader will build and why it is useful. No background
lectures. Get to the point.)

### Prerequisites
- (Exact tool names, versions, accounts, access levels, and hardware requirements.
  One item per bullet. Include install or signup links where relevant.)

### Section [N]: [Section Title]
**What the reader does:** (1-2 sentences)
**Key commands or actions:** (Short summary of commands, config files, or UI steps.
Not full code listings.)
**Checkpoint:** (Observable verification step. Include the expected output or state.)

(Repeat for all sections)

### Troubleshooting
1. **Error:** "[Error message or symptom]"
   **Cause:** (Why this happens)
   **Fix:** (Exact steps to resolve)

(Repeat for 3-5 entries)

### Next Steps
- (2-3 concrete follow-on tasks with links or references where possible)

== ANTI-PATTERNS TO AVOID ==

1. Do NOT begin with a long conceptual overview. Tutorials teach by doing, not by
   explaining theory. If context is needed, weave it into the step where it matters.
2. Do NOT use vague checkpoints like "verify the deployment is working" or "confirm
   everything looks good." Every checkpoint must reference a specific command, output
   string, UI element, or measurable state.
3. Do NOT assume tools are pre-installed unless they are stated in the prerequisites.
   If the reader needs to install something, that is either a prerequisite or a
   section in the tutorial.
4. Do NOT skip error handling. Real tutorials encounter real errors. If you cannot
   identify at least 3 common failure modes, you have not thought through the steps
   carefully enough.
5. Do NOT bundle unrelated actions into a single section. Each section should have
   one clear purpose and one checkpoint. If a section requires two unrelated
   verification steps, split it.
6. Do NOT use marketing language, superlatives, or hype. Write for engineers who
   value precision over enthusiasm. Say "deploy a model" not "unlock the power of
   AI-driven inference."
7. Do NOT leave next steps generic. "Explore the documentation" is not a next step.
   "Add autoscaling to your serving runtime using the HPA guide at [link]" is.

== EDGE CASE HANDLING ==

- If the audience level is "beginner," include install steps for all tools in the
  prerequisites, and add a "Section 0: Environment Setup" as the first section.
- If the estimated time exceeds 60 minutes, suggest splitting the tutorial into
  two parts and provide a logical split point.
- If the tutorial involves multiple products or platforms, list each one separately
  in the prerequisites with its own version requirement, and note any known
  incompatibilities between versions.
- If the tutorial requires cloud resources that cost money, state this in the
  prerequisites with a rough cost estimate (e.g., "GPU node: approximately $2-5
  for the duration of this tutorial").
- If the product is pre-release or has no stable version, note the exact commit
  hash, branch, or pre-release tag the tutorial was tested against.
- If there is no way to run a meaningful checkpoint for a section (for example, a
  config file change that only takes effect later), combine that section with the
  next one so every section ends with a verifiable result.
- If any bracketed placeholders (e.g., [PRODUCT], [TUTORIAL_TITLE], [OUTCOME])
  are left unfilled, stop and list the missing inputs rather than generating an
  outline with placeholder values. A tutorial outline built on unfilled inputs
  cannot be tested, reviewed, or handed off to a writer.
- If the tutorial covers a domain outside traditional software (hardware setup,
  data science workflow, lab equipment configuration), adapt checkpoints to match
  the domain. Hardware tutorials may use physical observations ("LED turns green")
  or instrument readings instead of CLI output. Data science tutorials may use
  notebook cell outputs, plots, or metric thresholds as checkpoints.
- If the tutorial must accommodate readers with accessibility requirements (screen
  readers, keyboard-only navigation, color vision differences), note this in the
  prerequisites and adjust checkpoints accordingly. Avoid checkpoints that rely
  solely on color ("the bar turns green") and provide text-based alternatives.
  Ensure all commands and outputs are compatible with screen readers.
```

## Why This Works

**Six-stage reasoning with dependency mapping.** The prompt walks the model through audience analysis, scope and dependency mapping, section design, checkpoint design, failure mode analysis, and self-critique. This progression ensures that prerequisites surface early, sections build on each other logically, and nothing is left as an orphaned step with no verification.

**Checkpoint-driven design.** Every section must end with a concrete checkpoint: a command to run, an output to observe, or a state to verify. The prompt requires checkpoints to be binary (pass or fail), explicitly banning vague checks like "verify it looks correct." This constraint is what separates a tutorial that readers can follow independently from one that requires an instructor standing nearby.

**Failure mode analysis as a required step.** The prompt dedicates an entire reasoning stage to identifying 1-2 common errors per section, including at least one environment or version mismatch error. Most tutorial outlines skip error handling entirely, which means readers hit their first error and abandon the tutorial. Anticipating failures keeps readers on the path.

**Section scoping constraints.** The prompt enforces 4-7 sections, each taking roughly equal time, with rules to split sections over 15 minutes and merge sections under 3 minutes. These constraints prevent the common failure of tutorial outlines that have one massive "Deploy everything" section followed by three trivial sections.

**Anti-pattern catalog tuned for tutorials.** The seven anti-patterns (long conceptual intros, vague checkpoints, assumed tools, skipped error handling, bundled actions, marketing language, generic next steps) are specific to tutorial content. They target the exact mistakes that make tutorials fail in practice, not generic writing advice.

## Usage Tips

- Use the generated outline as a skeleton, then fill in each section with tested commands and real terminal output. Never ship an outline as a finished tutorial.
- The checkpoint at the end of each section is the most important element. Readers who skip verification will hit confusing errors later. Make every checkpoint something observable: a CLI output, a running pod, a successful HTTP response, or a file on disk.
- If the tutorial covers more than one product or tool, call that out in the prerequisites so readers are not surprised mid-tutorial by a dependency they do not have.
- Adjust the number of sections based on your estimated completion time. A 15-minute tutorial should have 3 to 4 sections. A 60-minute tutorial can have up to 7. If you need more than 7, split the tutorial into parts.
- Test every command in the outline against a clean environment before publishing. Tutorials that only work on the author's laptop erode trust fast.
- Include the exact version numbers you tested against. "Install oc CLI" is not sufficient. "Install oc CLI v4.15.2" is.
- When writing checkpoints, include the expected output verbatim when possible. "You should see `status: Ready`" is far more useful than "verify the status."
- Keep troubleshooting entries focused on errors that actually happen in practice. If you have run through the tutorial yourself, you already know what breaks. Document those first.
- **Slash command connection:** If you use `ai-bu-claude-commands`, the `/write-docs` slash command can generate the API documentation that a tutorial references.

## Example Output

```text
## Outline: Deploying Your First Model with llm-d on OpenShift

### Audience Assumptions
- The reader has basic Kubernetes experience: they can run kubectl/oc commands,
  understand pods, services, and namespaces.
- The reader has used a container registry before and understands image references.
- The reader has NOT used llm-d or deployed a large language model on Kubernetes.

### Introduction
In this tutorial, you will deploy a pre-trained language model using llm-d on an
OpenShift cluster and expose it as a REST API. By the end, you will have a working
inference endpoint you can call with curl and receive a model-generated response.

### Prerequisites
- OpenShift 4.15+ cluster with cluster-admin access
- oc CLI v4.15.2+ installed and authenticated to your cluster
- A Hugging Face account with a read-access API token (create one at
  https://huggingface.co/settings/tokens)
- At least one GPU node available in your cluster (NVIDIA A100 or equivalent,
  minimum 40 GB VRAM)
- llm-d operator v0.3.0+ installed on the cluster (install guide:
  https://github.com/llm-d/llm-d/blob/main/docs/install.md)
- curl installed locally for testing the endpoint
- Estimated cloud cost: approximately $3-8 for GPU compute during this tutorial

### Section 1: Create a Namespace and Configure Secrets
**What the reader does:** Create a dedicated namespace for the tutorial and store
the Hugging Face API token as a Kubernetes secret so the model puller can
authenticate to the registry.

**Key commands or actions:**
- oc new-project llm-tutorial
- oc create secret generic hf-token --from-literal=token=<YOUR_TOKEN>
- oc get secret hf-token -o jsonpath='{.data.token}' | base64 -d

**Checkpoint:** Running `oc get secret hf-token -n llm-tutorial` returns a secret
of type Opaque with 1 data item. Decoding it with base64 returns your token string.

### Section 2: Register the Model
**What the reader does:** Create a ModelRegistry custom resource that points to
the Hugging Face model repository and specifies the model revision to pull.

**Key commands or actions:**
- Create model-registry.yaml with the model repo URL, revision tag, and secret
  reference
- oc apply -f model-registry.yaml
- oc get modelregistry -n llm-tutorial -w (watch until status is Ready)

**Checkpoint:** `oc get modelregistry my-model -n llm-tutorial` shows STATUS as
Ready and SIZE populated with the model size in GB.

### Section 3: Create the Serving Runtime
**What the reader does:** Define a ServingRuntime resource that specifies the
inference engine, resource requests (GPU, memory), and batching configuration.

**Key commands or actions:**
- Create serving-runtime.yaml with engine type, GPU count, memory limits,
  and max_batch_size
- oc apply -f serving-runtime.yaml
- oc get pods -n llm-tutorial -w (watch until the serving pod reaches Running)

**Checkpoint:** `oc get pods -n llm-tutorial` shows one pod with status Running
and READY 1/1. `oc logs <pod-name> -n llm-tutorial` contains the line
"Model loaded successfully, serving on port 8080."

### Section 4: Expose the Inference Endpoint
**What the reader does:** Create a Service and Route to expose the serving pod
as an HTTPS endpoint accessible outside the cluster.

**Key commands or actions:**
- oc expose deployment llm-serving --port=8080
- oc create route edge llm-api --service=llm-serving
- oc get route llm-api -o jsonpath='{.spec.host}'

**Checkpoint:** `curl -s -o /dev/null -w "%{http_code}" https://<route-host>/health`
returns 200.

### Section 5: Send a Test Inference Request
**What the reader does:** Send a prompt to the inference endpoint using curl
and verify that the model returns a coherent response.

**Key commands or actions:**
- curl -X POST https://<route-host>/v1/completions \
    -H "Content-Type: application/json" \
    -d '{"prompt": "Explain Kubernetes in one sentence.", "max_tokens": 50}'
- Inspect the JSON response for a "choices" array with generated text

**Checkpoint:** The curl command returns HTTP 200 with a JSON body containing
a "choices" array. The first choice has a "text" field with a non-empty string.
Response time is under 10 seconds for this prompt length.

### Troubleshooting

1. **Error:** "ImagePullBackOff" on the serving pod
   **Cause:** The pod cannot pull the model image, usually because the image pull
   secret is missing or misconfigured in the serving namespace.
   **Fix:** Run `oc get secret -n llm-tutorial` and verify your pull secret exists.
   If missing, recreate it. If present, check that it is linked to the service
   account: `oc describe sa default -n llm-tutorial`.

2. **Error:** "CUDA out of memory" in pod logs
   **Cause:** The model requires more GPU memory than the node provides, or another
   workload is consuming GPU resources on the same node.
   **Fix:** Reduce max_batch_size in your serving-runtime.yaml to 1 and redeploy.
   Alternatively, request a node with more GPU memory or evict competing workloads.

3. **Error:** ModelRegistry status stuck at "Pulling"
   **Cause:** The Hugging Face token is invalid or lacks read permissions for the
   model repository.
   **Fix:** Verify your token at https://huggingface.co/settings/tokens. Ensure it
   has "read" scope. Delete and recreate the secret with the corrected token, then
   delete and reapply the ModelRegistry resource.

4. **Error:** Route returns "503 Service Unavailable"
   **Cause:** The serving pod is not yet ready, or the service selector does not
   match the pod labels.
   **Fix:** Run `oc get endpoints llm-serving -n llm-tutorial`. If the ENDPOINTS
   column is empty, check that the service selector matches the pod labels with
   `oc describe svc llm-serving` and `oc get pods --show-labels`.

5. **Error:** curl returns "connection refused" on the route URL
   **Cause:** The route was created with the wrong target port, or TLS termination
   is misconfigured.
   **Fix:** Run `oc describe route llm-api` and verify the target port is 8080 and
   TLS termination is set to "edge." Recreate the route if needed.

### Next Steps
- Add horizontal pod autoscaling to your serving runtime so it scales with traffic.
  Follow the HPA configuration guide at
  https://docs.openshift.com/container-platform/4.15/nodes/pods/nodes-pods-autoscaling.html
- Swap the pre-trained model for a fine-tuned variant by updating the ModelRegistry
  resource to point to your own Hugging Face repository.
- Integrate the inference endpoint with a front-end application by adding the route
  URL as an environment variable in your app's deployment config.
```
