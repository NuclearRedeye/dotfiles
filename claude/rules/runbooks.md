---
paths:
  - "**/runbooks/**/*.md"
---

# Runbooks

Two kinds:
- Operational runbooks: cover a planned or recovery task, e.g. restoring
  etcd quorum after disk failure.
- Alert runbooks: cover how to respond to a firing alert, e.g. a
  `KubePodCrashLooping` alert.

Pick the structure that fits, but a codebase's own template or rules win.

## Operational runbooks
- Name the file after the task in kebab-case, e.g.
  `recover-etcd-quorum.md`.
- H1 is the task as an imperative, e.g. `# Recover etcd quorum`.
- A short description under the H1: what the runbook does and the end
  state.
- Then these H2 sections, in this order, all present:
  - `## When to use`: the symptoms or situations it's for.
  - `## When not to use`: near misses, and which runbook to use instead.
  - `## Before you start`: access, tools, backups and checks needed first.
  - `## Steps`: numbered steps.
  - `## Verification`: how to confirm it worked, and what to do if not.
- Use H3s inside `Steps` to group phases of a long task.

## Alert runbooks
Follow the
[Prometheus Operator runbook structure](https://runbooks.prometheus-operator.dev).

- One runbook per alert. Name the file after the alert, e.g.
  `KubePodCrashLooping.md`. Group by component in subfolders if needed.
- H1 is the exact alert name, so it can be found from the alert.
- Then these H2 sections, in this order, all present:
  - `## Meaning`: what the alert means and what fires it. Link to the
    alert rule.
  - `## Impact`: who or what is affected and how badly.
  - `## Diagnosis`: steps to confirm the cause, most likely first.
  - `## Mitigation`: steps to stop the impact, then fix the cause.
- No other H2 sections. Use H3s inside a section for sub-steps or
  separate causes.

## Writing
- Write for an on-call engineer at 3am who doesn't know this service.
- Numbered steps for anything done in order.
- Commands in fenced code blocks, ready to copy. Mark placeholders as
  `<namespace>`, and say where to find the value.
- Say what good and bad output look like after each check.
- Link dashboards, logs and related runbooks rather than repeating them.
- Flag destructive or risky steps before the step, not after.
