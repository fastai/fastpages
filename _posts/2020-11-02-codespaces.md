---
title: "[DRAFT - DO NOT SHARE] nbdev + GitHub Codespaces: A New Literate Programming Environment"
description: How a new GitHub feature makes literate programming easier than ever before.
comments: true
hide: false
toc: false
layout: post
hide: true
categories: [codespaces, nbdev]
image: images/fastpages_posts/codespaces/codespaces.png
author: "<a href='https://twitter.com/HamelHusain'>Hamel Husain</a> & <a href='https://twitter.com/jeremyphoward'>Jeremy Howard</a>"
permalink: /codespaces
---

<video class="codespaces-hero-video d-block width-full bg-white" alt="Codespaces demo" playsinline="" muted="" loop="" autoplay="" poster="https://github.githubassets.com/images/modules/site/codespaces/hero.jpg">
          <source type="video/mp4; codecs=hevc,mp4a.40.2" src="https://github.githubassets.com/images/modules/site/codespaces/hero.hevc.mp4">
          <source type="video/mp4; codecs=av01.0.05M.08,opus" src="https://github.githubassets.com/images/modules/site/codespaces/hero.av1.mp4">
          <source type="video/mp4; codecs=avc1.4D401E,mp4a.40.2" src="https://github.githubassets.com/images/modules/site/codespaces/hero.h264.mp4">
</video>


## WARNING:  This Blog Post Is A Draft.  Please Do Not Publicize!

## Introduction

> Literate programming is a programming paradigm introduced by Donald Knuth in which a computer program is given an explanation of its logic in a natural language, such as English, interspersed with snippets of macros and traditional source code, from which compilable source code can be generated.  According to Knuth, literate programming provides higher-quality programs by forcing programmers to explicitly state the thoughts behind the program.  This process makes poorly thought-out design decisions more obvious. Knuth also claims that literate programming provides a first-rate documentation system, which is not an add-on, but is grown naturally in the process of exposition of one's thoughts during a program's creation. [^1]

When I first learned about literate programming, I was quite skeptical.  Software engineers seem to have a workflow that works well for them, so why should I believe there is anything else that works better?  However, I quickly realized that I have never had access to a literate programming system as a Python developer.  Furthermore, I wrongly assumed that [Jupyter notebooks](https://jupyter.org/) fully encapsulated literate programming.  While Jupyter is a brilliant interactive computing system, it falls short of the literate programming paradigm for the following reasons:[^2]

- It can be difficult to compile source code from notebooks.
- It can be difficult to diff and use version control with notebooks because they are not stored in plain text.
- It is not clear how to automatically generate documentation from notebooks.
- It is not clear how to properly run tests suites when writing code in notebooks.

That's when I discovered [nbdev](https://nbdev.fast.ai/), a project that extends notebooks to complete the literate programming ideal.  I spent a month, full time, using nbdev to overhaul the docs for the [python library fastcore](https://fastcore.fast.ai/).  I can report that Donald Knuth is definitely onto something.  Indeed, the process of writing prose and tests alongside code forced me to deeply understand why the code does what it does, and to think deeply about its design.  If something was impossible to explain, this was a sign that the code need to be refactored.  To my surprise, I have never enjoyed as much productivity (and fun) as a software developer prior to using the tools I describe in this blog post!

## nbdev: Literate Programming With Jupyter

**Today, we are going to show you how to set up a literate programming environment, allowing you to use an IDE (VS Code) and an interactive computing environment (Jupyter), without leaving your browser, for free, with under 5 mins of setup. You'll even see how VSCode and Jupyter work together automatically!**

To whet your appetite on how cool this is, below is a teaser of what is possible:

{% include video.html url="https://github.com/machine-learning-apps/demo-videos/raw/master/codespaces-nbdev/e2e.mp4" %}

<p><br></p>

### Features of nbdev

As listed in the [docs](https://nbdev.fast.ai/), nbdev provides the following features:

- Searchable, hyperlinked documentation, which can be automatically hosted on [GitHub Pages](https://docs.github.com/en/github/working-with-github-pages) for free.
- Python modules, following best practices such as [automatically defining `__all__`](http://xion.io/post/code/python-all-wild-imports.html) with your exported functions, classes, and variables.
- Pip and Conda installers.
- Tests defined directly in notebooks which run in parallel.  This testing system has been thoroughly tested with [GitHub Actions](https://github.com/features/actions).
- Navigate and edit your code in a standard text editor or IDE, and export any changes automatically back into your notebooks.

Since you are in a notebook, you can also add charts, text, links, images, videos, etc, that are included automatically in the documentation of your library, along with standardized documentation generated automatically from your code.  [This site](https://docs.fast.ai/) is an example of docs generated automatically by nbdev.

## GitHub Codespaces

Thanks to [Conda](https://docs.conda.io/en/latest/) and [nbdev_template](https://github.com/fastai/nbdev_template), setting up a development environment with nbdev is far easier than it used to be. However, we realized it could be even easier, thanks to a new GitHub product called [Codespaces](https://github.com/features/codespaces).  Codespaces is a fully functional development environment in your browser, accessible directly from GitHub, that provides the following features:

1. A full VS Code IDE.
2. An environment that has files from the repository mounted into the environment, along with your GitHub credentials.
3. A development environment with dependencies pre-installed, backed by [Docker](https://www.docker.com/).
4. The ability to serve additional applications on arbitrary ports.  For nbdev, we serve a Jupyter notebook server as well as a [Jekyll](https://jekyllrb.com/) based documentation site.
5. A shared file system, which facilitates editing code in one browser tab and rendering the results in another.
6. ... [and more](https://docs.github.com/en/github/developing-online-with-codespaces).

For [fastai](https://github.com/fastai), Codespaces enables developers to immediately participate without wasting time on DevOps or complicated setup steps.  Most importantly, CodeSpaces with nbdev allows developers to quickly get started with creating their own software with literate programming.

## A demo of nbdev + Codespaces

This demo uses the project [fastai/fastcore](https://github.com/fastai/fastcore), which was built with nbdev, as an example.   First, we can navigate to this repo and launch a Codespace:

{% include video.html url="https://github.com/machine-learning-apps/demo-videos/raw/master/codespaces-nbdev/1_open.mp4" %}

<p><br></p>

If you are launching a fresh Codespace, it may take several minutes to set up. Once the environment is ready, we can verify that all dependencies we want are installed (in this case `fastcore` and `nbdev`):

{% include video.html url="https://github.com/machine-learning-apps/demo-videos/raw/master/codespaces-nbdev/2_verify.mp4" %}

<p><br></p>

Additionally, we can serve an arbitrary number of applications on user-specified ports, which we can open through VSCode as shown below:

{% include video.html url="https://github.com/machine-learning-apps/demo-videos/raw/master/codespaces-nbdev/3_nb.mp4" %}

<p><br></p>

In this case, these applications are a notebook and docs site.  Changes to a notebook are reflected immediately in the data docs.  Furthermore, we can use the cli command `nbdev_build_lib` to sync our notebooks with python modules.  This functionality is shown below:

{% include video.html url="https://github.com/machine-learning-apps/demo-videos/raw/master/codespaces-nbdev/4_reload.mp4" %}

<p><br></p>

This is amazing!  With a click of a button, I was able to:

1. Launch an IDE with all dependencies pre-installed.
2. Launch two additional applications: a Jupyter Notebook server on port 8080 and a docs site on port 4000.
3. Automatically update the docs and modules every time I make a change to a Jupyter notebook.

This is just the tip of the iceberg.  There are additional utilities for [writing and executing tests](https://nbdev.fast.ai/test.html), [diffing notebooks](https://nbdev.fast.ai/sync.html#Diff-notebook---library), [special flags](https://nbdev.fast.ai/magic_flags.html#How-do-comment-flags-correspond-to-magic-flags?) for hiding, showing, and collapsing cells in the docs, as well as [git hooks](https://nbdev.fast.ai/cli.html#nbdev_install_git_hooks) for further automation.  This and more functionality is covered in [the nbdev docs](https://nbdev.fast.ai/).

## Give It A Try For Yourself

To try out nbdev yourself, start with familiarizing yourself with the [nbdev docs](https://nbdev.fast.ai/) as well as the [video tutorial](https://youtu.be/Hrs7iEYmRmg).  When you are ready to write your own software with nbdev, see the [section in the docs regarding repo setup](https://nbdev.fast.ai/tutorial.html#Set-up-Repo).

GitHub Codespaces can be configured with a [`.devcontainer.json`](https://code.visualstudio.com/docs/remote/devcontainerjson-reference) configuration file.  Details on how to configure Codespaces for your repos can be found in [the official Codespaces docs](https://docs.github.com/en/github/developing-online-with-codespaces). While [nbdev_template](https://github.com/fastai/nbdev_template) (referenced in the setup section of the docs) already contains what you need to get started with nbdev, you might find it useful to customize your environment even further.

## You Can Write Blogs With Notebooks, Too!

This blog post was written in [fastpages](https://github.com/fastai/fastpages) which is also built on nbdev!  We recommend [fastpages](https://github.com/fastai/fastpages) if you want an easy way to blog with Jupyter notebooks.

## Additional Resources

1. The [GitHub Codepaces site](https://github.com/features/codespaces).
1. The official [docs for Codespaces](https://docs.github.com/en/github/developing-online-with-codespaces).
1. The nbdev [docs](https://nbdev.fast.ai/).
2. The nbdev [GitHub repo](https://github.com/fastai/nbdev).
3. [fastpages](https://github.com/fastai/fastpages): The project used to write this blog.
4. The GitHub repo [fastai/fastcore](https://github.com/fastai/fastcore), which is what we used in this blog post as an example.

----
[^1]: Wikipedia article: [Literate Programming](https://en.wikipedia.org/wiki/Literate_programming)
[^2]: This is not a criticism of Jupyter.  Jupyter doesn't claim to be a full literate programming system.  However, people can sometimes (unfairly) judge Jupyter according to this criteria.
