# Architecture Review Prompt

A prompt for evaluating system architecture with a focus on scalability, reliability, and operational readiness.

**Difficulty:** Advanced

## When to use

- Evaluating a new system design before committing to implementation
- Reviewing an existing system before a major scaling effort or migration
- Preparing for an architecture review meeting and you want to identify gaps ahead of time
- Assessing operational readiness before a GA launch or production rollout
- Onboarding onto a new team and you need to quickly understand the strengths and risks of an existing system

## When NOT to use

- The system is a prototype, proof of concept, or throwaway experiment. Applying production-grade review criteria to throwaway code wastes time.
- You need a detailed capacity plan with specific numbers. Run load tests and benchmark your infrastructure instead. This prompt identifies architectural risks, not exact throughput limits.
- You need a compliance or regulatory audit. Engage your compliance team for that.

## Prompt

```
You are a principal engineer reviewing the architecture of a system. Evaluate the design based on the following criteria and provide concrete, actionable feedback for each.

1. **Scalability**: Can this system handle 10x its current load? Where are the bottlenecks? Are there single points of contention (shared databases, global locks, single-threaded workers)?
2. **Reliability and Fault Tolerance**: What happens when a dependency fails? Are there retries, circuit breakers, timeouts, and fallback paths? What is the blast radius of a single component failure?
3. **Data Integrity**: How is consistency maintained? Are there scenarios where data could be lost, duplicated, or become stale? Are writes idempotent?
4. **Operational Readiness**: Is the system observable? Are there health checks, structured logging, metrics, and alerting? Can it be deployed with zero downtime? Can it be rolled back quickly?
5. **Simplicity**: Is the architecture more complex than it needs to be? Are there components that could be removed or consolidated without losing functionality?
6. **Security Boundaries**: Are trust boundaries clearly defined? Is authentication and authorization enforced at every layer, or only at the edge?

For each criterion, give one of these ratings:
- **Strong**: No significant concerns.
- **Adequate**: Works today but has known limitations that will need attention.
- **Needs Work**: Has gaps that could cause incidents or block scaling.

System name: [SYSTEM_NAME]
Architecture description or diagram: [ARCHITECTURE_DESCRIPTION]
Current scale (requests/sec, data volume, team size): [CURRENT_SCALE]
Known pain points or upcoming requirements: [KNOWN_ISSUES]
```

## Usage Tips

- Replace `[SYSTEM_NAME]` with the name of the service or platform being reviewed.
- Replace `[ARCHITECTURE_DESCRIPTION]` with a text description of the components, how they communicate, and what data stores they use. If you have an architecture diagram, describe it in text or paste the contents of a design doc.
- Replace `[CURRENT_SCALE]` with concrete numbers. Vague descriptions like "medium traffic" produce vague reviews.
- Replace `[KNOWN_ISSUES]` with any existing problems, planned migrations, or upcoming changes that the reviewer should factor in.
- This prompt works best when you give it real constraints. Include details like "we run on OpenShift 4.14" or "the team is 4 engineers" so the recommendations are grounded in your actual situation.

## Example Output

```
## Architecture Review: order-processing-service

### Scalability: Needs Work

The service uses a single PostgreSQL instance for both read and write traffic.
At 10x current load (from 200 to 2,000 orders/sec), the database will become
the bottleneck. The `orders` table is already the largest table, and every
order triggers three synchronous writes (order, line items, audit log).

Recommendation: Introduce read replicas for query traffic. Consider moving
the audit log to an async write path using a message queue.

### Reliability and Fault Tolerance: Adequate

The service has retry logic for the payment gateway, which is good. However,
the inventory check has no timeout configured. If the inventory service hangs,
this service will hang with it. There is no circuit breaker.

Recommendation: Add a 2-second timeout and a circuit breaker on the inventory
client. Define a fallback behavior (reject the order vs. accept with a warning).

### Data Integrity: Strong

Writes are wrapped in database transactions. The payment capture is idempotent
using an idempotency key. No concerns here.

### Operational Readiness: Needs Work

There are application logs, but they are unstructured (plain text). There are
no metrics exported for request latency or error rates. The health check
endpoint only returns HTTP 200 and does not verify database connectivity.

Recommendation: Switch to structured JSON logging. Add Prometheus metrics for
request duration, error count, and queue depth. Update the health check to
ping the database and return degraded status if it is unreachable.

### Simplicity: Adequate

The architecture is straightforward. One potential simplification: the
separate "notification dispatcher" service could be replaced by publishing
events to the existing message queue and letting consumers handle notifications
directly.

### Security Boundaries: Adequate

Authentication is enforced at the API gateway. Internal service-to-service
calls use mTLS, which is good. However, the inventory service accepts
unauthenticated requests from within the cluster. If any pod is compromised,
it could manipulate inventory data.

Recommendation: Add service-level authorization using RBAC or a service mesh
policy.
```
