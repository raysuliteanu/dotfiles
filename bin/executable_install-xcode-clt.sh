#!/usr/bin/env bash
set -euo pipefail

if [[ "$(uname)" != "Darwin" ]]; then
    echo "Error: this script only runs on macOS" >&2
    exit 1
fi

TRIGGER=/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress

cleanup() {
    rm -f "$TRIGGER"
}
trap cleanup EXIT

if xcode-select -p &>/dev/null; then
    echo "Xcode Command Line Tools already installed at $(xcode-select -p)"
    exit 0
fi

touch "$TRIGGER"

LABEL=$(softwareupdate --list 2>&1 | awk -F'*' '/Command Line Tools/{print $2}' | sed 's/^ *//' | head -1)

if [[ -z "$LABEL" ]]; then
    echo "Error: could not find Command Line Tools in softwareupdate list" >&2
    exit 1
fi

echo "Installing: $LABEL"
softwareupdate --install "$LABEL" --agree-to-license

echo "Done. $(clang --version | head -1)"
