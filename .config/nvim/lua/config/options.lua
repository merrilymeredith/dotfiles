vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

local o = vim.opt

-- Editing
o.expandtab = true
o.shiftround = true
o.shiftwidth = 2
o.formatexpr = "v:lua.require'conform'.formatexpr({'timeout_ms':4000})"

-- Display
o.breakindent = true
o.breakindentopt = "min:66,shift:2"
o.conceallevel = 3
o.diffopt:append("algorithm:patience")
o.fillchars = "fold: ,vert:│"
o.linebreak = true
o.listchars = "tab:⇥·,trail:◼,nbsp:◻,extends:»,precedes:«"
o.number = false
o.pumheight = 10
o.showbreak = "» "
o.termguicolors = true
o.signcolumn = "number"
o.winminwidth = 5

-- Behavior
o.autowriteall = true
o.backup = true
o.completeopt = { "menu", "menuone", "noselect" }
o.hidden = false
o.ignorecase = true
o.scrolloff = 15
o.sessionoptions = { "buffers", "curdir", "localoptions" }
o.sidescrolloff = 10
o.smartcase = true
o.splitbelow = true
o.splitright = true
o.undofile = true
o.wildignorecase = true

-- Paths
o.backupdir:remove(".")
o.tags:append({ ".tags", "./.tags;" })
o.wildignore = "*~,*.o,*.pyc,.git/*,hg/*,.svn/*"

if vim.fn.executable("ag") then
  o.grepprg = "ag --vimgrep"
  o.grepformat = { "%f:%l:%c:%m", "%f" }
end

-- if a venv for pynvim and jupyter client has been created, use it
if vim.uv.fs_stat(vim.fn.expand("~/.venvs/neovim")) then
  vim.g.python3_host_prog = vim.fn.expand("~/.venvs/neovim/bin/python3")
end
