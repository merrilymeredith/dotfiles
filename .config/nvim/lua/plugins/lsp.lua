return {
  -- mason is nonlazy so my executable tests work
  { "williamboman/mason.nvim", config = true },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason-lspconfig.nvim", config = true },
      { "folke/neodev.nvim", config = true },
      { "j-hui/fidget.nvim", config = true },
    },
    config = function(_, _)
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason-lspconfig").setup_handlers({
        function(server)
          require("lspconfig")[server].setup({ capabilities = capabilities })
        end,
        gopls = function()
          require("lspconfig").gopls.setup({
            capabilities = capabilities,
            settings = { gopls = { gofumpt = true } },
          })
        end,
        solargraph = function()
          require("lspconfig").solargraph.setup({
            capabilities = capabilities,
            init_options = { formatting = false },
          })
        end,
      })
    end,
  },
}
