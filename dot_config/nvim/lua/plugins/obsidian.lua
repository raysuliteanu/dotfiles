local vpath = vim.fn.expand("~") .. "/Documents/Obsidian/Ray"
return {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    event = {
        "BufReadPre " .. vpath .. "/**/*.md",
        "BufNewFile " .. vpath .. "/**/*.md",
    },
    dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "Ray",
                path = vpath,
            },
        },
        daily_notes = {
            folder = "Resources/Notes", -- Where daily notes are stored
            date_format = "%Y-%m-%d", -- Format for daily note filenames
            template = "note.md", -- The template file in your Templates folder
        },
        notes_subdir = "Resources/Notes",
        new_notes_location = "notes_subdir",
        open_notes_in = "vsplit",
        preferred_link_style = "markdown",
        templates = {
            folder = "Templates",
            date_format = "%Y-%m-%d",
            time_format = "%H:%M",
            substitutions = {},
        },
        frontmatter = {
            enabled = true,
        },
        ui = {
            -- using MeanderingProgrammer/render-markdown.nvim
            -- see plugins/markdown.lua
            enable = false,
        },
        picker = {
            -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
            name = "snacks.pick",
        },
        completion = {
            nvim_cmp = false,
            blink = true,
            -- Trigger completion at n chars.
            min_chars = 3,
        },
    },
    mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ["gf"] = {
            action = function()
                return require("obsidian").util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
        },
    },
    keys = {
        {
            "<leader>Of",
            ":ObsidianQuickSwitch<CR>",
            desc = "Find in Obsidian vault",
        },
        {
            "<leader>Os",
            ":ObsidianSearch<CR>",
            desc = "Search in Obsidian vault",
        },
        {
            "<leader>Od",
            ":ObsidianToday<CR>",
            desc = "New/Open daily note",
        },
        {
            "<leader>Ot",
            ":ObsidianTOC<CR>",
            desc = "Open TOC for current file",
        },
    },
}
