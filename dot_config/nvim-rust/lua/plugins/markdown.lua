return {
	-- render-markdown.nvim comes from the LazyVim markdown extra; this only
	-- wires up blink.cmp completions.
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {
			completions = { blink = { enabled = true } },
		},
	},

	-- Drop prettier from the markdown formatter chain: it isn't installed, and
	-- markdownlint-cli2 + markdown-toc already cover fixing and TOC updates.
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				markdown = { "markdownlint-cli2", "markdown-toc" },
				["markdown.mdx"] = { "markdownlint-cli2", "markdown-toc" },
			},
		},
	},
}
