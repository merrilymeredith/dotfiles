local diag_threshold = "WARN"

vim.diagnostic.config({
  underline = { severity = {min = diag_threshold} },
  virtual_text = { true, severity = {min = diag_threshold} },
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

    vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
      group = "lsp_diags",
      buffer = bufnr,
      callback = function(opts, bufnr, line_nr, client_id)
        bufnr = bufnr or 0
        line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
        opts = opts or {['lnum'] = line_nr}

        local line_diagnostics = vim.diagnostic.get(bufnr, {lnum = line_nr, severity = {max = diag_threshold}})
        if vim.tbl_isempty(line_diagnostics) then return end

        local diagnostic_message = ""
        for i, diagnostic in ipairs(line_diagnostics) do
          diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
          print(diagnostic_message)
          if i ~= #line_diagnostics then
            diagnostic_message = diagnostic_message .. "\n"
          end
        end
        vim.api.nvim_echo({{diagnostic_message, "Normal"}}, false, {})
      end,
    })

  end
})
