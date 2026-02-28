#!/usr/bin/env bash
# PostToolUse hook: run shellcheck after saving a .sh file.
# Exits 2 to surface issues to Claude when shellcheck reports any warnings or errors.
set -uo pipefail

input=$(cat)
file_path=$(jq -r '.tool_input.file_path // empty' <<< "$input")

# Only run for shell scripts
[[ "$file_path" == *.sh ]] || exit 0

if ! output=$(shellcheck "$file_path" 2>&1); then
    echo "$output" >&2
    exit 2
fi
