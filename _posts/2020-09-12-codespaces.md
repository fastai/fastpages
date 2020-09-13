---
title: "Nbdev + GitHub Codespaces: A New Literate Programming Environment"
description: How a new GitHub feature makes literate programming easier than ever before.
comments: true
hide: false
layout: post
categories: [actions, markdown]
image: images/fastpages_posts/codespaces/codespaces.png
author: Hamel Husain & Jeremy Howard
permalink: /codespaces
---

<video class="codespaces-hero-video d-block width-full bg-white" alt="Codespaces demo" playsinline="" muted="" loop="" autoplay="" poster="https://github.githubassets.com/images/modules/site/codespaces/hero.jpg">
          <source type="video/mp4; codecs=hevc,mp4a.40.2" src="https://github.githubassets.com/images/modules/site/codespaces/hero.hevc.mp4">
          <source type="video/mp4; codecs=av01.0.05M.08,opus" src="https://github.githubassets.com/images/modules/site/codespaces/hero.av1.mp4">
          <source type="video/mp4; codecs=avc1.4D401E,mp4a.40.2" src="https://github.githubassets.com/images/modules/site/codespaces/hero.h264.mp4">
</video>

## Introduction

### What is Literate Programming?

[Wikipedia](https://en.wikipedia.org/wiki/Literate_programming):

> Literate programming is a programming paradigm introduced by Donald Knuth in which a computer program is given an explanation of its logic in a natural language, such as English, interspersed with snippets of macros and traditional source code, from which compilable source code can be generated.The approach is used in scientific computing and in data science routinely for reproducible research and open access purposes ... According to Knuth,literate programming provides higher-quality programs, since it forces programmers to explicitly state the thoughts behind the program, making poorly thought-out design decisions more obvious. Knuth also claims that literate programming provides a first-rate documentation system, which is not an add-on, but is grown naturally in the process of exposition of one's thoughts during a program's creation.

One of the most popular literate programming tools in use today are [Jupyter Notebooks](https://jupyter.org/).  However, notebooks on their own fall short of the literate programming ideal for the following reasons:

- It can be difficult to compile source code from notebooks.
- It can be difficult to diff and use version control with notebooks because they are not stored in plain text.
- It is not clear how to automatically generate a documentation site from notebooks.

### Literate Programming For Jupyter: nbdev

The python project [nbdev](https://nbdev.fast.ai/) builds on Jupyter Notebooks to provide the following features:

- Searchable, hyperlinked documentation; any word you surround in backticks will be automatically hyperlinked to the appropriate documentation.
- Python modules, following best practices such as [automatically defining `__all__`](http://xion.io/post/code/python-all-wild-imports.html) with your exported functions, classes, and variables.
- Pip and conda installers (uploaded to pypi and anaconda for you).
- Tests (defined directly in your notebooks, and run in parallel).
- Navigate and edit your code in a standard text editor or IDE, and export any changes automatically back into your notebooks.

Since you are in a notebook, you can also add charts, text, links, images, videos, etc, that will included automatically in the documentation of your library. The cells where your code is defined will be hidden and replaced by standardized documentation of your function, showing its name, arguments, docstring, and link to the source code on github.

Sounds amazing, right?  It is!  We share further references to nbdev at the end of this blog post.

## Why You Should Try Literate Programming

Literate programming is not for everyone.  Many people feel quite comfortable with their current development environment. However, I recommend trying it, at least once, to see what you think.  

It will expand your mind on alternate ways of software development and give you insight into opportunities for better developer tools.  You might even decide that you are more productive with literate programming and stick with it.  Either way, its a beneficial experience that doesn't require much effort, especially with what I'm showing you in this blog post!

## The Problem: Setting Up Your Dev Environment

At the time of this writing, managing and setting up any python programming environment [can still be very challenging](http://veekaybee.github.io/2018/03/12/installing-python-is-hard/)[^1].

To add insult to injury, the nbdev development environment requires additional setup, which can make the barrier of entry high.  nbdev has several components:

1. A running Jupyter Noetbook.
2. A suite of CLI tools, with [githooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks).  These automatically sync notebooks with plain text scripts, automatically clean and test notebooks and convert notebooks to docs.
3. A documentation site, based [on Jekyll](https://jekyllrb.com/).

For example, my screen usually looks like this when developing with nbdev:

![]({{ site.baseurl }}/images/fastpages_posts/codespaces/dev.png "A typical nbdev development environemnt.  A Jupyter Notebooks and docs site.")

Note how in the screenshot above, there is a 1:1 correspondence between code and documentation.  Additionally, the `source` links take you directly to the generated plain text python code on GitHub!.

In addition to what is shown here, I often like to also use VSCode with an embbeded terminal.  To many folks, this can seem like an overwhelming  task to setup this development environment correctly.  :sunglasses: :rocket: Not anymore, with GitHub Codespaces! :rocket: :sunglasses: 

## Enter GitHub CodeSpaces

[GitHub Codespaces](https://github.com/features/codespaces) is a fully functional development environment in your browser, that you can access without ever leaving GitHub. With Codespaces, you get the following in your browser:

- A full VSCode IDE.
- The ability to serve additional applications on arbitrary ports so you can preview websites, or in our case, serve a jupyter notebook server and a documentation site.

This is how you launch a Codespace:

{% include video.html url="https://github.com/machine-learning-apps/demo-videos/raw/master/codespaces-nbdev/1_open.mp4" %}

If you are launching a fresh Codespace, it may take several minutes to spinup. Once the environment is ready, we can verify that all dependencies we wanted are installed (in this case nbdev):

{% include video.html url="https://github.com/machine-learning-apps/demo-videos/raw/master/codespaces-nbdev/2_verify.mp4" %}

Additionally, we can serve an arbitary number of applications on user specified ports, which we can open as shown below:

{% include video.html url="https://github.com/machine-learning-apps/demo-videos/raw/master/codespaces-nbdev/3_nb.mp4" %}

In this case, these applications are a notebook and docs site.  We can see that making a change in the notebook is also chnages the corresponding docs:

{% include video.html url="https://github.com/machine-learning-apps/demo-videos/raw/master/codespaces-nbdev/4_reload.mp4" %}

This is amazing!  With a click of a button, I was able to:

1. Launch an IDE with all dependencies pre-installed.
2. Launch two additional applications: a Jupyter Notebook server on port 8080 and a docs site on port 4000.
3. Automatically update the docs every time I make a change to a Jupyter notebook.

## How Does this work?

This section uses the repo [fastai/fastcore](https://github.com/fastai/fastcore) as an example.

To customize a Codespaces environment for visitors to your repo, [you can specify a `.devcontainer.json`](https://code.visualstudio.com/docs/remote/devcontainerjson-reference) file.  In this example,  [`.devcontainer.json`](https://github.com/fastai/fastcore/blob/master/.devcontainer.json) looks like this:

```json
{
    "name": "fastcore-codespaces",
    "dockerComposeFile": "docker-compose.yml",
    "settings": {"terminal.integrated.shell.linux": "/bin/bash"},
    "service": "watcher",
    "mounts": [ "source=/var/run/docker.sock,target=/var/run/docker.sock,type=bind" ],
    "forwardPorts": [4000, 8080],
    "extensions": ["ms-python.python",
                   "ms-azuretools.vscode-docker"],
    "runServices": ["notebook", "jekyll", "watcher"],
    "postStartCommand": "pip install -e ."
}
```
A quick description of these keys:

- **name:** this can be any name you choose, which will show up on the Codespaces menu.
- **dockerComposeFile**: since we are starting many different applications (a notebook and a docs site), we are using [Docker Compose](https://docs.docker.com/compose/). `docker-compose.yml` is located at the root of [this repo](https://github.com/fastai/fastcore).
- **settings**: these are [VSCode settings](https://code.visualstudio.com/docs/getstarted/settings).  In this case, I'm making sure the shell is bash.
- **service**: when you use Docker Compose, VS Code must bind to one of the services in your compose file.  I choose the service that automatically refreshes the docs called `watcher`, which I discuss later.
- **mounts**: this is biolerplate that is needed such that Docker works properly in Codespaces.
- **forwardPorts**: These are the ports you want to open (I'm opening one for the Jekyll docs site and another for the notebook).
- **extensions**: A list of [VS Code extensions](https://code.visualstudio.com/docs/introvideos/extend) to be added to the environment.  In this casse the python extension is helpful if using python or notebooks.  The Docker extension is optional and not required in this case, but I often find it helpful for debugging.
- **runServices**: These are the services that you want to run from your Docker Compose configuration.
- **postStartCommand**: A command string or list of command arguments to run when the container starts.  In this case, I wanted to do an editable install of the python library in the repository.

For more options, as well as more documentation on this configuration file, see [these docs](https://code.visualstudio.com/docs/remote/devcontainerjson-reference).

For completeness, below is the associated [`docker-compose.yml` file](https://github.com/fastai/fastcore/blob/master/docker-compose.yml):  

```yaml
  
version: "3"
services:
  fastai: &fastai
    restart: unless-stopped
    working_dir: /data
    image: fastai/codespaces
    logging:
      driver: json-file
      options:
        max-size: 50m
    stdin_open: true
    tty: true
    volumes:
      - .:/data/

  notebook:
    <<: *fastai
    command: bash -c "pip install -e . && jupyter notebook --allow-root --no-browser --ip=0.0.0.0 --port=8080 --NotebookApp.token='' --NotebookApp.password=''"
    ports:
      - "8080:8080"

  watcher:
    <<: *fastai
    command: watchmedo shell-command --command nbdev_build_docs --pattern *.ipynb --recursive --drop
    network_mode: host # for GitHub Codespaces https://github.com/features/codespaces/

  jekyll:
    <<: *fastai
    ports:
     - "4000:4000"
    command: >
     bash -c "cp -r docs_src docs
     && pip install .
     && nbdev_build_docs && cd docs
     && bundle i
     && chmod -R u+rwx . && bundle exec jekyll serve --host 0.0.0.0"
```

Below is a summary of the services defined in the above [Docker Compose](https://docs.docker.com/compose/) configuration:

- **fastai:** this is the base definition that the three services (`notebook`, `watcher`, and `jekyll`) use, so we don't have to repeat YAML for common settings.
- **notebook:** After defensively doing an editable install of the library defined in the repository, this serves a Jupyter notebook on port 8080.  
- **watcher:** We use the tool [`watchmedo`](https://github.com/gorakhargosh/watchdog) to automatically re-generate the docs when any notebook file changes.
- **jekyll:** This service builds the docs with nbdev and runs a [Jekyll](https://jekyllrb.com/) server for the docs.

You do not have to use Docker Compose with Codespaces. We only used it here because we wanted to expose several services without having our visitors do any setup.  More information about customizing Codespaces can be found in [the official docs](https://docs.github.com/en/github/developing-online-with-codespaces).

## Blogging With fastpages

This blog post was written in [fastpages](https://github.com/fastai/fastpages) which is also built on nbdev!  I highly recommend fastpages if you want an easy way to blog with Jupyter notebooks.

## Additional Resources

1. The [GitHub Codepaces site](https://github.com/features/codespaces).
1. The official [docs for Codespaces](https://docs.github.com/en/github/developing-online-with-codespaces).
1. The nbdev [docs](https://nbdev.fast.ai/).
2. The nbdev [GitHub repo](https://github.com/fastai/nbdev).
3. [fastpages](https://github.com/fastai/fastpages): The project used to write this blog.
4. The GitHub repo [fastai/fastcore](https://github.com/fastai/fastcore), which is what we used in this blog post as an example.

## Footnotes

[^1]: Even though this post is over two years old, not much has changed.