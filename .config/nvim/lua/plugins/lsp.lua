---@type LazySpec
return {
  -- mason is nonlazy so my executable tests work
  { "mason-org/mason.nvim", config = true },

  {
    "neovim/nvim-lspconfig",
    branch = "master",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason-lspconfig.nvim", config = true },
      "b0o/SchemaStore.nvim",
    },
    config = function(_, _)
      local lspconfig = require("lspconfig")

      lspconfig.util.default_config.capabilities = vim.tbl_deep_extend("force",
        lspconfig.util.default_config.capabilities,
        require("cmp_nvim_lsp").default_capabilities()
      )

      -- allow view / -R to also stop autostart. no other global flag for this.
      lspconfig.util.default_config.autostart = not vim.list_contains(vim.v.argv, "-R")
    end,
  },

  { "j-hui/fidget.nvim", event = "LspAttach", config = true },

  {
    "soulis-1256/eagle.nvim",
    event = "LspAttach",
    config = function()
      vim.go.mousemoveevent = true
      require("eagle").setup({
        border = "rounded",
        max_width_factor = 3,
        max_height_factor = 3,
      })
    end,
  },

  {
    "aznhe21/actions-preview.nvim",
    event = "LspAttach",
    opts = {
      backend = { "nui" },
      nui = {
        keymap = { close = { "<ESC>", "<C-c>", "q" } },
        layout = { size = { width = "80%", height = "80%" } },
        preview = { size = "75%" },
        select = { size = { width = "100%", height = "25%" } },
      },
    },
  },

  {
    "ray-x/lsp_signature.nvim",
    branch = "master",
    event = "LspAttach",
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

  -- mise use -g 'npm:@devcontainers/cli@latest'
  {
    'jedrzejboczar/devcontainers.nvim',
    cond = (vim.fn.executable("devcontainer") == 1),
    event = { "BufReadPre", "BufNewFile" },
    cmd = { 'DevcontainersUp', 'DevcontainersExec' },
    dependencies = {
      "neovim/nvim-lspconfig",
      -- "miversen33/netman.nvim", -- optional. this busts netrw right now
    },
    config = function(_, _)
      local devc = require("devcontainers")
      local lutil = require("lspconfig.util")

      local function chain(orig, new)
        return function(...)
          if orig then
            orig(...)
          end
          return new(...)
        end
      end

      lutil.on_setup = chain(lutil.on_setup, function(config, user_config)
        config.on_new_config = chain(config.on_new_config, devc.on_new_config)
      end)
    end,
  }
}
