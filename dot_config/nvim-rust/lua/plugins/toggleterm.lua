-- ToggleTerm, kept for the <C-t> toggle and send-visual-selection workflow.
-- LazyVim's Snacks terminal (<C-/>, <leader>ft) still works alongside it.
return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		cmd = { "ToggleTerm", "ToggleTermSendVisualSelection", "TermExec" },
		opts = {},
		keys = {
			{ "<C-t>", "<cmd>ToggleTerm<cr>", mode = { "n", "t" }, desc = "Toggle terminal" },
			{
				"<C-t>",
				"<cmd>ToggleTermSendVisualSelection<cr>",
				mode = "v",
				desc = "Send selection to terminal",
			},
		},
	},
}
