---
name: knowledge-base
description: Create a new knowledge base (Karpathy's LLM Wiki pattern) for a topic in ~/Documents, then run the first ingest. Use when the user wants to start a knowledge base on a topic.
argument-hint: "[topic]"
---

# New knowledge base

Set up a persistent, LLM-maintained knowledge base following Karpathy's
LLM Wiki pattern, then ingest the first sources with the user.

The pattern, pinned so every knowledge base starts from the same idea
file:
`https://gist.githubusercontent.com/karpathy/442a6bf555914893e9891c11519de94f/raw/ac46de1ad27f92b28ac95459c782c07f6b8c964a/llm-wiki.md`

Ask the user **one question per turn**, each with a suggested default.
Skip any question the arguments or earlier answers already settle.

## 1. Read the pattern

Fetch the gist above with `curl -fsSL`. Read it in full: it is the brief
for every later step. If the fetch fails, stop and tell the user.

## 2. Interview

Ask, in this order:

1. **Topic and goal**: what is the knowledge base about, and what do they
   want out of it (e.g. "understand X well enough to decide Y")?
2. **Name**: propose a kebab-case slug from the topic. The knowledge base
   lives at `~/Documents/kb-<slug>`. If that path exists, ask for another
   slug.
3. **Sources**: what kinds (essays, papers, PDFs, transcripts, videos)
   and roughly how many? This shapes the page types and whether
   `index.md` alone will scale.
4. **Page types**: propose the defaults below, tailored to the topic, and
   ask what to add or drop. Defaults:
   - `sources/`: one summary page per raw source.
   - `people/`: profiles of authors and key figures: who they are, their
     positions, how their views relate to others', what they've written.
   - `concepts/`: ideas, terms and techniques.
   - `findings/`: key claims and takeaways, with supporting and
     contradicting sources.
5. **First sources**: URLs or file paths to ingest first. Fine to have
   none yet.

Assume one-at-a-time, discussed ingests (Karpathy's preferred style)
unless the user says otherwise.

## 3. Scaffold

Create, under `~/Documents/kb-<slug>/`:

- `llm-wiki.md`: the fetched gist, kept for reference.
- `raw/` and `raw/assets/`: immutable sources; you never edit these.
- `wiki/index.md`, `wiki/log.md`, `wiki/overview.md`, plus one folder per
  page type.
- `CLAUDE.md`: the schema. Fill in [schema-template.md](schema-template.md)
  with the interview answers. Fill every placeholder; keep its sections.

Then `git init`, and log the setup in `wiki/log.md` as
`## [YYYY-MM-DD] setup | <topic>`. Ask before the first commit.

Done when: the tree exists, `CLAUDE.md` has no placeholders left, and
`overview.md` states the topic and goal.

## 4. First ingest

Read the new `CLAUDE.md` and follow its **Ingest** workflow for each
source from step 2, one at a time:

- URL: fetch it and save as markdown in `raw/`. If the site blocks
  fetching, ask the user to save it there (Obsidian Web Clipper works).
- File: copy it into `raw/`.

Done when: every source has a `sources/` page, `index.md` lists every
page, and each ingest has a `log.md` entry.

## 5. Hand over

Tell the user, briefly:

- The knowledge base path, and to open it as an Obsidian vault and check
  the graph view.
- To start future sessions in that directory so `CLAUDE.md` loads.
- How to use it: drop files in `raw/` and say "ingest", ask questions
  ("query"), or ask for a "lint" pass.
- Gaps and next sources worth finding, from the first ingest.
- One synthesis question worth asking next, e.g. where two authors
  agree and differ.
