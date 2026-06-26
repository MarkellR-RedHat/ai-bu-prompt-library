# Workshop Outline

Structure a hands-on workshop with clear learning objectives, timed sections, and practical exercises that attendees can complete during the session.

**Difficulty:** Advanced

## When to use
- Building a workshop for a conference (KubeCon, DevConf, Summit)
- Creating an internal training session for your team or org
- Designing a hands-on lab for a customer enablement session
- Structuring a multi-hour training that needs to stay on schedule

## When NOT to use
- The session is a talk or presentation with no hands-on component (write a talk outline instead)
- The workshop is under 30 minutes (use tutorial-outline for shorter exercises)
- You have not validated the exercises against a real environment yet (do that first, then outline)

## Prompt

```
You are a developer educator designing a hands-on workshop. Create a detailed workshop outline that an instructor can follow to deliver a structured, timed session.

Workshop title: [WORKSHOP_TITLE]
Duration: [DURATION, e.g., 2 hours, half day, full day]
Target audience: [AUDIENCE, e.g., platform engineers new to Kubernetes, experienced ML engineers learning inference optimization]
Skill level: [LEVEL, e.g., beginner, intermediate, advanced]
Max attendees: [MAX_ATTENDEES, e.g., 30]
Environment: [ENVIRONMENT, e.g., pre-provisioned OpenShift clusters, attendees bring their own laptops, cloud sandbox]

By the end of the workshop, attendees should be able to:
[LEARNING_OBJECTIVES, e.g., "deploy a model for inference using llm-d," "configure KV-cache-aware routing," "interpret inference metrics in Grafana"]

Structure the outline as follows:

1. **Overview and logistics** (first 5-10 minutes):
   - Welcome, introductions, and logistics (Wi-Fi, environment access, where to get help)
   - State the learning objectives clearly
   - Verify everyone can access the workshop environment (include a quick smoke test command)

2. **Sections** (break the workshop into 3-6 timed sections): For each section, provide:
   - Section title and time allocation (e.g., "Section 2: Deploy Your First Model, 25 minutes")
   - Learning objective for this section
   - Instructor talking points (2-3 bullets of what to explain before the exercise)
   - Hands-on exercise: what the attendees do, step by step
   - Checkpoint: how attendees verify they completed the exercise successfully
   - Common issues: 2-3 problems attendees might hit, with quick fixes

3. **Breaks**: Schedule breaks every 60-90 minutes. Include a suggested break duration.

4. **Wrap-up** (last 10-15 minutes):
   - Recap what was covered
   - Resources for continued learning (docs, repos, community channels)
   - Feedback collection (survey link or quick poll)

5. **Instructor notes**:
   - Pre-workshop setup checklist (what needs to be provisioned before the session)
   - Timing buffer: which sections can be shortened if the workshop runs long
   - Backup plan: what to do if the environment has issues

Constraints:
- Be specific about timing. Every section should have a time allocation that adds up to the total duration.
- Exercises must be completable in the time allocated. Err on the side of simpler exercises that everyone finishes over ambitious exercises that leave half the room behind.
- Include the exact commands or steps for each exercise. An instructor should be able to run this workshop using only the outline.
- Do not use em dashes. Use commas, periods, or "and" instead.
```

## Usage Tips

- Test every exercise against the actual workshop environment before finalizing the outline. Commands that work on your machine may not work in a shared sandbox.
- Build in 20% timing buffer. Workshops always run longer than planned, especially with a large group.
- For conferences, check the venue's constraints: internet bandwidth, power outlets, screen resolution, and whether attendees will have access to a cluster or need one provisioned.
- Pair this with the tutorial-outline prompt to create take-home exercises for attendees who want to continue learning after the workshop.

## Example Output Snippet

> ## Workshop: Getting Started with llm-d on OpenShift
> **Duration:** 2 hours | **Level:** Intermediate | **Max attendees:** 30
>
> ### Section 1: Environment Setup and Smoke Test (15 minutes)
> **Objective:** Verify every attendee can access the workshop cluster and run basic oc commands.
>
> **Instructor talking points:**
> - Explain the workshop environment: pre-provisioned OpenShift 4.15 clusters, one namespace per attendee
> - Walk through the credentials handout and show how to log in
>
> **Exercise:**
> 1. Log in to the cluster: `oc login --server=[CLUSTER_URL] --token=[YOUR_TOKEN]`
> 2. Verify access: `oc whoami` (should show your workshop username)
> 3. List available namespaces: `oc get projects` (should show your assigned namespace)
>
> **Checkpoint:** Every attendee can run `oc whoami` and see their username.
>
> **Common issues:**
> - Token expired: Generate a new token from the OpenShift console (show URL on screen)
> - Corporate VPN blocking access: Disconnect VPN and use venue Wi-Fi
>
> ### Section 2: Deploy Your First Model (25 minutes)
> **Objective:** Deploy a pre-trained LLM and expose it as an inference endpoint.
> ...
