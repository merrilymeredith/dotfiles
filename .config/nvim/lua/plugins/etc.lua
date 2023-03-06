local g = vim.g

g.vimwiki_auto_chdir = 1
g.vimwiki_auto_header = 1
g.vimwiki_ext2syntax = { [vim.type_idx] = vim.types.dictionary }

g.vimwiki_list = {
  {
    path = "~/vimwiki/",
    auto_tags = 1,
    auto_toc = 1,
    automatic_nested_syntaxes = 1,
  },
  {
    path = "~/Documents/SpiderOak Hive/vimwiki",
    auto_tags = 1,
    auto_toc = 1,
    automatic_nested_syntaxes = 1,
  },
}

return {
  "vimwiki/vimwiki",
}
