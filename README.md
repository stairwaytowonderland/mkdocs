# Docs Site Template :book:

<div align="center">

[![Publish Docs](https://github.com/stairwaytowonderland/mkdocs/actions/workflows/mkdocs.yaml/badge.svg)](https://github.com/stairwaytowonderland/mkdocs/actions/workflows/mkdocs.yaml)
[![Release](https://github.com/stairwaytowonderland/mkdocs/actions/workflows/release.yaml/badge.svg)](https://github.com/stairwaytowonderland/mkdocs/actions/workflows/release.yaml)
[![GitHub Release](https://img.shields.io/github/v/release/stairwaytowonderland/mkdocs?include_prereleases&sort=semver&label=latest)](https://github.com/stairwaytowonderland/mkdocs/releases/latest)
[![semantic-release: angular](https://img.shields.io/badge/semantic--release-angular-e10079?logo=semantic-release)](https://github.com/semantic-release/semantic-release)

[![MkDocs](https://img.shields.io/badge/Docs-Built_with_MkDocs-2FA4E7?logo=Markdown&logoColor=black&labelColor=white)](https://www.mkdocs.org/user-guide/)
[![Material for MkDocs](https://img.shields.io/badge/Material_for_MkDocs-4051b5?logo=materialformkdocs&labelColor=white)](https://squidfunk.github.io/mkdocs-material/reference/)
[![Pages Documentation](https://img.shields.io/badge/Pages-stairwaytowonderland.github.io/mkdocs-254869?logo=GitHub&logoColor=white&labelColor=gray)](https://stairwaytowonderland.github.io/mkdocs/)

</div>

## Overview :rocket:

Welcome to the technical knowledgebase and documentation template site.

**Please try to adhere to a logical folder structure for easier finding of useful things.**

## Markdown Spec :dna:

This is a GitHub repo, so basic markdown rendered in the repo view adheres to the [GitHub-flavored markdown spec](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax).

The **GitHub Pages** site is built using **MkDocs**, which adheres to [Python Markdown](./docs/user-guide/authoring/markdown/index.md).


## **_VS Code_** as a Markdown Editor :keyboard:

We generally use VS Code for our edits done on the desktop. Here are some handy extensions for markdown:

- "Markdown Table Prettifier" by darkriszty -- a great way to make formatting markdown tables a breeze!
- "Code Spell Checker" by streetsidesoftware -- about as close as you can get to a proper spell checker when writing markdown.

- "GitHub Markdown Preview" by Matt Bierner -- changes VS Code's built-in markdown preview to match GitHub (install full extension pack)
- "Markdown Admonitions" by tomasdahlqvist -- enables [MkDocs-style admonitions](https://squidfunk.github.io/mkdocs-material/reference/admonitions/#usage) in the VS Code preview.
- "Markdown Preview for Github Alerts" by Yahya Batulu -- enables GitHub style [alerts](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#alerts)
- "Markdown Editor" by zaaack -- enables a full-featured WYSIWYG editor for markdown
- "Mermaid Markdown Syntax Highlighting" by Brian Pruitt-Goddard -- enables color coding for Mermaid charting language

## Writing Docs :pencil:

This repository uses [GitHub Pages](https://pages.github.com/) and the [MkDocs](https://www.mkdocs.org/) static site generator to produce attractive, navigable documentation from the Markdown files in the `docs/` directory. The [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) theme is used for a modern look and enhanced navigation, in combination with various MkDocs plugins and extensions.

Documentation changes are automatically built and deployed to GitHub Pages via a **GitHub Actions workflow ([`.github/workflows/mkdocs.yaml`](https://github.com/stairwaytowonderland/mkdocs/blob/main/.github/workflows/mkdocs.yaml))**, so updates are published whenever you push changes to the appropriate branch.

### Run MkDocs Locally :computer:

Running MkDocs locally while writing documentation is highly recommended, to provide a **live preview** in order to preview exactly how elements will be rendered.

For detailed instructions and pre-requisites, see the [Detailed Instructions](#detailed-instructions) section of this guide.

#### Quick Start -- 3 Basic Steps

##### Step 1 - Initialize Virtual Environment

Create/activate a virtual environment in your repo root.

> [!NOTE]
> Highlights information that users should take into account, even when skimming.

  1. Create (*if not already created*)
      ```sh
      python3 -m venv .venv
      ```

  2. Activate (*if not already activated*)
      ```sh
      . .venv/bin/activate
      ```

##### Step 2 - Install Dependencies

Run pip install to install MkDocs and dependencies (if not already installed).

> [!NOTE]
> This only has to be done once (*per virtual environment*).

```sh
pip3 install -r mkdocs/requirements.txt
```

##### Step 3 - Serve

```sh
mkdocs serve -f mkdocs/mkdocs.yml --livereload
```
_or simply just_:
```sh
task serve
```
