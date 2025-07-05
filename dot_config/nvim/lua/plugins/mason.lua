return {
    {
        "mason-org/mason-lspconfig.nvim",
        version = "1.32.0",
        opts = {
            ensure_installed = { "lua_ls", "rust_analyzer" },
        },
        dependencies = {
            { "mason-org/mason.nvim", version = "1.11.0" },
            "neovim/nvim-lspconfig",
        },
    },
}
