return {
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- defaults to [n]ormal mode if not specified
		keys = {
			{
				"<leader>Oo",
				":cd /home/ray/Documents/Obsidian/Ray<cr>",
				desc = "Set cwd to Obsidian vault",
			},
			{
				"<leader>On",
				":ObsidianTemplate note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>",
				desc = "Apply Obsidian 'note' template",
			},
			{
				"<leader>O ",
				":Telescope find_files search_dirs={'/home/ray/Documents/Obsidian/Ray'}<cr>",
				desc = "Find in Obsidian vault",
			},
			{
				"<leader>O/",
				":Telescope find_files live_grep={'/home/ray/Documents/Obsidian/Ray'}<cr>",
				desc = "Grep in Obsidian vault",
			},
		},
		config = function()
			require("obsidian").setup({
				workspaces = {
					{
						name = "Ray",
						path = "/home/ray/Documents/Obsidian/Ray",
					},
					{
						name = "no-vault",
						path = function()
							-- alternatively use the CWD:
							-- return assert(vim.fn.getcwd())
							return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
						end,
						overrides = {
							notes_subdir = vim.NIL, -- have to use 'vim.NIL' instead of 'nil'
							new_notes_location = "current_dir",
							templates = {
								folder = vim.NIL,
							},
							disable_frontmatter = true,
						},
					},
				},
				notes_subdir = "Resources/Notes",
				new_notes_location = "notes_subdir",
				disable_frontmatter = true,
				templates = {
					subdir = "Templates",
					date_format = "%Y-%m-%d",
					time_format = "%H:%M:%S",
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
					nvim_cmp = true,
					min_chars = 2,
				},
				ui = {
					-- using MeanderingProgrammer/render-markdown.nvim
					-- see plugins/markdown.lua
					enable = false,
				},
			})
		end,
	},
}
