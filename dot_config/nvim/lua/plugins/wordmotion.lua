return {
	"chaoren/vim-wordmotion",
	event = { "BufReadPost", "BufNewFile" },
	init = function()
		-- Default mappings:
		-- w, b, e, ge (word motions)
		-- aw, iw (text objects)

		-- Optional: add any customizations here
		-- vim.g.wordmotion_prefix = "<leader>"  -- Uncomment to change the default prefix

		-- Optional: define custom word boundaries
		-- vim.g.wordmotion_spaces = {"_", "-", ".", ":", ",", ";", "<", ">", "!", "?", "\"", "'", "`", "@", "#", "$", "%", "^", "&", "*", "+", "=", "~", "(", ")", "{", "}", "[", "]"}
	end,
}
