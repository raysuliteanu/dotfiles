-- event = {
-- 	-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
-- 	-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
-- 	-- refer to `:h file-pattern` for more examples
-- 	"BufReadPre "
-- 		.. vpath
-- 		.. "/**/*.md",
-- 	"BufNewFile " .. vpath .. "/**/*.md",
-- },
local vpath = vim.fn.expand("~") .. "/Documents/Obsidian/Ray"
-- return {
-- 	{
-- 		"epwalsh/obsidian.nvim",
-- 		version = "*",
-- 		lazy = true,
-- 		-- ft = "markdown",
-- 		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
-- 		event = {
-- 			-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
-- 			-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
-- 			-- refer to `:h file-pattern` for more examples
-- 			"BufReadPre "
-- 				.. vpath
-- 				.. "/**/*.md",
-- 			"BufNewFile " .. vpath .. "/**/*.md",
-- 		},
-- 		dependencies = {
-- 			"echasnovski/mini.pick",
-- 		},
-- 		config = function()
-- 			require("obsidian").setup({
-- 				workspaces = {
-- 					{
-- 						name = "Ray",
-- 						path = vpath,
-- 					},
-- 				},
-- 				notes_subdir = "Resources/Notes",
-- 				new_notes_location = "notes_subdir",
-- 				disable_frontmatter = false,
-- 				templates = {
-- 					folder = "Templates",
-- 					date_format = "%Y-%m-%d",
-- 					time_format = "%H:%M",
-- 					substitutions = {},
-- 				},
-- 				completion = {
-- 					nvim_cmp = false,
-- 					min_chars = 2,
-- 				},
-- 				ui = {
-- 					-- using MeanderingProgrammer/render-markdown.nvim
-- 					-- see plugins/markdown.lua
-- 					enable = false,
-- 				},
-- 				picker = {
-- 					-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
-- 					name = "mini.pick",
-- 				},
-- 			})
-- 		end,
-- 		-- defaults to [n]ormal mode if not specified
-- 		keys = {
-- 			{
-- 				"<leader>Ov",
-- 				":cd " .. vpath .. "<CR>:ObsidianQuickSwitch<CR>",
-- 				desc = "Open Obsidian vault",
-- 			},
-- 			{
-- 				"<leader>On",
-- 				":ObsidianNewFromTemplate note<CR>",
-- 				desc = "New Obsidian note",
-- 			},
-- 			{
-- 				"<leader>Of",
-- 				":ObsidianQuickSwitch<CR>",
-- 				desc = "Find in Obsidian vault",
-- 			},
-- 			{
-- 				"<leader>Os",
-- 				":ObsidianSearch<CR>",
-- 				desc = "Search in Obsidian vault",
-- 			},
-- 			{
-- 				"<leader>Oe",
-- 				":ObsidianExtractNote<CR>",
-- 				desc = "Extract selected text to file",
-- 			},
-- 			{
-- 				"<leader>Od",
-- 				":ObsidianToday<CR>",
-- 				desc = "New/Open daily note",
-- 			},
-- 			{
-- 				"<leader>Ot",
-- 				":ObsidianTOC<CR>",
-- 				desc = "Open TOC for current file",
-- 			},
-- 		},
-- 	},
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

		-- see below for full list of optional dependencies 👇
	},
	opts = {
		workspaces = {
			{
				name = "Ray",
				path = vpath,
			},
		},
		notes_subdir = "Resources/Notes",
		new_notes_location = "notes_subdir",
		disable_frontmatter = false,
		preferred_link_style = "wiki",
		templates = {
			folder = "Templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
			substitutions = {},
		},

		completion = {
			nvim_cmp = false,
			blink = true,
			-- Trigger completion at n chars.
			min_chars = 3,
		},
	},
	mappings = {
		{
			"<leader>Ov",
			":cd " .. vpath .. "<CR>:ObsidianQuickSwitch<CR>",
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
}
