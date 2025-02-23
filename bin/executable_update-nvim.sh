#!/bin/sh
# simple script to update nvim to latest nightly build
# aliases already exist for v/vi/vim to this nightly nvim
# really just until v11 is released and available via brew

cd ~/Downloads || exit $?
# download latest nighly nvim build; -s silent, -S show errors, -L follow redirects, -O save as
echo "curl -sSLO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz"
curl -sSLO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz || exit $?

cd || exit $?

echo "saving current version of nvim"
rm -rf ~/nvim-linux-x86_64.prev || exit $?
mv ~/nvim-linux-x86_64 ~/nvim-linux-x86_64.prev || exit $?

# install new version
echo "tar zxf ~/Downloads/nvim-linux-x86_64.tar.gz "
tar zxf ~/Downloads/nvim-linux-x86_64.tar.gz || exit $?

echo "installed nvim:"
# show version
~/nvim-linux-x86_64/bin/nvim -v
