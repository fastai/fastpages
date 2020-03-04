# Development Guide
  - [Seeing All Options From the Terminal](#seeing-all-commands-in-the-terminal)
  - [Basic usage: viewing your blog](#basic-usage-viewing-your-blog)
  - [Converting the pages locally](#converting-the-pages-locally)
  - [Visual Studio Code integration](#visual-studio-code-integration)
  - [Advanced usage](#advanced-usage)
    - [Rebuild all the containers](#rebuild-all-the-containers)
    - [Removing all the containers](#removing-all-the-containers)
    - [Attaching a shell to a container](#attaching-a-shell-to-a-container)
  - [Running a Jupyter Server](#running-a-jupyter-server)

You can run your fastpages blog on your local machine, and view any changes you make to your posts, including Jupyter Notebooks and Word documents, live.
The live preview requires that you have Docker installed on your machine. [Follow the instructions on this page if you need to install Docker.](https://www.docker.com/products/docker-desktop)

## Seeing All Commands In The Terminal

There are many different `docker-compose` commands that are necessary to manage the lifecycle of the fastpages Docker containers.  To make this easier, we aliased common commands in a [Makefile](https://www.gnu.org/software/make/manual/html_node/Introduction.html).  

You can quickly see all available commands by running this command in the root of your repository:

`make`

## Basic usage: viewing your blog

All of the commands in this block assume that you're in your blog root directory.
To run the blog with live preview:

```bash
make server
```

When you run this command for the first time, it'll build the required Docker images, and the process might take a couple minutes.

This command will build all the necessary containers and run the following services:
1. A service that monitors any changes in `./_notebooks/*.ipynb/` and `./_word/*.docx;*.doc` and rebuild the blog on change.
2. A Jekyll server on https://127.0.0.1:4000 — use this to preview your blog.

The services will output to your terminal. If you close the terminal or hit `Ctrl-C`, the services will stop.
If you want to run the services in the background:

```bash
# run all services in the background
make server-detached

# stop the services
make stop
```

If you need to restart just the Jekyll server, and it's running in the background — you can do `make restart-jekyll`.

_Note that the blog won't autoreload on change, you'll have to refresh your browser manually._

**If containers won't start**: try `make build` first, this would rebuild all the containers from scratch, This might fix the majority of update problems.

## Converting the pages locally

If you just want to convert your notebooks and word documents to `.md` posts in `_posts`, this command will do it for you:

```bash
make convert
```

You can launch just the jekyll server with `make server`.

## Visual Studio Code integration

If you're using VSCode with the Docker extension, you can run these containers from the sidebar: `fastpages_watcher_1` and `fastpages_jekyll_1`.
The containers will only show up in the list after you run or build them for the first time. So if they're not in the list — try `make build` in the console.

## Advanced usage

### Rebuild all the containers
If you changed files in `_action_files` directory, you might need to rebuild the containers manually, without cache.

```bash
make build
```

### Removing all the containers
Want to start from scratch and remove all the containers?

```
make remove
```

### Attaching a shell to a container
You can attach a terminal to a running service:

```bash

# If the container is already running:

# attach to a bash shell in the jekyll service
make bash-jekyll

# attach to a bash shell in the watcher service.
make bash-nb
```

_Note: you can use `docker-compose run` instead of `make bash-nb` or `make bash-jekyll` to start a service and then attach to it.
Or you can run all your services in the background, `make server-detached`, and then use `make bash-nb` or `make bash-jekyll` as in the examples above._

## Running A Jupyter Server

The fastpages development enviornment does not provide a Jupyter server for you.  This is intentional so that you are free to run Jupyter Notebooks or Jupyter Lab in a manner that is familiar to you, and manage dependencies (requirements.txt, conda, etc) in the way you wish.  Some tips that may make your life easier:

- Provide instructions in your README and your blog posts on how to install the dependencies required to run your notebooks.  This will make it eaiser for your audience to reproduce your notebooks.
- Do not edit the Dockerfile in `/_action_files`, as that may interfere with the blogging environment.  Furthermore, any changes you make to these files may get lost in future upgrades, if [upgrading automatically](UGPRADE.md).  Instead, if you wish to manage your Jupyter server with Docker, we recommend that you maintain a seperate Dockerfile at the root of your repository.
