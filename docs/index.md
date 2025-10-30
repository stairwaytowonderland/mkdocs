---
title: Welcome
subtitle: Site Overview
icon: material/home
# hide:
#   - navigation
---

{%
    include-markdown "../README.md"
%}

---

#### Detailed Instructions

##### Prerequisites

- [x] bash 3.x
- [x] Python 3.x
- [x] pip3

##### Confirm your Versions

To **Confirm your versions**, run the following:

```
# For bash version
bash --version

# For Python 3.x version
python3 --version

# For pip3 version
pip3 --version
```

##### Install Dependencies

To **install `pip3`** (*if not already installed*), run the following:

```sh
python3 -m ensurepip --default-pip
```

##### Activating Live Preview

To **preview documentation** locally before pushing, follow the steps below.

1. Create and activate a **virtual environment** (*optional, but recommended*):

    > [!NOTE]
    > This is done so the dependencies ([**_step 2_**](#step2)) are not installed globally for your user.

    1. **Initialize**

        ```sh
        python3 -m venv .venv
        ```

    2. **Activate**

        ```sh
        . .venv/bin/activate
        ```

2. **Install mkdocs and dependencies** (*if not already installed*): <a name="step2"></a>

    > [!NOTE]
    > This only needs to be done one time per virtual environment.

    ```sh
    pip install -r mkdocs/requirements.txt
    ```

3. **Serve the documentation locally**:

    There are several techniques, 2 of which are described below.

    > [!NOTE]
    > Both options below will start a local web server (usually at [http://127.0.0.1:8000](http://127.0.0.1:8000)) where you can view and test your documentation.

    1. **_Using `mkdocs serve`_ (*Recommended*)** <a name="step3a"></a>

        Using `mkdocs serve` is the **standard way** of testing mkdocs locally.

        - This is the recommended way, so you can preview the updates live (`--livereload` option)
        - Plugin options that are disabled on "*serve*" won't function in the same way as in GitHub Pages itself. For that, see *Option 2*.

        ```sh
        mkdocs serve -f mkdocs/mkdocs.yml --livereload
        ```
        _or simply just_:
        ```sh
        task serve
        ```

    1. **_Serving the static site directly using `python -m http.server`_**

        > [!INFO]
        > The static site must be built first ([**_step 4_**](#step4))

        GitHub pages serves the pre-built static site directly. To better emulate that, a more traditional http server should be used for testing. For those cases, the following option can be used.

        ```sh
        python -m http.server 8000 --directory mkdocs/dist
        ```
        _or simply just_:
        ```sh
        task http
        ```

4. **Re-Build static site files (*Optional*)**: <a name="step4"></a>

    The `mkdocs build` will (re)generate the static site files in the `mkdocs/dist/` directory (*ignored from version control*).

    ```sh
    mkdocs build -f mkdocs/mkdocs.yml
    ```
    _or simply just_:
    ```sh
    task build
    ```

    > [!TIP]
    > In most cases, this step isn't necessary if `mkdocs serve` ([**_step 3a_**](#step3a)) is being used.

    > [!NOTE]
    > To fully clean and rebuild the site files, you can use `--clean` option:
        ```sh
        mkdocs build -f mkdocs/mkdocs.yml --clean
        ```

##### Cleanup

1. **Deactivate the virtual environment** (*optional, if virtual environment was used*)

    If a virtual environment was used, it can now be deactivated with the following command (*it can always be re-activated using the **`activate`** command in step 1*):

    ```sh
    deactivate
    ```

2. You can **_optionally_, delete the virtual environment folder** (`rm -rf .venv`).

    > [!NOTE]
    > Even though it's completely safe to do so, we don't recommend this, as you'll need to re-install dependencies the next time you run MKDocs locally.

For more details, see the official [**MKDocs**](https://www.mkdocs.org/user-guide/) and [**Material for MKDocs**](https://squidfunk.github.io/mkdocs-material/reference/) documentation.

---

### MKDocs Limitations :warning:{ title="MkDocs Limitations, Workarounds, and Solutions" }

- The [`awesome-nav`](https://github.com/lukasgeiter/mkdocs-awesome-nav) plugin supports certain dynamic navigation features that seem to not be fully compatible with the [`navigation.indexes`](https://squidfunk.github.io/mkdocs-material/setup/setting-up-navigation/#section-index-pages) theme feature (see mkdocs.yml). The incompatibility is made very apparent when using `python -m http.server` to run the site (locally). This limitation might result in the following unexpected behavior:

    - A standard directory listing for certain sections
    - The `title:` meta being ignored
    - Other unexpected behavior that is solved with `awesome-nav`

    **Solution** :white_check_mark:

    Set [`use_directory_urls: false`](https://www.mkdocs.org/user-guide/configuration/#use_directory_urls) in the `mkdocs/mkdocs.yml` file
