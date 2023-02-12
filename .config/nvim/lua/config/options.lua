vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

local o = vim.opt

-- Editing
o.expandtab = true
o.shiftround = true
o.shiftwidth = 2

-- Display
o.breakindent = true
o.breakindentopt = "min:66,shift:2"
o.diffopt:append("algorithm:patience")
o.fillchars = "fold: ,vert:│"
o.linebreak = true
o.listchars = "tab:⇥·,trail:◼,nbsp:◻,extends:»,precedes:«"
o.showbreak = "» "
o.termguicolors = true
o.signcolumn = "number"

-- set font etc
if vim.fn.has("gui") then
  o.number = true
end

-- Behavior
o.autowriteall = true
o.ignorecase = true
o.scrolloff = 15
o.sidescrolloff = 10
o.smartcase = true
o.splitbelow = true
o.splitright = true
o.wildignorecase = true

-- Paths
o.tags:append(".tags,./.tags;")
o.wildignore = "*~,*.o,*.pyc,.git/*,hg/*,.svn/*"

vim.api.nvim_create_autocmd("LspAttach", {
  once = true,
  callback = function(args)
    vim.opt.number = true
  end,
})
