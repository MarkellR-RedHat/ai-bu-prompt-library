# Demo Script Generator

Create a structured, time-boxed demo script that walks through a real workflow and lands a clear takeaway for your audience.

## Prompt

```
You are a developer advocate preparing a live demo for [PRODUCT].

Write a demo script for the following:
- Topic: [TOPIC]
- Target audience: [AUDIENCE, e.g., platform engineers, ML engineers, application developers]
- Time limit: [DURATION, e.g., 10 minutes]
- Environment: [ENVIRONMENT, e.g., OpenShift cluster, local laptop, cloud sandbox]

The script must include:
1. A one-sentence setup that tells the audience what problem this demo solves.
2. Pre-demo checklist: everything that needs to be running or configured before you start.
3. Numbered steps with the exact commands or UI actions to perform. For each step, include:
   - The command or action
   - What the audience should see (expected output or behavior)
   - A one-line talking point explaining why this step matters
4. One intentional "what if" moment: show what happens when something goes wrong, and how [PRODUCT] handles it.
5. A closing recap with the key takeaway and a next-steps link or resource.

Keep the tone conversational but technical. No marketing language. Every step should be something the audience could reproduce on their own afterward.
```

## Usage Tips

- Fill in all bracketed placeholders before running the prompt. The more specific you are about your audience and environment, the better the output.
- If your demo is longer than 15 minutes, consider splitting it into two prompts, one per segment.
- After generating the script, do a dry run against a real environment. The prompt produces realistic commands, but they need validation against your actual setup.
- Pair this with a screen recording if you want to pre-record a backup in case the live demo hits issues.

## Example Output Snippet

```
## Setup
This demo shows how llm-d serves multiple LoRA adapters from a single
base model on OpenShift AI, cutting GPU memory usage by 60% compared
to running separate model instances.

## Pre-Demo Checklist
- OpenShift 4.15+ cluster with GPU nodes available
- llm-d operator installed (v0.1.0+)
- Two LoRA adapters uploaded to the model registry
- Terminal with oc CLI authenticated to the cluster

## Step 1: Deploy the base model
Command:
  oc apply -f base-model-serving.yaml

Expected output:
  servingruntime.serving.kserve.io/llama-base created

Talking point: "We are starting with a single base model. No adapters
loaded yet. This is your starting cost baseline."

...
```
