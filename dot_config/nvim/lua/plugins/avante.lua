return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
        input = {
            provider = "snacks", -- "native" | "dressing" | "snacks"
            provider_opts = {
                -- Snacks input configuration
                title = "Avante Input",
                placeholder = "ENTER YOUR API key...",
            },
        },
        disabled_tools = {
            "list_files", -- Built-in file operations
            "search_files",
            "read_file",
            "create_file",
            "rename_file",
            "delete_file",
            "create_dir",
            "rename_dir",
            "delete_dir",
            "bash", -- Built-in terminal access
        },
        -- provider = "openai", -- default is claude
        -- openai = {
        -- 	endpoint = "https://api.openai.com/v1",
        -- 	model = "gpt-4o",
        -- 	timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
        -- 	temperature = 0,
        -- 	max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
        -- 	--reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
        -- },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        {
            -- support for image pasting
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                -- recommended settings
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    -- required for Windows users
                    use_absolute_path = true,
                },
            },
        },
        {
            -- Make sure to set this up properly if you have lazy=true
            "MeanderingProgrammer/render-markdown.nvim",
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
    },
}
