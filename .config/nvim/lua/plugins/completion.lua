return {
  {
    "hrsh7th/nvim-cmp",
    branch = "main",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "quangnguyen30192/cmp-nvim-tags",
    },
    config = function()
      local cmp = require("cmp")

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      cmp.setup({
        preselect = cmp.PreselectMode.None,
        completion = {
          keyword_length = 3,
        },
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        ---@diagnostic disable-next-line: missing-fields
        formatting = {
          format = function(entry, vim_item)
            if vim_item.kind == "Text" then
              vim_item.kind = entry.source.name
            end
            vim_item.menu = nil
            return vim_item
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if vim.snippet.active({direction = 1}) then
              vim.snippet.jump(1)
            elseif cmp.visible() then
              cmp.select_next_item()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if vim.snippet.active({direction = -1}) then
              vim.snippet.jump(-1)
            elseif cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-g>"] = cmp.mapping.abort(),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<Space>"] = cmp.mapping(function(fallback)
            cmp.confirm({ select = false })
            fallback()
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "lazydev" },
        }, {
          { name = "nvim_lsp" },
        }, {
          { name = "buffer", option = { keyword_pattern = [[\k\+]] } },
          { name = "path" },
        }, {
          { name = "tags" },
          { name = "calc" },
        }),
      })
    end,
  },
}
