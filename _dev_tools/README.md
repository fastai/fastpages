# Dev Tools For `fastpages`

## Background

This directory has various scripts that make it easier for your to contribute to `fastpages`, by enabling you to test and preview changes locally.  These dev tools heavily rely on Docker, since `fastpages` uses these dependencies:

- [fastai/nbdev](https://github.com/fastai/nbdev): used to convert notebooks to blog posts.  `nbdev` serves as a wrapper around [jupyter/nbconvert](https://github.com/jupyter/nbconvert) that provides additional features that are useful for blogging.
- [pandoc](https://pandoc.org/index.html): used to convert Microsoft Word documents (*.docx) into blog posts.
- [Jekyll](https://jekyllrb.com/): a static site generator that is popular for docs and blogs.

Additionally, when you develop locally **it is important to ensure these dependencies are exactly the same as those used in the [Actions Workflow](../.github/workflows/ci.yaml)** that is used to automate the conversion process of word docs & jupyter notebooks and build the blog site.  In order to accomplish this with minimal effort, we make use of [Docker](https://www.docker.com/).  For those that are unfamiliar with Docker, [here is a gentle tutorial](https://towardsdatascience.com/how-docker-can-help-you-become-a-more-effective-data-scientist-7fc048ef91d5).  However, **familiarity with Docker is not strictly required in order to use these dev tools**.


## Commands & Usage
---

For all of the following commands, you must switch to the `/_dev_tools` directory here.


### Prepare the image (once)

**`make build`**
-  Builds the environment that is responsible for converting notebooks and word docs to plot posts.

If you change something in the [Dockerfile](../_action_files/Dockerfile), you will want to rebuild this environment by running:

**`make rebuild`**


### Run The Webserver

**`make run-server`**
 - Starts the webserver that will serve your blog.  Will serve the blog on http://0.0.0.0:4000/fastpages/

 Note: you may want stop and restart this server if you make any changes to the Jekyll config or Liquid templates of `fastpages`.

### Convert Notebooks/Docs to Blog Posts

Save your notebooks or word docs to either the `/_notebooks` or `/_word` folder respectively. 

**`make convert`**
- converts files in `/_notebooks` or `/word` to markdown files in `/_posts` which will be used be automatically converted by the webserver for you to blog posts.

Note: you must re-run this command each time you want to update the conversion of Jupyter notebooks and Word docs.


###  Stop All Containers

**`make stop`**

- this stops both the webserver and any other interactive environments you may have up.


## Advanced Usage

Some additional commands that may be helpful.

**`make bash-fastpages`** opens a shell in the environment that executes `nbdev` and `pandoc`

**`make bash-jekyll`** opens a shell in the environment that runs the jekyll webserver.  Note: the webserver must already be running (via `make run-server`) for this to work!

## Using an IDE / Notebook

This repo's directory on your local filesystem is mounted into the Docker containers so any changes you make to files in this repo in your local environment will instantly be reflected there.  

This means **you can use your favorite IDE or Jupyter notebooks as you would normally would locally** even if you have these Docker containers running.

# Making a Pull Request

Some general rules of thumb that will make your life easier.

- Test the blog locally before opening a pull request. 
- Read the [contributing](../CONTRIBUTING.md) guide.
- When you do open a pull request, please request a draft build of your PR by making a **comment with the magic command `/preview` in the pull request.**  This will allow reviewers to see a live-preview of your changes without having to clone your branch.
    - You can do this multiple times, if necessary, to rebuild your preview due to changes.  But please do not abuse this and test locally before doing this.

# Acknowledgements

These devtools closely imitate [ageron/handson-ml2](https://github.com/ageron/handson-ml2/tree/master/docker).

