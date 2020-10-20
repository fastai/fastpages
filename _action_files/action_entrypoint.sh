#!/bin/bash
set -e

# setup ssh: allow key to be used without a prompt and start ssh agent
export GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
eval "$(ssh-agent -s)"

######## Run notebook/word converter ########
# word converter using pandoc
/fastpages/word2post.sh
# notebook converter using nbdev
cp /fastpages/settings.ini .
python /fastpages/nb2post.py


######## Optionally save files and build GitHub Pages ########
if [[ "$INPUT_BOOL_SAVE_MARKDOWN" == "true" ]];then

    if [ -z "$INPUT_SSH_DEPLOY_KEY" ];then 
        echo "You must set the SSH_DEPLOY_KEY input if BOOL_SAVE_MARKDOWN is set to true."; 
        exit 1;
    fi

    # Get user's email from commit history
    if [[ "$GITHUB_EVENT_NAME" == "push" ]];then
        USER_EMAIL=$(jq '.commits | .[0] | .author.email' < "$GITHUB_EVENT_PATH")
    else
        USER_EMAIL="actions@github.com"
    fi

    # Setup Git credentials if we are planning to change the data in the repo
    git config --global user.name "$GITHUB_ACTOR"
    git config --global user.email "$USER_EMAIL"
    git remote add fastpages-origin "git@github.com:$GITHUB_REPOSITORY.git"
    echo "${INPUT_SSH_DEPLOY_KEY}" > _mykey
    chmod 400 _mykey
    ssh-add _mykey

    # Optionally save intermediate markdown
    if [[ "$INPUT_BOOL_SAVE_MARKDOWN" == "true" ]]; then
        git pull fastpages-origin "${GITHUB_REF}" --ff-only
        git add _posts
        git commit -m "[Bot] Update $INPUT_FORMAT blog posts" --allow-empty
        git push fastpages-origin HEAD:"$GITHUB_REF"
    fi
fi


