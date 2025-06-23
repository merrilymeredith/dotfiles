local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    {
      "rebelot/kanagawa.nvim",
      priority = 1000,
      opts = {
        keywordStyle = { italic = false },
        statementStyle = { bold = false },
        colors = {
          theme = {
            all = {
              ui = {
                bg = "none",
                bg_gutter = "none",
              },
            },
          },
        },
      },
      config = function(_, opts)
        require("kanagawa").setup(opts)
        vim.cmd("colorscheme kanagawa")
      end,
    },
    { import = "plugins" },
  },
  concurrency = 4,
  change_detection = { enabled = false },
  defaults = { version = "*" },
  lockfile = vim.fn.stdpath("state") .. "/lazy-lock.json",
  local_spec = false,  -- don't load .lazy.lua files
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
