#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 2 ]]; then
    echo "Usage: tmux-set-env.sh VAR VALUE" >&2
    exit 1
fi

tmux set-environment "$1" "$2"
export "$1"="$2"
