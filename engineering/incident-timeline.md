# Incident Timeline Builder

Build a structured incident timeline from raw logs, Slack messages, alerts, and notes, turning chaotic incident data into a clear, chronological sequence of events suitable for post-mortem review.

**Difficulty:** Intermediate

## Naive vs. Engineered

Most people dump a Slack thread into an AI tool and type something like:

> **Naive prompt:** "Create a timeline from these incident messages."

**What you get:** A cleaned-up list of the Slack messages in roughly the order they appeared, missing events from other sources, with no gap analysis, no detection delay calculation, no distinction between reliable automated timestamps and approximate human-reported times, and no confidence assessment. It looks organized, but it silently drops contradictions and fills gaps with plausible-sounding guesses.

**This prompt** produces a fact-based, multi-source timeline with every event categorized and sourced, gaps explicitly flagged instead of papered over, timestamp conflicts called out, key milestones identified and measured, and a confidence rating that tells the review team where the weak spots are. The difference is the gap between "incident started around 2pm" and a structured table showing detection at 14:01, alert at 14:03, human response at 14:06, with an 8-minute gap from 14:14 to 14:22 flagged for follow-up because the decision to kill the migration was made during that period with no written record.

## When to use

- Building a timeline for a post-mortem after a production incident, when raw data is scattered across Slack threads, alert systems, and deployment logs
- Organizing overlapping Slack threads and log entries from multiple channels into a single chronological sequence that the whole team can follow
- Preparing for an incident review meeting where you need to present what happened and when, without ambiguity or missing context
- Documenting an incident that spanned multiple teams and communication channels, where no single person saw the full picture
- Reconstructing a timeline days after the incident, when memories have faded and only written records remain
- Training new SREs by walking them through a real incident timeline to show how detection, diagnosis, and resolution unfolded
- Comparing timelines across recurring incidents to identify systemic patterns (e.g., the same service failing every time a migration runs)

## When NOT to use

- The incident is still active and ongoing. Focus on resolution first, document later. Building a timeline during the incident distracts from fixing the problem.
- You need a full post-mortem report with root cause analysis, action items, and severity assessment. Use an incident report prompt for that, and feed this timeline into it as input.
- The incident was trivial and resolved in under 5 minutes with no customer impact and no interesting failure mode worth documenting.
- You need a customer-facing incident report or status page update. Those require a different tone and level of detail than an internal engineering timeline.

## Prompt

````
You are a senior SRE building an incident timeline for a post-mortem review. Your job is to take messy, overlapping, and sometimes contradictory raw data from multiple sources and produce a clear, chronological, fact-based timeline that the incident review team can use as the single source of truth.

Context for this incident:
- Incident title: [INCIDENT_TITLE]
- Date: [DATE]
- Severity: [SEV_LEVEL]
- Services affected: [SERVICES]
- Duration (approximate): [DURATION_IF_KNOWN]
- Teams involved: [TEAMS_INVOLVED]

Step-by-step reasoning process (follow this carefully):

1. First pass: Read through all the raw data without taking notes. Get a sense of the overall incident arc: what broke, when people noticed, what they tried, and when it was resolved.

2. Second pass: Extract every event that has a timestamp or can be placed in time relative to another event. For each event, record the timestamp, what happened, who did it or reported it, and where the information came from.

3. Sort all events into chronological order. When timestamps come from different sources (e.g., PagerDuty vs. Slack), prefer automated system timestamps over human-reported times. Automated systems do not misremember when things happened.

4. Identify gaps: Look for periods where significant time passed with no recorded events. These gaps usually mean one of two things: either nothing happened (unlikely during an active incident) or the activity was not captured in the data you have. Flag every gap longer than 5 minutes.

5. Resolve conflicts: If two sources disagree on when something happened, note the discrepancy in the timeline. Do not silently pick one. State which source you consider more reliable and why.

6. Identify the key milestones: detection (when the first symptom appeared), response (when a human engaged), diagnosis (when the root cause was identified), mitigation (when a fix was applied), and resolution (when service was confirmed restored).

7. Calculate detection delay, response time, and total incident duration from these milestones.

For each event in the timeline, provide:
- **Timestamp** (24-hour UTC format): When it happened. If the exact time is unclear, note it as approximate with "~" and explain why.
- **Event**: What happened, in one clear sentence. Use specific, observable facts, not interpretations.
- **Source**: Where this information came from (e.g., Slack #incident-channel, PagerDuty alert ID, Grafana dashboard, deployment log, Datadog trace).
- **Actor**: Who took the action or reported the observation. Use roles (e.g., "on-call SRE") if names should be anonymized.
- **Category**: One of: DETECTION, COMMUNICATION, DIAGNOSIS, ACTION, ESCALATION, RESOLUTION, or OTHER.

After the timeline, provide these analysis sections:

1. **Key milestones summary**: List the detection, response, diagnosis, mitigation, and resolution timestamps in a compact table. Calculate the elapsed time between each milestone.

2. **Key gaps**: List any periods where you could not determine what happened based on the available data. For each gap, note the time range, what you would expect to have happened, and what data source might fill the gap (e.g., "interview the DBA on-call" or "check CloudWatch logs for this period").

3. **Detection delay analysis**: How long between the first observable symptom and the first human response? Break this into system detection time (symptom to alert) and human response time (alert to acknowledgment). Note whether the detection delay was caused by missing monitors, alert fatigue, routing issues, or something else if the data supports a conclusion.

4. **Resolution markers**: Identify the moment the root cause was found, the moment the fix was applied, and the moment service was confirmed restored. Note whether resolution was confirmed by automated checks or manual verification.

5. **Timeline confidence assessment**: Rate your confidence in the timeline as HIGH (all events have precise timestamps from reliable sources), MEDIUM (some timestamps are approximate or some gaps exist), or LOW (significant gaps or conflicting data). Explain your rating.

Self-critique checklist (run through this before presenting your final output):
- [ ] Did I include every event from the raw data that is relevant to the incident, or did I drop something?
- [ ] Are all timestamps in UTC? Did I convert any local times correctly?
- [ ] Did I flag every gap longer than 5 minutes, or did I gloss over a missing period?
- [ ] Did I note all timestamp conflicts between sources instead of silently picking one?
- [ ] Did I stick to observable facts in the Event column, or did I inject interpretation or speculation?
- [ ] Did I calculate detection delay and resolution time correctly from the milestone timestamps?
- [ ] Did I avoid filling gaps with speculation? Gaps should be flagged, not invented around.
- [ ] Is the timeline actually in chronological order? Did I double-check the sort?

Anti-patterns to avoid:
1. Do not speculate about events that are not supported by the raw data. If there is a gap, flag it. Do not invent a plausible narrative to fill it.
2. Do not editorialize in the Event column. "SRE checked Grafana" is a fact. "SRE finally checked Grafana after an unacceptable delay" is editorializing.
3. Do not silently discard data that seems irrelevant. If a Slack message or log entry is in the raw data, either include it or explicitly note that you excluded it and why.
4. Do not merge multiple events into one row to save space. Each distinct action or observation gets its own row, even if they happened within the same minute.
5. Do not convert timestamps to local time zones. UTC throughout, no exceptions. Teams are often distributed, and local times cause confusion.
6. Do not assign blame or identify "who caused the incident" in the timeline. The timeline is a neutral record of events, not a blame assignment.
7. Do not omit the confidence assessment. Every timeline has uncertainty, and the team needs to know where the weak spots are.

Edge case handling:
- If the raw data contains Slack messages with no timestamps (e.g., copied without time information), place them relative to surrounding messages that do have timestamps and mark them as "~approximate."
- If the incident spans midnight UTC, make sure the date is clear for every entry. Use the full date-time format (e.g., 2025-03-12 14:03) rather than just the time.
- If the raw data includes automated alert spam (dozens of identical alerts firing in sequence), consolidate them into a single entry noting the first and last alert, the count, and the alert name. Do not list each one individually.
- If the incident had multiple phases (e.g., partial recovery followed by a second failure), clearly delineate the phases with a separator row in the timeline.
- If the raw data includes irrelevant Slack chatter mixed in with incident messages (e.g., someone asking about lunch), exclude it but note that you filtered non-incident messages from the channel.

Raw data (paste Slack messages, logs, alerts, and notes below):
[PASTE_RAW_DATA_HERE]
````

## Why This Works

This prompt applies forensic rigor to incident reconstruction through several specific techniques:

- **Two-pass reading process** (first pass for overall understanding, second pass for event extraction): This prevents the model from latching onto the first event it sees and building a narrative around it. The overview pass establishes context that makes the detail pass more accurate.
- **Source hierarchy for timestamp resolution** ("prefer automated system timestamps over human-reported times"): This single instruction eliminates a major class of timeline errors. PagerDuty says the alert fired at 14:03; a Slack message says "alert came in around 2pm." Without explicit guidance, the model might average these or pick arbitrarily. With this rule, it uses the reliable source and flags the discrepancy.
- **Explicit gap detection** (flag every gap longer than 5 minutes): This is the most important technique in the prompt. Naive timelines present a smooth narrative; real incidents have gaps where activity happened but was not recorded. Forcing the model to flag gaps instead of filling them with speculation produces a timeline the team can actually trust and improve.
- **Event categorization** (DETECTION, COMMUNICATION, DIAGNOSIS, ACTION, ESCALATION, RESOLUTION, OTHER): Tagging each event by type makes patterns visible. A timeline full of COMMUNICATION events with few DIAGNOSIS events tells you the team was talking but not investigating. This kind of pattern is invisible in an uncategorized list.
- **Anti-pattern avoidance** (seven rules including "do not speculate," "do not editorialize," and "do not assign blame"): These rules are what make the timeline suitable for a blameless post-mortem. Without them, the model tends to construct a narrative that implies fault, which poisons the review process.
- **Confidence assessment** (HIGH, MEDIUM, LOW with explanation): Requiring the model to rate its own confidence and explain the rating prevents false precision. A timeline presented as authoritative when it has significant gaps is worse than no timeline at all, because the team makes decisions based on incomplete information they believe is complete.
- **Milestone-based metrics** (detection delay, response time, total duration): Automatically calculating these metrics from the timeline data gives the post-mortem team concrete numbers to discuss and compare against SLOs, which is far more useful than qualitative assessments like "response was slow."

The core principle is that an incident timeline is an evidence-based document, not a story. The naive prompt produces a story. This prompt produces evidence.

## Usage Tips

- Copy and paste directly from Slack, PagerDuty, Datadog, and log files. The prompt handles messy, overlapping data well. Do not clean the data up before pasting; let the model sort through it.
- Include timestamps from monitoring alerts and automated systems, as these are the most accurate time references. Human-reported times in Slack are often rounded or approximate.
- After generating the timeline, share it with the incident responders for fact-checking before the post-mortem meeting. People will remember details that did not make it into Slack or logs.
- Feed the completed timeline into an incident report prompt to generate the full post-mortem document. The timeline is the backbone that the rest of the report hangs on.
- If the incident spanned more than 4 hours, consider breaking the raw data into phases (e.g., detection, diagnosis, mitigation) and running the prompt on each phase separately. Then combine the results.
- For recurring incidents, run this prompt on each occurrence and then compare the timelines side by side. Patterns in detection delays or repeated diagnostic dead ends become obvious when you line up multiple timelines.
- Include PagerDuty or OpsGenie alert data if available. The alert routing history (who was paged, when they acknowledged, whether it escalated) is some of the most reliable timestamp data you can get.

## Example Output

```
## Incident Timeline: order-service 5xx spike, 2025-03-12

| Timestamp (UTC) | Event | Source | Actor | Category |
|---|---|---|---|---|
| 14:01 | 5xx error rate on order-service begins rising above baseline (0.1% to 2.3%) | Grafana dashboard | Automated | DETECTION |
| 14:03 | PagerDuty alert fires: "order-service 5xx rate > 5%" (alert ID #8834) | PagerDuty | Automated | DETECTION |
| 14:06 | On-call SRE acknowledges PagerDuty alert and opens #incident-20250312 channel | Slack #incidents, PagerDuty | On-call SRE | COMMUNICATION |
| 14:07 | On-call SRE posts initial assessment: "5xx spike on order-service, investigating" | Slack #incident-20250312 | On-call SRE | COMMUNICATION |
| 14:09 | SRE checks Grafana, confirms 5xx spike starting at ~14:01, currently at 8.4% | Grafana dashboard | On-call SRE | DIAGNOSIS |
| 14:11 | SRE checks recent deployments; last deploy was at 12:30, no changes to order-service | Deployment log (ArgoCD) | On-call SRE | DIAGNOSIS |
| 14:14 | Database team reports long-running schema migration holding a table lock on orders table | Slack #incident-20250312 | DBA on-call | DIAGNOSIS |
| 14:15 | Incident commander role assumed by engineering manager | Slack #incident-20250312 | Engineering manager | ESCALATION |
| 14:22 | Decision made to kill the migration process after confirming it can be safely re-run | Slack #incident-20250312 | Incident commander | ACTION |
| 14:28 | DBA executes pg_terminate_backend on the migration process | Database logs | DBA on-call | ACTION |
| 14:30 | Table lock released, order-service queries begin completing normally | Database logs, Grafana | Automated | RESOLUTION |
| 14:35 | 5xx rate drops below 1% | Grafana dashboard | Automated | RESOLUTION |
| 14:42 | 5xx rate at baseline (0.1%), all health checks passing | Grafana dashboard, health check endpoint | On-call SRE | RESOLUTION |
| 14:50 | Incident declared resolved, channel archived | Slack #incident-20250312 | Incident commander | RESOLUTION |

## Key Milestones Summary

| Milestone | Timestamp | Elapsed from previous |
|---|---|---|
| First symptom | 14:01 | -- |
| Alert fired | 14:03 | +2 min |
| Human response | 14:06 | +3 min |
| Root cause identified | 14:14 | +8 min |
| Fix applied | 14:28 | +14 min |
| Service confirmed restored | 14:42 | +14 min |
| Incident closed | 14:50 | +8 min |

**Total duration**: 49 minutes (14:01 to 14:50)

## Detection Delay Analysis

System detection time: 2 minutes (first symptom at 14:01, alert at 14:03). The alert threshold was set at 5%, which meant the system waited for the error rate to climb before firing. A lower threshold (e.g., 2%) would have fired at ~14:02.

Human response time: 3 minutes (alert at 14:03, acknowledgment at 14:06). Within acceptable range for a SEV-2.

Total detection-to-response: 5 minutes. No issues identified with detection speed.

## Key Gaps

- **14:14 to 14:22 (8 minutes)**: No messages in the incident channel while the team discussed whether to kill the migration. This discussion likely happened in a Slack huddle or video call. Recommend: interview the incident commander and DBA to reconstruct this decision-making process.
- **14:28 to 14:30 (2 minutes)**: Minor gap between the kill command and lock release. Likely just processing time, but worth confirming with the DBA.

## Timeline Confidence: MEDIUM

Most events have precise timestamps from automated systems (PagerDuty, Grafana, database logs). The 14:14 to 14:22 gap reduces confidence because a key decision (whether to kill the migration) was made during that period with no written record of the discussion. The DBA's report at 14:14 has a Slack timestamp, which is reliable.
```
