# nvim-rust

A focused Neovim configuration for Rust development, separate from the general
config in `~/.config/nvim`. Built on LazyVim.

## Usage

Neovim picks this config up via `NVIM_APPNAME`, which also isolates its plugin,
state and cache directories (`~/.local/share/nvim-rust`, `~/.local/state/nvim-rust`,
`~/.cache/nvim-rust`). Nothing is shared with the default config.

```sh
NVIM_APPNAME=nvim-rust nvim
```

Suggested shell alias:

```sh
alias rv='NVIM_APPNAME=nvim-rust nvim'
```

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

## External dependencies

`rust-analyzer` must be on `PATH` (`rustup component add rust-analyzer`).
Everything else — taplo, marksman, codelldb, markdownlint-cli2, markdown-toc —
is installed by Mason on first launch.
