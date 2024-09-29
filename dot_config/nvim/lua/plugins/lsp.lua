return {
	"neovim/nvim-lspconfig", -- REQUIRED: for native Neovim LSP integration
	lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
	dependencies = {
		{ "folke/neoconf.nvim" },

		-- COQ
		{ "ms-jpq/coq_nvim", branch = "coq" },
		-- 9000+ Snippets
		{ "ms-jpq/coq.artifacts", branch = "artifacts" },
		-- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
		-- Need to **configure separately**
		{ "ms-jpq/coq.thirdparty", branch = "3p" },
		-- - shell repl
		-- - nvim lua api
		-- - scientific calculator
		-- - comment banner
		-- - etc
	},
	init = function()
		vim.g.coq_settings = {
			-- start COQ at startup but don't announce it
			auto_start = "shut-up",
		}
	end,
	config = function()
		-- Your LSP settings here
	end,
}
