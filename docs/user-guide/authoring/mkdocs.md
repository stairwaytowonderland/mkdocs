---
title: MkDocs Pages
icon: simple/materialformkdocs
tags:
  - MkDocs
---

# MkDocs Pages

## Overview

This site uses the [**Material theme for MkDocs**](https://squidfunk.github.io/mkdocs-material/) to generate documentation.

To accomplish different tasks (for example, like creating code blocks, panels (admonitions), or annotations), specific syntax should be used.

Please use this page as a rough starter guide.

> [!TIP]
> For a quick and more thorough reference, see the 3rd party maintained [**cheat sheet**](https://yakworks.github.io/docmark/cheat-sheet/).

## Page Construction

### Section Index Page

To have a page act as a section (directory) index page, simply create a file called `index.md` (add some content so it's not just a blank page) and place in the appropriate directory.

### Page Meta

Some yaml [meta data](https://squidfunk.github.io/mkdocs-material/reference/#setting-the-page-title) can be used at the top of your `md` file to help our documentation site with navigation.

!!! info

    *If* using yaml meta data, the `title` **_must_** be included.

    !!! example

        ```yaml title="YAML Meta Data"
        ---
        title: Page Tile
        tags:
          - SomeTag
          - AnotherTag
        ---

        # Page Tile

        ## Section Heading
        ```

        !!! note
            YAML meta-data isn't required for each page, but is recommended.

        !!! warning "Important"
            When using the `title` meta data property, the `title` value (*e.g. "Page Title"*) will also be used as the navigation title

## Markdown Syntax

Some common usage examples. The examples on this page are not exhaustive, and only provide a few examples, that are more commonly used.

Please see the [official documentation](https://squidfunk.github.io/mkdocs-material/reference) for a complete set of examples.

### Lists

Please see the [official documentation](https://squidfunk.github.io/mkdocs-material/reference/lists/#usage) for additional information and examples.

!!! tip
    Put a **new line before a list** to ensure proper rendering.

**Unordered lists**

Unordered lists can be written by prefixing a line with a -, * or + list marker, all of which can be used interchangeably.

**Ordered lists**

Ordered lists must start with a number immediately followed by a dot. The numbers do not need to be consecutive and can be all set to 1., as they will be re-numbered when rendered:

#### Basic Example

=== "Unordered Output"

    - Nulla et rhoncus turpis. Mauris ultricies elementum leo. Duis efficitur
      accumsan nibh eu mattis. Vivamus tempus velit eros, porttitor placerat nibh
      lacinia sed. Aenean in finibus diam.

        * Duis mollis est eget nibh volutpat, fermentum aliquet dui mollis.
        * Nam vulputate tincidunt fringilla.
        * Nullam dignissim ultrices urna non auctor.

=== "Unordered Markdown"

    ```markdown title="Unordered list"
    - Nulla et rhoncus turpis. Mauris ultricies elementum leo. Duis efficitur
      accumsan nibh eu mattis. Vivamus tempus velit eros, porttitor placerat nibh
      lacinia sed. Aenean in finibus diam.

        * Duis mollis est eget nibh volutpat, fermentum aliquet dui mollis.
        * Nam vulputate tincidunt fringilla.
        * Nullam dignissim ultrices urna non auctor.
    ```

=== "Ordered Output"

    - Nulla et rhoncus turpis. Mauris ultricies elementum leo. Duis efficitur
      accumsan nibh eu mattis. Vivamus tempus velit eros, porttitor placerat nibh
      lacinia sed. Aenean in finibus diam.

        * Duis mollis est eget nibh volutpat, fermentum aliquet dui mollis.
        * Nam vulputate tincidunt fringilla.
        * Nullam dignissim ultrices urna non auctor.

=== "Ordered Markdown"

    ```markdown title="Unordered list"
    1.  Vivamus id mi enim. Integer id turpis sapien. Ut condimentum lobortis
        sagittis. Aliquam purus tellus, faucibus eget urna at, iaculis venenatis
        nulla. Vivamus a pharetra leo.

        1.  Vivamus venenatis porttitor tortor sit amet rutrum. Pellentesque aliquet
            quam enim, eu volutpat urna rutrum a. Nam vehicula nunc mauris, a
            ultricies libero efficitur sed.

        2.  Morbi eget dapibus felis. Vivamus venenatis porttitor tortor sit amet
            rutrum. Pellentesque aliquet quam enim, eu volutpat urna rutrum a.

            1.  Mauris dictum mi lacus
            2.  Ut sit amet placerat ante
            3.  Suspendisse ac eros arcu
    ```

### Panels, Callouts, Admonitions

Please see the [official documentation](https://squidfunk.github.io/mkdocs-material/reference/admonitions/#usage) for additional information and examples.

#### GitHub Flavor Alert/Callout Example

=== "Basic Output"

    > [!NOTE]
    > Callout something here

=== "Basic Markdown"

    ```markdown title="Basic example"
    > [!NOTE]
    > Callout something here
    ```

=== "Alert Output"

    > [!NOTE] Custom Title
    > Callout something here

=== "Alert Markdown"

    ```markdown title="Example with custom title"
    > [!NOTE] Custom Title
    > Callout something here
    ```

#### Basic MkDocs Admonition Example

=== "Basic Output"

    !!! note
        Callout something here

=== "Basic Markdown"

    ```markdown title="Basic example"
    !!! note
        Callout something here
    ```

=== "Admonition Output"

    !!! note "Example title"
        Callout something here

=== "Admonition Markdown"

    ```markdown title="Basic example"
    !!! note "Example title"
        Callout something here
    ```

#### Collapsable MkDocs Admonition Examples

=== "Collapsed Output"

    ??? note
        Callout something here

=== "Collapsed Markdown"

    ```markdown title="Collapsed example"
    ??? note
        Callout something here
    ```

=== "Expanded Output"

    ???+ note
        Callout something here

=== "Expanded Markdown"

    ```markdown title="Collapsed example"
    ???+ note
        Callout something here
    ```

#### Advanced MkDocs Admonition Examples

=== "Annotations Output"

    ??? note annotate "Phasellus posuere in sem ut cursus (1)"

        Lorem ipsum dolor sit amet, (2) consectetur adipiscing elit. Nulla et
        euismod nulla. Curabitur feugiat, tortor non consequat finibus, justo
        purus auctor massa, nec semper lorem quam in massa.

    1.  :man_raising_hand: I'm an annotation!
    2.  :woman_raising_hand: I'm an annotation as well!

=== "Annotations Markdown"

    ```markdown title="Collapsed example"
    ???+ note annotate "Custom title (1)"
        Callout something here

    1.  Example annotation
    ```

=== "Nested Output"

    !!! note "Outer Note"

        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
        nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
        massa, nec semper lorem quam in massa.

        !!! note "Inner Note"

            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
            nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
            massa, nec semper lorem quam in massa.

=== "Nested Markdown"

    ```markdown title="Nested example"
    !!! note "Outer Note"

        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
        nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
        massa, nec semper lorem quam in massa.

        !!! note "Inner Note"

            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
            nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
            massa, nec semper lorem quam in massa.
    ```

### Code blocks

Please see the [official documentation](https://squidfunk.github.io/mkdocs-material/reference/code-blocks/#usage) for additional information and examples.

=== "Output"

    ```.hcl title="Example with <a target='_blank' href='https://squidfunk.github.io/mkdocs-material/reference/annotations/#usage'>annotation</a>"
    variable "example_variable" {
      type    = string
      default = "" # (1)!
    }

    variable "another_variable" {
      type    = bool
      default = false # (2)!
    }
    ```

    1.  :space_invader: Example annotation
    2.  Another annotation

=== "Markdown"

    ````mardown title="Example with <a target='_blank' href='https://squidfunk.github.io/mkdocs-material/reference/annotations/#usage'>annotation</a>"
    ```.hcl title="Example with <a href='https://squidfunk.github.io/mkdocs-material/reference/annotations/'>annotation</a>"
    variable "example_variable" {
      type    = string
      default = "" # (1)!
    }

    variable "another_variable" {
      type    = bool
      default = false # (2)!
    }
    ```

    1.  :space_invader: Example annotation
    2.  Another annotation
    ````

### Images

Please see the [official documentation](https://squidfunk.github.io/mkdocs-material/reference/images/#usage) for additional information and examples.

=== "Left Align Output"

    ![Image title](https://dummyimage.com/600x400/eee/aaa){ align=left }

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor massa, nec semper lorem quam in massa.

=== "Left Align Markdown"

    ```markdown title="Left aligned with caption"
    ![Image title](https://dummyimage.com/600x400/eee/aaa){ align=left }

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor massa, nec semper lorem quam in massa.
    ```

=== "Caption Output"

    ![Image title](https://dummyimage.com/600x400/eee/aaa){ width="300" }
    /// caption
    Image caption
    ///

=== "Caption Markdown"

    ```markdown title="Image with caption"
    ![Image title](https://dummyimage.com/600x400/eee/aaa){ width="300" }
    /// caption
    Image caption
    ///
    ```

=== "Caption Alt Output"

    <figure markdown="span">
      ![Image title](https://dummyimage.com/600x400/){ width="300" }
      <figcaption>Image caption</figcaption>
    </figure>

=== "Caption Alt Markdown"

    ```markdown title="Centered example"
    <figure markdown="span">
      ![Image title](https://dummyimage.com/600x400/){ width="300" }
      <figcaption>Image caption</figcaption>
    </figure>
    ```

### Diagrams

Please see the [official documentation](https://squidfunk.github.io/mkdocs-material/reference/diagrams/#usage) for additional information and examples.

!!! note "Mermaid Diagrams"
    For more information on Mermaid Diagrams, please see the [mermaid official documentation](https://mermaid.js.org/)

=== "Flow chart Output"

    ```mermaid
    graph LR
      A[Start] --> B{Error?};
      B -->|Yes| C[Hmm...];
      C --> D[Debug];
      D --> B;
      B ---->|No| E[Yay!];
    ```

=== "Flow chart Markdown"

    ```` markdown title="Mermaid flow chart"
    ```mermaid
    graph LR
      A[Start] --> B{Error?};
      B -->|Yes| C[Hmm...];
      C --> D[Debug];
      D --> B;
      B ---->|No| E[Yay!];
    ```
    ````

=== "Sequence diagram Output"

    ```mermaid
    sequenceDiagram
      autonumber
      Alice->>John: Hello John, how are you?
      loop Healthcheck
          John->>John: Fight against hypochondria
      end
      Note right of John: Rational thoughts!
      John-->>Alice: Great!
      John->>Bob: How about you?
      Bob-->>John: Jolly good!
    ```

=== "Sequence diagram Markdown"

    ````markdown title="Mermaid sequence diagram"
    ```mermaid
    sequenceDiagram
      autonumber
      Alice->>John: Hello John, how are you?
      loop Healthcheck
          John->>John: Fight against hypochondria
      end
      Note right of John: Rational thoughts!
      John-->>Alice: Great!
      John->>Bob: How about you?
      Bob-->>John: Jolly good!
    ```
    ````

---

# Related Pages

{pagelist 5 Authoring -Index}

