--- @type vim.lsp.Config
return {
  -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
  settings = {
    gopls = {
      analyses = {
        unusedvariable = true,
        useany = true,
      },
      hints = {
        assignVariableTypes = true,
        constantValues = true,
        rangeVariableTypes = true,
      },
      vulncheck = "Imports",
      gofumpt = true,
      staticcheck = true,
      experimentalPostfixCompletions = true,
    },
  }
}
