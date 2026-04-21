return {
    -- render-markdown.nvim is managed by the LazyVim markdown extra.
    -- This override just adds blink.cmp completions support.
    {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
            completions = { blink = { enabled = true } },
        },
    },

    -- Drop prettier from the markdown formatter chain:
    --   - prettier is not installed
    --   - line-wrapping is handled by the BufWritePre gw autocmd (autocmds.lua)
    --   - markdownlint-cli2 auto-fixes lint issues on save
    --   - markdown-toc updates TOC markers when present
    -- markdown-preview.nvim is fully managed by the LazyVim markdown extra.
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                markdown = { "markdownlint-cli2", "markdown-toc" },
                ["markdown.mdx"] = { "markdownlint-cli2", "markdown-toc" },
            },
        },
    },
}
