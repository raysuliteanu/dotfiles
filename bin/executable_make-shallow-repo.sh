#!/usr/bin/env bash

set -e

# Parse arguments
force=false
directories=()

while [[ $# -gt 0 ]]; do
    case $1 in
        --force)
            force=true
            shift
            ;;
        *)
            directories+=("$1")
            shift
            ;;
    esac
done

# Validate that we have directories
if [ ${#directories[@]} -eq 0 ]; then
    echo "Usage: $0 [--force] <directory> [<directory> ...]" >&2
    exit 1
fi

# Validate all directories and collect valid ones
valid_dirs=()
for dir in "${directories[@]}"; do
    # Check if directory exists
    if [ ! -d "$dir" ]; then
        echo "Warning: '$dir' is not a directory, skipping" >&2
        continue
    fi

    # Check if it's a git repo
    if [ ! -d "$dir/.git" ]; then
        echo "Warning: '$dir' is not a git repository, skipping" >&2
        continue
    fi

    # Check if it has a remote
    if ! git -C "$dir" remote 2>/dev/null | grep -q .; then
        echo "Warning: '$dir' has no remotes, skipping" >&2
        continue
    fi

    # Check if it's already shallow
    if [ "$(git -C "$dir" rev-parse --is-shallow-repository 2>/dev/null)" = "true" ]; then
        echo "Warning: '$dir' is already a shallow clone, skipping" >&2
        continue
    fi

    valid_dirs+=("$(realpath "$dir")")
done

# Exit if no valid directories
if [ ${#valid_dirs[@]} -eq 0 ]; then
    echo "No valid non-shallow repositories to convert" >&2
    exit 1
fi

# Function to convert a repo to shallow
convert_to_shallow() {
    local repo_dir="$1"
    echo "Converting '$repo_dir' to shallow clone..."

    # Get the default remote (usually origin)
    local remote
    remote=$(git -C "$repo_dir" remote | head -n 1)

    # Fetch with depth 1
    git -C "$repo_dir" fetch --depth 1 "$remote"

    # Clean up reflog and garbage collect
    git -C "$repo_dir" reflog expire --expire=all --all
    git -C "$repo_dir" gc --prune=all

    echo "Successfully converted '$repo_dir' to shallow clone"
}

# If force mode, confirm once for all directories
if [ "$force" = true ]; then
    echo "About to convert the following directories to shallow clones:"
    for dir in "${valid_dirs[@]}"; do
        echo "$dir"
    done
    read -r -p "Proceed? (y/n) " response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        echo "Aborted"
        exit 0
    fi

    # Convert all directories
    for dir in "${valid_dirs[@]}"; do
        convert_to_shallow "$dir"
    done
else
    # Confirm for each directory
    for dir in "${valid_dirs[@]}"; do
        read -r -p "Convert '$dir' to shallow clone? (y/n) " response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            convert_to_shallow "$dir"
        else
            echo "Skipped '$dir'"
        fi
    done
fi

echo "Done"
