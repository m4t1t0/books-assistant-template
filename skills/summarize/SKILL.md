# Skill: summarize

Produce summaries from the library: a single book, or a synthesis of a topic
across multiple books.

## When to trigger

- "Summarize <book>" / "what does <book> say about X"
- "Summarize <topic>" / "what do my books say about <topic>"

## Book mode

1. Read the book page in `library/books/`.
2. If the question targets a specific theme, also grep the book's fulltext in
   `fulltext/` and read the matching sections.
3. Return a layered answer:
   - **One-line thesis**
   - **Key ideas** (from the wiki page)
   - **Evidence**: quotes or chapter references, from fulltext if needed
   - **Connections**: where this sits in the library

## Topic mode

1. Resolve the topic: match to a topic page in `library/topics/` (fuzzy match
   on the controlled vocabulary in `library/AGENTS.md`; if no topic matches,
   fall back to grepping all book pages for the term).
2. Collect every book page tagged with that topic (from the catalog).
3. Read the relevant book pages; for depth, grep fulltext of the top matches.
4. Return a **synthesis across sources**:
   - **The through-line**: what the books collectively say
   - **Agreements**: where they align, with each book cited inline
   - **Tensions**: where they disagree or make different tradeoffs
   - **Who to read**: ranked reading order for going deeper

## Rules

- Always cite which book each claim comes from (inline, like *(Newman)*).
- Quote verbatim only from fulltext, never from memory.
- If the library has only one book on the topic, say so plainly and give the
  single-book view rather than pretending to synthesize.
