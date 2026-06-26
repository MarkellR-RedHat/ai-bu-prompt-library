# Tutorial Outline Builder

Generate a structured tutorial outline that moves the reader from zero to a working result, with clear prerequisites and checkpoints along the way.

**Difficulty:** Intermediate

## When to use

- Creating a hands-on tutorial for product documentation or a docs site.
- Building a workshop exercise for a conference, training session, or team onboarding.
- Writing a getting-started guide for a new feature or product release.
- Structuring a self-paced lab that needs clear checkpoints so learners know they are on track.
- Planning a multi-part tutorial series and need to scope each installment.

## When NOT to use

- You need a conceptual explainer without hands-on steps. Write an article or architecture overview instead.
- The tutorial is a single command with no meaningful steps. A short README or quick-start snippet is a better fit.
- You are documenting an API reference. That requires a different structure focused on endpoints, parameters, and response schemas.

## Prompt

```text
You are a technical writer creating a hands-on tutorial for [PRODUCT].

Build a detailed outline for the following tutorial:
- Title: [TUTORIAL_TITLE, e.g., "Deploying your first model with llm-d on OpenShift"]
- Goal: By the end, the reader should be able to [OUTCOME, e.g., "serve a fine-tuned LLM behind an API endpoint"]
- Audience skill level: [LEVEL, e.g., beginner, intermediate, advanced]
- Estimated completion time: [TIME, e.g., 30 minutes]

Structure the outline as follows:

1. Introduction (2-3 sentences): What the reader will build and why it is useful.
2. Prerequisites: List every tool, account, version, and piece of access the reader needs before starting. Be exact with version numbers where it matters.
3. Sections: Break the tutorial into 4-7 logical sections. For each section, provide:
   - Section title
   - What the reader does in this section (1-2 sentences)
   - Key commands or code snippets to include (short summary, not full code)
   - A checkpoint: how the reader confirms this section worked before moving on
4. Troubleshooting: List 3-5 common errors a reader might hit, with the fix for each.
5. Next steps: 2-3 concrete things the reader can try after finishing, with links or references where possible.

Write for practitioners. Assume the reader has the baseline skills for their stated level but has never used [PRODUCT] before. Skip conceptual overviews unless they are necessary to complete a step.
```

## Usage Tips

- Use the generated outline as a skeleton, then fill in each section with tested commands and real output.
- The "checkpoint" at the end of each section is critical. Readers who skip ahead without verifying will hit confusing errors later. Make sure each checkpoint is something observable, like a CLI output or a running pod.
- If the tutorial covers more than one product or tool, call that out in the prerequisites so readers do not get surprised mid-tutorial.
- Adjust the number of sections based on your estimated completion time. A 15-minute tutorial should have 3-4 sections. A 60-minute tutorial can have up to 7.

## Example Output Snippet

```
## Outline: Deploying Your First Model with llm-d on OpenShift

### Introduction
In this tutorial, you will deploy a pre-trained language model using
llm-d on an OpenShift cluster and expose it as a REST API. By the
end, you will have a working inference endpoint you can call with
curl.

### Prerequisites
- OpenShift 4.15+ cluster with cluster-admin access
- oc CLI v4.15+ installed and authenticated
- A Hugging Face account with an API token
- At least one GPU node (NVIDIA A100 or equivalent)
- llm-d operator v0.1.0+ installed on the cluster

### Section 1: Configure the Model Registry
What the reader does: Create a model registry entry pointing to the
Hugging Face model repository.

Key commands: oc apply -f model-registry-config.yaml, verify with
oc get modelregistry.

Checkpoint: Running "oc get modelregistry" shows the new entry with
status Ready.

### Section 2: Create a Serving Runtime
...

### Troubleshooting
1. Error: "ImagePullBackOff" on the serving pod
   Fix: Verify your image pull secret is configured in the serving
   namespace. Run "oc get secret -n llm-serving" to check.

2. Error: "CUDA out of memory"
   Fix: Reduce the model's max_batch_size in the serving config,
   or request a node with more GPU memory.
...
```
