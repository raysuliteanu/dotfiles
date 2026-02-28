#!/usr/bin/env bash
# PostToolUse hook: run cargo clippy after saving a .rs file.
# Exits 2 to surface issues to Claude when clippy reports any warnings or errors.
set -uo pipefail

input=$(cat)
file_path=$(jq -r '.tool_input.file_path // empty' <<< "$input")

# Only run for Rust source files
[[ "$file_path" == *.rs ]] || exit 0

# Walk up from the file's directory to find the cargo workspace/project root
dir=$(dirname "$file_path")
cargo_root=""
while [[ "$dir" != "/" ]]; do
    if [[ -f "$dir/Cargo.toml" ]]; then
        cargo_root="$dir"
        break
    fi
    dir=$(dirname "$dir")
done

# No Cargo project found — nothing to do
[[ -n "$cargo_root" ]] || exit 0

# -D warnings makes clippy exit non-zero for warnings, not just hard errors
if ! output=$(cd "$cargo_root" && cargo clippy -- -D warnings 2>&1); then
    echo "$output" >&2
    exit 2
fi
