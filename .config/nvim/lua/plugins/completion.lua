return {
  {
    "hrsh7th/nvim-cmp",
    branch = "main",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "quangnguyen30192/cmp-nvim-tags",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

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
            luasnip.lsp_expand(args.body)
          end,
        },
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
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-g>"] = cmp.mapping.abort(),
          ["<Right>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<Space>"] = function(fallback)
            local e = cmp.get_active_entry()
            if cmp.visible() and e then
              cmp.confirm({ select = false }, function()
                if e:get_kind() ~= cmp.lsp.CompletionItemKind.Snippet then
                  vim.api.nvim_feedkeys(" ", "n", false)
                end
              end)
            end
            fallback()
          end,
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "buffer", option = { keyword_pattern = [[\k\+]] } },
          { name = "path" },
          { name = "tags" },
          { name = "calc" },
        }),
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    build = (jit.os ~= "Windows") and "make install_jsregexp",
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
  },
  {
    "ray-x/lsp_signature.nvim",
    branch = "master",
    event = { "LspAttach" },
    opts = {
      toggle_key = "<F12>",
      toggle_key_flip_floatwin_setting = true,
      floating_window = false,
      fix_pos = true,
      hint_enable = false,
      handler_opts = { border = "none" },
    },
  },
}
