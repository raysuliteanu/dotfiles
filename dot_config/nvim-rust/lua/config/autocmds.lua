-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- Auto-wrap at 80 columns for markdown files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.textwidth = 80
		vim.opt_local.formatoptions:append("tcqn")
	end,
})

-- jj writes change descriptions to a file with no extension; give it the
-- gitcommit filetype so treesitter highlighting and textwidth apply.
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.jjdescription" },
	callback = function()
		vim.bo.filetype = "gitcommit"
	end,
})
