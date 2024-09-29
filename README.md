# Dotfiles

These are my configuration files. If you find something useful, feel free to copy
but of course I make no warranty about it working or not in your environment.

## Chezmoi

I use [Chezmoi](https://www.chezmoi.io/) to manage my configuration. It does take
a little getting used to. Here are some suggestions which I've done to make it easier
for me to use.

### Aliases

If you look at my aliases.zsh (dot_oh-my-zsh/custom/aliases.zsh)
file I created some aliases to open config files using `chezmoi edit` e.g.
`alias zalias='chezmoi edit ~/.oh-my-zsh/custom/aliases.zsh`

### Plugins

- I use ["xvzc/chezmoi.nvim"](https://github.com/xvzc/chezmoi.nvim)
Neovim plugin. See dot_config/nvim/lua/plugins/chezmoi.lua
- There's a plugin for oh-my-zsh for chezmoi. You can add it with
`omz plugins add chezmoi` or manually edit your .zshrc file to add it to the
`plugins=...`.

# TODOs

One thing chezmoi doesn't do is install software. It's just managing (and sync'ing
across devices) config. I need to have a solution to bootstrap a new environment
with minimal initial dependencies. For example, if all I needed to do was install
`brew` then run `brew` where I give it a file
(e.g. [here](https://github.com/raysuliteanu/configs/blob/trunk/Brewfile)) with
all the stuff to install, that would be fine. To install `brew` you just need `curl`
and `git` (as I recall).
