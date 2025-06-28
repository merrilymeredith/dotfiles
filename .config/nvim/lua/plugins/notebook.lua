vim.g.molten_auto_init_behavior = "raise"
vim.g.molten_auto_open_output = false
vim.g.molten_virt_text_output = true
vim.g.molten_wrap_output = true

-- local setup: bin/setup-jupyter-venv
--   creates ~/.venvs/neovim, used automatically for nvim remote plugins
-- :MoltenInit explicitly

return {
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto" },
    dependencies = {
      "jmbuhr/otter.nvim",
      "benlubas/molten-nvim",
    },
    opts = {
      codeRunner = { default_method = "molten" },
    },
  },
  {
    "benlubas/molten-nvim",
    branch = "main",
    cond = (vim.fn.has("python3") == 1),
    build = ":UpdateRemotePlugins",
    keys = {
      { "<leader>me", ":MoltenEvaluateOperator<CR>", desc = "eval operator" },
      { "<leader>me", ":<C-u>MoltenEvaluateVisual<CR>", desc = "eval selection", mode = "v" },
      { "<leader>ml", ":MoltenEvaluateLine<CR>", desc = "eval line" },
      { "<leader>mr", ":MoltenReevaluateCell<CR>", desc = "re-eval cell" },
      { "<leader>md", ":MoltenDelete<CR>", desc = "forget cell" },
      { "<leader>mD", ":MoltenDelete!<CR>", desc = "forget all cells" },
      { "<leader>mo", ":noautocmd MoltenEnterOutput<CR>", desc = "open/enter output window" },
      { "<leader>mh", ":MoltenToggleVirtual!<CR>", desc = "toggle output virtual text"},
      { "<leader>mx", ":MoltenOpenInBrowser<CR>", desc = "open output in browser"},
      { "[c", ":MoltenPrev<CR>", desc = "previous code cell" },
      { "]c", ":MoltenNext<CR>", desc = "next code cell" },
    },
    config = function()
      vim.api.nvim_set_hl(0, "MoltenCell", {link = "DiffChange"})
      vim.api.nvim_set_hl(0, "MoltenVirtualText", {link = "MoreMsg"})
    end
  },
}
