return {
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		ft = "markdown",
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
					subdir = "Templates",
					date_format = "%Y-%m-%d",
					time_format = "%H:%M",
				},
				-- key mappings, below are the defaults
				mappings = {
					-- overrides the 'gf' mapping to work on markdown/wiki links within your vault
					["gf"] = {
						action = function()
							return require("obsidian").util.gf_passthrough()
						end,
						opts = { noremap = false, expr = true, buffer = true },
					},
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
				"<leader>Ov",
				":cd /home/ray/Documents/Obsidian/Ray<CR>:ObsidianQuickSwitch<CR>",
				desc = "Open Obsidian vault",
			},
			{
				"<leader>On",
				":ObsidianNewFromTemplate note<CR>",
				desc = "New Obsidian note",
			},
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
				"<leader>Oe",
				":ObsidianExtractNote<CR>",
				desc = "Extract selected text to file",
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
	},
}
