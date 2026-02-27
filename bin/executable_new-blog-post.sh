#!/usr/bin/env bash
set -euo pipefail

# Create a new draft blog post from the template and open it in nvim.
# Usage: new-blog-post.sh <post name>
# Spaces in the post name are converted to dashes in the filename.

if [ $# -eq 0 ]; then
    echo "Usage: $(basename "$0") <post name>" >&2
    exit 1
fi

# Allow spaces in the argument, translating them to dashes
FILE_NAME=$(echo "$*" | tr ' ' '-').md

BLOG_DIR=$HOME/Documents/kidoni.dev
TEMPLATE=$BLOG_DIR/blog-template.md
BLOG_FILE=$BLOG_DIR/content/posts/$FILE_NAME

if [ ! -f "$TEMPLATE" ]; then
    echo "error: template not found: $TEMPLATE" >&2
    exit 1
fi

if [ -f "$BLOG_FILE" ]; then
    echo "error: file already exists: $BLOG_FILE" >&2
    exit 1
fi

# Copy template with today's date substituted into the frontmatter
sed "s/^date: .*/date: $(date +%Y-%m-%d)/" "$TEMPLATE" > "$BLOG_FILE"

nvim "$BLOG_FILE"
