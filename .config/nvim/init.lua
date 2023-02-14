require("config.options")
require("lazy-bootstrap")
require("config.maps")
require("config.lsp")

local g = vim.g

-- >> Builtin
g.netrw_altfile = 1
g.netrw_use_errorwindow = 0

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

