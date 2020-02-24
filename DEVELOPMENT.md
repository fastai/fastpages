# Development Guide

  - [Basic usage: viewing your blog](#basic-usage-viewing-your-blog)
  - [Converting the pages locally](#converting-the-pages-locally)
  - [Visual Studio Code integration](#visual-studio-code-integration)
  - [Advanced usage](#advanced-usage)
    - [Rebuild all the containers](#rebuild-all-the-containers)
    - [Removing all the containers](#removing-all-the-containers)
    - [Attaching a shell in a services / container](#attaching-a-shell-in-a-services-container)

You can run your fastpages blog on your local machine, and view any changes you make to your posts, including Jupyter Notebooks and Word documents, live.
The live preview requires that you have Docker installed on your machine. [Follow the instructions on this page if you need to install Docker.](https://www.docker.com/products/docker-desktop)

## Basic usage: viewing your blog

All of the commands in this block assume that you're in your blog root directory.
To run the blog with live preview:

```bash
docker-compose up
```

When you run this command for the first time, it'll build the required Docker images, and the process might take a couple minutes.

This command will build all the necessary containers and run the following services:
1. A service that monitors any changes in `./_notebooks/*.ipynb/` and `./_word/*.docx;*.doc` and rebuild the blog on change.
2. A Jupyter Notebook that will run on https://127.0.0.1:8888 — use this to write and edit your posts.
3. A Jekyll server on `https://127.0.0.1:4000` — use this to preview your blog.

The services will output to your terminal. If you close the terminal or hit `Ctrl-C`, the services will stop.
If you want to run the services in the background:

```bash
# run all services in the background
docker-compose up -d

# stop the services
docker-compose down
```

If you need to restart just the Jekyll server, and it's running in the background — you can do `docker-compose restart jekyll`.

_Note that the blog won't autoreload on change, you'll have to refresh your browser manually._

## Converting the pages locally

If you just want to convert your notebooks and word documents to `.md` posts in `_posts`, this command will do it for you:

```bash
docker-compose up converter
```

You can launch just the jekyll server with `docker-compose up jekyll`.

## Visual Studio Code integration

If you're using VSCode with the Docker extension, you can run three containers from the sidebar: `fastpages_jupyter_1`,`fastpages_watcher_1`, and `fastpages_jekyll_1`.
The containers will only show up in the list after you run or build them for the first time. So if they're not in the list — try `docker-compose build` in the console.

## Advanced usage

### Rebuild all the containers
If you changed files in `_action_files` directory, you might need to rebuild the containers manually, without cache.

```bash
docker-compose build --force-rm --no-cache
```

### Removing all the containers
Want to start from scratch and remove all the containers?

```
# make sure the containers are stopped:
docker-compose stop

# remove stopped containers
docker-compose rm
```

### Attaching a shell in a services / container
You can attach a terminal to a running service:

```bash

# If the container is already running:

# attach to a bash shell in the jekyll service
docker-compose exec jekyll /bin/bash

# attach to a bash shell in the jupyter / watcher service.
# they're essentially running the same software inside.
docker-compose exec watcher /bin/bash
```

_Note: you can use `docker-compose run` instead of `docker-compose exec` to start a service and then attach to it.
Or you can run all your services in the background, `docker-compose up -d`, and then use `docker-compose exec` as in the example above._