local diag_virtual_min_threshold = "WARN"
local diag_float_max_threshold = "INFO"

vim.diagnostic.config({
  severity_sort = true,
  underline = { severity = {min = diag_virtual_min_threshold} },
  virtual_text = { true, severity = {min = diag_virtual_min_threshold} },
  float = { source = "if_many" },
})

-- Some options are more chill in text mode, this unchills them if a LSP is in
-- play.  Note they're global
vim.api.nvim_create_autocmd("LspAttach", {
  once = true,
  group = "lsp_attach",
  callback = function(args)
    vim.opt.number = true
    vim.opt.updatetime = 250
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = "lsp_attach",
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- enable auto diags in message area for below threshold
    vim.api.nvim_create_augroup('lsp_diags', {clear = false})
    vim.api.nvim_create_autocmd("CursorHold", {
      group = "lsp_diags",
      buffer = bufnr,
      callback = function(opts, bufnr, line_nr, client_id)
        vim.diagnostic.open_float(nil, {
          focusable = false,
          close_events = {"BufLeave", "CursorMoved", "InsertEnter", "FocusLost"},
          scope = "line",
          severity = {max = diag_float_max_threshold},
        })
      end,
    })
  end
})

-- This can be removed when mason-lspconfig gets support for standardrb
if vim.fn.executable("standardrb") == 1 then
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "ruby",
    group = vim.api.nvim_create_augroup("lsp_ruby", {clear = true}),
    once = true,
    callback = function()
      require("lspconfig").standardrb.setup({
        autostart = true,
        single_file_support = true
      })
      vim.cmd.LspStart("standardrb")
    end,
  })
end

