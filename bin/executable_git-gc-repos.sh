#!/usr/bin/env bash

set -euo pipefail

# Directory to search for git repositories
SEARCH_DIR=${1:-}

if [ -z "$SEARCH_DIR" ]; then
    echo "Please provide a directory to search for git repositories."
    exit 1
fi

# Find repo roots (git or jj), without descending into them
# so nested repos inside a repo are left to their parent
while IFS= read -r repo_dir; do

    # jj repos with a co-located git repo are managed by jj, not git
    if [ -d "$repo_dir/.jj" ]; then
        echo "Skipping jj repository: $repo_dir"
        continue
    fi

    if ! git -C "$repo_dir" rev-parse --git-dir >/dev/null 2>&1; then
        echo "Skipping non-git directory: $repo_dir"
        continue
    fi

    echo "Running 'git gc' in $repo_dir"
    git -C "$repo_dir" gc || echo "git gc failed in $repo_dir"
done < <(find "$SEARCH_DIR" -type d -exec test -d '{}/.git' -o -d '{}/.jj' \; -print -prune)
