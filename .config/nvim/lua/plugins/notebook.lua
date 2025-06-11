vim.g.molten_auto_init_behavior = "raise"
vim.g.molten_auto_open_output = false
vim.g.molten_virt_text_output = true
vim.g.molten_wrap_output = true

-- local setup: bin/setup-jupyter-venv
-- activate "jupyter" venv before running vim,
-- :MoltenInit explicitly

-- TODO silence pyright unused warnings, hopefully only for quarto?

return {
  { "quarto-dev/quarto-nvim",
    ft = {"quarto"},
    dependencies = {
      "jmbuhr/otter.nvim",
      { "benlubas/molten-nvim", build = ":UpdateRemotePlugins" },
    },
    opts = {
      codeRunner = { default_method = "molten" },
    },
  },
}
