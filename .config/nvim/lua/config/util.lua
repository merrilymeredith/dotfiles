local M = {}

local api = vim.api
local fn = vim.fn

function M.calias(abbrev, expand)
  vim.cmd.cnoreabbrev(
    string.format(
      [[<expr> %s (getcmdtype() == ":" && getcmdline() == "%s") ? "%s" : "%s"]],
      abbrev,
      abbrev,
      expand,
      abbrev
    )
  )
end

function M.autocmd(group, event, pattern, opts)
  if type(opts) == "function" then
    local func = opts
    opts = {
      callback = function(_)
        func()
      end,
    }
  end

  api.nvim_create_autocmd(
    event,
    vim.tbl_extend("keep", opts, {
      group = group,
      pattern = pattern,
    })
  )
end

function M.safe_filter_file(cmd)
  local errorfile = fn.tempname()
  vim.cmd([[silent %!]] .. cmd .. [[ 2>]] .. fn.shellescape(errorfile))
  if vim.v.shell_error ~= 0 then
    vim.cmd("silent undo")
    api.nvim_err_write(io.open(errorfile):read("*a"))
  end
  fn.delete(errorfile)
end

return M
