-- elixir-tools installs elixir-ls in directories by version and otp version in
-- order to match up the right version with your app.  it doesn't expose what
-- path is in use except for how it launches elixir-ls, so we can scrape it out
-- of there.  it's not clear to me how nvim-dap would handle an adapter's
-- definition changing, so i wouldn't expect this to work well with more than
-- one version in the same nvim session.

local function find_elixir_lsp_dap_cmd(bufnr)
  -- deprecated 0.10.0: s/get_active_clients/get_clients/; s/idname/name/
  local elixir_lsp = vim.lsp.get_active_clients({
    idname = "ElixirLS",
    bufnr = bufnr or vim.api.nvim_get_current_buf(),
  })[1]

  if elixir_lsp then
    local elixir_lsp_cmd = elixir_lsp.config.cmd[1]
    local dap_cmd = elixir_lsp_cmd:gsub("language_server.", "debug_adapter.")

    return dap_cmd
  end
end

local dap = require("dap")

dap.adapters.mix_task = function(callback, _)
  local dap_cmd = find_elixir_lsp_dap_cmd()

  if dap_cmd then
    callback({
      type = 'executable',
      command = find_elixir_lsp_dap_cmd(),
      args = {},
    })
  end
end

dap.configurations.elixir = {
  {
    type = "mix_task",
    name = "mix test",
    task = 'test',
    taskArgs = { "--trace" },
    request = "launch",
    startApps = true,
    projectDir = "${workspaceFolder}",
    requireFiles = {
      "test/**/test_helper.exs",
      "test/**/*_test.exs"
    }
  },
  {
    type = "mix_task",
    name = "phx.server",
    request = "launch",
    task = "phx.server",
    projectDir = "${workspaceFolder}"
  },
}
