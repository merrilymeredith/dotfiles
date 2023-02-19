local g = vim.g

-- >> Perl
g.perl_include_pod = 1
g.perl_sub_signatures = 1
g.perl_sync_dist = 300
g.perl_compiler_force_warnings = 0

return {
  'Shougo/vinarise.vim',
  'asciidoc/vim-asciidoc',
  {'vim-perl/vim-perl', branch = 'dev'},
  'yko/mojo.vim',
}
