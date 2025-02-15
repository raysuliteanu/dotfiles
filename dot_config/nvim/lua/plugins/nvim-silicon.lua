-- requires `silicon` to be installed e.g. `brew install silicon`
return {
	"michaelrommel/nvim-silicon",
	lazy = true,
	cmd = "Silicon",
	config = function()
		require("nvim-silicon").setup({
			background = "#000000",
			-- for list of themes available use `silicon --list-themes`
			theme = "GitHub",
			-- for list of fonts installed use `fc-list`
			font = "JetBrainsMonoNLNerdFontMono-ExtraBold",
			no_window_controls = true,
			pad_horiz = 0,
			pad_vert = 0,
			window_title = function()
				local buf_name = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
				return vim.fn.fnamemodify(buf_name, ":t")
			end,
			output = function()
				local vpath = vim.fn.expand("~") .. "/Pictures/Screenshots/"
				return vpath .. os.date("!%Y-%m-%dT%H-%M-%S") .. ".png"
			end,
		})
	end,
}
