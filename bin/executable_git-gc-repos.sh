#!/usr/bin/env bash

set -euo pipefail

# Directory to search for git repositories
SEARCH_DIR=${1:-}

if [ -z "$SEARCH_DIR" ]; then
    echo "Please provide a directory to search for git repositories."
    exit 1
fi

# Find all git repositories and run 'git gc'
while IFS= read -r git_dir; do
    repo_dir=$(dirname "$git_dir")
    echo "Running 'git gc' in $repo_dir"
    git -C "$repo_dir" gc
done < <(fd -H -t d "^\.git$" "$SEARCH_DIR")
