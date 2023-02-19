local g = vim.g

-- >> Undotree
g.undotree_SplitWidth = 45
g.undotree_SetFocusWhenToggle = 1
g.undotree_ShortIndicators = 1
g.undotree_DiffCommand = "diff -dp -U 1"

-- >> Tagbar
g.tagbar_autoclose = 1
g.tagbar_autofocus = 1
g.tagbar_compact = 1
g.tagbar_width = 30

return {
  "editorconfig/editorconfig-vim",

  "tpope/vim-unimpaired",
  "tomtom/tcomment_vim",
  "tpope/vim-endwise",
  "godlygeek/tabular",
  {"mbbill/undotree", cmd = "UndotreeToggle"},

  "tpope/vim-vinegar",
  "kshenoy/vim-signature",
  {"majutsushi/tagbar", cmd = "TagbarToggle"},

  {
    "RRethy/vim-illuminate",
    event = {"BufReadPost", "BufNewFile"},
    opts = {
      delay = 250,
      large_file_cutoff = 15000,
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
      vim.cmd([[
        hi! IlluminatedWordRead ctermfg=0 ctermbg=11 guifg=#f0a0c0 guibg=#302028
        hi! IlluminatedWordText ctermfg=0 ctermbg=11 guifg=#f0a0c0 guibg=#302028
        hi! IlluminatedWordWrite ctermfg=0 ctermbg=11 cterm=underline guifg=#f0a0c0 guibg=#302028 gui=underline
      ]])
    end,
  },
}
