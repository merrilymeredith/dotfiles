local M = {}

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
    opts = { callback = function (_)
      func()
    end }
  end

  vim.api.nvim_create_autocmd(
    event,
    vim.tbl_extend("keep", opts, {
      group = group,
      pattern = pattern,
    })
  )
end

return M
