return {
  {
    "scalameta/nvim-metals",
    ft = { "scala", "sbt", "sc" }, -- Only Scala files, NOT java!
    opts = function()
      local metals_config = require("metals").bare_config()

      -- Ensure Metals only attaches to Scala files
      return metals_config
    end,
    config = function(self, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "scala", "sbt", "sc" }, -- Explicitly only Scala, no Java!
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end,
  },
}
