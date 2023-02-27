return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-omni",
      "hrsh7th/cmp-path",
      "quangnguyen30192/cmp-nvim-tags",
    },
    opts = function()
      local cmp = require("cmp")
      return {
        completion = {
          keyword_length = 3,
          completeopt = "menu,menuone,noinsert,noselect",
        },
        formatting = {
          format = function(entry, vim_item)
            if vim_item.kind == "Text" then
              vim_item.kind = entry.source.name
            end
            return vim_item
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<C-g>"] = cmp.mapping.abort(),
          ["<Right>"] = cmp.mapping.confirm({select = true}),
          ["<Space>"] = function(fallback)
            if cmp.visible() then
              cmp.confirm({select = false}, function()
                vim.api.nvim_feedkeys(" ", "n", false)
              end)
            end
            fallback()
          end,
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lua" },
          { name = "buffer", option = { keyword_pattern = [[\k\+]] } },
          { name = "path" },
          { name = "omni" },
          { name = "tags" },
          { name = "calc" },
        }),
      }
    end,
  },
}
