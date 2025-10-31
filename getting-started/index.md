---
title: Getting Started
icon: material/laptop
weight: 0
tags:
  - Index
hide:
  - tags
---

# Getting Started :material-laptop:{ title="Getting Started Writing MkDocs Documentation" }

## Overview :rocket:{ title="General Information" }

The MkDocs site getting started guide.

## Markdown Spec :dna:

This is a GitHub repo, so basic markdown rendered in the repo view adheres to the [GitHub-flavored markdown spec](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax).

The **GitHub Pages** site is built using **MkDocs**, which adheres to [Python Markdown](./docs/user-guide/authoring/markdown/index.md).


## **_VS Code_** as a Markdown Editor :keyboard:{ title="Visual Studio Code as Markdown Editor" }

We generally use VS Code for our edits done on the desktop. Here are some handy extensions for markdown:

- "Markdown Table Prettifier" by darkriszty -- a great way to make formatting markdown tables a breeze!
- "Code Spell Checker" by streetsidesoftware -- about as close as you can get to a proper spell checker when writing markdown.

- "GitHub Markdown Preview" by Matt Bierner -- changes VS Code's built-in markdown preview to match GitHub (install full extension pack)
- "Markdown Admonitions" by tomasdahlqvist -- enables [MkDocs-style admonitions](https://squidfunk.github.io/mkdocs-material/reference/admonitions/#usage) in the VS Code preview.
- "Markdown Preview for Github Alerts" by Yahya Batulu -- enables GitHub style [alerts](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#alerts)
- "Markdown Editor" by zaaack -- enables a full-featured WYSIWYG editor for markdown
- "Mermaid Markdown Syntax Highlighting" by Brian Pruitt-Goddard -- enables color coding for Mermaid charting language

## Writing Docs :pencil:{ title="Writing Documentation" }

This repository uses [GitHub Pages](https://pages.github.com/) and the [MkDocs](https://www.mkdocs.org/) static site generator to produce attractive, navigable documentation from the Markdown files in the `docs/` directory. The [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) theme is used for a modern look and enhanced navigation, in combination with various MkDocs plugins and extensions.

Documentation changes are automatically built and deployed to GitHub Pages via a **GitHub Actions workflow ([`.github/workflows/mkdocs.yaml`](https://github.com/stairwaytowonderland/mkdocs/blob/main/.github/workflows/mkdocs.yaml))**, so updates are published whenever you push changes to the appropriate branch.
