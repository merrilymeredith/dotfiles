local g = vim.g

require("config.options")
require("lazy-bootstrap")
require("config.maps")
require("config.lsp")
require("config.autocmds")
require("config.commands")

require("local.tig")
require("local.encrypted")

-- >> Builtin
g.netrw_altfile = 1
g.netrw_use_errorwindow = 0
