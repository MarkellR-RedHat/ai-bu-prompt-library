# Architecture Review Prompt

A structured prompt for evaluating system architecture across scalability, reliability, operational readiness, security, and simplicity, producing a rated assessment with concrete, prioritized recommendations.

**Difficulty:** Advanced

## Naive vs. Engineered

Most people describe their system and type something like:

> **Naive prompt:** "Review our architecture and tell us what to improve."

**What you get:** A generic checklist of best practices that could apply to literally any system. Something like:

> **Recommendations:**
> - Consider adding a caching layer to improve performance.
> - You should implement monitoring and alerting for all services.
> - Consider breaking the monolith into microservices for better scalability.
> - Make sure you have proper error handling and retry logic.
> - Consider using a message queue for asynchronous processing.
> - Implement CI/CD pipelines for faster deployments.

No assessment of your actual constraints. No distinction between what matters now and what matters at 10x scale. No acknowledgment that your 4-person team cannot implement 15 recommendations simultaneously. You could paste any architecture description and get the same list back.

**This prompt** produces a rated assessment across six specific criteria, with recommendations grounded in your actual scale, team size, deployment environment, and known pain points. Each recommendation includes what to do, why it matters, and estimated effort. Instead of "consider using a message queue," you get: "Move audit log writes to an async path using the existing RabbitMQ cluster. This reduces per-transaction write count from 3 to 2, which unblocks your path to 2,000 orders/sec on the single PostgreSQL primary. Estimated effort: 2 to 3 weeks for a team already familiar with the queue infrastructure."

## When to use

- Evaluating a new system design before committing to implementation, so you can identify structural problems while they are still cheap to fix
- Reviewing an existing system before a major scaling effort, migration, or platform change
- Preparing for an architecture review meeting and you want to identify gaps ahead of time so the meeting is productive
- Assessing operational readiness before a GA launch, production rollout, or traffic migration
- Onboarding onto a new team and you need to quickly understand the strengths, risks, and blind spots of an existing system
- Comparing two proposed architectures to decide which one to pursue
- Documenting the current state of a system's architecture for a technical strategy document or executive review

## When NOT to use

- The system is a prototype, proof of concept, or throwaway experiment. Applying production-grade review criteria to throwaway code wastes time and produces irrelevant recommendations.
- You need a detailed capacity plan with specific throughput numbers. Run load tests and benchmark your infrastructure instead. This prompt identifies architectural risks, not exact performance limits.
- You need a compliance or regulatory audit (SOC 2, FedRAMP, HIPAA). Engage your compliance team and use the appropriate audit framework for that.
- The system has fewer than 3 components and serves a single use case. At that scale, a code review is more useful than an architecture review.

## Prompt

````
You are a principal engineer conducting an architecture review of a production system. Your goal is to identify structural risks and provide concrete, prioritized recommendations that the team can act on. Do not provide generic advice. Every recommendation should be specific to the system described below.

System context:
- System name: [SYSTEM_NAME]
- Architecture description (components, communication patterns, data stores, deployment topology): [ARCHITECTURE_DESCRIPTION]
- Current scale (requests/sec, data volume, number of users, team size): [CURRENT_SCALE]
- Target scale or upcoming requirements: [TARGET_SCALE_OR_UPCOMING_REQUIREMENTS]
- Known pain points, tech debt, or planned migrations: [KNOWN_ISSUES]
- Deployment environment (cloud provider, orchestration platform, region topology): [DEPLOYMENT_ENVIRONMENT]

Evaluate the architecture against each of the following criteria. Follow the evaluation process described below for each criterion.

Evaluation process (apply to each criterion):
1. Assess the current state based on the information provided. Identify what is working well and what is missing.
2. Project how the system would behave at the target scale or under the upcoming requirements. Identify which aspects would break or degrade.
3. Rate the criterion using one of these levels:
   - **Strong**: No significant concerns at current or projected scale.
   - **Adequate**: Works today but has known limitations that will need attention before the next major milestone.
   - **Needs Work**: Has gaps that could cause incidents, data loss, or block scaling if not addressed.
4. Provide 1 to 3 specific, actionable recommendations. Each recommendation should include what to do, why it matters, and what the expected outcome is. Do not recommend things the team is already doing.

Criteria to evaluate:

**1. Scalability**
Can this system handle the target scale? Where are the bottlenecks? Analyze:
- Horizontal vs. vertical scaling paths for each component
- Single points of contention (shared databases, global locks, single-threaded workers, centralized coordinators)
- Data partitioning and sharding strategy
- Queue depth and backpressure behavior under load
- Caching strategy and cache invalidation approach

**2. Reliability and Fault Tolerance**
What happens when a dependency fails? Analyze:
- Retry logic, circuit breakers, timeouts, and fallback paths for each external dependency
- Blast radius of a single component failure (does one service failure cascade to others?)
- Data replication and recovery strategy
- Graceful degradation paths (can the system serve partial results or operate in a reduced mode?)
- Deployment strategy and its impact on availability (rolling updates, blue-green, canary)

**3. Data Integrity and Consistency**
How is data correctness maintained? Analyze:
- Consistency model (strong, eventual, or mixed) and whether it matches the business requirements
- Write durability guarantees (are writes acknowledged before or after persistence?)
- Idempotency of writes and external calls
- Data duplication across services and how consistency is maintained across copies
- Backup and point-in-time recovery capabilities

**4. Operational Readiness**
Can the team operate this system effectively? Analyze:
- Observability: structured logging, distributed tracing, metrics, and dashboards
- Alerting: are alerts actionable, or do they produce noise that gets ignored?
- Health checks: do they verify actual functionality, or just return HTTP 200?
- Deployment: can the system be deployed with zero downtime? How long does a rollback take?
- Runbooks: are common operational tasks documented?
- On-call burden: how often does this system page, and are pages actionable?

**5. Simplicity and Maintainability**
Is the architecture more complex than it needs to be? Analyze:
- Components that could be removed or consolidated without losing functionality
- Indirection layers that add latency and cognitive overhead without clear benefit
- Technology choices that require specialized expertise the team does not have
- Build and deployment pipeline complexity
- Whether the number of services matches the team size (a 4-person team should not operate 20 microservices)

**6. Security Boundaries**
Are trust boundaries clearly defined and enforced? Analyze:
- Authentication and authorization enforcement at every layer, not just at the edge
- Service-to-service authentication (mTLS, JWT, API keys) and whether it is enforced or optional
- Data encryption at rest and in transit
- Secrets management (how are credentials stored, rotated, and accessed?)
- Network segmentation and least-privilege access

After completing all criteria, provide:

**Priority summary**: Rank the top 3 issues by risk and effort. For each, state:
- What the issue is
- What the worst-case impact is if not addressed
- What the recommended fix is and an estimated effort level (days, weeks, or months)

Self-critique checklist (apply before presenting your final output):
- [ ] Did I base my assessment on the specific system described, or did I give generic advice that could apply to any system?
- [ ] Are my recommendations actionable? Could the team start working on them this sprint, or are they vague aspirations?
- [ ] Did I avoid recommending technologies or patterns that require expertise the team does not have?
- [ ] Did I consider the team size and organizational constraints, not just the technical ideal?
- [ ] Did I distinguish between issues that matter at current scale and issues that will only matter at the target scale?
- [ ] Did I avoid recommending a rewrite when incremental improvements would achieve the same goal?
- [ ] Did I check for contradictions in my recommendations (e.g., recommending both simplification and adding new components)?

Anti-patterns to avoid:
1. Do not recommend microservices decomposition to a team that is struggling with the operational overhead of their current architecture.
2. Do not suggest "add caching" without specifying what to cache, where, the eviction strategy, and how stale data is handled.
3. Do not recommend a technology (Kafka, Redis, Kubernetes) without explaining why the current approach is insufficient and why this specific technology addresses the gap.
4. Do not rate everything as "Needs Work" to appear thorough. If something is genuinely strong, say so.
5. Do not recommend changes that only matter at 100x scale when the team is trying to get to 2x.
6. Do not suggest adding complexity (new services, new databases, new queues) when the simpler solution is to optimize the existing component.
7. Do not ignore team size. A recommendation that requires 3 months of dedicated work from a 4-person team is not actionable without also suggesting what to deprioritize.

Edge case handling:
- If the architecture description is a diagram rather than text, describe the components and data flows you can identify and ask the user to confirm your understanding before proceeding.
- If critical information is missing (e.g., no mention of how deployments work), note the gap and explain why it matters rather than skipping the criterion.
- If the system is a monolith, evaluate it as a monolith. Do not automatically recommend breaking it into services unless there is a clear scaling or organizational reason to do so.
- If the team is very small (1 to 3 engineers), weight operational simplicity much more heavily than architectural purity.
- If a placeholder is left unfilled (e.g., [CURRENT_SCALE] is still "[CURRENT_SCALE]"), stop and ask the user to provide it. Architecture reviews without scale data produce generic advice.
- If the architecture description mixes multiple systems or services without clear boundaries, ask the user to scope the review to one system and explain how the others connect at the boundary.
- If the deployment environment is not Kubernetes-based (bare metal, VM-based, serverless, mainframe), adjust your evaluation criteria accordingly rather than assuming container orchestration patterns apply.
- If the user provides a very short description (under 100 words), list the specific questions you need answered before you can produce a useful review rather than filling in assumptions.
````

## Why This Works

This prompt uses several techniques to produce architecture reviews that are actually useful, not just technically correct:

- **Rich context injection** (system name, scale numbers, team size, deployment environment, known issues): Architecture advice without context is useless. By requiring specific inputs like "200 orders/sec on a single PostgreSQL instance with a 4-person team," the model cannot fall back on generic recommendations. Every suggestion must be grounded in your reality.
- **Structured evaluation criteria with rating levels** (Strong, Adequate, Needs Work): Forces the model to make a judgment call for each criterion instead of producing an undifferentiated list of suggestions. This is what makes the output actionable; you know immediately where to focus.
- **Projection to target scale**: Requiring the model to evaluate both current state and behavior at target scale prevents the common failure of either ignoring future needs or over-engineering for a scale you will never reach.
- **Anti-pattern avoidance** (seven rules including "do not recommend microservices to a team struggling with operational overhead" and "do not ignore team size"): These rules encode the hard-won wisdom that the best architecture is the one your team can actually operate. Without them, the model defaults to recommending the technically ideal solution regardless of organizational constraints.
- **Self-critique checklist**: Makes the model verify that its recommendations are specific to your system, actionable this sprint, and free of contradictions. This catches the generic advice that would otherwise slip through.
- **Priority summary with effort estimates**: Requiring a ranked top-3 with worst-case impact and effort level (days, weeks, months) transforms the output from a wish list into a prioritized action plan. This is what engineering leads actually need to make decisions.

The fundamental difference is that the naive approach gives you a textbook review. This prompt gives you a review written by someone who understands your system, your team, and your constraints.

## Usage Tips

- Replace `[SYSTEM_NAME]` with the name of the service or platform being reviewed.
- Replace `[ARCHITECTURE_DESCRIPTION]` with a text description of the components, how they communicate, what data stores they use, and how the system is deployed. If you have an architecture diagram, describe it in text or paste the contents of a design document. The more detail you provide, the more specific the recommendations will be.
- Replace `[CURRENT_SCALE]` with concrete numbers: requests per second, data volume in GB or TB, number of active users, and the size of the engineering team that operates the system. Vague descriptions like "medium traffic" produce vague reviews.
- Replace `[TARGET_SCALE_OR_UPCOMING_REQUIREMENTS]` with where the system needs to be in 6 to 12 months. This could be a traffic growth target, a new feature requirement, a compliance deadline, or a migration to a new platform.
- Replace `[KNOWN_ISSUES]` with any existing problems, planned migrations, or upcoming changes that the reviewer should factor in. This prevents the model from recommending changes you are already planning.
- Replace `[DEPLOYMENT_ENVIRONMENT]` with your cloud provider, orchestration platform (OpenShift, EKS, GKE), and region topology (single region, multi-region, hybrid).
- This prompt works best when you give it real constraints. Include details like "we run on OpenShift 4.14 in us-east-1 only" or "the team is 4 engineers and we do not have a dedicated SRE" so the recommendations are grounded in your actual situation.
- For multi-team systems, run the review separately for each team's domain and then once for the cross-team integration points.
- **Slash command connection:** If you use `ai-bu-claude-commands`, the `/tldr-repo` slash command can quickly summarize an unfamiliar codebase before you run an architecture review on it.

## Example Output

```
## Architecture Review: order-processing-service

### 1. Scalability: Needs Work

**Current state**: The service uses a single PostgreSQL instance for both read and write
traffic. Every order triggers three synchronous writes (order, line items, audit log)
in a single transaction. At 200 orders/sec, the database CPU is at 60%.

**At target scale (2,000 orders/sec)**: The database will be saturated. Write contention
on the `orders` table will increase transaction latency, and read queries for the admin
dashboard will compete with writes.

**Recommendations**:
1. **Introduce read replicas for query traffic.** Route the admin dashboard and reporting
   queries to a read replica. This removes read load from the primary and can be done
   without application changes if your connection pool supports read/write splitting.
   Estimated effort: 1 to 2 weeks.
2. **Move audit log writes to an asynchronous path.** The audit log does not need to be
   in the same transaction as the order. Publish audit events to a message queue and
   write them asynchronously. This reduces the per-transaction write count from 3 to 2.
   Estimated effort: 2 to 3 weeks.

### 2. Reliability and Fault Tolerance: Adequate

**Current state**: The service has retry logic with exponential backoff for the payment
gateway, which is good. The inventory check has no timeout configured.

**Risk**: If the inventory service hangs, this service will hang with it. There is no
circuit breaker. Under sustained inventory service degradation, the order service's
thread pool will be exhausted and it will stop accepting new requests.

**Recommendations**:
1. **Add a 2-second timeout and circuit breaker on the inventory client.** Define a
   fallback behavior: either reject the order with a clear error, or accept with a
   flag indicating inventory was not verified. Estimated effort: 2 to 3 days.

### 3. Data Integrity and Consistency: Strong

Writes are wrapped in database transactions. The payment capture is idempotent using
an idempotency key. Order creation and line item insertion are atomic. No concerns at
current or projected scale.

### 4. Operational Readiness: Needs Work

**Current state**: Application logs exist but are unstructured (plain text). There are
no metrics exported for request latency or error rates. The health check endpoint
returns HTTP 200 unconditionally and does not verify database connectivity.

**Recommendations**:
1. **Switch to structured JSON logging.** This enables log aggregation, searching, and
   alerting based on specific fields. Estimated effort: 2 to 3 days.
2. **Export Prometheus metrics for request duration, error count, and queue depth.** These
   are the minimum metrics needed to detect degradation before customers report it.
   Estimated effort: 3 to 5 days.
3. **Update the health check to verify database connectivity.** Return degraded status if
   the database is unreachable. This allows your orchestrator to route traffic away from
   unhealthy instances. Estimated effort: 1 day.

### 5. Simplicity and Maintainability: Adequate

The architecture is straightforward: one service, one database, two external dependencies
(payment gateway and inventory service). One potential simplification: the separate
"notification dispatcher" service could be replaced by publishing events to the existing
message queue and letting consumers handle notifications. This removes one service from
the team's operational burden.

### 6. Security Boundaries: Adequate

Authentication is enforced at the API gateway. Internal service-to-service calls use mTLS.
However, the inventory service accepts unauthenticated requests from within the cluster. If
any pod is compromised, it could manipulate inventory data.

**Recommendation**: Add service-level authorization using RBAC or a service mesh policy.
Estimated effort: 1 to 2 weeks depending on your service mesh maturity.

---

## Priority Summary

| Rank | Issue | Worst-case impact | Fix | Effort |
|------|-------|-------------------|-----|--------|
| 1 | No timeout or circuit breaker on inventory client | Full service outage if inventory service hangs | Add 2s timeout and circuit breaker | Days |
| 2 | Single database with no read replicas | Service cannot reach 2,000 orders/sec target | Add read replicas, async audit log | Weeks |
| 3 | No metrics or structured logging | Degradation goes undetected until customers report it | Add Prometheus metrics, structured logging | Days |
```
