local command = vim.api.nvim_create_user_command
local cmd, fn = vim.cmd, vim.fn

require("config.util").calias({
  -- replace default:
  grep = "Grep",

  -- typos:
  Q = "q",
  Qa = "qa",
  W = "w",
  gcd = "Gcd",
  hgcd = "Hgcd",

  -- Make the ! versions default to stay in one window + buffer:
  doc = "ViewDoc!",
  help = "ViewDocHelp!",
  man = "ViewDocMan!",
  perldoc = "ViewDocPerl!",
})

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
  fn.setreg("/", [[\v]] .. pattern)
  cmd.copen()
  cmd.cfirst()
end, { nargs = "*", complete = "file" })

-- Remove buffers for files that are gone, old, or netrw dirs
command("PruneSession", function()
  local bufs = vim.api.nvim_list_bufs()
  for _, bufnr in ipairs(bufs) do
    local name = vim.api.nvim_buf_get_name(bufnr)
    if name then
      local type = vim.fn.getftype(name)
      if type == "" or type == "dir"
        or (os.time() - vim.fn.getftime(name)) > 2592000
      then
        vim.print("pruned: " .. name)
        vim.cmd.bwipeout(bufnr)
      end
    end
  end
  if not vim.api.nvim_buf_get_name(0) then
    vim.cmd.bprev()
  end
end, {})
