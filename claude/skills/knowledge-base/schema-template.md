# <Topic> knowledge base

<Goal: one or two sentences on what this knowledge base is for.>

Sources: <kinds of source and expected volume>.

You maintain this knowledge base. The user curates sources and asks questions; you
do the summarising, cross-referencing, filing and bookkeeping. The pattern
is in `llm-wiki.md`. Evolve this file with the user as conventions settle.

## Layout

- `raw/`: source documents. Immutable: read them, never edit them.
  Images go in `raw/assets/`.
- `wiki/`: everything you write.
  - `index.md`: catalogue of every page, by type, one line each.
  - `log.md`: append-only timeline of ingests, queries and lint passes.
  - `overview.md`: the evolving synthesis of the whole topic.
<One line per page-type folder: `wiki/<type>/`: what goes in it.>

## Page conventions

- File names are kebab-case, e.g. `wiki/people/jane-doe.md`.
- Link pages with Obsidian wikilinks: `[[jane-doe]]`.
- Every page starts with YAML frontmatter:

  ```yaml
  type: <page type>
  sources: [<raw file names>]
  updated: YYYY-MM-DD
  ```

- Cite claims back to their source page, e.g. `([[source-slug]])`.
- When sources disagree, keep both claims, cite each, and mark the
  conflict with `> [!warning] Contradiction`.
<Per-type sections each page must have, e.g. for people: Who they are,
Key positions, Works, Relationships to others.>

## Workflows

### Ingest

1. Read the source in `raw/` in full (text first, then any images).
2. Read `index.md` and the existing pages the source relates to.
3. Discuss the key takeaways with the user before writing, including how
   it connects to what the knowledge base already holds.
4. Write its `sources/` page, linking related sources.
5. Update existing pages first; create a page only for something new.
   Flag where it contradicts or strengthens existing pages.
6. Update `overview.md` if the synthesis moved.
7. Update `index.md`.
8. Append to `log.md`: `## [YYYY-MM-DD] ingest | <source title>`.

### Query

1. Read `index.md`, then the relevant pages.
2. Answer with citations to wiki pages.
3. Offer to file a useful answer (comparison, analysis, new connection)
   as a new page, then update `index.md` and `log.md`
   (`## [YYYY-MM-DD] query | <question>`).

### Lint

Check for contradictions, stale claims, orphan pages, concepts mentioned
without a page, missing links and gaps a new source could fill. Report,
fix what the user agrees to, and log
`## [YYYY-MM-DD] lint | <summary>`.
