# Automatically Convert MS Word (*.docx) Documents To Blog Posts

_Note: You can convert Google Docs to Word Docs by navigating to the File menu, and selecting Download > Microsoft Word (.docx)_

[`fastpages`](https://github.com/fastai/fastpages) will automatically convert Word Documents (.docx) saved into this directory as blog posts!.  Furthermore, images in your document are saved and displayed as you would expect on your blog post automatically.

## Usage

1. Create a Word Document (must be .docx) with the contents of your blog post.

2. Save your file with the naming convention `YYYY-MM-DD-*.docx` into the `/_word` folder of this repo.  For example `2020-01-28-My-First-Post.docx`.  This [naming convention is required by Jekyll](https://jekyllrb.com/docs/posts/) to render your blog post.
    - Be careful to name your file correctly!  It is easy to forget the last dash in `YYYY-MM-DD-`. Furthermore, the character immediately following the dash should only be an alphabetical letter.  Examples of valid filenames are:

        ```shell
        2020-01-28-My-First-Post.docx
        2012-09-12-how-to-write-a-blog.docx
        ```

    - If you fail to name your file correctly, `fastpages` will automatically attempt to fix the problem by prepending the last modified date of your notebook to your generated blog post. However, it is recommended that you name your files properly yourself for more transparency.

3. Synchronize your files with GitHub by [following the instructions in this blog post](https://www.fast.ai/2020/01/18/gitblog/).
