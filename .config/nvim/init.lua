local g = vim.g

require("config.options")
require("lazy-bootstrap")
require("config.maps")
require("config.lsp")

-- >> Builtin
g.netrw_altfile = 1
g.netrw_use_errorwindow = 0

-- >> Perl
g.perl_include_pod = 1
g.perl_sub_signatures = 1
g.perl_sync_dist = 300
g.perl_compiler_force_warnings = 0

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

-- >> Viewdoc
g.viewdoc_open = "topleft new"
g.viewdoc_winwidth_max = 100
