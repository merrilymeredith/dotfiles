local autocmd = require("config.util").autocmd
local cmd = vim.cmd
local fn = vim.fn

local g = vim.api.nvim_create_augroup("vimrc", { clear = true })

-- >> neovim specific
-- Always start terminals in insert/terminal mode
autocmd(g, "TermOpen", "*", cmd.startinsert)

-- neovim's autoread doesn't do this by default.
autocmd(g, "FocusGained", "*", cmd.checktime)

-- >> autowriteall improvment
-- Stopinsert on leave, or autowriteall doesn't work.
autocmd(g, { "WinLeave", "FocusLost" }, "*", function()
  if fn.pumvisible() == 0 then
    fn.stopinsert()
  end
  cmd.wa()
end)

-- >> auto mkpath on write
autocmd(g, "BufWritePre", "*", {
  callback = function(ctx)
    if vim.bo[ctx.buf].buftype == "" and not string.match(ctx.file, "^[%w]+:") then
      fn.mkdir(fn.fnamemodify(ctx.file, ":p:h"), "p")
    end
  end,
})

-- >> auto session ?

-- >> jump to last position on open
local nojump = vim.regex([[mail\|commit\|rebase]])
assert(nojump, "Couldn't compile nojump regexp?")

autocmd(g, "BufReadPost", "*", function()
  if nojump:match_str(vim.bo.filetype or "") then
    return
  end

  local lastpos = fn.line([['"]])
  if lastpos >= 1 and lastpos <= fn.line("$") then
    vim.cmd([[normal! g`"]])
  end
end)

-- >> simple highlight conflict markers
autocmd(g, "BufReadPost", "*", function()
  fn.matchadd("Error", [[\m^\([<>|]\)\{7} \@=\|^=\{7}$]])
end)
