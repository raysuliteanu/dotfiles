#!/bin/bash
# a simple script to create a new markdown file with the
# frontmatter from the template file I created.

if [ $# -eq 0 ]; then
	echo "blog file name must be provided"
	exit 1
fi

# allow spaces in the script argument, but translate spaces to dashes
FILE_NAME=$(echo "$*" | tr ' ' '-').md

OBS_VAULT=$HOME/Documents/kidoni.dev
TEMPLATE=$OBS_VAULT/blog-template.md
BLOG_FILE=$OBS_VAULT/content/$FILE_NAME

nvim +":r $TEMPLATE" "$BLOG_FILE"
