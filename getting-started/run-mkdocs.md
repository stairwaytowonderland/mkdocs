---
title: Running MkDocs Locally
weight: 0
tags:
  - MkDocs
hide:
  - tags
---

# Run MkDocs Locally :computer:{ title="Running MkDocs Locally" }

## Overview

Running mkdocs locally while writing documentation is highly recommended, to provide a **live preview** in order to preview exactly how elements will be rendered.

For detailed instructions and pre-requisites, see the [Detailed Instructions](#detailed-instructions) section of this guide.

### Quick Start -- 3 Basic Steps

#### Step 1 - Virtual Environment

Create/activate a virtual environment in your repo root.

<small>This is is optional, but highly recommended so the dependencies don't get installed globally.</small>

  1. Create (*if not already created*)
      ```sh
      python3 -m venv .venv
      ```

  2. Activate (*if not already activated*)
      ```sh
      . .venv/bin/activate
      ```

#### Step 2 - pip install

Run pip install.

<small>Install mkdocs and dependencies, if not already installed. This only has to be done once (*per virtual environment*).</small>

```sh
pip3 install -r mkdocs/requirements.txt
```

#### Step 3 - Build & Serve

And away we go ...

<small>In most cases the `mkdocs serve` command also rebuilds all the necessary site files.</small>

```sh
mkdocs serve -f mkdocs/mkdocs.yaml
```

### Detailed Instructions

#### Prerequisites

- [x] bash 3.x
- [x] Python 3.x
- [x] pip3

#### Confirm your Versions

To **Confirm your versions**, run the following:

```
# For bash version
bash --version

# For Python 3.x version
python3 --version

# For pip3 version
pip3 --version
```

#### Install Dependencies

To **install `pip3`** (*if not already installed*), run the following:

```sh
python3 -m ensurepip --default-pip
```

#### Activating Live Preview

To **preview documentation** locally before pushing, follow the steps below.

1. Create and activate a **virtual environment** (*optional, but recommended*):

    > [!NOTE]
    > This is done so the dependencies (**_step 2_**) are not installed globally for your user.

    1. **Initialize**

        ```sh
        python3 -m venv .venv
        ```

    2. **Activate**

        ```sh
        . .venv/bin/activate
        ```

2. **Install mkdocs and dependencies** (*if not already installed*):

    > [!NOTE]
    > This only needs to be done one time per virtual environment.

    ```sh
    pip install -r mkdocs/requirements.txt
    ```

3. **Build static site files**:

    The `mkdocs build` will (re)generate the static site files in the `mkdocs/dist/` directory (*ignored from version control*).

    ```sh
    mkdocs build -f mkdocs/mkdocs.yaml
    ```

    > [!TIP]
    > In most cases, this step isn't necessary if `mkdocs serve` (**_step 4a_**) is being used.

    > [!NOTE]
    > To fully clean and rebuild the site files, you can use `--clean` option:
        ```sh
        mkdocs build -f mkdocs/mkdocs.yaml --clean
        ```

4. **Serve the documentation locally**:

    There are several techniques, 2 of which are described below.

    > [!NOTE]
    > Both options below will start a local web server (usually at [http://127.0.0.1:8000](http://127.0.0.1:8000)) where you can view and test your documentation.

    1. **_Using `mkdocs serve`_ (*Recommended*)**

        Using `mkdocs serve` is the **standard way** of testing mkdocs locally.

        - Usually a bit slower, but good enough for most use cases.
        - The live-reload functionality can be disabled with a `--no-livereload` option
        - Plugin options that are disabled on "*serve*" won't function in the same way as in GitHub Pages itself. For that, see *Option 2*.

        ```sh
        mkdocs serve -f mkdocs/mkdocs.yaml
        ```

    1. **_Serving the static site directly using `python -m http.server`_**

        GitHub pages serves the pre-built static site directly. To better emulate that, a more traditional http server should be used for testing. For those cases, the following option can be used.

        ```sh
        python -m http.server 8000 --directory mkdocs/dist
        ```

#### Cleanup

1. **Deactivate the virtual environment** (*optional, if virtual environment was used*)

    If a virtual environment was used, it can now be deactivated with the following command (*it can always be re-activated using the **`activate`** command in step 1*):

    ```sh
    deactivate
    ```

2. You can **_optionally_, delete the virtual environment folder** (`rm -rf .venv`).

    > [!NOTE]
    > Even though it's completely safe to do so, we don't recommend this, as you'll need to re-install dependencies the next time you run MKDocs locally.

For more details, see the official [**MKDocs**](https://www.mkdocs.org/user-guide/) and [**Material for MKDocs**](https://squidfunk.github.io/mkdocs-material/reference/) documentation.

### MKDocs Limitations :warning:{ title="MkDocs Limitations, Workarounds, and Solutions" }

- The [`awesome-nav`](https://github.com/lukasgeiter/mkdocs-awesome-nav) plugin supports certain dynamic navigation features that seem to not be fully compatible with the [`navigation.indexes`](https://squidfunk.github.io/mkdocs-material/setup/setting-up-navigation/#section-index-pages) theme feature (see mkdocs.yaml). The incompatibility is made very apparent when using `python -m http.server` to run the site (locally). This limitation might result in the following unexpected behavior:

    - A standard directory listing for certain sections
    - The `title:` meta being ignored
    - Other unexpected behavior that is solved with `awesome-nav`

    **Solution** :white_check_mark:

    Set [`use_directory_urls: false`](https://www.mkdocs.org/user-guide/configuration/#use_directory_urls) in the `mkdocs/mkdocs.yaml` file
