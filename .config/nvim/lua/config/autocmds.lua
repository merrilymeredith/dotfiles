local cmd = vim.cmd
local fn = vim.fn

local vimrc = vim.api.nvim_create_augroup("vimrc", { clear = true })

local function autocmd(event, pattern, opts)
  vim.api.nvim_create_autocmd(
    event,
    vim.tbl_extend("keep", opts, {
      group = vimrc,
      pattern = pattern,
    })
  )
end

local function cb(func)
  return {
    callback = function(_)
      func()
    end,
  }
end

-- >> neovim specific
-- Always start terminals in insert/terminal mode
autocmd("TermOpen", "*", cb(cmd.startinsert))

-- neovim's autoread doesn't do this by default.
autocmd("FocusGained", "*", cb(cmd.checktime))

-- >> autowriteall improvment
-- Stopinsert on leave, or autowriteall doesn't work.
autocmd({ "WinLeave", "FocusLost" }, "*", {
  callback = function(_)
    if not fn.pumvisible() then
      fn.stopinsert()
    end
  end,
})

-- write all on leave
autocmd("FocusLost", "*", cb(cmd.wa))

-- >> auto mkpath on write
autocmd("BufWritePre", "*", {
  callback = function(ctx)
    if vim.bo[ctx.buf].buftype == "" and not string.match(ctx.file, "^[%w]+:") then
      fn.mkdir(fn.fnamemodify(ctx.file, ":p:h"), "p")
    end
  end,
})

-- >> auto session ?

-- >> jump to last position on open
autocmd("BufReadPost", "*", {
  callback = function(_)
    local ft = vim.bo.filetype
    if ft == "mail" or string.match(ft, "^git") or string.match(ft, "^hg") then
      return ""
    end

    local lastpos = fn.line([['"]])
    if lastpos >= 1 and lastpos <= fn.line("$") then
      vim.cmd([[normal! g`"]])
    end
  end,
})

-- >> simple highlight conflict markers
autocmd("BufReadPost", "*", {
  callback = function(_)
    fn.matchadd("Error", [[\m^\([<>|]\)\{7} \@=\|^=\{7}$]])
  end,
})

-- >> nicer quickfix
autocmd("BufReadPost", "quickfix", {
  callback = function(ctx)
    -- simplify noisy :ltag output
    if string.match(vim.w.quickfix_title, "^ltag") then
      -- Hide ctags regex anchors
      fn.matchadd("Conceal", [[\m|\zs\^\\V\|\\$\ze|]])

      -- highlight match in line. if tagname begins with / the rest is a \V
      -- regex. match must be between vertical bars, so its the 2nd column.
      local tagmatch = string.gsub(vim.fn.gettagstack().items[1].tagname, "^/", "\\V", 1)
      fn.matchadd("Underlined", [[\m|.*\zs]] .. tagmatch .. [[\m\ze.*|]])
    end

    -- easy close
    vim.keymap.set("n", "q", "<C-w>q", { buffer = true })
  end,
})
