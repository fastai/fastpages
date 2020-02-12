

![](https://github.com/fastai/fastpages/workflows/CI/badge.svg) ![](https://github.com/fastai/fastpages/workflows/GH-Pages%20Status/badge.svg)  [![](https://img.shields.io/static/v1?label=&message=View%20Demo%20Site&color=inactive&style=plastic)](https://fastai.github.io/fastpages/)

# Welcome To `fastpages`

> An easy to use blogging platform, with support for Jupyter notebooks, Word docs, and Markdown.

![](_diagram.png)

`fastpages` uses [GitHub Actions](https://github.com/features/actions) to simplify the process of of creating [Jekyll blog posts](https://jekyllrb.com/) on [GitHub Pages](https://pages.github.com/) from a variety of input formats.

### `fastpages` contain **special features for Jupyter Notebooks**, such as:

- Interactive visualizations made with [Altair](https://altair-viz.github.io/) remain interactive.
- Ability to hide cells by placing the comment `#hide` at the top of any cell.  (To hide only the input to a cell use the `hide input` [Jupyter extension](https://github.com/ipython-contrib/jupyter_contrib_nbextensions)).
- Add jekyll warnings, important or note banners with appropriate block quotes by using special markdown syntax [defined here](https://nbdev.fast.ai/export2html/#add_jekyll_notes).

- Ability to embed twitter cards and youtube videos via the following markdown syntax:
    ```markdown
    > youtube: https://youtu.be/your-link
    > twitter: https://twitter.com/some-link
    ```
- Define the Title, Summary and other metadata for your blog post via a special markdown cell at the beginning of your notebook as follows:
    ```markdown
    # Title
    > Awesome summary
    - toc: False
    - metadata_key1: metadata_value1
    - metadata_key2: metadata_value2
    ```

- Notebooks are exported to HTML in a lightweight manner to allow you to customize CSS and styling.  CSS can optionally be modified in [/assets/main.scss](/assets/main.scss).
- The notebook to blog conversion is powered by `nbdev`, which is under active development.  Check the [nbdev docs](https://nbdev.fast.ai/), particularly the [export2html](https://nbdev.fast.ai/export2html/) section, for a complete list of features that may be useful for notebooks.

**[See the demo site](https://fastai.github.io/fastpages/)**

---

## Setup Instructions

1. Click the [![](https://img.shields.io/static/v1?label=&message=Use%20this%20template&color=brightgreen&style=plastic)](https://github.com/fastai/fastpages/generate) button to create a copy of this repo in your account. 

2. Change the badges on this README to point to your repository instead of this one.  For example, instead of 

    `![](https://github.com/fastai/fastpages/workflows/CI/badge.svg)`

    this would be

    `![](https://github.com/your-username/your-repo-name/workflows/CI/badge.svg)`

3. Change `baseurl:` in `_config.yaml` to the name of your repository. For example, instead of 

    `baseurl: "/fastpages"`

    this would be

    `baseurl: "/your-repo-name"`

4. [Follow these instructions to create an ssh-deploy key](https://developer.github.com/v3/guides/managing-deploy-keys/#deploy-keys).  Make sure you **select Allow write access** when adding this key to your GitHub account.

5. [Follow these instructions to upload your deploy key](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets#creating-encrypted-secrets) as an encrypted secret on GitHub.  Make sure you name your key `SSH_DEPLOY_KEY`.

6. Go to your [repository settings and enable GitHub Pages](https://help.github.com/en/enterprise/2.13/user/articles/configuring-a-publishing-source-for-github-pages) on your `gh-pages` branch.


## Usage

1. Create a Jupyter Notebook or Word Document with the content of your blog post.

2. For Jupyter notebooks, create a markdown cell at the beginning of the notebook with the following contents:

    ```markdown
    # Title
    > Awesome summary
    - toc: False
    - metadata_key1: metadata_value1
    - metadata_key2: metadata_value2
    ```

    - Replace `Title`, with your desired title, and `Awesome summary` with your desired summary. 
    - `fast_template` will automatically generate a table of contents for you based on [markdown headers](https://guides.github.com/features/mastering-markdown/)!  You can toggle this feature on or off by setting `toc:` to either `True` or `False`.
    - **Additional metadata is optional** and allows you to set custom [front matter](https://jekyllrb.com/docs/front-matter/).


3. Save your notebook or word document with the naming convention `YYYY-MM-DD-*.` into the `/_notebooks` or `/_word` folder of this repo, respectively.  For example `2020-01-28-My-First-Post.ipynb`.  This [naming convention is required by Jekyll](https://jekyllrb.com/docs/posts/) to render your blog post.
    - Be careful to name your file correctly!  It is easy to forget the last dash in `YYYY-MM-DD-`. Furthermore, the character immediately following the dash should only be an alphabetical letter.  Examples of valid filenames are:

        ```shell
        2020-01-28-My-First-Post.ipynb
        2012-09-12-how-to-write-a-blog.docx
        ```

     - If you fail to name your file correctly, `fastpages` will automatically attempt to fix the problem by prepending the last modified date of your file to your generated blog post, however, it is recommended that you name your files properly yourself for more transparency.

4. If you are writing your blog post in markdown, save your `.md` file into the `/_posts` folder with the same naming convention as mentioned above.

5. [Commit and push](https://help.github.com/en/github/managing-files-in-a-repository/adding-a-file-to-a-repository-using-the-command-line) your file(s) to GitHub in your repository's master branch.

6. GitHub will automatically convert your files to blog posts.  You can click on the Actions tab of your repo to view the logs of this process.

7. If you wish, you can preview how your blog will look locally before commiting to GitHub.  If you wish to do so, please see the [development guide](_dev_tools/README.md).

## Using The GitHub Action & Your Own Custom Blog

The `fastpages` action allows you to convert notebooks from `/_notebooks` and word documents from `/_word` directories in your repo into [Jekyll](https://jekyllrb.com/) compliant blog post markdown files located in `/_posts`.  **Note: This directory structure is currently inflexible** for this Action, as it is designed to be used with Jekyll.

If you already have sufficient familiarity with [Jekyll](https://jekyllrb.com/) and wish to use this automation in your own theme,  you can use this GitHub Action by referencing `fastai/fastpages@master` as follows:

```yaml
...

uses: fastai/fastpages@master

...
```
An illustrative example of what a complete workflow may look like:



```yaml
jobs:
  build-site:
    runs-on: ubuntu-latest
    ...

    - name: convert notebooks and word docs to posts
      uses: fastai/fastpages@master

    ...

    - name: Jekyll build
      uses: docker://jekyll/jekyll
      with:
        args: jekyll build

    - name: Deploy
      uses: peaceiris/actions-gh-pages@v2
      if: github.event_name == 'push'
      env:
        ACTIONS_DEPLOY_KEY: ${{ secrets.SSH_DEPLOY_KEY }}
        PUBLISH_BRANCH: gh-pages
        PUBLISH_DIR: ./_site
```

Note that this Action **does not have any required inputs, and has no output variables**.  

### Optional Inputs

  - `BOOL_SAVE_MARKDOWN`:  Either 'true' or 'false'.  Whether or not to commit converted markdown files from notebooks and word documents into the _posts directory in your repo.  This is useful for debugging. _default: false_
  - `SSH_DEPLOY_KEY`: a ssh deploy key is required if BOOL_SAVE_MARKDOWN = 'true'

See the API spec for this action in [action.yml](action.yml)

Detailed instructions on how to customize this blog are beyond the scope of this README.  ( We invite someone from the community to contribute a blog post on how to do this in this repo! )

# Contributing To Fastpages

Please see the [development guide](_dev_tools/README.md).


# FAQ

- **Q:** Where are the markdown files in `_posts/` that are generated from my Jupyter notebooks or word documents?  **A:** The GitHub Actions workflow in this repo converts your notebook and word documents to markdown on the fly before building your site, but never commits these intermediate markdown files to this repo.  This is in order to save you from the annoyance of your local environment being constantly out of sync with your repository.  You can optionally see these intermediate markdown files by setting the `BOOL_SAVE_MARKDOWN` and `SSH_DEPLOY_KEY` inputs to the fastpages action in your `.github/workflows/ci.yaml` file as follows:

```yaml
    ...

    - name: convert notebooks and word docs to posts
      uses: fastai/fastpages@master
      with:
        BOOL_SAVE_MARKDOWN: true
        SSH_DEPLOY_KEY: ${{ secrets.SSH_DEPLOY_KEY }}

    ...
```
