Hello :wave: {_username_}!  Thank you for using fastpages!  

## Before you merge this PR

Please complete the following steps:

1. [Follow these instructions to create an ssh-deploy key](https://developer.github.com/v3/guides/managing-deploy-keys/#deploy-keys).  Make sure you **select Allow write access** when adding this key to your GitHub account.

2. [Follow these instructions to upload your deploy key](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets#creating-encrypted-secrets) as an encrypted secret on GitHub.  Make sure you name your key `SSH_DEPLOY_KEY`.  Note: The deploy key secret is your **private key** (NOT the public key).

## What to Expect After Mering This PR

- GitHub Actions will build your blog, which will take 3-4 minutes to complete.  **This will happen anytime you push changes to the master branch of your repository.**  You can monitor the logs of this if you like on the [Actions tab of your repo](https://github.com/{_username_}/fastpages/{_repo_name_}).
- Your GH-Pages Status badge on your README will eventually turn green, indicating your first sucessfull build.
- You can monitor the status of your site in your [repository settings](https://github.com/{_username_}/{_repo_name_}/settings) in the GitHub Pages section.

If you are not using a custom domain, your website will appear at https://{_username_}.github.io/{_repo_name_}.


## Optional: Using a Custom Domain

1. After merging this PR, add a file named `CNAME` at the root of your repo.  For example, we are hosting `fastpages` at `https://fastpages.fast.ai`, and  [this is the contents of our `CNAME`](https://github.com/fastai/fastpages/blob/master/CNAME): 
        
    >`fastpages.fast.ai`


2. Change the `url` and `baseurl` parameters in your `/_config.yml` file to reflect your custom domain. 


    Wondering how to setup a custom domain?  See [this article](https://dev.to/trentyang/how-to-setup-google-domain-for-github-pages-1p58).  You must add a CNAME file to the root of your master branch for the intructions in the article to work correctly.
