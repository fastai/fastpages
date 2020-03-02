Hello :wave: @{_username_}!  Thank you for using fastpages!  

## Before you merge this PR

1. Create an ssh key-pair.  Open <a href="https://8gwifi.org/sshfunctions.jsp" target="_blank">this utility</a>. Select: `RSA` and `4096` and leave `Passphrase` blank.  Click the blue button `Generate-SSH-Keys`.

2. Navigate to <a href="https://github.com/{_username_}/{_repo_name_}/settings/secrets" target="_blank">this link</a> and click `Add a new secret`.  Copy and paste the **Private Key** into the `Value` field. In the `Name` field, name the secret `SSH_DEPLOY_KEY`.  

3. Navigate to <a href="https://github.com/{_username_}/{_repo_name_}/settings/keys" target="_blank">this link</a> and click the `Add deploy key` button.  Paste your **Public Key** from step 1 into the `Key` box.  In the `Title`, name the key anything you want, for example `fastpages-key`.  Finally, **make sure you click the checkbox next to `Allow write access`** (pictured below), and click `Add key` to save the key.

![](_fastpages_docs/_checkbox.png)


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
