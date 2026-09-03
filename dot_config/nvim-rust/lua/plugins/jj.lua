-- Jujutsu integration. Keymaps live under <leader>j so they don't collide with
-- LazyVim's <leader>g git mappings (gitsigns / lazygit still work in colocated
-- jj+git repos).
return {
	{
		"NicolasGB/jj.nvim",
		version = "*",
		dependencies = { "folke/snacks.nvim" },
		cmd = { "J", "Jdiff", "Jvdiff", "Jhdiff", "Jread", "Jedit", "Jsplit", "Jvsplit", "Jtabedit", "Jbrowse" },
		opts = {
			picker = { snacks = {} },
			diff = { backend = "native" },
		},
		keys = {
			{ "<leader>j", "", desc = "+jujutsu" },
			{ "<leader>jl", "<cmd>J log<cr>", desc = "Log" },
			{ "<leader>js", "<cmd>J status<cr>", desc = "Status" },
			{ "<leader>jd", "<cmd>Jdiff<cr>", desc = "Diff" },
			{ "<leader>jD", "<cmd>J describe<cr>", desc = "Describe" },
			{ "<leader>jn", "<cmd>J new<cr>", desc = "New Change" },
			{ "<leader>jc", "<cmd>J commit<cr>", desc = "Commit" },
			{ "<leader>jS", "<cmd>J squash<cr>", desc = "Squash" },
			{ "<leader>jr", "<cmd>J resolve<cr>", desc = "Resolve Conflicts" },
			{ "<leader>ju", "<cmd>J undo<cr>", desc = "Undo" },
			{ "<leader>jf", "<cmd>J fetch<cr>", desc = "Fetch" },
			{ "<leader>jp", "<cmd>J push<cr>", desc = "Push" },
			{ "<leader>jb", "<cmd>J annotate<cr>", desc = "Blame File" },
		},
	},
}
