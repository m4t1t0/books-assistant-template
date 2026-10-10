---
description: In-depth study summary of a book as a typeset PDF (exports/, via pandoc + typst)
---

Use the `deep-summary` skill to produce a deep summary: $ARGUMENTS (if empty,
ask me which ingested book to summarize).

Follow the skill's pipeline in strict order: read the book page in
`library/books/` and deep-read the fulltext in `fulltext/` chapter by chapter
→ draft `exports/<book-slug>-deep-summary.md` with the five expanded sections
(one-paragraph thesis, expanded key ideas, one page per chapter, extended
evidence, extended connections) → prepend the preamble from the skill's
`reference/preamble.typ` with the correct `deep-title` → compile with
`pandoc ... --pdf-engine=typst -o exports/<book-slug>-deep-summary.pdf` →
verify page count, footer, and chapter page breaks → report paths and pages.

Quote verbatim only from fulltext, never from memory. The Markdown source is
the artifact of record — recompile it after any edit, never hand-patch the PDF.
