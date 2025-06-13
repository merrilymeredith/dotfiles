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
    cond = (vim.fn.has("python3") == 1),
    build = ":UpdateRemotePlugins",
    keys = {
      { "<leader>me", ":MoltenEvaluateOperator<CR>", desc = "eval operator" },
      { "<leader>me", ":<C-u>MoltenEvaluateVisual<CR>", desc = "eval selection", mode = "v" },
      { "<leader>mr", ":MoltenReevaluateCell<CR>", desc = "re-eval cell" },
      { "<leader>md", ":MoltenDelete<CR>", desc = "forget cell" },
      { "<leader>mo", ":noautocmd MoltenEnterOutput<CR>", desc = "open output window" },
      { "<leader>mh", ":MoltenHideOutput<CR>", desc = "hide output window"},
      { "<leader>mx", ":MoltenOpenInBrowser<CR>", desc = "open output in browser"},
    },
  },
}
