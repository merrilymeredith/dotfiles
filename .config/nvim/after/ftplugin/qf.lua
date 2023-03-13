local fn = vim.fn

local wininfo = fn.getwininfo(fn.win_getid())[1] or {}
local is_loc = wininfo.loclist == 1
local qftitle = wininfo.variables.quickfix_title

vim.bo.buflisted = false
vim.wo.concealcursor = "n"
vim.wo.wrap = false

-- easy close
vim.keymap.set("n", "q", "<C-w>q", { buffer = true })

if is_loc then
  -- simplify noisy :ltag output
  if qftitle and string.match(qftitle, "^ltag") then
    -- Hide ctags regex anchors
    fn.matchadd("Conceal", [[\m|\zs\^\\V\|\\$\ze|]])

    -- Hide lsp tagfunc line/col seek references
    fn.matchadd("Conceal", [[\m|\zs\\Vcall cursor(\|)\ze|]])

    -- highlight match in line. if tagname begins with / the rest is a \v
    -- regex. match must be between vertical bars, so its the 2nd column.
    local tagstack = fn.gettagstack()
    if tagstack then
      local tagmatch = string.gsub(tagstack.items[1].tagname, "^/", "\\v", 1)
      fn.matchadd("Underlined", [[\m|.*\zs]] .. tagmatch .. [[\m\ze.*|]])
    end
  end
end
