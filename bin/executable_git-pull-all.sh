#!/usr/bin/env bash

set -euo pipefail

# Get the directory to search in, or use the current directory if none is provided
search_dir=${1:-$(pwd)}

# Find repo roots (git or jj), without descending into them
# so nested repos inside a repo are left to their parent
while IFS= read -r repo; do

    # jj repos with a co-located git repo are managed by jj, not git
    if [ -d "$repo/.jj" ]; then
        echo "Skipping jj repository: $repo"
        continue
    fi

    if ! git -C "$repo" rev-parse --git-dir >/dev/null 2>&1; then
        echo "Skipping non-git directory: $repo"
        continue
    fi

    echo "Pulling updates in repository: $repo"
    git -C "$repo" pull || echo "git pull failed in $repo"
done < <(find "$search_dir" -type d -exec test -d '{}/.git' -o -d '{}/.jj' \; -print -prune)
