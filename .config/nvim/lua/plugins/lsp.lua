return {
  "neovim/nvim-lspconfig",
  {"williamboman/mason.nvim", config = true},
  {"j-hui/fidget.nvim", config = true},

  {
    "williamboman/mason-lspconfig.nvim",
    config = function(plugin, opts)
      require("mason-lspconfig").setup()
      require("mason-lspconfig").setup_handlers({
        function(server)
          require("lspconfig")[server].setup({})
        end,
        gopls = function ()
          require("lspconfig").gopls.setup({
            settings = { gopls = { gofumpt = true } }
          })
        end
      })
    end,
  },
}
