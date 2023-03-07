return {
  -- mason is nonlazy so my executable tests works
  { "williamboman/mason.nvim", config = true },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      { "j-hui/fidget.nvim", config = true },
    },
    config = function(plugin, opts)
      require("mason-lspconfig").setup()
      require("mason-lspconfig").setup_handlers({
        function(server)
          require("lspconfig")[server].setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
          })
        end,
        gopls = function()
          require("lspconfig").gopls.setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            settings = { gopls = { gofumpt = true } },
          })
        end,
        solargraph = function()
          require("lspconfig").solargraph.setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            init_options = { formatting = false },
          })
        end,
      })
    end,
  },
}
