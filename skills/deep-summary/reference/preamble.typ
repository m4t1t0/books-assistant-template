// deep-summary print style (raw typst block prepended by pandoc)
// Usage: copy this block to the TOP of the summary markdown as ```{=typst} ... ```
// and set `deep-title` below.

#let deep-title = "SET ME: Book Title — Deep Summary"

#set page(
  paper: "a4",
  margin: (x: 19mm, top: 21mm, bottom: 24mm),
  footer: context [
    #set text(8pt, fill: rgb("#7a869a"))
    #grid(
      columns: (1fr, auto),
      align(left, deep-title),
      align(right, counter(page).display()),
    )
  ],
)

#set text(font: "Libertinus Serif", size: 10.5pt)
#set par(justify: true, leading: 0.62em)

#show heading.where(level: 1): set text(20pt, fill: rgb("#0f3460"), weight: "bold")
#show heading.where(level: 2): set text(13.5pt, fill: rgb("#0f3460"), weight: "bold")
#show heading.where(level: 3): set text(11.5pt, fill: rgb("#16213e"), weight: "medium")

// navy section headings with a thin rule underneath
#show heading.where(level: 2): set block(
  stroke: (bottom: 0.75pt + rgb("#c9d4e2")),
  inset: (top: 3mm, bottom: 2.5mm),
  width: 100%,
  above: 1.6em,
)

#show link: set text(fill: rgb("#0a5ca8"))

// quotes: small italics; block quotes get a light panel with a left rule
#show quote: set text(size: 9.5pt, style: "italic", fill: rgb("#333c4e"))
#show quote.where(block: true): it => block(
  fill: luma(246),
  width: 100%,
  inset: (x: 4mm, y: 2.5mm),
  radius: (top-right: 2pt, bottom-right: 2pt),
  stroke: (left: 2pt + rgb("#a9b6c9")),
  it,
)
