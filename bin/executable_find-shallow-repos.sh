#!/usr/bin/env bash

# Parse arguments
print_non_shallow=false
search_dir="."

while [[ $# -gt 0 ]]; do
    case $1 in
        --print-non-shallow)
            print_non_shallow=true
            shift
            ;;
        *)
            search_dir="$1"
            shift
            ;;
    esac
done

# Find all .git directories and process their parent directories
find "$search_dir" -name .git -type d 2>/dev/null | while IFS= read -r git_dir; do
    repo_dir=$(dirname "$git_dir")

    # Check if the repo has a remote
    if git -C "$repo_dir" remote 2>/dev/null | grep -q .; then
        # Check if it's shallow
        if [ "$(git -C "$repo_dir" rev-parse --is-shallow-repository 2>/dev/null)" = "true" ]; then
            is_shallow=true
        else
            is_shallow=false
        fi

        # Output based on mode
        if [ "$print_non_shallow" = true ]; then
            if [ "$is_shallow" = false ]; then
                realpath "$repo_dir"
            fi
        else
            rel_path=$(realpath --relative-to="$search_dir" "$repo_dir")
            if [ "$is_shallow" = true ]; then
                echo "$rel_path: shallow"
            else
                echo "$rel_path: not shallow"
            fi
        fi
    fi
done
