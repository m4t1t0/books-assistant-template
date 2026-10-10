---
description: Summarize a book or synthesize a topic across the library
---

Use the `summarize` skill to answer: $ARGUMENTS

Decide the mode from the request:

- **Book mode** — a specific book: read its page in `library/books/`, grep its
  fulltext in `fulltext/` if the question targets a theme, and return thesis,
  key ideas, verbatim evidence, and connections.
- **Topic mode** — a theme across books: match the controlled vocabulary in
  `library/AGENTS.md`, collect every book tagged with it, and synthesize the
  through-line, agreements, tensions, and a ranked reading order.

Cite each claim inline (e.g. *(Newman)*). Quote verbatim only from fulltext,
never from memory. If the library has only one book on the topic, say so
plainly instead of pretending to synthesize.
