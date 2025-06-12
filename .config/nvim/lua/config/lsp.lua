vim.diagnostic.config({
  float = {
    border = "solid",
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    focusable = false,
    header = "",
    max_width = 55,
    source = "if_many",
  },
  severity_sort = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = "lsp_attach",
  callback = function(args)
    vim.opt.number = true
    vim.opt.updatetime = 250

    vim.api.nvim_create_autocmd("CursorHold", {
      group = vim.api.nvim_create_augroup("lsp_buf_diags", { clear = true }),
      buffer = args.buf,
      callback = function(_) vim.diagnostic.open_float() end,
    })
  end,
})
