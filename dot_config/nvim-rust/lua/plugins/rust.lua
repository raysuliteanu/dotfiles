-- rustaceanvim, crates.nvim, codelldb and the rust-analyzer settings all come
-- from the LazyVim `lang.rust` extra (see lazyvim.json). This only adds the
-- entry points the extra does not map.
--
-- Rust/Cargo actions live under <leader>r rather than <leader>c so they don't
-- shadow LazyVim's code mappings (<leader>cr rename, <leader>cf format, ...).
return {
	{
		"mrcjkb/rustaceanvim",
		opts = {
			server = {
				on_attach = function(_, bufnr)
					local map = function(lhs, action, desc)
						vim.keymap.set("n", lhs, function()
							vim.cmd.RustLsp(action)
						end, { buffer = bufnr, desc = desc })
					end

					map("<leader>rr", "runnables", "Runnables")
					map("<leader>rt", "testables", "Testables")
					map("<leader>rm", "expandMacro", "Expand Macro")
					map("<leader>re", "explainError", "Explain Error")
					map("<leader>rD", "renderDiagnostic", "Render Diagnostic")
					map("<leader>rp", "parentModule", "Parent Module")
					map("<leader>rc", "openCargo", "Open Cargo.toml")

					-- Hover with code actions attached (rustaceanvim's richer hover)
					vim.keymap.set("n", "K", function()
						vim.cmd.RustLsp({ "hover", "actions" })
					end, { buffer = bufnr, desc = "Hover Actions" })
				end,
			},
		},
	},

	{
		"Saecki/crates.nvim",
		init = function()
			vim.api.nvim_create_autocmd("BufRead", {
				pattern = "Cargo.toml",
				callback = function(ev)
					local crates = require("crates")
					local map = function(lhs, fn, desc)
						vim.keymap.set("n", lhs, fn, { buffer = ev.buf, desc = desc })
					end

					map("<leader>ru", crates.upgrade_crate, "Upgrade Crate")
					map("<leader>rU", crates.upgrade_all_crates, "Upgrade All Crates")
					map("<leader>rv", crates.show_versions_popup, "Show Versions")
					map("<leader>rf", crates.show_features_popup, "Show Features")
					map("<leader>rd", crates.open_documentation, "Open docs.rs")
				end,
			})
		end,
	},

	-- Register the <leader>r group so which-key labels it.
	{
		"folke/which-key.nvim",
		opts = {
			spec = {
				{ "<leader>r", group = "rust", icon = { icon = "󱘗 ", color = "orange" } },
			},
		},
	},
}
