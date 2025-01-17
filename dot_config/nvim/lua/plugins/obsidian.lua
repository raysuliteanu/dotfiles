return {
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		-- ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		event = {
			-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
			-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
			-- refer to `:h file-pattern` for more examples
			"BufReadPre "
				.. vim.fn.expand("~")
				.. "/Documents/Obsidian/Ray/**/*.md",
			"BufNewFile " .. vim.fn.expand("~") .. "/Documents/Obsidian/Ray/**/*.md",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("obsidian").setup({
				workspaces = {
					{
						name = "Ray",
						path = "/home/ray/Documents/Obsidian/Ray",
					},
				},
				notes_subdir = "Resources/Notes",
				new_notes_location = "notes_subdir",
				disable_frontmatter = false,
				templates = {
					folder = "Templates",
					date_format = "%Y-%m-%d",
					time_format = "%H:%M",
					substitutions = {},
				},
				completion = {
					nvim_cmp = false,
					min_chars = 2,
				},
				ui = {
					-- using MeanderingProgrammer/render-markdown.nvim
					-- see plugins/markdown.lua
					enable = false,
				},
			})
		end,
		-- defaults to [n]ormal mode if not specified
		keys = {
			{
				"<leader>ov",
				":cd /home/ray/Documents/Obsidian/Ray<CR>:ObsidianQuickSwitch<CR>",
				desc = "Open Obsidian vault",
			},
			{
				"<leader>on",
				":ObsidianNewFromTemplate note<CR>",
				desc = "New Obsidian note",
			},
			{
				"<leader>of",
				":ObsidianQuickSwitch<CR>",
				desc = "Find in Obsidian vault",
			},
			{
				"<leader>os",
				":ObsidianSearch<CR>",
				desc = "Search in Obsidian vault",
			},
			{
				"<leader>oe",
				":ObsidianExtractNote<CR>",
				desc = "Extract selected text to file",
			},
			{
				"<leader>od",
				":ObsidianToday<CR>",
				desc = "New/Open daily note",
			},
			{
				"<leader>ot",
				":ObsidianTOC<CR>",
				desc = "Open TOC for current file",
			},
		},
	},
}
