local g = vim.g

-- >> Viewdoc
g.no_viewdoc_abbrev = 1
g.viewdoc_open = "topleft new"
g.viewdoc_winwidth_max = 100

return {
  "powerman/vim-plugin-viewdoc",

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "auto",
        icons_enabled = false,
        section_separators = "",
        component_separators = "",
      },
      tabline = {
        lualine_a = { {'buffers', mode = 4} },
      },
      extensions = {"quickfix"},
    }
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    keys = {
      {"<leader>ig", "<cmd>IndentBlanklineToggle<cr>"},
    },
    opts = {
      enabled = false,
      char = "│",
      -- filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
  },

  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "BufReadPre",
    opts = {
      symbol = "│",
      -- symbol = "▏",
      options = { try_as_border = true },
      draw = {
        animation = function() return 2 end,
      },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      require("mini.indentscope").setup(opts)
    end,
  },
}
