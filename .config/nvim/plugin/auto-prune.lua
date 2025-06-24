-- Prune old swap, backup, and undo files at startup

local fn, fs = vim.fn, vim.fs

local function prune_files(path, days, which_time)
  local sunset = os.time() - (days * 86400)
  path = fs.normalize(path)
  which_time = which_time or "mtime"

  if fn.getftype(path) == "" then return end

  for fname, type in fs.dir(path) do
    local fpath = fs.normalize(path .. "/" .. fname)
    if type == "file" and vim.uv.fs_stat(fpath)[which_time].sec < sunset then
      os.remove(fpath)
    end
  end
end

local function auto_prune()
    if vim.go.swapfile then prune_files(vim.go.directory, 90) end
    if vim.go.backup then prune_files(vim.go.backupdir, 90, "atime") end
    if vim.go.undofile then prune_files(vim.go.undodir, 90) end
end

if vim.v.vim_did_enter then
  auto_prune()
else
  vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    group = vim.api.nvim_create_augroup("AutoPrune", { clear = true }),
    callback = auto_prune,  })
end
