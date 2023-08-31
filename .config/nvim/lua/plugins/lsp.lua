return {
  -- mason is nonlazy so my executable tests work
  { "williamboman/mason.nvim", config = true },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason-lspconfig.nvim", config = true },
      { "folke/neodev.nvim", config = true },
      { "j-hui/fidget.nvim", config = true, branch = "legacy" },
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

  {
    "aznhe21/actions-preview.nvim",
    keys = "<leader>ca",
    opts = {
      nui = {
        keymap = { close = { "<ESC>", "<C-c>", "q" } },
      },
    },
    config = function(_, opts)
      require("actions-preview").setup(opts)
      vim.keymap.set("n", "<leader>ca", require("actions-preview").code_actions, { silent = true })
    end,
  },
}
