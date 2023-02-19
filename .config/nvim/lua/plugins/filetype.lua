local g = vim.g

-- >> Polyglot
g.polyglot_disabled = {'autoindent', 'sensible', 'vifm', 'perl', 'go'}

-- >> Perl
g.perl_include_pod = 1
g.perl_sub_signatures = 1
g.perl_sync_dist = 300
g.perl_compiler_force_warnings = 0

return {
  'Shougo/vinarise.vim',
  'asciidoc/vim-asciidoc',
  {'vim-perl/vim-perl', branch = 'dev'},
  'sheerun/vim-polyglot',
  'yko/mojo.vim',
}
