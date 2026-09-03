# nvim-rust

A small, focused Neovim configuration for Rust development, built on
[LazyVim](https://www.lazyvim.org/).

General-purpose Neovim configs tend to accumulate every language and tool you
have ever touched. This one carries only what Rust work actually needs:
rust-analyzer via rustaceanvim, `Cargo.toml` support, a debugger, and enough
Markdown, Git and Jujutsu support to live in a real repository. Around 40
plugins in total, most of them LazyVim's own defaults.

It is deliberately unopinionated about everything else. There is no AI tooling,
no note-taking, no second language server — if you want those, add them in
`lua/plugins/`.

## Requirements

- Neovim >= 0.11.2 (LazyVim's minimum)
- `rust-analyzer` on `PATH` — `rustup component add rust-analyzer`
- `git`, a C compiler and `curl` (for treesitter parsers and Mason downloads)
- A [Nerd Font](https://www.nerdfonts.com/) for the icons
- Optionally [`jj`](https://jj-vcs.github.io/jj/) for the Jujutsu integration

Everything else — taplo, marksman, codelldb, markdownlint-cli2, markdown-toc —
is installed by Mason on first launch.

## Installation

### As a separate config (recommended)

`NVIM_APPNAME` lets Neovim keep several configurations side by side. It isolates
the plugin, state and cache directories too, so this config shares nothing with
whatever you already run:

```sh
git clone https://github.com/raysuliteanu/nvim-rust ~/.config/nvim-rust
NVIM_APPNAME=nvim-rust nvim
```

That leaves `~/.config/nvim` untouched. An alias makes it convenient:

```sh
alias rv='NVIM_APPNAME=nvim-rust nvim'
```

Directories used: `~/.config/nvim-rust`, `~/.local/share/nvim-rust`,
`~/.local/state/nvim-rust`, `~/.cache/nvim-rust`.

### As your default config

If you want this to be what plain `nvim` starts, back up anything already there
first:

```sh
mv ~/.config/nvim{,.bak}
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

git clone https://github.com/raysuliteanu/nvim-rust ~/.config/nvim
nvim
```

Remove the `.git` directory afterwards if you would rather track it in your own
dotfiles repo than stay pinned to this one.

Either way, the first launch installs plugins and tools and takes a minute.
Run `:checkhealth` once it settles.

## What's included

LazyVim's base (picker, explorer, statusline, which-key, treesitter, gitsigns,
lazygit, trouble, ...) plus these extras, listed in `lazyvim.json`:

| Extra | Provides |
| --- | --- |
| `lang.rust` | rustaceanvim (rust-analyzer), crates.nvim, codelldb, `rust`/`ron` parsers |
| `lang.toml` | taplo LSP + TOML treesitter |
| `lang.markdown` | marksman LSP, render-markdown.nvim, markdown-preview, markdownlint-cli2 |
| `lang.git` | gitcommit/git treesitter parsers |
| `dap.core` | nvim-dap, dap-ui, virtual text, mason-nvim-dap |
| `editor.snacks_picker` | Snacks as the picker |
| `editor.snacks_explorer` | Snacks as the file explorer |

Local overrides in `lua/plugins/`:

- `rust.lua` — extra rustaceanvim/crates keymaps under `<leader>r`
- `jj.lua` — [jj.nvim](https://github.com/NicolasGB/jj.nvim) under `<leader>j`
- `markdown.lua` — blink.cmp completions, prettier dropped from the format chain
- `blink-cmp.lua` — completion sources and signature help

## Keymaps

Beyond LazyVim's defaults:

### Rust — `<leader>r` (in `.rs` buffers)

| Key | Action |
| --- | --- |
| `<leader>rr` | Runnables |
| `<leader>rt` | Testables |
| `<leader>rm` | Expand macro |
| `<leader>re` | Explain error |
| `<leader>rD` | Render diagnostic |
| `<leader>rp` | Parent module |
| `<leader>rc` | Open `Cargo.toml` |
| `K` | Hover with code actions |

### Cargo — `<leader>r` (in `Cargo.toml`)

| Key | Action |
| --- | --- |
| `<leader>ru` / `<leader>rU` | Upgrade crate / all crates |
| `<leader>rv` | Show versions |
| `<leader>rf` | Show features |
| `<leader>rd` | Open docs.rs |

### Debugging

From the LazyVim `lang.rust` extra and `dap.core`: `<leader>dr` picks a Rust
debuggable, `<leader>d` is the general DAP group. codelldb is installed by Mason
on first run.

### Jujutsu — `<leader>j`

| Key | Action |
| --- | --- |
| `<leader>jl` / `<leader>js` | Log / status |
| `<leader>jd` / `<leader>jD` | Diff / describe |
| `<leader>jn` / `<leader>jc` | New change / commit |
| `<leader>jS` / `<leader>jr` | Squash / resolve conflicts |
| `<leader>ju` | Undo |
| `<leader>jf` / `<leader>jp` | Fetch / push |
| `<leader>jb` | Blame (annotate) |

Git keeps LazyVim's `<leader>g` mappings, so both work in colocated repos.

## Customising

`lazyvim.json` lists the enabled LazyVim extras; add or remove entries there, or
use `:LazyExtras`. Anything beyond that goes in `lua/plugins/` as a normal
lazy.nvim spec — files are picked up automatically.
