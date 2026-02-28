#!/usr/bin/env bash
# PreToolUse hook: block git/jj push if cargo fmt --check fails.
# Exits 2 to block the push and surface the error to Claude.
set -uo pipefail

input=$(cat)
command=$(jq -r '.tool_input.command // empty' <<< "$input")
cwd=$(jq -r '.cwd // empty' <<< "$input")

# Only intercept push commands (covers `git push` and `jj git push`)
[[ "$command" == *"git push"* ]] || exit 0

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

# Not a Rust project — allow the push
[[ -n "$cargo_root" ]] || exit 0

if ! output=$(cd "$cargo_root" && cargo fmt --check 2>&1); then
    echo "cargo fmt --check failed in $cargo_root. Run 'cargo fmt' before pushing." >&2
    echo "$output" >&2
    exit 2
fi
