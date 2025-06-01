local api, fn = vim.api, vim.fn

local function tig(ctx)
  local cmd = ctx.fargs
  local orig_number = vim.wo.number

  local buf = api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "delete"

  api.nvim_set_current_buf(buf)
  vim.wo.number = false

  table.insert(cmd, 1, "tig")
  fn.jobstart(cmd, {
    on_exit = function()
      vim.wo.number = orig_number
      vim.cmd.buffer("#")
    end,
    term = true,
  })
end

api.nvim_create_user_command("Tig", tig, { nargs = "*", complete = "file" })

api.nvim_create_user_command("TigBlame", function()
  tig({ fargs = { "blame", "+" .. fn.line("."), "--", fn.expand("%") } })
end, {})

api.nvim_create_user_command("TigLog", function()
  tig({ fargs = { "log", "-p", "--", fn.expand("%") } })
end, {})
