#!/usr/bin/env bash
# WorktreeCreate hook: give isolated agents a jj workspace (colocated with a git
# worktree) instead of a plain git worktree. Outside jj repos, fall back to
# `git worktree add`. Prints only the created path on stdout.
set -euo pipefail

input=$(cat)
cwd=$(jq -r '.cwd' <<< "$input")
path=$(jq -r '.worktree_path' <<< "$input")
ref=$(jq -r '.ref // empty' <<< "$input")
cd "$cwd"
mkdir -p "$(dirname "$path")"

if jj root > /dev/null 2>&1; then
    # Parent revision: the requested ref if jj can resolve it, else the parent(s)
    # of the current workspace's working copy (jj's default).
    rev_args=()
    if [[ -n "$ref" && "$ref" != "HEAD" ]] && jj log --no-graph -r "$ref" -T '' > /dev/null 2>&1; then
        rev_args=(-r "$ref")
    fi
    jj workspace add --colocate --name "$(basename "$path")" "${rev_args[@]}" "$path" >&2
else
    git worktree add --detach "$path" "${ref:-HEAD}" >&2
fi
echo "$path"
