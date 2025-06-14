return {
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        mail = { "pandoc_markdown" },
        markdown = { "pandoc_markdown" },
        perl = { "perltidy" },
        ruby = { "standardrb", "rubocop", stop_after_first = true },
        sh = { "shfmt" },
        sql = { "pg_format" },
        -- LSP-handled:
        -- elixir = { "mix" },
        -- go = { "goimports", "gofumpt" },
      },
      formatters = {
        pandoc_markdown = {
          command = "pandoc",
          args = { "-f", "markdown", "-t", "markdown" },
          stdin = true,
        },
        shfmt = {
          prepend_args = function(_, ctx)
            return { "-i", vim.bo[ctx.buf].shiftwidth }
          end,
        },
        perltidy = {
          prepend_args = function(_, ctx)
            return { "-i", vim.bo[ctx.buf].shiftwidth }
          end,
        },
      },
      format_on_save = function(bufnr)
        local autoformat_filetypes = { "elixir", "go" }

        if not vim.tbl_contains(autoformat_filetypes, vim.bo[bufnr].filetype) then
          return
        end

        return {
          timeout_ms = 500,
          lsp_format = "prefer",
        }
      end
    },
  },
}
