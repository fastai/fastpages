Hello :wave: @{_username_}!  Thank you for using fastpages!  

## Before you merge this PR

1. [Follow these instructions to create an ssh-deploy key](https://developer.github.com/v3/guides/managing-deploy-keys/#deploy-keys).  Make sure you **select Allow write access** when adding this key to your GitHub account.

2. [Follow these instructions to upload your deploy key](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets#creating-encrypted-secrets) as an encrypted secret on GitHub.  Make sure you name your key `SSH_DEPLOY_KEY`.  Note: The deploy key secret is your **private key** (NOT the public key).


### Summary of changes made in this PR

- `README.md`: changed badge URLs to reflect this repository & removed fastpages instructions.
- `_config.yml`: corrected the `github_username`, `baseurl`, `github_repo`, and `url` parameters to reflect this repository.
- Removed extreanous files that are used for the maintenance of fastpages and not useful for this repo.
- Saved the instructions in this PR to `_setup_pr_template.md` in the root of your repository for easy reference at a later time.

### What to Expect After Merging This PR

- GitHub Actions will build your site, which will take 3-4 minutes to complete.  **This will happen anytime you push changes to the master branch of your repository.**  You can monitor the logs of this if you like on the [Actions tab of your repo](https://github.com/{_username_}/{_repo_name_}/actions).
- Your GH-Pages Status badge on your README will eventually appear and be green, indicating your first sucessfull build.
- You can monitor the status of your site in the GitHub Pages section of your [repository settings](https://github.com/{_username_}/{_repo_name_}/settings).

If you are not using a custom domain, your website will appear at: 

#### https://{_username_}.github.io/{_repo_name_}


## Optional: Using a Custom Domain

1. After merging this PR, add a file named `CNAME` at the root of your repo.  For example, the `fastpages` blog is hosted at `https://fastpages.fast.ai`, which means [our CNAME](https://github.com/fastai/fastpages/blob/master/CNAME) contains the following contents: 

        
    >`fastpages.fast.ai`


2. Change the `url` and `baseurl` parameters in your `/_config.yml` file to reflect your custom domain.


    Wondering how to setup a custom domain?  See [this article](https://dev.to/trentyang/how-to-setup-google-domain-for-github-pages-1p58).  You must add a CNAME file to the root of your master branch for the intructions in the article to work correctly.


## Questions

Please use the [nbdev & blogging channel](https://forums.fast.ai/c/fastai-users/nbdev/48) in the fastai forums for any questions or feature requests.
