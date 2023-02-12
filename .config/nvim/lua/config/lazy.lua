require("lazy-bootstrap").setup({
  spec = {
    { "nanotech/jellybeans.vim",
      priority = 1000,
      config = function() vim.cmd.colorscheme("jellybeans") end },
    { import = "plugins" }
  },
  change_detection = { enabled = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
        "tutor",
      },
    },
  },
})

