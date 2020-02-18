# Manual Setup Instructions

These are the setup steps that are automated by [setup.yaml](.github/workflows/setup.yaml)

1. Click the [![](https://img.shields.io/static/v1?label=&message=Use%20this%20template&color=brightgreen&style=flat)](https://github.com/fastai/fastpages/generate) button to create a copy of this repo in your account.

2. [Follow these instructions to create an ssh-deploy key](https://developer.github.com/v3/guides/managing-deploy-keys/#deploy-keys).  Make sure you **select Allow write access** when adding this key to your GitHub account.

3. [Follow these instructions to upload your deploy key](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets#creating-encrypted-secrets) as an encrypted secret on GitHub.  Make sure you name your key `SSH_DEPLOY_KEY`.  Note: The deploy key secret is your **private key** (NOT the public key).

4. [Create a branch](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-and-deleting-branches-within-your-repository#creating-a-branch) named `gh-pages`.

5. Change the badges on this README to point to **your** repository instead of `fastai/fastpages`.  Badges are organized in a section at the beginning of this README.  For example, you should replace `fastai` and `fastpages` in the below url:

    `![](https://github.com/fastai/fastpages/workflows/CI/badge.svg)`

      to

    `![](https://github.com/{your-username}/{your-repo-name}/workflows/CI/badge.svg)`

6. Change `baseurl:` in `_config.yaml` to the name of your repository. For example, instead of 

    `baseurl: "/fastpages"`

    this should be

    `baseurl: "/your-repo-name"`

7. Similarly, change the `url:` parameter in `_config.yaml` to the url your blog will be served on.  For example, instead of

    `url: "https://fastpages.fast.ai/"`

    this should be 

    `url: "https://<your-user-name>.github.io"`

8. Read through `_config.yaml` carefully as there may be other options that must be set.  The comments in this file will provide instructions. 

9. Delete the `CNAME` file from the root of your `master` branch (or change it if you are using a custom domain)

10. Go to your [repository settings and enable GitHub Pages](https://help.github.com/en/enterprise/2.13/user/articles/configuring-a-publishing-source-for-github-pages) with the `gh-pages` branch you created earlier.