#!/bin/sh

# This sets the environment variable when testing locally and not in a GitHub Action
if [ -z "$GITHUB_ACTIONS" ]; then
    GITHUB_WORKSPACE='/data'
    echo "=== Running Locally: All assets expected to be in the directory /data ==="
fi

# Loops through directory of *.docx files and converts to markdown
# markdown files are saved in _posts, media assets are saved in assets/img/<filename>/media
for FILENAME in ${GITHUB_WORKSPACE}/_word/*.docx; do
    [ -e "$FILENAME" ] || continue # skip when glob doesn't match
    NAME=${FILENAME##*/} # Get filename without the directory
    NEW_NAME=`python3 "/fastpages/word2post.py" "${FILENAME}"` # clean filename to be Jekyll compliant for posts
    BASE_NEW_NAME=${NEW_NAME%.md}  # Strip the file extension

    if [ -z "$NEW_NAME" ]; then
        echo "Unable To Rename: ${FILENAME} to a Jekyll complaint filename for blog posts"
        exit 1
    fi
    
    echo "Converting: ${NAME}  ---to--- ${NEW_NAME}"
    cd ${GITHUB_WORKSPACE}
    pandoc --from docx --to gfm --output "${GITHUB_WORKSPACE}/_posts/${NEW_NAME}" --columns 9999 \
    --extract-media="assets/img/${BASE_NEW_NAME}" --standalone "${FILENAME}"

    # Inject correction to image links in markdown
    sed -i.bak 's/!\[\](assets/!\[\]({{ site.url }}{{ site.baseurl }}\/assets/g' "_posts/${NEW_NAME}"
    # Remove intermediate files
    rm _posts/*.bak

    cat "${GITHUB_WORKSPACE}/_action_files/word_front_matter.txt" "_posts/${NEW_NAME}" > temp && mv temp "_posts/${NEW_NAME}"
done
