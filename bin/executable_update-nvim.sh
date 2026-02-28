#!/usr/bin/env bash

set -euo pipefail

# simple script to update nvim to latest nightly build
# aliases already exist for v/vi/vim to this nightly nvim
# really just until v11 is released and available via brew

cd "$HOME/Downloads"
# download latest nightly nvim build; -s silent, -S show errors, -L follow redirects, -O save as
echo "curl -sSLO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz"
curl -sSLO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz

cd "$HOME"

echo "saving current version of nvim"
rm -rf nvim-linux-x86_64.prev
mv nvim-linux-x86_64 nvim-linux-x86_64.prev

# install new version
echo "tar zxf Downloads/nvim-linux-x86_64.tar.gz"
tar zxf Downloads/nvim-linux-x86_64.tar.gz

echo "installed nvim:"
# show version
nvim-linux-x86_64/bin/nvim -v
