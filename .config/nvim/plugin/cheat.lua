local api, fn = vim.api, vim.fn

api.nvim_create_user_command(
  "Cheat",
  function(ctx)
    local query = ctx.args

    local buf = api.nvim_create_buf(false, true)
    vim.bo[buf].bufhidden = "unload"
    api.nvim_buf_set_keymap(buf, "n", "q", "<C-w>q", {})

    api.nvim_open_win(buf, true, { split = "above" })

    if query == "" then
      fn.jobstart("cht.sh --shell", { term = true })
    else
      fn.jobstart("cht.sh " .. query, { term = true })
      vim.cmd.stopinsert()
    end
  end,
  { nargs = "*" }
)
