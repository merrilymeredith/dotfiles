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
      local lspconfig = require("lspconfig")

      lspconfig.util.default_config.capabilities = vim.tbl_deep_extend("force",
        lspconfig.util.default_config.capabilities,
        require("cmp_nvim_lsp").default_capabilities()
      )

      -- allow view / -R to also stop autostart. no other global flag for this.
      lspconfig.util.default_config.autostart = not vim.list_contains(vim.v.argv, "-R")

      require("mason-lspconfig").setup_handlers({
        function(server) lspconfig[server].setup({}) end,
        gopls = function()
          lspconfig.gopls.setup({
            settings = {
              -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
              gopls = {
                analyses = {
                  unusedvariable = true,
                  useany = true,
                },
                hints = {
                  assignVariableTypes = true,
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
          lspconfig.solargraph.setup({
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
