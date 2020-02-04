#!/bin/bash
set -e

# setup ssh: allow key to be used without a prompt and start ssh agent
export GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
eval "$(ssh-agent -s)"



# # Check for SSH Directory
# if [ ! -d ~/.ssh ]; then
#    mkdir -p ~/.ssh/
# fi

# # Create user's ssh config it doesn't exist
# if [ ! -f ~/.ssh/config ]; then
#         touch ~/.ssh/config
#         echo "StrictHostKeyChecking no" > ~/.ssh/config
#         echo "StrictHostKeyChecking no --[done]"
#         chmod 644 ~/.ssh/config
# fi

######## Validate Inputs ########
# BOOL_SAVE_MARKDOWN
if [ "$INPUT_BOOL_SAVE_MARKDOWN" == "true" ];then
    if [ -z "$INPUT_SSH_DEPLOY_KEY" ];then 
        echo "You must set the SSH_DEPLOY_KEY input if BOOL_SAVE_MARKDOWN is set to true."; 
        exit 1;
    fi
elif [[ "$INPUT_BOOL_SAVE_MARKDOWN" != "false" ]];then
    echo "input BOOL_SAVE_MARKDOWN must be either 'true' or 'false', but received value: $INPUT_BOOL_SAVE_MARKDOWN";
    exit 1;
fi

# FORMAT
if [[ -z "$INPUT_FORMAT" ]]; then
	echo "Set the FORMAT input."
	exit 1
fi

######## Run Converter ########
# Process either word or markdown inputs
if [[ "$INPUT_FORMAT" == "word" ]];then
    ./_action_files/word2post.sh
elif [[ "$INPUT_FORMAT" == "notebook" ]];then
    cp /fastpages/settings.ini .
    python _action_files/nb2post.py
else
    echo "input FORMAT must be either 'word' or 'notebook', but received value: $INPUT_FORMAT";
    exit 1;
fi

# Get user's email from commit history
if [[ "$GITHUB_EVENT_NAME" == "push" ]];then
    USER_EMAIL=`cat $GITHUB_EVENT_PATH | jq '.commits | .[0] | .author.email'`
else
    USER_EMAIL="actions@github.com"
fi

# Conditionally commit markdown files to repo
if [ "$INPUT_BOOL_SAVE_MARKDOWN" == "true" ]; then
    git config --global user.name "$GITHUB_ACTOR"
    git config --global user.email "$USER_EMAIL"
    echo $INPUT_SSH_DEPLOY_KEY | base64 -d > mykey
    chmod 400 mykey
    ssh-add mykey
    git pull --ff-only
    git add _posts
    git commit -m "Update $INPUT_FORMAT blog posts" --allow-empty
    git push
fi