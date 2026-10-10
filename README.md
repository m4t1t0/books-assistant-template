# Books Assistant — a second brain for your library

A starter project for running a **book second brain** on top of agentic coding assistants ([OpenCode](https://opencode.ai), Claude Code, Cursor) — drop PDFs in, the agent converts them to Markdown, distills them into interlinked wiki pages, and answers questions with summaries synthesized across your whole library.

Heavily inspired by [Maikel's personal-assistant template](https://github.com/mgonzalezbaile/personal-assistant) — a sibling project worth checking out. Ships with:

- **Ingest pipeline** (`skills/ingest-book/`) — PDF → Markdown ([MarkItDown](https://github.com/microsoft/markitdown)) → distilled book page → cross-links → catalog
- **Summarize skill** (`skills/summarize/`) — layered summaries of a single book, or topic-mode synthesis across every book you've ingested
- **Deep-summary skill** (`skills/deep-summary/`) — in-depth study-summary PDFs for books you check frequently: one-paragraph thesis, expanded key ideas, one page per chapter, extended evidence and library connections — typeset with [Typst](https://typst.app) via [Pandoc](https://pandoc.org)
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

- [Pandoc](https://pandoc.org) + [Typst](https://typst.app) for the `deep-summary` PDF output (optional — only needed to typeset deep summaries):

```bash
brew install pandoc typst
```

- macOS or Linux. Tested on macOS.

## Quick start

### Option A — Use this template (recommended)

Click **Use this template** at the top of the GitHub page, or:

```bash
gh repo create <you>/books-assistant --template m4t1t0/books-assistant-template --private --clone ~/repos/books-assistant
cd ~/repos/books-assistant
```

GitHub template repos carry no shared history and no `origin` remote — your copy is fully yours from the first commit, and you can never accidentally push back to the template.

### Option B — Plain clone

```bash
git clone https://github.com/m4t1t0/books-assistant-template.git ~/repos/books-assistant
cd ~/repos/books-assistant
```

⚠️ A plain clone keeps the template as your `origin`. Cut the ties before committing anything:

```bash
chmod +x scripts/setup/fresh-git-init.sh && ./scripts/setup/fresh-git-init.sh
gh repo create <you>/books-assistant --private --source . --push   # optional, creates your own remote
```

The script wipes `.git` (and the link to the template repo with it), re-initializes a fresh history, and tells you how to add your own remote.

Open the folder with your agent of choice and start a session. Then:

1. **Personalize** — replace `{{NAME}}` / `{{EMAIL}}` placeholders in `AGENTS.md`.
2. **Ingest your first book** — drop a PDF into `sources/`, then tell your agent:
   > Ingest the book in sources/
   The agent converts it, writes `library/books/<author>/<title>.md`, wires cross-links and topic tags, updates the catalog, and deletes the PDF.
3. **Ask questions** — the three reading skills are also slash commands (`.opencode/commands/`):
   > /summarize Building Microservices
   > /summarize scaling
   > /deep-summary Team Topologies
   Plain-language prompts work identically:
   > Summarize Building Microservices
   > Deep summary of Team Topologies
   The deep-summary skill reads the full text chapter by chapter and writes `exports/<book>-deep-summary.pdf`: a one-paragraph thesis, expanded key ideas, one page per chapter, extended verbatim evidence, and extended library connections.
4. **Grow the web** — every new book links into existing topics and book pages. The more you ingest, the better topic-mode synthesis gets.

## What's in the box

```
.
├── AGENTS.md                 persistent assistant instructions (loaded every session)
├── .opencode/commands/       slash commands (thin wrappers into each skill's pipeline)
├── library/
│   ├── AGENTS.md             catalog hub: every book, topic, and author is registered here
│   ├── books/<author>/       one distilled page per ingested book
│   ├── topics/               thematic pages linking books together
│   └── people/               author pages
├── sources/                  drop raw PDFs here for ingestion (processed ones are deleted)
├── fulltext/                 converted Markdown of every book (kept forever, gitignore me if you prefer)
├── exports/                  generated artifacts: deep-summary Markdown + PDFs (transient, regenerate freely)
└── skills/
    ├── ingest-book/          PDF → md → wiki page → cross-links → catalog
    ├── summarize/            book summaries and cross-book topic syntheses
    └── deep-summary/         in-depth study summaries typeset to PDF (pandoc + typst)
```

### Skills

| Skill | Purpose | External deps | Slash command |
| --- | --- | --- | --- |
| `ingest-book` | Convert, distill, cross-link, catalog, cleanup | `markitdown` | `/ingest-book` |
| `summarize` | Single-book summaries + topic synthesis across books | none | `/summarize` |
| `deep-summary` | In-depth study-summary PDF: one-paragraph thesis, one page per chapter, extended evidence and connections | `pandoc` + `typst` | `/deep-summary` |

Slash commands are thin wrappers in `.opencode/commands/` that pass arguments into the skill's pipeline — the skills themselves are agent-auto-triggerable without them.

## Design principles

- **Distillation over dump.** Each book becomes a 1–3k-word wiki page that fits in context whole — the full text stays in `fulltext/` for targeted greps.
- **Controlled topic vocabulary.** Book pages may only tag topics registered in `library/AGENTS.md`; new topics are added deliberately.
- **Cross-links are mandatory.** Every book page connects to at least one topic, author, or other book.
- **Citations from fulltext.** Verbatim quotes always come from the converted Markdown, never from memory.

## A note on copyright

Converted full-texts of copyrighted books are for **personal use only**. Keep them out of public repos — if you push this workspace with `fulltext/` populated, make sure the repository is private.

## License

MIT — see [LICENSE](LICENSE).
