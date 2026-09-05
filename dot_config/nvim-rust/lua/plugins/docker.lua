-- The docker-compose language server only attaches to the compound filetype
-- `yaml.docker-compose`, and Neovim has no built-in rule that produces it, so
-- the server the `lang.docker` extra installs would otherwise never start.
-- Both components still match, so yamlls + SchemaStore keep working too.
vim.filetype.add({
	pattern = {
		["[dD]ocker[-_]?compose%.ya?ml"] = "yaml.docker-compose",
		["compose%.ya?ml"] = "yaml.docker-compose",
		["[dD]ocker[-_]?compose%.[%w_.-]+%.ya?ml"] = "yaml.docker-compose",
		["compose%.[%w_.-]+%.ya?ml"] = "yaml.docker-compose",
	},
})

-- lazydocker in a Snacks float, the same way LazyVim opens lazygit. The
-- Dockerfile/compose language servers come from the LazyVim `lang.docker`
-- extra; the container UI itself needs no plugin, just the lazydocker binary.
return {
	{
		"folke/snacks.nvim",
		keys = {
			{
				"<leader>D",
				function()
					if vim.fn.executable("lazydocker") == 0 then
						Snacks.notify.error("lazydocker is not installed")
						return
					end
					Snacks.terminal.toggle("lazydocker", {
						win = {
							position = "float",
							border = "rounded",
							width = 0.9,
							height = 0.9,
							title = " lazydocker ",
							title_pos = "center",
						},
					})
				end,
				desc = "Lazydocker",
			},
		},
	},
}
