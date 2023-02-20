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

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lua",
    },
    opts = function()
      local cmp = require("cmp")
      return {
        completion = {
          completeopt = "menu,menuone,noinsert,noselect",
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              cmp.complete()
            end
          end,
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<C-g>"] = cmp.mapping.abort(),
          ["<Right>"] = cmp.mapping.confirm({select = true}),
          ["<Space>"] = function(fallback)
            if cmp.visible() then
              cmp.confirm({select = false})
              vim.api.nvim_feedkeys(" ", "n", false)
            end
            fallback()
          end,
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lua" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
        experimental = {
          ghost_text = {
            hl_group = "LspCodeLens",
          },
        },
      }
    end,
  },
}
