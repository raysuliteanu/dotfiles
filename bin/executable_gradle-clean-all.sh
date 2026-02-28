#!/usr/bin/env bash

set -euo pipefail

# Check if a directory is provided as an argument, if not, use the current directory
search_dir=${1:-$(pwd)}

# Find directories with a file named 'gradlew' and execute 'gradlew clean' in those directories
# $1 is intentionally unexpanded here; it expands inside the inner bash -c invocation
# shellcheck disable=SC2016
fd -t f "^gradlew$" "$search_dir" -x bash -c 'cd "$1" && gradle -q clean' -- '{//}'
