# Books Assistant — a second brain for your library

A starter project for running a **book second brain** on top of agentic coding assistants ([OpenCode](https://opencode.ai), Claude Code, Cursor) — drop PDFs in, the agent converts them to Markdown, distills them into interlinked wiki pages, and answers questions with summaries synthesized across your whole library.

Inspired by (and sibling to) the [personal-assistant template](https://github.com/mgonzalezbaile/personal-assistant). Ships with:

- **Ingest pipeline** (`skills/ingest-book/`) — PDF → Markdown ([MarkItDown](https://github.com/microsoft/markitdown)) → distilled book page → cross-links → catalog
- **Summarize skill** (`skills/summarize/`) — layered summaries of a single book, or topic-mode synthesis across every book you've ingested
- **Library wiki** (`library/`) — one page per book, topic pages built from a controlled vocabulary, author pages, and a catalog hub
- **Full-text archive** (`fulltext/`) — the complete converted Markdown of every book, kept forever for deep, chapter-level queries

Clone, drop in a PDF, ask your agent to ingest it — you're done.

---

## Prerequisites

- An agentic assistant that reads `AGENTS.md` (OpenCode, Claude Code, Cursor — the layout is agent-agnostic)
- Python 3 with [MarkItDown](https://github.com/microsoft/markitdown) for the PDF conversion step:

```bash
python3 -m venv ~/.venvs/markitdown
~/.venvs/markitdown/bin/pip install 'markitdown[pdf]'
```

- macOS or Linux. Tested on macOS.

## Quick start

```bash
git clone https://github.com/<you>/books-assistant.git ~/repos/books-assistant
cd ~/repos/books-assistant
```

Open the folder with your agent of choice and start a session. Then:

1. **Personalize** — replace `{{NAME}}` / `{{EMAIL}}` placeholders in `AGENTS.md`.
2. **Ingest your first book** — drop a PDF into `sources/`, then tell your agent:
   > Ingest the book in sources/
   The agent converts it, writes `library/books/<author>/<title>.md`, wires cross-links and topic tags, updates the catalog, and deletes the PDF.
3. **Ask questions** — the two reading skills:
   > Summarize Building Microservices
   > What do my books say about scaling?
4. **Grow the web** — every new book links into existing topics and book pages. The more you ingest, the better topic-mode synthesis gets.

## What's in the box

```
.
├── AGENTS.md                 persistent assistant instructions (loaded every session)
├── library/
│   ├── AGENTS.md             catalog hub: every book, topic, and author is registered here
│   ├── books/<author>/       one distilled page per ingested book
│   ├── topics/               thematic pages linking books together
│   └── people/               author pages
├── sources/                  drop raw PDFs here for ingestion (processed ones are deleted)
├── fulltext/                 converted Markdown of every book (kept forever, gitignore me if you prefer)
└── skills/
    ├── ingest-book/          PDF → md → wiki page → cross-links → catalog
    └── summarize/            book summaries and cross-book topic syntheses
```

### Skills

| Skill | Purpose | External deps |
| --- | --- | --- |
| `ingest-book` | Convert, distill, cross-link, catalog, cleanup | `markitdown` |
| `summarize` | Single-book summaries + topic synthesis across books | none |

## Design principles

- **Distillation over dump.** Each book becomes a 1–3k-word wiki page that fits in context whole — the full text stays in `fulltext/` for targeted greps.
- **Controlled topic vocabulary.** Book pages may only tag topics registered in `library/AGENTS.md`; new topics are added deliberately.
- **Cross-links are mandatory.** Every book page connects to at least one topic, author, or other book.
- **Citations from fulltext.** Verbatim quotes always come from the converted Markdown, never from memory.

## A note on copyright

Converted full-texts of copyrighted books are for **personal use only**. Keep them out of public repos — if you push this workspace with `fulltext/` populated, make sure the repository is private.

## License

MIT — see [LICENSE](LICENSE).
