---
description: Ingest a PDF book from sources/ into the library
---

Use the `ingest-book` skill to ingest a book into the library.

The PDF to process: $ARGUMENTS (if empty, look in `sources/` for the only
PDF there and confirm with me before proceeding).

Follow the skill's pipeline in strict order: locate → convert with
`~/.venvs/markitdown/bin/markitdown` → skim fulltext → distill the wiki page
in `library/books/<author-slug>/<book-slug>.md` → cross-link topic/author
pages and the catalog in `library/AGENTS.md` → delete the PDF from
`sources/` → report which pages were created or updated.

Topic tags must come from the controlled vocabulary in `library/AGENTS.md`.
Never invent content and never delete the fulltext Markdown.
