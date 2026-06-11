-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
-- vim.api.nvim_create_autocmd("TextYankPost", {
-- 	callback = function()
-- 		vim.highlight.on_yank()
-- 	end,
-- 	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
-- 	pattern = "*",
-- })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { os.getenv("HOME") .. "/.local/share/chezmoi/*" },
	callback = function(ev)
		local bufnr = ev.buf
		local edit_watch = function()
			require("chezmoi.commands.__edit").watch(bufnr)
		end
		vim.schedule(edit_watch)
	end,
})

-- Auto-wrap at 80 columns for markdown files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.textwidth = 80
		vim.opt_local.formatoptions:append("tcqn")
	end,
})

-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = "*.md",
-- 	callback = function()
-- 		if vim.bo.filetype ~= "markdown" then
-- 			return
-- 		end
--
-- 		local view = vim.fn.winsaveview()
-- 		-- gw respects formatexpr, which LazyVim sets to the LSP formatter.
-- 		-- Async LSP calls inside BufWritePre crash neovim, so clear it temporarily
-- 		-- to force gw to use vim's built-in textwidth wrapper.
-- 		local saved_formatexpr = vim.bo.formatexpr
-- 		vim.bo.formatexpr = ""
--
-- 		-- Skip YAML frontmatter (--- ... ---) so gw doesn't collapse it onto one line.
-- 		local body_start = 1
-- 		local lines = vim.api.nvim_buf_get_lines(0, 0, 2, false)
-- 		if lines[1] == "---" then
-- 			local all_lines = vim.api.nvim_buf_get_lines(0, 1, -1, false)
-- 			for i, line in ipairs(all_lines) do
-- 				if line == "---" or line == "..." then
-- 					body_start = i + 2 -- 1-indexed, skip the closing delimiter line
-- 					break
-- 				end
-- 			end
-- 		end
--
-- 		if body_start > 1 then
-- 			vim.cmd("silent keepjumps normal! " .. body_start .. "GVGgw")
-- 		else
-- 			vim.cmd("silent keepjumps normal! ggVGgw")
-- 		end
--
-- 		vim.bo.formatexpr = saved_formatexpr
-- 		vim.fn.winrestview(view)
-- 	end,
-- })
