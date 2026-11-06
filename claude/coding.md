# Coding

## Ask first
- Before any commit, push or PR. Show me the proposed message(s) or PR
  description first.

## Never
- Force-push, rebase shared branches or amend commits that have been pushed,
  unless I explicitly ask.
- Commit secrets, `.env` files or local config. Warn me if one is staged.

## Commit messages use the Conventional Commits standard
Format: `<type>(<scope>): <summary>`, optional body and footers.

- **Types:** `feat`, `fix`, `refactor`, `perf`, `test`, `docs`, `build`,
  `ci`, `chore`, `revert`, `wip` (see below) and `poc` (throwaway
  prototype, not meant to merge). One type per commit; needing two usually
  means two commits.
- **Scope:** optional short area name (`auth`, `kyb`, `api`). Reuse scopes
  from the repo's history; omit if none fits.
- **Summary:** imperative, starts lowercase, no full stop. Keep the whole
  header line under ~72 chars.
  Good: `fix(api): return 404 for unknown company numbers`
  Bad: `fix: fixed bug`
- **Body:** optional; explain *why*, not what.
- **Simple changes:** title line only, no body or `Co-Authored-By` trailer.
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

## Worktrees
Put worktrees beside the repo, never inside it: nested checkouts confuse
watchers, linters and package managers in large monorepos.

- Branch: `<type>/<ticket>-<slug>`, or `<type>/<slug>` when there's no
  ticket. Type is a commit type from the list above. Write the slug from
  the task in 2–4 kebab-case words, all lowercase. Never invent a ticket.
- Directory: `../<repo>-<branch>`, with `/` replaced by `-`, e.g.
  `../dotfiles-fix-112-do-some-cool-thing`.
- State the names before creating; don't ask unless something's unclear.
- Don't install dependencies. Remind me to `/cd` into the new worktree or
  start a new Claude session there.

## Record decisions as ADRs
When we settle a decision, offer to record it as an ADR if it's all three:

1. Hard to reverse: changing our minds later has a real cost.
2. Surprising without context: a future reader would wonder why.
3. The result of a real trade-off: there were genuine alternatives.

Skip it if any is missing. Before writing one, read `~/.claude/rules/adr.md`
for the format.

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
