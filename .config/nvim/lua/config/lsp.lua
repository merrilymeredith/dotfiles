vim.diagnostic.config({
  float = {
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    focusable = false,
    header = "",
    max_width = 72,
    source = "if_many",
    style = "minimal",
  },
  severity_sort = true,
  underline = true,
  virtual_text = false,
})

-- Some options are more chill in text mode, this unchills them if a LSP is in
-- play.  Note they're global
vim.api.nvim_create_autocmd("LspAttach", {
  once = true,
  group = "lsp_attach",
  callback = function()
    vim.opt.number = true
    vim.opt.updatetime = 250
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = "lsp_attach",
  callback = function(args)
    vim.api.nvim_create_autocmd("CursorHold", {
      group = vim.api.nvim_create_augroup("lsp_buf_diags", { clear = true }),
      buffer = args.buf,
      callback = vim.diagnostic.open_float,
    })
  end,
})

-- Format on write, but only certain languages
local autoformat_filetypes = { elixir = true, go = true }

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("lsp_autoformat", { clear = true }),
  callback = function()
    if autoformat_filetypes[vim.bo.filetype] then
      vim.lsp.buf.format({ timeout_ms = 100 })
    end
  end,
})
