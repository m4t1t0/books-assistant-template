---
name: Deep Summary
description: Produce an in-depth study-summary PDF of an ingested book for frequent re-checking — one-paragraph thesis, expanded key ideas, one page per chapter, extended evidence, extended library connections
---

# Skill: deep-summary

Deep-dive summaries for books that Rafael checks frequently: a print-quality
PDF study companion, not a chat reply.

## When to trigger

- "Deep summary of \<book\>" / "make an in-depth summary PDF of \<book\>"
- "I need the big \<book\> study doc"

Escalation rule: use this instead of `summarize` when the user wants depth.
Approximate the upgrade path: one-line thesis → one-paragraph thesis; chapter
map → one page per chapter; brief evidence/connections → full sections.

## Pipeline (strict order)

1. **Locate sources**. Book page `library/books/<author-slug>/<book-slug>.md`
   and the raw fulltext `fulltext/<book-slug>.md`. Never write a deep summary
   from the wiki page alone — the fulltext is mandatory here.
2. **Deep-read the fulltext, chapter by chapter.** For EVERY chapter, read the
   chapter opening (thesis, definitions), the section headings, thematic
   worked examples, and the chapter conclusion. Case studies carry content —
   skim those too. A chapter summary written without reading that chapter's
   fulltext is a fabrication.
3. **Draft** `exports/<book-slug>-deep-summary.md` with a YAML title block
   (title, author, year, generated date). Five sections, all expanded:
   - **Thesis** — one full paragraph (5–10 sentences): the core argument, why
     it matters, for whom, and the payoff. Not a single line.
   - **Key Ideas** — one solid paragraph per idea (not 1–2-sentence bullets),
     6–12 ideas, each grounded in chapters and the fulltext.
   - **Chapter by Chapter** — exactly one page per chapter/parts: what the
     chapter argues, the concepts it defines, its examples/case studies, and
     how it sets up the next chapter. Start every chapter block with a raw
     `#pagebreak()` (typst level-3 heading per chapter).
   - **Evidence** — extended: 8–12 verbatim quotes with speaker and chapter
     reference, plus a sub-list of "Ideas borrowed from": external sources the
     book leans on (e.g. Sweller's cognitive load, Dunbar's numbers, Wardley
     mapping).
   - **Connections** — extended: one paragraph per related library book/page
     describing agreements, tensions, what this book uniquely contributes, and
     where to read what; quote the wiki page's connection notes and extend
     them with fulltext passages.
   Length target: 10–20 pages for a ~300-page book.
4. **Style**: prepend the contents of `reference/preamble.typ` at the very top
   of the draft as a fenced raw block ```{=typst} … ```, and set its
   `deep-title` variable to "<Book Title> — Deep Summary".
5. **Compile**:
   `pandoc exports/<book-slug>-deep-summary.md --pdf-engine=typst -o exports/<book-slug>-deep-summary.pdf`
6. **Verify**: the PDF is non-trivial (page count in the double digits is
   expected; solo-chapter or one-page output means a step was skipped), the
   footer shows title + page numbers, and each chapter actually starts on a
   fresh page. Report output paths and page count.

## Slug conventions

Follow `ingest-book`: book output uses the same `<book-slug>` as
`fulltext/<slug>.md`; PDFs live in `exports/` (transient artifacts, safe to
regenerate — never delete the Markdown source that produced them).

## Rules

- Quote verbatim only from fulltext, never from memory.
- Cite the author inline on every claim (e.g. *(Skelton & Pais)*), with
  chapter references.
- Never invent content: if a chapter can't be read in the fulltext, summarize
  only from headings/wikimap and mark it "(condensed from headings)".
- The Markdown source is the artifact of record; after any edit, recompile —
  never hand-patch the PDF.
- One book per run. Cross-book topic synthesis remains `summarize`'s job.
