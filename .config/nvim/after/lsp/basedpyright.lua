--- @type vim.lsp.Config
return {
  handlers = {
    ['textDocument/publishDiagnostics'] = function(_, params, ctx)
      -- otter.nvim is an adapter to run regular lsps on the code cells of
      -- journals. it makes hidden buffers of all the code of each language.
      -- filter out warnings for stuff that is normal (an "unused" last
      -- expression is still displayed)
      if string.match(params.uri, "%.otter.py") then
        params.diagnostics = vim.tbl_filter(function(it)
          return it.code ~= "reportUnusedCallResult" and
            it.code ~= "reportUnusedExpression"
        end, params.diagnostics)
      end

      return vim.lsp.diagnostic.on_publish_diagnostics(_, params, ctx)
    end,
  }
}

