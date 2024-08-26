return {
  -- mason is nonlazy so my executable tests work
  { "williamboman/mason.nvim", config = true },

  {
    "neovim/nvim-lspconfig",
    branch = "master",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason-lspconfig.nvim", config = true },
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
            settings = {
              gopls = {
                analyses = {
                  unusedvariable = true,
                  useany = true,
                },
                hints = {
                  constantValues = true,
                  rangeVariableTypes = true,
                },
                vulncheck = "Imports",
                gofumpt = true,
                staticcheck = true,
              },
            },
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

  { "j-hui/fidget.nvim", event = "LspAttach", config = true },

  {
    "aznhe21/actions-preview.nvim",
    event = "LspAttach",
    opts = {
      nui = {
        keymap = { close = { "<ESC>", "<C-c>", "q" } },
      },
    },
  },

  {
    "ray-x/lsp_signature.nvim",
    branch = "master",
    event = "VeryLazy",
    opts = {
      toggle_key = "<C-S>",
      select_signature_key = "<M-n>",
      toggle_key_flip_floatwin_setting = true,
      doc_lines = 0,
      floating_window = true,
      fix_pos = true,
      hint_enable = false,
    },
  },
}
