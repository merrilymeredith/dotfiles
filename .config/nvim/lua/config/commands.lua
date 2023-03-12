local command = vim.api.nvim_create_user_command
local calias = require("config.util").calias
local cmd = vim.cmd
local fn = vim.fn

command("Hgcd", function()
  local root = fn.systemlist("hg root 2>/dev/null")[1]
  if vim.v.shell_error == 0 then
    cmd.cd(root)
  end
end, {})

command("Gcd", function()
  local root = fn.systemlist("git rev-parse --show-toplevel 2>/dev/null")[1]
  if vim.v.shell_error == 0 then
    cmd.cd(root)
  end
end, {})

command("Grep", function(ctx)
  local pattern = ctx.fargs[1] or fn.expand("<cword>")
  local grepcmd = table.concat({
    vim.o.grepprg,
    fn.shellescape(pattern),
    table.concat(vim.list_slice(ctx.fargs, 2, #ctx.fargs), " "),
  }, " ")

  fn.setqflist({}, " ", { title = grepcmd, lines = fn.systemlist(grepcmd) })
  fn.setreg("/", [[\V]] .. pattern)
  cmd.copen()
  cmd.cfirst()
end, { nargs = "*", complete = "file" })

calias("Q", "q")
calias("Qa", "qa")
calias("W", "w")
calias("grep", "Grep")

calias("gcd", "Gcd")
calias("hgcd", "Hgcd")

-- Switch these to default to stay in one window + buffer
calias("doc", "ViewDoc!")
calias("help", "ViewDocHelp!")
calias("man", "ViewDocMan!")
calias("perldoc", "ViewDocPerl!")
