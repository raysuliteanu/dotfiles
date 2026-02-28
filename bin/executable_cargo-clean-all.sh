#!/usr/bin/env bash

set -euo pipefail

# Check if a directory is provided as an argument, if not, use the current directory
search_dir=${1:-$(pwd)}

# find -execdir won't run if PATH ends in a colon, for security; see man page
PATH=${PATH%:}
export PATH

fd -t f "^Cargo\.toml$" "$search_dir" -x cargo -q clean --manifest-path {}
