local M = {}

M.type_symbol_filters = {
	default = { "Class", "Enum", "Interface", "Struct", "Trait", "TypeParameter" },
	rust = { "Enum", "Struct", "Trait", "TypeParameter" },
	java = { "Class", "Enum", "Interface", "TypeParameter" },
	kotlin = { "Class", "Enum", "Interface", "Object", "Struct", "TypeParameter" },
	scala = { "Class", "Enum", "Interface", "Module", "Namespace", "Object", "Trait", "TypeParameter" },
	go = { "Interface", "Struct", "TypeParameter" },
	typescript = { "Class", "Enum", "Interface", "TypeParameter" },
	typescriptreact = { "Class", "Enum", "Interface", "TypeParameter" },
	javascript = { "Class" },
	javascriptreact = { "Class" },
	python = { "Class", "TypeParameter" },
	lua = { "Class", "Interface", "Module", "Struct" },
	c = { "Enum", "Struct" },
	cpp = { "Class", "Enum", "Interface", "Namespace", "Struct", "TypeParameter" },
	cs = { "Class", "Enum", "Interface", "Struct", "TypeParameter" },
	php = { "Class", "Enum", "Interface", "Trait" },
	ruby = { "Class", "Module" },
}

M.broad_symbol_filters = vim.tbl_deep_extend("force", {}, M.type_symbol_filters, {
	default = {
		"Class",
		"Constant",
		"Constructor",
		"Enum",
		"Field",
		"Function",
		"Interface",
		"Method",
		"Module",
		"Namespace",
		"Property",
		"Struct",
		"Trait",
		"TypeParameter",
	},
	rust = { "Constant", "Enum", "Function", "Method", "Module", "Struct", "Trait", "TypeParameter" },
	java = { "Class", "Constant", "Constructor", "Enum", "Field", "Interface", "Method", "TypeParameter" },
	kotlin = { "Class", "Constant", "Constructor", "Enum", "Field", "Function", "Interface", "Method", "Object", "Property", "Struct", "TypeParameter" },
	scala = { "Class", "Constant", "Constructor", "Enum", "Field", "Function", "Interface", "Method", "Module", "Namespace", "Object", "Property", "Trait", "TypeParameter" },
	go = { "Constant", "Field", "Function", "Interface", "Method", "Struct", "TypeParameter" },
	typescript = { "Class", "Constant", "Enum", "Field", "Function", "Interface", "Method", "Module", "Property", "TypeParameter" },
	typescriptreact = { "Class", "Constant", "Enum", "Field", "Function", "Interface", "Method", "Module", "Property", "TypeParameter" },
	javascript = { "Class", "Constant", "Field", "Function", "Method", "Module", "Property" },
	javascriptreact = { "Class", "Constant", "Field", "Function", "Method", "Module", "Property" },
	python = { "Class", "Constant", "Field", "Function", "Method", "Property", "TypeParameter" },
	lua = { "Class", "Constant", "Field", "Function", "Interface", "Method", "Module", "Property", "Struct" },
	c = { "Constant", "Enum", "Field", "Function", "Struct" },
	cpp = { "Class", "Constant", "Constructor", "Enum", "Field", "Function", "Interface", "Method", "Namespace", "Struct", "TypeParameter" },
	cs = { "Class", "Constant", "Constructor", "Enum", "Field", "Interface", "Method", "Property", "Struct", "TypeParameter" },
	php = { "Class", "Constant", "Constructor", "Enum", "Field", "Function", "Interface", "Method", "Property", "Trait" },
	ruby = { "Class", "Constant", "Function", "Method", "Module", "Property" },
})

function M.search_types()
	Snacks.picker.lsp_workspace_symbols({
		title = "Search Types",
		prompt = "Types> ",
		filter = M.type_symbol_filters,
	})
end

function M.search_symbols()
	Snacks.picker.lsp_workspace_symbols({
		title = "Search Symbols",
		prompt = "Symbols> ",
		filter = M.broad_symbol_filters,
	})
end

function M.search_buffer_types()
	Snacks.picker.lsp_symbols({
		title = "Search Buffer Types",
		prompt = "Buffer Types> ",
		filter = M.type_symbol_filters,
	})
end

return M
