return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "lua_ls", "rust_analyzer", "jdtls" },
        },
        dependencies = {
            { "mason-org/mason.nvim", version = "1.11.0", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
}
