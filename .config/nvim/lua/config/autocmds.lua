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
  if not fn.pumvisible() then
    fn.stopinsert()
  end
end)

-- write all on leave
autocmd(g, "FocusLost", "*", cmd.wa)

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
autocmd(g, "BufReadPost", "*", function()
  local ft = vim.bo.filetype
  if ft == "mail" or string.match(ft, "^git") or string.match(ft, "^hg") then
    return ""
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

-- >> nicer quickfix
autocmd(g, "BufReadPost", "quickfix", {
  callback = function(ctx)
    -- simplify noisy :ltag output
    if string.match(vim.w.quickfix_title, "^ltag") then
      -- Hide ctags regex anchors
      fn.matchadd("Conceal", [[\m|\zs\^\\V\|\\$\ze|]])

      -- highlight match in line. if tagname begins with / the rest is a \v
      -- regex. match must be between vertical bars, so its the 2nd column.
      local tagmatch = string.gsub(vim.fn.gettagstack().items[1].tagname, "^/", "\\v", 1)
      fn.matchadd("Underlined", [[\m|.*\zs]] .. tagmatch .. [[\m\ze.*|]])
    end

    -- easy close
    vim.keymap.set("n", "q", "<C-w>q", { buffer = true })
  end,
})
