-- requires `silicon` to be installed e.g. `brew install silicon`
return {
	"michaelrommel/nvim-silicon",
	lazy = true,
	cmd = "silicon",
	config = function()
		require("nvim-silicon").setup({
			-- for list of themes available use `silicon --list-themes`
			theme = "GitHub",
			-- for list of fonts installed use `fc-list`
			font = "JetBrainsMonoNLNerdFontMono-ExtraBold",
			window_title = function()
				local buf_name = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
				return vim.fn.fnamemodify(buf_name, ":t")
			end,
			output = function()
				local vpath = vim.fn.expand("~") .. "/Pictures/Screenshots/"
				return vpath .. os.date("!%Y-%m-%dT%H-%M-%SZ") .. ".png"
			end,
		})
	end,
}
