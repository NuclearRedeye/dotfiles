---
paths:
  - "**/docs/adr/**/*.md"
---

# ADRs

Based on Matt Pocock's ADR format, with required frontmatter. Use this over
the `domain-modeling` skill's format, but a codebase's own template or rules
win.

## Files
- Put ADRs in `docs/adr/`. In a repo with several contexts, system-wide
  decisions go in the root `docs/adr/`, others in `<context>/docs/adr/`.
- Name `NNNN-slug.md`: one higher than the highest existing number, slug in
  kebab-case, e.g. `0003-use-gateway-api.md`.
- Create `docs/adr/` only when writing the first ADR.

## Template

```md
---
status: accepted
date: 2026-11-06
---

# Use Gateway API for ingress

We need to route external traffic to cluster services. We chose Gateway
API over Ingress because it splits infra and app ownership via roles,
supports TCP/gRPC natively, and is where upstream development is going.
```

- Frontmatter is required:
  - `status`: `proposed`, `accepted`, `deprecated` or
    `superseded by ADR-NNNN`.
  - `date`: when the decision was made, as `YYYY-MM-DD`.
- H1 states the decision. No number in the H1; the filename holds it.
- Body is 1–3 sentences: the context, what we decided and why.
- Optional H2s, only when they add value. Most ADRs need neither:
  - `## Considered Options`: rejected alternatives, when the reason for
    rejecting them is non-obvious.
  - `## Consequences`: non-obvious downstream effects.
- No other sections.

## Changing ADRs
- Don't rewrite an accepted ADR's decision. Fixing typos and links is fine.
- To change a decision, write a new ADR. Set the old one's status to
  `superseded by ADR-NNNN` and link back to it from the new one.
- If a decision no longer applies and nothing replaces it, set its status
  to `deprecated`.

## Writing
- Write for an engineer a year from now who wasn't in the discussion.
- Record *why*, not *how*. Implementation detail belongs in code or
  design docs.
- ADRs are history; READMEs and other docs describe the current state.
  Link to an ADR from those docs and from code comments rather than
  repeating it.
