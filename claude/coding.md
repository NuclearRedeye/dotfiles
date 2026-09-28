# Coding

## Ask first
- Before any commit or push. Show me the proposed message(s) first.

## Never
- Force-push, rebase shared branches or amend commits that have been pushed,
  unless I explicitly ask.
- Commit secrets, `.env` files or local config. Warn me if one is staged.

## Commit messages use the Conventional Commits standard
Format: `<type>(<scope>): <summary>`, optional body and footers.

- **Types:** feat, fix, refactor, perf, test, docs, build, ci, chore, revert,
  and `wip` (see below). One type per commit; needing two usually means two
  commits.
- **Scope:** optional short area name (`auth`, `kyb`, `api`). Reuse scopes
  from the repo's history; omit if none fits.
- **Summary:** imperative, starts lowercase, no full stop. Keep the whole
  header line under ~72 chars.
  Good: `fix(api): return 404 for unknown company numbers`
  Bad: `fix: fixed bug`
- **Body:** optional; explain *why*, not what.
- **Breaking changes:** add `!` (e.g. `feat(api)!: remove v1 endpoints`) plus
  a `BREAKING CHANGE:` footer with migration notes. Flag these to me first.
- **Tickets:** `Refs: CDD-1234` footer when known. Never invent one.

## Commit size and scope
Prefer small, focused commits. Each commit should do one thing and leave the
codebase in a working state (builds, tests pass). `wip:` checkpoints are the
only exception.

- One logical change per commit. A bug fix, a refactor and a new feature are
  three commits, even if they touch the same file.
- Separate mechanical changes from behavioural ones. Renames, moves and
  formatting go in their own commit so the real change is easy to review.
- If a commit message needs "and" to describe it, it's probably two commits.
- Rough guide: under ~200 changed lines. Larger is fine for generated code,
  migrations or lockfiles, but call that out in the message.
- Don't commit work in progress or commented-out code. If I ask you to
  checkpoint mid-task, use a `wip:` prefix so it's obvious to squash later.
- When a task naturally produces several commits, propose the split before
  committing, e.g. "1) extract helper, 2) add validation, 3) tests".

## Code comments
Keep comments short: ideally one line, around 16 words.

- Explain *why* or anything non-obvious. Don't restate what the code does.
  Good: `// Retry once; provider drops the first request after idle`
  Bad:  `// Loop through the list and add each item to the total`
- If a comment needs more than a line or two, the code probably needs
  simplifying or a better name instead.
- Longer context belongs in design docs: ADRs, TDRs or spec files. Link to
  the relevant one (e.g. `// See docs/adr/0012-retry-policy.md`) rather than
  repeating it. Link to a commit, PR or ticket only when no doc exists.
- Docstrings for public APIs are the exception: follow the language's
  convention, but keep each part as brief as possible.
- Update or delete comments when the code they describe changes.

## Favour readability over performance
Only trade readability for speed when performance is a stated requirement,
there's a measured problem or it's a known hot path.

- Write the clearest version first. Don't optimise on speculation.
- Clear still means sensible: avoid obviously wasteful patterns (N+1
  queries, repeated work in loops) where the efficient version is just as
  readable.
- If you keep a simple but slow approach on purpose, mark it with `PERF:`
  and note what's slow.
- If an optimisation makes code harder to read, isolate it, explain *why*
  in a short comment and link to the benchmark or ticket.

## Capture debt as comments in code
Mark deferred, broken or questionable code with tagged comments so a search
finds them all.

**Tags:** `TODO` works but incomplete · `FIXME` known bug or wrong in some
cases · `HACK` workaround to rewrite (say what it works around) ·
`PERF` correct but slow.

Format: `<TAG>(<ticket>): <what and why>`

    // TODO(CDD-1234): support multiple directors once API returns them
    // FIXME(CDD-1301): fails when company number has leading zeros
    // HACK: provider returns 200 on errors; check body until they fix it
    // PERF: N+1 query per officer; batch this if lists get large

- Tickets are optional but encouraged. Never invent one; omit the brackets
  if there isn't one.
- Uppercase tag plus a colon. Always say *why*, not just "TODO: refactor".
- Add tags when leaving something incomplete in code you're changing. For
  problems outside the task's scope, tell me rather than editing unrelated
  files or fixing them unasked.
- List any tags you added in your reply so I can raise tickets.
- Only remove a tag when the change actually resolves it.
