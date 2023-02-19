vim.diagnostic.config({
  virtual_text = { true, severity = "WARN", },
})

vim.api.nvim_create_autocmd("LspAttach", {
  once = true,
  callback = function(args)
    vim.opt.number = true
  end,
})
