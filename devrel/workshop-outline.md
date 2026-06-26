# Workshop Outline Generator

Design a hands-on workshop with precise learning objectives, timed sections, practical exercises, instructor notes, and contingency plans that an instructor can pick up and deliver without additional preparation.

**Difficulty:** Advanced

## Naive vs. Engineered

**Naive prompt:** "Create a workshop outline for teaching llm-d on OpenShift. It should be 2 hours for intermediate users."

**What you get:** Something like this:

> *Workshop Outline (2 hours). 1. Introduction (15 min). 2. Overview of llm-d (20 min). 3. Hands-on: Deploy a model (30 min). 4. Break (10 min). 5. Advanced configuration (25 min). 6. Q&A and wrap-up (20 min).*

Six lines that add up to 2 hours on paper but fall apart in a live room. "Hands-on: Deploy a model" has no commands, no checkpoint, and no troubleshooting guide for when an attendee's pod gets stuck in Pending because of GPU scheduling. "Advanced configuration" could mean anything. No instructor notes, no TA briefing, and no backup plan for when the cluster goes down 10 minutes into the session.

**This prompt** produces a workshop with timed sections that add up correctly, step-by-step exercises with exact commands (e.g., `oc apply -f cache-routing.yaml`), verification checkpoints for every section ("router logs show repeated requests with the same prefix routed to the same replica"), common-issue guides that TAs can reference in real time, timing buffers with explicit cut instructions ("Section 3 can be shortened to a 5-minute instructor demo if running behind"), and a complete pre-workshop setup checklist including pre-pulling model images on GPU nodes. The difference: an instructor who has never seen the material before can pick up this outline and deliver the workshop without additional preparation.

## When to use

- Building a workshop for a major conference (KubeCon, DevConf, Red Hat Summit, FOSDEM)
- Creating an internal training session for your team, org, or business unit
- Designing a hands-on lab for customer enablement or partner training
- Structuring a multi-hour training that needs strict timekeeping across sections
- Converting existing documentation or tutorials into a live, guided workshop format
- Planning a train-the-trainer session where multiple instructors need a shared playbook
- Preparing a workshop that must accommodate mixed skill levels in one room

## When NOT to use

- The session is a talk or presentation with no hands-on component (use a talk outline prompt instead)
- The workshop is under 30 minutes (use the tutorial-outline prompt for shorter exercises)
- You have not validated the exercises against a real environment yet (do that first, then use this prompt to structure what you have proven works)
- You need a self-paced async course rather than a live, instructor-led session

## Prompt

```
You are a senior developer educator at a major open source technology company.
Your job is to design hands-on workshops that are clear, tightly timed, and
actually completable by every attendee in the room. You have deep expertise in
structuring technical training for adult learners, pacing exercises so no one
gets left behind, and writing instructor notes that prevent common failure modes.

INPUTS (fill in each bracket before running this prompt):

  Workshop title: [WORKSHOP_TITLE]
  Duration: [DURATION, e.g., 2 hours, half day, full day]
  Target audience: [AUDIENCE, e.g., platform engineers new to Kubernetes,
                    experienced ML engineers learning inference optimization]
  Skill level: [LEVEL, e.g., beginner, intermediate, advanced]
  Max attendees: [MAX_ATTENDEES, e.g., 30]
  Environment: [ENVIRONMENT, e.g., pre-provisioned OpenShift clusters,
                attendees bring their own laptops, cloud sandbox]
  Number of instructors or TAs: [TA_COUNT, e.g., 1 lead + 2 TAs]
  Learning objectives (list 3-5):
    [LEARNING_OBJECTIVES, e.g.,
     "deploy a model for inference using llm-d,"
     "configure KV-cache-aware routing,"
     "interpret inference metrics in Grafana"]

STEP-BY-STEP REASONING INSTRUCTIONS:

Follow these steps in order. Think through each one carefully before moving
to the next. Do not skip steps.

Step 1: Audience analysis.
  Consider the target audience and skill level. Identify what prerequisite
  knowledge you can assume. List 3-5 things the audience likely already knows
  and 2-3 things they probably do not know yet. This will shape how much
  context each section needs.

Step 2: Learning arc design.
  Map the learning objectives to a logical progression. Each section should
  build on the previous one. Identify the dependency chain: which objectives
  must come first because later objectives rely on them. Arrange sections so
  the cognitive load increases gradually, not all at once.

Step 3: Time budget allocation.
  Calculate the total available minutes from the duration. Subtract time for
  the opening (10 minutes), closing (10 minutes), and breaks (10 minutes per
  break, with a break every 60-90 minutes). Distribute the remaining time
  across sections. Allocate at least 50% of each section's time to hands-on
  exercises and at most 30% to instructor explanation. Reserve a 15-20%
  timing buffer by identifying which sections can be shortened if the
  workshop runs long.

Step 4: Exercise design.
  For each section, design one focused exercise. Each exercise should have a
  single clear goal, explicit step-by-step instructions (including exact
  commands), and a verification checkpoint that tells the attendee whether
  they succeeded. Exercises must be completable by the slowest attendee in the
  allocated time. When in doubt, make exercises simpler rather than more
  ambitious. Half the room finishing is worse than everyone finishing.

Step 5: Failure mode analysis.
  For each exercise, identify 3-5 things that commonly go wrong: environment
  issues, typos, version mismatches, network problems, permissions errors.
  Write a one-line fix for each. These go into the "Common issues" section
  that instructors and TAs can reference in real time.

Step 6: Instructor notes.
  Write a pre-workshop setup checklist (what must be provisioned, tested, and
  verified before attendees arrive). Identify which sections serve as the
  timing buffer (can be shortened or cut). Write a backup plan for environment
  failures (e.g., switching to a demo if clusters go down).

OUTPUT FORMAT:

Use the following structure exactly. Do not add extra top-level sections.
Do not change the heading hierarchy.

---

## Workshop: [WORKSHOP_TITLE]
**Duration:** [DURATION] | **Level:** [LEVEL] | **Max attendees:** [MAX_ATTENDEES]

### Prerequisites
- [What attendees should know or have installed before arriving]

### Learning Objectives
1. [Objective 1]
2. [Objective 2]
3. [Objective 3]

### Section 0: Opening and Environment Setup ([TIME] minutes)
**Objective:** Verify every attendee can access the workshop environment.

**Instructor talking points:**
- [2-3 bullets]

**Smoke test exercise:**
1. [Step with exact command]
2. [Verification step]

**Checkpoint:** [How to confirm success]

**Common issues:**
- [Issue]: [One-line fix]

### Section N: [TITLE] ([TIME] minutes)
**Objective:** [Single sentence]

**Instructor talking points:**
- [2-3 bullets of what to explain before the exercise]

**Exercise:**
1. [Numbered steps with exact commands]

**Checkpoint:** [How attendees verify they completed the exercise]

**Common issues:**
- [Issue]: [Fix]

### Break ([TIME] minutes)
[Insert breaks every 60-90 minutes]

### Wrap-up ([TIME] minutes)
- Recap of what was covered (restate each learning objective and confirm it
  was met)
- Resources for continued learning (documentation links, repos, community
  channels)
- Feedback collection method (survey link, QR code, or quick show of hands)
- What to do next: suggest a follow-up tutorial, project, or community to join

### Instructor Notes
**Pre-workshop setup checklist:**
- [ ] [Item]

**Timing buffer sections:** [Which sections to shorten if running late]

**Backup plan:** [What to do if the environment fails]

**TA briefing points:** [What TAs need to know before the session]

---

SELF-CRITIQUE CHECKLIST:

Before finalizing your output, review it against every item below. If any
check fails, revise your output before presenting it.

1. Do all section times add up to the total workshop duration, including
   breaks and opening/closing? Verify the arithmetic explicitly.
2. Does every exercise include exact commands or steps, not vague
   instructions like "configure the application"?
3. Does every exercise have a checkpoint that an attendee can verify on
   their own without asking the instructor?
4. Are there at least 2 common issues listed per exercise?
5. Is the cognitive progression logical? Would a new attendee be confused
   by Section 3 if they completed Sections 1 and 2?
6. Is the timing realistic? Could the slowest attendee in a room of
   [MAX_ATTENDEES] complete each exercise in the allocated time?
7. Does the instructor notes section include a complete pre-workshop
   setup checklist?
8. Are the backup plan instructions specific enough for an instructor who
   has never seen them before to execute under pressure?
9. Have you avoided em dashes, marketing language, and hype words like
   "revolutionary," "cutting-edge," or "game-changing"?
10. Is the total timing buffer at least 15% of the workshop duration?

ANTI-PATTERNS TO AVOID:

1. "Deploy a complex multi-service application" as a single exercise.
   Break complex tasks into smaller, independently verifiable steps.
2. Exercises that require downloading large files during the session.
   Pre-load everything in the environment setup or pre-provision it.
3. Assuming all attendees have the same OS, shell, or tool versions.
   Specify the exact environment and note any platform-specific variations.
4. Instructor-only demos with no attendee participation. Every section
   should have something the attendee types, runs, or builds.
5. Skipping the "common issues" section because "it should just work."
   It will not just work for everyone. Plan for failure.
6. Allocating the same amount of time per section regardless of
   complexity. Harder exercises need more time, not less.
7. Ending the workshop without a clear "what to do next" resource list.
   Attendees will forget everything if they do not have a follow-up path.
8. Writing vague checkpoints like "you should see output." Specify what
   the output looks like, or provide an exact string to grep for.

EDGE CASE HANDLING:

- If the duration is "full day" (6-8 hours), include a lunch break of
  45-60 minutes and at least two shorter breaks. Structure the day into
  a morning session and an afternoon session with distinct themes.
- If max attendees exceeds 50, note that exercises must be fully self-service
  with no instructor debugging required. Add a troubleshooting appendix.
- If the skill level is "mixed" or "beginner to advanced," design a core
  path that everyone follows and mark optional stretch goals for advanced
  attendees who finish early.
- If the environment is "attendees bring their own laptops," add a
  pre-workshop setup email template to the instructor notes section,
  listing everything attendees must install before arriving.
- If the number of TAs is zero, flag this as a risk in the instructor
  notes and recommend simplifying exercises or reducing max attendees.
- If any bracketed placeholders (e.g., [WORKSHOP_TITLE], [DURATION],
  [LEARNING_OBJECTIVES]) are left unfilled, stop and list the missing inputs
  rather than generating an outline with placeholder values. A workshop outline
  built on unfilled inputs cannot be delivered or reviewed meaningfully.
- If the target audience is non-technical (product managers, designers, business
  analysts), reduce command-line exercises in favor of UI walkthroughs, visual
  outputs, and guided exploration. Adjust talking points to focus on outcomes
  and business value rather than implementation details. Checkpoints should
  verify understanding through observation, not terminal output.
- If the duration is very short (under 30 minutes), collapse the structure to
  a single focused exercise with one learning objective. Skip the break, shorten
  the opening to 3 minutes, and reduce the wrap-up to 2 minutes. Flag that this
  format is closer to a guided demo than a full workshop.
```

## Why This Works

**Multi-stage reasoning with dependency awareness.** The six-step reasoning chain (audience analysis, learning arc, time budget, exercise design, failure mode analysis, instructor notes) forces the model to build each layer on the previous one. The learning arc shapes the exercises, the exercises shape the time budget, and the time budget shapes the buffer plan. Without this structure, AI-generated workshops produce disconnected sections with timing that does not add up.

**Failure mode analysis as a first-class step.** Most workshop outlines skip troubleshooting entirely. This prompt dedicates an entire reasoning step to identifying 3-5 things that commonly go wrong per exercise and writing one-line fixes. This is what separates a workshop that works in a conference room of 30 people from one that only works on the author's laptop.

**Time budget arithmetic.** The prompt requires the model to calculate total available minutes, subtract fixed overhead (opening, closing, breaks), and distribute the remainder across sections with explicit buffer allocation. The self-critique checklist verifies that all section times add up to the total duration. This catches the most common workshop design error: sections that collectively exceed the time slot.

**Checkpoint-driven exercise design.** Every exercise ends with a verification checkpoint that tells the attendee whether they succeeded. This is critical for self-pacing in a room with mixed skill levels. Without checkpoints, fast attendees wait while slow attendees silently fall behind, and no one knows who is stuck.

**Instructor notes and backup plans.** The output includes a pre-workshop setup checklist, timing buffer instructions (which sections to cut if running late), and a backup plan for environment failures. These operational details are what make the difference between a polished workshop and a stressful one.

## Usage Tips

- Test every exercise against the actual workshop environment before finalizing the outline. Commands that work on your machine may not work in a shared sandbox, on a different OS, or behind a corporate proxy.
- Build in a 20% timing buffer. Workshops always run longer than planned, especially with a large group. Identify which sections to cut first if you fall behind.
- For conferences, check the venue's constraints early: internet bandwidth, power outlets, screen resolution, room layout, and whether attendees will have cluster access or need one provisioned.
- Pair this prompt with the tutorial-outline prompt to create take-home exercises for attendees who want to continue learning after the workshop.
- Run the generated outline past a colleague who was not involved in creating it. If they cannot deliver the workshop from the outline alone, it is not detailed enough.
- Include a pre-workshop email template in your instructor notes. Attendees who show up without prerequisites installed will derail the first 30 minutes.
- If you are running the workshop with TAs, share the outline with them at least 48 hours in advance so they can run through the exercises and anticipate questions.
- Print the "common issues" sections as a separate quick-reference sheet for TAs. During the session, they need fast answers, not a 10-page document.
- **Slash command connection:** If you use `ai-bu-claude-commands`, the `/demo-prep` slash command can generate the live demo portion that fits within a workshop section.

## Example Output

> ## Workshop: Getting Started with llm-d on OpenShift
> **Duration:** 2 hours | **Level:** Intermediate | **Max attendees:** 30
>
> ### Prerequisites
> - Familiarity with Kubernetes concepts (pods, deployments, services)
> - Basic command-line experience (navigating directories, running commands)
> - No prior llm-d experience required
>
> ### Learning Objectives
> 1. Deploy a pre-trained LLM as an inference endpoint using llm-d on OpenShift
> 2. Configure KV-cache-aware routing for efficient multi-replica inference
> 3. Monitor inference performance using Grafana dashboards and key metrics
>
> ### Section 0: Opening and Environment Setup (15 minutes)
> **Objective:** Verify every attendee can access the workshop cluster and run basic oc commands.
>
> **Instructor talking points:**
> - Explain the workshop environment: pre-provisioned OpenShift 4.15 clusters, one namespace per attendee
> - Walk through the credentials handout and demonstrate the login flow on screen
> - Set expectations: today we focus on deploying and monitoring, not model training
>
> **Smoke test exercise:**
> 1. Log in to the cluster: `oc login --server=[CLUSTER_URL] --token=[YOUR_TOKEN]`
> 2. Verify access: `oc whoami` (expected output: your workshop username, e.g., `user-12`)
> 3. List available namespaces: `oc get projects` (expected: your assigned namespace appears in the list)
>
> **Checkpoint:** Every attendee can run `oc whoami` and see their assigned username.
>
> **Common issues:**
> - Token expired: Generate a new token from the OpenShift web console at [CONSOLE_URL]. Click your username in the top right, then "Copy login command."
> - Corporate VPN blocking access: Disconnect VPN and connect to the venue Wi-Fi network (SSID and password on the projector slide).
> - `oc` command not found: Download the CLI from [MIRROR_URL] or use the web terminal built into the OpenShift console.
>
> ### Section 1: Deploy Your First Model (25 minutes)
> **Objective:** Deploy a pre-trained LLM and expose it as an inference endpoint using llm-d.
>
> **Instructor talking points:**
> - Explain what llm-d does: a Kubernetes-native inference stack for serving LLMs at scale
> - Walk through the InferencePool custom resource and what each field controls
> - Show the architecture diagram: model pod, routing layer, service endpoint
>
> **Exercise:**
> 1. Switch to your namespace: `oc project [YOUR_NAMESPACE]`
> 2. Apply the model deployment manifest: `oc apply -f /workshop/manifests/deploy-model.yaml`
> 3. Watch the pod come up: `oc get pods -w` (wait until STATUS shows `Running` and READY shows `1/1`)
> 4. Verify the inference endpoint: `curl -s http://[MODEL_SERVICE]:8080/v1/models | jq .`
>    (expected: JSON response listing the deployed model name)
> 5. Send a test prompt: `curl -s -X POST http://[MODEL_SERVICE]:8080/v1/completions -H "Content-Type: application/json" -d '{"model":"workshop-model","prompt":"Kubernetes is","max_tokens":20}' | jq .choices[0].text`
>    (expected: a short text completion)
>
> **Checkpoint:** The curl command in step 5 returns a text completion without errors.
>
> **Common issues:**
> - Pod stuck in `Pending`: Check events with `oc describe pod [POD_NAME]`. Likely cause is GPU scheduling. Ask a TA to verify the node pool.
> - `curl: connection refused`: The service is not ready yet. Wait 30 seconds and retry. If it persists, check `oc get svc` to verify the service exists.
> - JSON parse error from jq: Ensure the curl command uses single quotes around the JSON body, not double quotes.
>
> ### Break (10 minutes)
>
> ### Section 2: Configure KV-Cache-Aware Routing (25 minutes)
> **Objective:** Enable KV-cache-aware routing and observe how it distributes requests across replicas.
>
> **Instructor talking points:**
> - Explain KV-cache-aware routing: why prefix caching matters for inference latency
> - Show the routing configuration options in the InferencePool spec
> - Describe the difference between round-robin and cache-aware strategies
>
> **Exercise:**
> 1. Scale the model to 2 replicas: `oc scale deployment workshop-model --replicas=2`
> 2. Confirm both replicas are running: `oc get pods -l app=workshop-model` (expected: 2 pods in Running state)
> 3. Apply the cache-aware routing config: `oc apply -f /workshop/manifests/cache-routing.yaml`
> 4. Send 5 requests with the same prefix and observe routing:
>    `for i in $(seq 1 5); do curl -s -X POST http://[MODEL_SERVICE]:8080/v1/completions -H "Content-Type: application/json" -d '{"model":"workshop-model","prompt":"OpenShift is a platform","max_tokens":10}' -o /dev/null -w "Request $i: HTTP %{http_code}, Time: %{time_total}s\n"; done`
> 5. Check routing logs: `oc logs deployment/llm-d-router --tail=10` (expected: requests routed to the same replica due to prefix match)
>
> **Checkpoint:** The router logs show that repeated requests with the same prefix are consistently routed to the same replica.
>
> **Common issues:**
> - Second replica not starting: GPU quota may be exhausted. Ask the instructor or TA to check cluster capacity.
> - Routing logs show round-robin behavior: The cache-routing config may not have applied. Run `oc get inferencepool -o yaml` and verify the routing strategy field.
>
> ### Section 3: Monitor Inference Metrics in Grafana (20 minutes)
> **Objective:** Access the Grafana dashboard and interpret key inference metrics.
>
> **Exercise:**
> 1. Open the Grafana URL in your browser: `[GRAFANA_URL]`
> 2. Log in with your workshop credentials (same username and password as the cluster)
> 3. Navigate to Dashboards, then select "llm-d Inference Overview"
> 4. Generate load by running the provided script: `bash /workshop/scripts/load-test.sh`
> 5. In Grafana, observe three panels: request latency (p50, p95, p99), tokens per second, and cache hit rate
> 6. Take a screenshot or note the p95 latency and cache hit rate values
>
> **Checkpoint:** You can identify the p95 latency and cache hit rate on the Grafana dashboard. The cache hit rate should be above 60% after the load test.
>
> **Common issues:**
> - Grafana login fails: Clear browser cookies or try an incognito window. Workshop credentials are case-sensitive.
> - Dashboard shows "No data": The Prometheus data source may need 30-60 seconds to populate after the load test starts. Refresh the page.
> - Load test script fails: Verify the MODEL_SERVICE environment variable is set. Run `echo $MODEL_SERVICE` to check.
>
> ### Wrap-up (10 minutes)
> - Recap: We deployed an LLM with llm-d, configured cache-aware routing, and monitored inference metrics
> - Resources: [llm-d documentation URL], [GitHub repository URL], [community Slack channel]
> - Feedback: Scan the QR code on the final slide to complete the 2-minute survey
> - Next steps: Try the "Advanced llm-d Configuration" self-paced tutorial at [TUTORIAL_URL]
>
> ### Instructor Notes
> **Pre-workshop setup checklist:**
> - [ ] Provision OpenShift 4.15 cluster with GPU node pool (at least 2 GPUs per attendee pair)
> - [ ] Create 30 namespaces (user-01 through user-30) with resource quotas applied
> - [ ] Pre-pull the workshop model image on all GPU nodes to avoid download delays
> - [ ] Deploy Grafana and Prometheus with the llm-d dashboards pre-loaded
> - [ ] Test every exercise end-to-end on a fresh namespace the morning of the workshop
> - [ ] Prepare printed credential handouts with login commands
>
> **Timing buffer sections:** Section 3 (Grafana) can be shortened to a 5-minute instructor demo if running behind. Section 2 can skip the load observation step (step 4 and 5).
>
> **Backup plan:** If the cluster is unreachable, switch to the pre-recorded demo video at [VIDEO_URL]. Walk through each exercise on screen and have attendees follow along conceptually. Distribute the self-paced tutorial link so they can complete the exercises later.
>
> **TA briefing points:** TAs should pre-run all exercises on a test namespace before the session. During the workshop, station one TA at the front (handling environment issues) and one roaming the room (helping with exercise steps). Escalate any cluster-wide issues to the lead instructor immediately.
