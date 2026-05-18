#!/usr/bin/env bash
# PreToolUse hook: run cargo fmt --check and cargo clippy before any commit or push.
# Exits 2 to block the operation and surface the failure to Claude.
set -uo pipefail

input=$(cat)
command=$(jq -r '.tool_input.command // empty' <<< "$input")
cwd=$(jq -r '.cwd // empty' <<< "$input")

# Intercept commits (jj commit, git commit) and pushes (jj git push, git push)
[[ "$command" == *"jj commit"* || "$command" == *"git commit"* || "$command" == *"git push"* ]] || exit 0

# Walk up from cwd to find the cargo workspace/project root
dir="${cwd:-$(pwd)}"
cargo_root=""
while [[ "$dir" != "/" ]]; do
    if [[ -f "$dir/Cargo.toml" ]]; then
        cargo_root="$dir"
        break
    fi
    dir=$(dirname "$dir")
done

# Not a Rust project — allow the operation
[[ -n "$cargo_root" ]] || exit 0

cd "$cargo_root" || exit 0

# Auto-format if needed, then verify it's clean.
if ! cargo fmt --check &>/dev/null; then
    echo "Auto-running cargo fmt..." >&2
    if ! cargo fmt 2>&1; then
        echo "cargo fmt failed — cannot proceed with commit." >&2
        exit 2
    fi
fi

if ! output=$(cargo clippy --all-targets -- -D warnings 2>&1); then
    echo "cargo clippy failed. Fix warnings before committing." >&2
    echo "$output" >&2
    exit 2
fi
