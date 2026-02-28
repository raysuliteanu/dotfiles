#!/usr/bin/env bash

set -euo pipefail

if [ ! -v GITHUB_TOKEN ]; then
    GITHUB_TOKEN=$(gh auth token)
    export GITHUB_TOKEN
fi

