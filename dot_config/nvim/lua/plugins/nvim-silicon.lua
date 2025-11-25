-- requires `silicon` to be installed e.g. `brew install silicon`
return {
    "michaelrommel/nvim-silicon",
    lazy = true,
    cmd = "Silicon",
    config = function()
        require("nvim-silicon").setup({
            -- background = "#000000",
            -- for list of themes available use `silicon --list-themes`
            theme = "gruvbox-dark",
            -- for list of fonts installed use `fc-list`
            -- font = "JetBrainsMonoNLNerdFontMono-ExtraBold",
            no_window_controls = true,
            pad_horiz = 0,
            pad_vert = 0,
            -- line_offset = 1,
            -- here a function is used to return the actual source code line number
            line_offset = function(args)
                return args.line1
            end,
            window_title = function()
                local buf_name = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
                local fname = vim.fn.fnamemodify(buf_name, ":t")
                return fname
            end,
            output = function()
                local vpath = vim.fn.expand("~") .. "/Pictures/Screenshots/"
                local buf_name = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
                local fname = vim.fn.fnamemodify(buf_name, ":t")
                return vpath .. fname .. "-" .. os.date("!%Y%m%d-%H%M%S") .. ".png"
            end,
        })
    end,
}
