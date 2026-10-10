#!/usr/bin/env bash
# WorktreeRemove hook: undo jj-worktree-create.sh. Forgets the jj workspace and
# deletes its directory; only deletes directories that are jj workspaces.
set -euo pipefail

input=$(cat)
cwd=$(jq -r '.cwd' <<< "$input")
path=$(jq -r '.worktree_path' <<< "$input")
cd "$cwd"

if [[ -d "$path/.jj" ]]; then
    jj workspace forget "$(basename "$path")" >&2 || true
    git worktree prune >&2 2>&1 || true
    rm -rf "$path"
elif [[ -e "$path/.git" ]]; then
    git worktree remove --force "$path" >&2
fi
