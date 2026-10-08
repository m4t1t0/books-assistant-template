# Books Assistant

## How to Use This File

**MANDATORY**: This workspace is documented through a hierarchy of agent instruction files.
Follow this protocol at the start of every session:

1. Read this file first — it maps the entire workspace.
2. Follow the links in the navigation tables below to the instruction file closest to your task.
3. Each child file describes local structure, conventions, and key files.
4. Only after exhausting the instruction-file chain, explore individual content files.

## What Is This Project

This repository is {{NAME}}'s second brain for books. PDFs are ingested
into Markdown, distilled into wiki pages in `library/`, and connected through
topics and cross-links. The two core capabilities:

- **ingest-book** — convert a PDF (`sources/`) and distill it into the library
- **summarize** — summarize a single book, or synthesize a topic across books

## Deep-Dive Navigation

| Path | Description | Keywords |
|------|-------------|----------|
| [library/AGENTS.md](library/AGENTS.md) | The knowledge layer: book pages, topic pages, people pages, and the catalog. | library, wiki, books, topics, catalog |

## Conventions

- **Language**: books are English (computer science / software architecture). Write all wiki pages in English.
- **Topic tags are a controlled vocabulary**: every book page declares its topics from the tags listed in `library/AGENTS.md`. New topics may be added, but only deliberately, with an entry in the topic list.
- **Cross-links are mandatory**: every book page links to at least one other book, topic, or people page.
- **Raw converted Markdown** of every book is kept in `fulltext/` (never deleted) for full-text search and deep queries.
- **PDFs in `sources/` are transient**: processed PDFs are deleted after successful ingest.
- **TASKS.md** can hold a reading queue (Next up / Reading / Done).

## Agent Compatibility

This workspace runs on OpenCode: skills are plain Markdown in `skills/*/SKILL.md`,
mirrored via symlink into `.opencode/skills/`.

## Me

{{NAME}} ({{EMAIL}})

## Key Files
- **library/AGENTS.md** — navigation hub for the library wiki
- **sources/** — raw PDFs awaiting ingest
- **fulltext/** — converted Markdown of ingested books (kept forever)
- **skills/** — ingest-book and summarize capabilities
