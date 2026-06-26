# Incident Timeline Builder

Build a structured incident timeline from raw logs, Slack messages, and notes, turning chaotic incident data into a clear sequence of events.

**Difficulty:** Intermediate

## When to use
- Building a timeline for a post-mortem after an incident
- Organizing scattered Slack threads and log entries into chronological order
- Preparing for an incident review meeting
- Documenting an incident that spanned multiple teams and communication channels

## When NOT to use
- The incident is still active (focus on resolution, document later)
- You need a full post-mortem report (use incident-report for that, and feed this timeline into it)
- The incident was trivial and resolved in under 5 minutes with no customer impact

## Prompt

```
You are an SRE building an incident timeline for a post-mortem. Using the raw data below, construct a clear, chronological timeline of events.

Incident: [INCIDENT_TITLE]
Date: [DATE]
Severity: [SEV_LEVEL]
Services affected: [SERVICES]

For each event in the timeline, provide:
- **Timestamp** (24-hour UTC format): When it happened. If the exact time is unclear, note it as approximate with "~".
- **Event**: What happened, in one clear sentence.
- **Source**: Where this information came from (e.g., Slack #incident-channel, PagerDuty alert, Grafana dashboard, deployment log).
- **Actor**: Who took the action or who reported the observation, if known. Use roles (e.g., "on-call SRE") if names are sensitive.

After the timeline, provide:

1. **Key gaps**: List any periods where you could not determine what happened based on the available data. These need follow-up.
2. **Detection delay**: How long between the first observable symptom and the first human response? What caused the delay, if any?
3. **Resolution markers**: Identify the moment the root cause was found, the moment the fix was applied, and the moment service was confirmed restored.

Constraints:
- Use UTC timestamps throughout. Convert from local time zones if needed.
- If timestamps in the raw data conflict, note the discrepancy and use the most reliable source.
- Do not speculate about events not supported by the raw data. Flag gaps instead.
- Do not use em dashes. Use commas, periods, or "and" instead.

Raw data (paste Slack messages, logs, alerts, and notes below):
[PASTE_RAW_DATA_HERE]
```

## Usage Tips

- Copy and paste directly from Slack, PagerDuty, and log files. The prompt handles messy, overlapping data well.
- Include timestamps from monitoring alerts, as these are usually the most accurate.
- After generating the timeline, share it with the incident responders for fact-checking before the post-mortem meeting.
- Feed the completed timeline into the incident-report prompt to generate the full post-mortem.

## Example Output Snippet

> | Timestamp (UTC) | Event | Source | Actor |
> |---|---|---|---|
> | 14:03 | PagerDuty alert fires: "order-service 5xx rate > 5%" | PagerDuty | Automated |
> | 14:06 | On-call SRE acknowledges alert and opens incident channel | Slack #incidents | On-call SRE |
> | 14:09 | SRE checks Grafana, confirms 5xx spike starting at ~14:01 | Grafana dashboard | On-call SRE |
> | 14:14 | Database team reports long-running migration holding table lock | Slack #incident-20250312 | DBA on-call |
> | 14:22 | Decision made to kill the migration process | Slack #incident-20250312 | Incident commander |
> | 14:35 | Migration rolled back, table lock released | Database logs | DBA on-call |
> | 14:42 | 5xx rate dropping, below 1% | Grafana dashboard | On-call SRE |
> | 14:50 | Error rates at baseline, incident declared resolved | Slack #incident-20250312 | Incident commander |
>
> **Detection delay**: 2 minutes between first symptom (~14:01 per Grafana) and alert firing (14:03). 3 additional minutes to human acknowledgment. Total detection-to-response: 5 minutes.
>
> **Key gaps**: No data available for what happened between 14:14 and 14:22 while the team discussed whether to kill the migration. Meeting notes or a follow-up interview would fill this gap.
