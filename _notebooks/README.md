# Auto-convert Jupyter Notebooks To Posts

[`fast_template`](https://www.fast.ai/2020/01/16/fast_template/) will **automatically convert [Jupyter](https://jupyter.org/) Notebooks saved into this directory as blog posts!**.  In addition to automatic conversion, there are some additional benefits that `fast_template` provides:

- Preserves the interactivity of charts and graphs from visualization libraries like [Altair](https://altair-viz.github.io/).  
- Allows you to use features of [nbdev](https://nbdev.fast.ai/) to customize blog posts, such as:
    - Hiding cells by placing the comment `#hide` at the top of any cell.  (To hide only the input to a cell use the `hide input` [jupyter extension](https://github.com/ipython-contrib/jupyter_contrib_nbextensions)).
    - Add jekyll warnings, important or note banners with appropriate block quotes by using special markdown syntax [defined here](https://nbdev.fast.ai/export2html/#add_jekyll_notes).
    - Displaying formatted documentation for classes, functions, and enums by calling [show_doc](https://nbdev.fast.ai/showdoc/#show_doc).
    - Define the Title, Summary and other metadata for your blog post via a special markdown cell at the beginning of your notebook.  See the [Usage](#Usage) section below for more details.
    - There may be more applicable provided by `nbdev`, which is under active development.  Check the [nbdev docs](https://nbdev.fast.ai/), particularly the [export2html](https://nbdev.fast.ai/export2html/) section, for a complete list of features that may be useful.
- Notebooks are exported to HTML in a lightweight manner to allow you to customize CSS and styling.  CSS can optionally be modified in [/assets/main.scss](/assets/main.scss).

## Setup

1. Follow [these instructions](https://www.fast.ai/2020/01/16/fast_template/), which walks you through setting up [`fast_template`](https://github.com/fastai/fast_template) on GitHub.

2. Create a personal access token by following [these instructions](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line).  You can **ignore the section "Using a token on the command line".**  On the `Select Scopes` screen, **give your token `repo` scope**, which allows the automated system to make changes to your repository for you.  

3. Add your personal access token as an encrypted secret named `PERSONAL_ACCESS_TOKEN` to the repository you created with `fast_template`, by following the instructions in the section "Create encrypted secrets" of [this article](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/creating-and-using-encrypted-secrets#creating-encrypted-secrets).  **It is important that you name your secret exactly as stated above.** You only need to follow the _Create encyrpted secrets_ section of the article, and can safely ignore everything else.

## Usage

1. Create a Jupyter Notebook with the contents of your blog post.
2. Create a markdown cell at the beginning of your notebook with the following contents:

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

3. Save your notebook with the naming convention `YYYY-MM-DD-*.ipynb` into the `/_notebooks` folder of this repo.  For example `2020-01-28-My-First-Post.ipynb`.  This [naming convention is required by Jekyll](https://jekyllrb.com/docs/posts/) to render your blog post.
    - Be careful to name your file correctly!  It is easy to forget the last dash in `YYYY-MM-DD-`. Furthermore, the character immediately following the dash should only be an alphabetical letter.  Examples of valid filenames are:

        ```shell
        2020-01-28-My-First-Post.ipynb
        2012-09-12-how-to-write-a-blog.ipynb
        ```

    - If you fail to name your file correctly, `fast_template` will automatically attempt to fix the problem by prepending the last modified date of your notebook to your generated blog post in `/_posts`, however, it is recommended that you name your files properly yourself for more transparency.

4. [Commit and push](https://help.github.com/en/github/managing-files-in-a-repository/adding-a-file-to-a-repository-using-the-command-line) your notebook to GitHub.  **Important: At least one of your commit messages prior to pushing your notebook(s) must contain the word `/sync` in order to trigger automatic notebook conversion.**  Furthermore, the automatic conversion only occurs when a **push is made to the master branch**.  
    - The requirement of the `/sync` keyword is designed to alleviate instances of unwanted local conflicts that would otherwise require you to pull a fresh copy of your repo after each commit. When a notebook is converted to a blog post, a new file is committed to your repo automatically. See [How Does it Work?](#How-Does-it-Work) for more details and with instructions on customizing this behavior.

## How Does it Work?

The Jupyter to blog conversion process is powered by [nbdev](https://github.com/fastai/nbdev), which has [utilities to convert notebooks to webpages](https://nbdev.fast.ai/export2html/), including integrations with [GitHub Pages](https://pages.github.com/), such as [jekyll notes](https://nbdev.fast.ai/export2html/#add_jekyll_notes).  

A [GitHub Action](https://github.com/features/actions) calls `nbdev` when changes to files are detected in the `/_notebooks` directory of your repo and converts Jupyter notebook files into blog posts.  These blog posts are placed into the `/_posts` directory (via a commit and push) which is used by GitHub Pages to render your blog posts.  This GitHub Action an be customized by modifying the [/.github/workflows/nb2post.yaml](/.github/workflows/nb2post.yaml) in your repo.  

Some important notes about [nb2post.yaml](/.github/workflows/nb2post.yaml):

```yaml
...
  push:
    branches:
      - master 
    paths:
      - '_notebooks/*.ipynb'
```

This defines what will trigger the workflow, in this case, anytime files in the `/_notebooks` directory with a file name matching `*.ipynb` are pushed to the `master` branch.

``` yaml
...
    if: contains(join(github.event.commits.*.message), '/sync')
```

This is a conditional statement added to the workflow that checks for the keyword `/sync` in your commit messages.  You can remove or edit this statement to customize syncing behavior. You can read more about this syntax in [these help docs](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/contexts-and-expression-syntax-for-github-actions).

## Additional Resources

- [4 Part Series On Blogging With GitHub Pages](https://www.fast.ai/2020/01/20/blog_overview/): provides more context of the benefits and motivations behind `fast_template`, as well as different modalities for blogging: markdown, Jupyter Notebooks, Word docs, etc.
- [Blogging with Jupyter Notebooks](https://www.fast.ai/2020/01/20/nb2md/): part of the aforementioned 4-part series, which includes instructions on how to blog with Jupyter Notebooks without using automation or GitHub Actions.
- [Altair Tutorial](https://github.com/uwdata/visualization-curriculum): an excellent tutorial by [Jeffrey Heer](https://github.com/jheer) of the [Altair](https://altair-viz.github.io/) visualization library, which includes the ability to create interactive data visualizations in Jupyter.  **Interactive visualizations created with Altair will remain interactive when converted to a blog post via the mechanisms described in this README!**
- [The official Jekyll Tutorial](https://jekyllrb.com/docs/step-by-step/01-setup/): A gentle introduction to Jekyll, which will provide you with tools on how to customize your blog.
- [Repository of Useful Jekyll Snippets](https://github.com/mdo/jekyll-snippets), by [mdo](https://github.com/mdo): a useful cookbook for accomplishing common tasks when creating a blog with Jekyll.
- [Primer Components](https://primer.style/css/components): `fast_template` comes preloaded with this CSS library, which allows you to easily insert components such as [buttons](https://primer.style/css/components/buttons), [timelines](https://primer.style/css/components/timeline) and more with HTML into your blog posts.  This is optional and for advanced users who want to add custom elements to their site.  _Note: [alerts](https://primer.style/css/components/alerts) are are provided natively in `fast_template` through markdown shortcuts that are [documented here](https://nbdev.fast.ai/export2html/#add_jekyll_notes)_.

### Acknowledgements

Notebook conversion for `fast_template` was contributed by [@hamelsmu](https://github.com/hamelsmu) - thanks Hamel!
