---
paths:
  - "**/docs/requirements/**/*.md"
---

# Requirements

Written in [EARS](https://alistairmavin.com/ears/) syntax, kept with the
code they describe. A codebase's own template or rules win.

## Files
- Put requirements in `docs/requirements/`. In a repo with several
  contexts, system-wide ones go in the root, others in
  `<context>/docs/requirements/`.
- One concern per file, named after it in kebab-case, e.g. `volumes.md`
  and `data-protection.md`. If a reader might look up two parts of a file
  separately, split it.
- Each file has its own ID prefix of 2–4 capitals, e.g. `VOL-`, `DP-`.
- Create `docs/requirements/` only when writing the first file.

## Template

```md
# Data protection requirements

How data in each storage tier (VOL-001) survives node failure and is
backed up.

## DP-002 Single node failure
When one node fails, the cluster shall run the affected workloads on
another node within 5 min, with no data loss.
- Verify: power off a node; time until pods are Ready; check data.
- Status: proposed

## DP-005 Incremental backups
Where a volume is backed up, the cluster should back it up incrementally.
- Verify: second backup transfers only changed blocks.
- Status: accepted
```

- H1 names the concern. Below it, 1–2 sentences on scope.
- One H2 per requirement: `## <ID> <short title>`.
- Under each H2, in this order:
  - One EARS statement.
  - `- Verify:` one line on how to prove it's met.
  - `- Status:` `proposed`, `accepted`, `met` or `dropped`.
- No other sections. Put open questions in chat or an issue, not the file.

## EARS
Pick the pattern that fits:
- Always: `The <system> shall <response>.`
- Event: `When <trigger>, the <system> shall <response>.`
- State: `While <state>, the <system> shall <response>.`
- Optional: `Where <feature applies>, the <system> shall <response>.`
- Unwanted: `If <failure>, then the <system> shall <response>.`

Use `shall` for must-haves and `should` for nice-to-haves.

## Writing
- One `shall` or `should` per requirement. If it needs "and" across two
  behaviours, split it.
- Say *what* the system does, not *how*. No product names or config
  values (e.g. "3 replicas") unless they're the requirement itself.
- Put a number on it wherever you can: times, sizes, data loss limits.
- Refer to other requirements by ID, e.g. `the ephemeral tier (VOL-001)`.
- Link to the ADRs that meet a requirement, and from those ADRs back to it.

## Changing requirements
- IDs are permanent. Never reuse or renumber them.
- Don't delete a requirement; set its status to `dropped` and say why in
  one line.
- Changing an `accepted` requirement's meaning needs a new ID; drop the old
  one and point it to the new one.
