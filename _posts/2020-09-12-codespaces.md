---
title: "Nbdev + GitHub Codespaces: A New Literate Programming Environment"
description: How a new GitHub feature makes literate programming easier than ever before.
comments: true
hide: false
toc: false
layout: post
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

According to the [docs](https://nbdev.fast.ai/), nbdev provides the following features:

- Searchable, hyperlinked documentation.
- Python modules, following best practices such as [automatically defining `__all__`](http://xion.io/post/code/python-all-wild-imports.html) with your exported functions, classes, and variables.
- Pip and Conda installers.
- Tests (defined directly in your notebooks, and run in parallel).
- Navigate and edit your code in a standard text editor or IDE, and export any changes automatically back into your notebooks.

Since you are in a notebook, you can also add charts, text, links, images, videos, etc, that is included automatically in the documentation of your library, along with standardized documentation generated automatically from your code.

## GitHub Codespaces

Thanks to [Conda](https://docs.conda.io/en/latest/) and [nbdev_template](https://github.com/fastai/nbdev_template), getting set up to start using literate programming is far easier than it used to be. However, we realized it could be even easier, thanks to [GitHub Codespaces](https://github.com/features/codespaces).

Codespaces is a fully functional development environment in your browser, that you can access without ever leaving GitHub. With Codespaces, you get the following in your browser:

1. A full VS Code IDE.
2. An environment that has files from the repository mounted into the environment, along with your GitHub credentials.
3. A development environment with depdencies pre-installed, backed by [Docker](https://www.docker.com/).
4. The ability to serve additional applications on arbitrary ports.  For nbdev, we serve a Jupyter notebook server as well as a [Jekyll](https://jekyllrb.com/) based documentation site.
5. A shared file system, which facilitates editing code in one browser tab and rendering the results in another.

We found that GitHub Codespaces eliminates all of the complexity of instantiating a literate programming environment.  For [fastai](https://github.com/fastai), Codespaces enables developers to immediately participate (https://github.com/fastai) without wasting time on DevOps or complicated setup steps.  
Most importantly, CodeSpaces allows people to quickly get started with creating their own software with literate programming.

## Enter GitHub CodeSpaces

This is how you launch a Codespace:

{% include video.html url="https://github.com/machine-learning-apps/demo-videos/raw/master/codespaces-nbdev/1_open_zoom.mp4" %}

<p><br></p>

If you are launching a fresh Codespace, it may take several minutes to set up. Once the environment is ready, we can verify that all dependencies we wanted are installed (in this case nbdev):

{% include video.html url="https://github.com/machine-learning-apps/demo-videos/raw/master/codespaces-nbdev/2_verify_zoom.mp4" %}

<p><br></p>

Additionally, we can serve an arbitrary number of applications on user-specified ports, which we can open through VSCode as shown below:

{% include video.html url="https://github.com/machine-learning-apps/demo-videos/raw/master/codespaces-nbdev/3_nb_zoom.mp4" %}

<p><br></p>

In this case, these applications are a notebook and docs site.  We can see that making a change in the notebook also changes the corresponding docs:

{% include video.html url="https://github.com/machine-learning-apps/demo-videos/raw/master/codespaces-nbdev/4_reload_zoom.mp4" %}

<p><br></p>

This is amazing!  With a click of a button, I was able to:

1. Launch an IDE with all dependencies pre-installed.
2. Launch two additional applications: a Jupyter Notebook server on port 8080 and a docs site on port 4000.
3. Automatically update the docs every time I make a change to a Jupyter notebook.


## Something about docs

Note how in the screenshot above, there is a 1:1 correspondence between code and documentation.  Additionally, the `source` links take you directly to the generated plain text python code on GitHub!.

## How Does this work?

This section uses the configuration files in the GitHub repo [fastai/fastcore](https://github.com/fastai/fastcore) as an example.

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
- **mounts**: this is boilerplate that is needed such that Docker works properly in Codespaces.
- **forwardPorts**: These are the ports you want to open (I'm opening one for the Jekyll docs site and another for the notebook).
- **extensions**: A list of [VS Code extensions](https://code.visualstudio.com/docs/introvideos/extend) to be added to the environment.  The Docker extension is optional and not required in this case, but I often find it helpful for debugging.
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

## Conclusion

By setting up Codespaces appropriately on your repo, you can give contributors a head start by providing an easy to use development environment that has ultimate portability (all you need is a browser).  Furthermore, when you have a specialized development environment, Codespaces can do the heavy lifting of setting everything up for you!

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
[^3]: This blog post doesn't contain any code so its not the b[This blog post](https://fastpages.fast.ai/fastcore/) summarizes interesting parts of fastcore.
