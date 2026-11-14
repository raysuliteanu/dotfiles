-- Outside tmux but inside Rex, move between nvim splits and hand off to the
-- neighbouring Rex pane at the edge (pairs with ctrl+hjkl in rex/init.lua).
local function navigate(wincmd, rex_dir, tmux_cmd)
	return function()
		if vim.env.TMUX or not vim.env.REX_SESSION then
			vim.cmd(tmux_cmd)
			return
		end
		local win = vim.api.nvim_get_current_win()
		vim.cmd("wincmd " .. wincmd)
		if win == vim.api.nvim_get_current_win() then
			vim.fn.jobstart({ "rex", "focus", rex_dir })
		end
	end
end

return {
	"christoomey/vim-tmux-navigator",
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
	},
	keys = {
		{ "<c-h>", navigate("h", "left", "TmuxNavigateLeft") },
		{ "<c-j>", navigate("j", "down", "TmuxNavigateDown") },
		{ "<c-k>", navigate("k", "up", "TmuxNavigateUp") },
		{ "<c-l>", navigate("l", "right", "TmuxNavigateRight") },
		{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
	},
}
