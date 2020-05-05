# Filing Bugs & Troubleshooting

These are required prerequisites before filing an issue on GitHub or on the [fastai forums](https://forums.fast.ai/)

## Step 1: Attempt To Upgrade fastpages

See the [Upgrading guide](https://github.com/fastai/fastpages/blob/master/_fastpages_docs/UPGRADE.md).

**In addition to upgrading**, if developing locally, refresh your Docker containers with the following commands from the root of your repo:

`make remove` followed by `make build`

## Step 2: Search Relevant Places For Similar Issues

- [ ] Search the [fastai forums](https://forums.fast.ai/) for similar problems.
- [ ] Search issues on the [fastpages repo](https://github.com/fastai/fastpages/) for a similar problems?
- [ ] Read the [README of the repo](https://github.com/fastai/fastpages/blob/master/README.md) carefully


## Step 3: Observe Build Logs When Developing Locally
 
- [ ] Run the [fastpages blog server locally](DEVELOPMENT.md)
    - Pay attention to the emitted logs when you save your notebooks or files. Often, you will see errors here that will give you important clues.
- [ ] When developing locally, you will notice that Jupyter notebooks are converted to corresponding markdown files in the `_posts` folder.  Take a look at the problematic blog posts and see if you can spot the offending HTML or markdown in that code.
- Use your browser's developer tools to see if there are any errors.  Common errors are (1) not able to find images because they have not been saved into the right folder, (2) javascript or other errors.
- If you receive a Jekyll build error or a Liquid error, search for this error on Stack Overflow to provide more insight on the problem.

## Step 4: See if there are errors in the build process of GitHub Actions.

- [ ] In your GitHub repository, you will have a tab called **Actions**.  To find build errors, click on the `Event` dropdown list and select `push`.  Browse through tthe logs to see if you can find an error.


## Step 5: Once you have performed all the above steps, post your issue in the fastai formus or a GitHub Issue.

- [ ] Use the [nbdev & blogging category](https://forums.fast.ai/c/fastai-users/nbdev/48) to specify your problem if posting on the fastpages forums.
- [ ] If you cannot find a similar issue create a new thread instead of commenting on an unrelated one.
- When reporting a bug, provide this information:

    1. Steps to reproduce the problem
    2. **A link to the notebook or markdown file** where the error is occuring
    3. If the error is happening in GitHub Actions, a link to the specific error along with how you are able to reproduce this error.  You must provide this **in addition to the link to the notebook or markdown file**.
    4. A screenshot / dump of relevant logs or error messages you are receiving from your local development environment. the local development server as indicated in the [development guide](https://github.com/fastai/fastpages/blob/master/_fastpages_docs/DEVELOPMENT.md).


**You must provide ALL of the above information**.

# Frequent Errors

1. Malformed front matter.  Note that anything defined in front matter must be valid YAML.  **Failure to provide valid YAML could result in your page not rendering** in your blog.  For example, if you want a colon in your title you must escape it with double quotes like this:

    ` - title: "Deep learning: A tutorial"`
    
    or in a notebook

    `# "Deep learning: A tutorial"`

    See this [tutorial on YAML](https://rollout.io/blog/yaml-tutorial-everything-you-need-get-started/) for more information.

    **Colons, tilda, asteriks and other characters may cause your front matter to break and for your posts to not render.**  If you violoate these conventions you often get an error that looks something like this:

    ```bash
    Error: YAML Exception reading ... (<unknown>): mapping values are not allowed
    ```

2. Can you customize the styling or theme of fastpages?  **A**: See [Customizing Fastpages](https://github.com/fastai/fastpages#customizing-fastpages)

See the [FAQ](https://github.com/fastai/fastpages#faq) for frequently asked questions.
