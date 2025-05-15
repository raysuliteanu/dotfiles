return {
	-- amongst your other plugins
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
		opts = {
			open_mapping = [[c-t]],
		},
	},
	-- or
	-- {'akinsho/toggleterm.nvim', version = "*", opts = {--[[ things you want to change go here]]}}
}
