#!/usr/bin/env bash
# PreToolUse hook: run cargo fmt --check and cargo clippy before any commit or push.
# Exits 2 to block the operation and surface the failure to Claude.
set -uo pipefail

input=$(cat)
command=$(jq -r '.tool_input.command // empty' <<< "$input")
cwd=$(jq -r '.cwd // empty' <<< "$input")

# Intercept commits (jj commit, jj describe, git commit) and pushes (jj git push, git push)
# Note: `jj describe -m ... && jj new` is equivalent to `jj commit` — catch both.
# Global options may sit between the tool and the subcommand (`jj -R DIR commit`,
# `git -C DIR commit`), so match the subcommand anywhere in the same command.
[[ "$command" =~ (^|[^[:alnum:]_-])jj[[:space:]][^\;\&\|]*(commit|describe|git[[:space:]]+push) ||
   "$command" =~ (^|[^[:alnum:]_-])git[[:space:]][^\;\&\|]*(commit|push) ]] || exit 0

# The commit may target another directory than the session cwd (e.g. a jj
# workspace used by a parallel agent): honor `cd DIR && ...`, `jj -R DIR`,
# `jj --repository DIR` and `git -C DIR`, so each workspace is checked against
# its own tree.
dir="${cwd:-$(pwd)}"
target=""
if [[ "$command" =~ ^[[:space:]]*cd[[:space:]]+([^[:space:]\;\&]+) ]]; then
    target="${BASH_REMATCH[1]}"
fi
if [[ "$command" =~ (jj[[:space:]]+(-R|--repository)[[:space:]=]+|git[[:space:]]+-C[[:space:]]+)([^[:space:]\;\&]+) ]]; then
    target="${BASH_REMATCH[3]}"
fi
if [[ -n "$target" ]]; then
    target="${target%\"}"; target="${target#\"}"; target="${target%\'}"; target="${target#\'}"
    target="${target/#\~/$HOME}"
    [[ "$target" == /* ]] || target="$dir/$target"
    [[ -d "$target" ]] && dir="$target"
fi

# Walk up from the target dir to find the cargo workspace/project root
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
