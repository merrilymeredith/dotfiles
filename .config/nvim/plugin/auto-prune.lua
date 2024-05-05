-- Prune old swap, backup, and undo files at startup

local fn, fs = vim.fn, vim.fs

local function prune_files(path, days)
  local sunset = os.time() - (days * 86400)
  path = fs.normalize(path)

  if fn.getftype(path) == "" then return end

  for fname, type in fs.dir(path) do
    local fpath = fs.normalize(path .. "/" .. fname)
    if type == "file" and fn.getftime(fpath) < sunset then
      os.remove(fpath)
    end
  end
end

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  group = vim.api.nvim_create_augroup("AutoPrune", { clear = true }),
  callback = function()
    if vim.v.vim_did_enter then return end
    if vim.go.swapfile then prune_files(vim.go.directory, 90) end
    if vim.go.backup then prune_files(vim.go.backupdir, 90) end
    if vim.go.undofile then prune_files(vim.go.undodir, 90) end
  end
})
