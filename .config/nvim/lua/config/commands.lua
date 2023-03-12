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
