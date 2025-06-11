vim.diagnostic.config({
  severity_sort = true,
  virtual_lines = { current_line = true },
})

vim.api.nvim_create_autocmd("LspAttach", {
  once = true,
  group = "lsp_attach",
  callback = function()
    -- Some options are more chill in text mode, this unchills them if a LSP is
    -- in play.  Note they're global and this is a once aucmd
    vim.opt.number = true
    vim.opt.updatetime = 250
  end,
})
