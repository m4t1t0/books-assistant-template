---
name: Ingest Book
description: Ingest a PDF book from sources/ into the library — convert to Markdown, distill into a wiki page, wire cross-links, update the catalog, delete the PDF
---

# Skill: ingest-book

Ingest a PDF book into the library: convert to Markdown, distill into a wiki
page, wire cross-links, update the catalog, and clean up.

## When to trigger

- "Ingest this book", "add this PDF to the library"
- A PDF sits in `sources/` and the user asks to process it

## Pipeline (strict order)

1. **Locate**: the PDF must be in `sources/`. If the user points elsewhere
   (e.g. Downloads), move it there first.
2. **Convert**: run:
   `~/.venvs/markitdown/bin/markitdown sources/<file>.pdf > fulltext/<slug>.md`
   Verify the output is non-trivial (> 10 KB for a real book). If conversion
   produces garbage (image-only PDF), report failure — do not fabricate.
3. **Read**: skim the fulltext (chapter headings, section structure, intro and
   conclusion of each chapter are enough for a first-pass distillation; read
   more deeply what the user marks as important later).
4. **Distill**: write `library/books/<author-slug>/<book-slug>.md` with:
   - Front matter block: title, author, year, edition, pages, topics (tags
     MUST come from the controlled vocabulary in `library/AGENTS.md`)
   - **Thesis**: the book's core argument in 1–3 sentences
   - **Key ideas**: the 5–10 ideas that carry the book, each 1–3 sentences
   - **Chapter map**: one line per chapter/parts
   - **Memorable quotes**: 3–5 verbatim quotes with chapter reference
   - **Connections**: links to at least one topic page and, when relevant,
     other books ("extends X", "contrasts with Y on Z")
5. **Cross-link**:
   - Update each referenced topic page with a one-line entry for this book
   - Create/update the author page in `library/people/`
   - Register the book in the Books catalog table in `library/AGENTS.md`
6. **Cleanup**: delete the PDF from `sources/`.
7. **Report**: tell the user which pages were created/updated.

## Slug conventions

- Book pages: `library/books/<author-slug>/<title-slug>.md` (e.g. `sam-newman/building-microservices.md`)
- Author slugs: lowercase, hyphenated (`sam-newman`)
- Topic tags: lowercase, singular where natural (`microservices`, `api-design`)

## Rules

- Never invent content: if a section can't be read, mark it "(not skimmed)".
- Never delete the fulltext Markdown.
- If the book doesn't fit existing topic tags, propose new ones and ask.
