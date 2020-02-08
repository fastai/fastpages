# Automatically Convert MS Word (*.docx) Documents To Blog Posts

_Note: You can convert Google Docs to Word Docs by navigating to the File menu, and selecting Download > Microsoft Word (.docx)_

[`fast_template`](https://www.fast.ai/2020/01/16/fast_template/) will **automatically convert Word Documents (.docx) saved into this directory as blog posts!**.  The following steps are automated:

- Conversion of `.docx` files to `markdown`
- Resolution of links to images (you do not have to rename links)

## Setup

1. Follow [these instructions](https://www.fast.ai/2020/01/16/fast_template/), which walks you through setting up [`fast_template`](https://github.com/fastai/fast_template) on GitHub.

2. If you are using [a custom domain](https://help.github.com/en/github/working-with-github-pages/configuring-a-custom-domain-for-your-github-pages-site), specify your site's `url` and `baseurl` in [_config.yml](/_config.yml) as follows:

    ```yaml
    url: http://example.com #the base hostname & protocol for your site, e.g. http://example.com
    baseurl: /blog # the subpath of your site, e.g. /blog
    ```

3. Create a personal access token by following [these instructions](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line).  You can **ignore the section "Using a token on the command line".**

4. Add your personal access token as an encrypted secret named `PERSONAL_ACCESS_TOKEN` to the repository you created with `fast_template`, by following the instructions in the section "Create encrypted secrets" of [this article](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/creating-and-using-encrypted-secrets#creating-encrypted-secrets).  **It is important that you name your secret exactly as stated above.** You only need to follow the _Create encyrpted secrets_ section of the article, and can safely ignore everything else.

## Usage

1. Create a Word Document (must be .docx) with the contents of your blog post.

3. Save your file with the naming convention `YYYY-MM-DD-*.docx` into the `/_word folder of this repo.  For example `2020-01-28-My-First-Post.docx`.  This [naming convention is required by Jekyll](https://jekyllrb.com/docs/posts/) to render your blog post.
    - Be careful to name your file correctly!  It is easy to forget the last dash in `YYYY-MM-DD-`. Furthermore, the character immediately following the dash should only be an alphabetical letter.  Examples of valid filenames are:

        ```shell
        2020-01-28-My-First-Post.docx
        2012-09-12-how-to-write-a-blog.docx
        ```

    - If you fail to name your file correctly, `fast_template` will automatically attempt to fix the problem by prepending the last modified date of your notebook to your generated blog post in `/_posts`, however, it is recommended that you name your files properly yourself for more transparency.

4. Synchronize your files with GitHub by [following the instructions in this blog post](https://www.fast.ai/2020/01/18/gitblog/).

## Caveats

**You Should _NOT_ edit markdown files that are generated automatically via this mechanism**, as your file may get overwritten on subsequent conversions.  If you wish to switch to editing in markdown from a file that has been converted from MS Word, you should move the associated MS Word file out of the `_word/` directory of this repo.

## Additional Resources

- [Syncing your blog with your PC, and using your word processor](https://www.fast.ai/2020/01/20/nb2md/): This blog post describes how you can perform these steps manually without automation and is good background reading.
- [4 Part Series On Blogging With GitHub Pages](https://www.fast.ai/2020/01/20/blog_overview/): provides more context of the benefits and motivations behind `fast_template`, as well as different modalities for blogging: markdown, Jupyter Notebooks, Word docs, etc.
