local autocmd = require("config.util").autocmd
local cmd = vim.cmd
local fn = vim.fn

local g = vim.api.nvim_create_augroup("vimrc", { clear = true })

-- >> neovim specific
-- Always start terminals in insert/terminal mode
autocmd(g, "TermOpen", "*", function(_) cmd.startinsert() end)

-- neovim's autoread doesn't do this by default.
autocmd(g, "FocusGained", "*", function(_) cmd.checktime() end)

-- >> autowriteall improvment
-- Stopinsert on leave, or autowriteall doesn't work.
autocmd(g, { "WinLeave", "FocusLost" }, "*", function(_)
  if fn.pumvisible() == 0 then
    cmd.stopinsert()
  end
  pcall(cmd.wa)
end)

-- >> auto mkpath on write
autocmd(g, "BufWritePre", "*", function(ctx)
  if vim.bo[ctx.buf].buftype == "" and not string.match(ctx.file, "^[%w]+:") then
    fn.mkdir(fn.fnamemodify(ctx.file, ":p:h"), "p")
  end
end)

-- >> auto session ?

-- >> jump to last position on open
local nojump = vim.regex([[mail\|commit\|rebase]])
assert(nojump, "Couldn't compile nojump regexp?")

autocmd(g, "BufReadPost", "*", function(_)
  if nojump:match_str(vim.bo.filetype or "") then
    return
  end

  local lastpos = fn.line([['"]])
  if lastpos >= 1 and lastpos <= fn.line("$") then
    vim.cmd([[normal! g`"]])
  end
end)

-- >> simple highlight conflict markers
autocmd(g, "BufReadPost", "*", function(_)
  fn.matchadd("Error", [[\m^\([<>|]\)\{7} \@=\|^=\{7}$]])
end)
