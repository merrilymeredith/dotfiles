local g = vim.g

-- >> Perl
g.perl_include_pod = 1
g.perl_sub_signatures = 1
g.perl_sync_dist = 300
g.perl_compiler_force_warnings = 0

return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
          "c",
          "comment",
          "eex",
          "elixir",
          "heex",
          "help",
          "lua",
          "surface",
          "vim",
        },
      })
    end,
  },
  { "Shougo/vinarise.vim", cmd = "Vinarise" },
  "asciidoc/vim-asciidoc",
  { "vim-perl/vim-perl", branch = "dev" },
  "yko/mojo.vim",
}
