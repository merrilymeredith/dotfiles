vim.diagnostic.config({
  float = {
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    focusable = false,
    header = "",
    max_width = 55,
    source = "if_many",
    severity = { max = vim.diagnostic.severity.WARN },
  },
  severity_sort = true,
  virtual_lines = { severity = vim.diagnostic.severity.ERROR },
})

vim.api.nvim_create_autocmd("LspAttach", {
  once = true,
  group = "lsp_attach",
  callback = function(args)
    -- Some options are more chill in text mode, this unchills them if a LSP is
    -- in play.  Note they're global and this is a non-once aucmd
    vim.opt.number = true
    vim.opt.updatetime = 250

    vim.api.nvim_create_autocmd("CursorHold", {
      group = vim.api.nvim_create_augroup("lsp_buf_diags", { clear = true }),
      buffer = args.buf,
      callback = function(_) vim.diagnostic.open_float() end,
    })
  end,
})
