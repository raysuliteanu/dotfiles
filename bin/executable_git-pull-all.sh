#!/usr/bin/env bash

set -euo pipefail

# Get the directory to search in, or use the current directory if none is provided
search_dir=${1:-$(pwd)}

# Find all directories containing a .git subdirectory
while IFS= read -r git_dir; do
    repo=$(dirname "$git_dir")
    echo "Pulling updates in repository: $repo"
    git -C "$repo" pull
done < <(fd -H -t d "^\.git$" "$search_dir")
