local function map(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  opts.desc = desc
  vim.keymap.set(mode, lhs, rhs, opts)
end

local function mkbmap(buf)
  return function(mode, lhs, rhs, desc, opts)
    opts = opts or {}
    opts.buffer = buf
    map(mode, lhs, rhs, desc, opts)
  end
end

map("n", "<F2>", ":Neotree reveal<CR>")
map("n", "<F3>", "n")
map("n", "<S-F3>", "N")
map("", "<F4>", ":let v:hlsearch = !v:hlsearch<CR>", "Toggle Search Highlight")
map("n", "<F5>", ":UndotreeToggle<CR>")
map("n", "<F8>", ":TagbarToggle<CR>")

-- Allow :noh even in insert mode
map("i", "<F4>", "<C-O><F4>")

-- cover for search habit
map("c", "<F3>", "<CR>")

-- change to file's directory
map("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>", "Chdir to buffer dir")

-- window switching
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-\\>", "<C-w>p")

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>")
map("n", "<C-Down>", "<cmd>resize -2<cr>")
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>")
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>")

-- buffer switching
map("n", "gb", "<C-^>", "Jump to # buffer")
map("n", "gB", ":ls<CR>:b ", "List and switch buffers", { silent = false })

-- Select last paste, in the same mode it was pasted in
map("n", "gV", "'`[' . strpart(getregtype(), 0, 1) . '`]'", "", { expr = true })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

map("n", "j", "v:count == 0 ? 'gj' : 'j'", "", { expr = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", "", { expr = true })

-- Use ltag over tselect
map("n", "g<C-]>", ":exe 'ltag ' . expand('<cword>') | lopen<CR>", "List and next Tag")

-- clear all interestingwords with \\k since \K is ri.vim
map("n", "<leader><leader>k", ":call UncolorAllWords()<CR>")

-- use Grep for a recursive *
map("n", "g*", ":Grep<CR>", "Recursive keyword search")

-- K: doc, gKK: doc current filename
map("n", "gKK", ":call ViewDoc('doc', expand('%:p'))<CR>", "ViewDoc current buffer")

-- Tabular shortcuts
map({"n", "v"}, "<leader>ta", ":Tabularize first_arrow<CR>", "Align =>")
map({"n", "v"}, "<leader>te", ":Tabularize first_eq<CR>", "Align =")
map({"n", "v"}, "<leader>tc", ":Tabularize first_colon<CR>", "Align :")
map({"n", "v"}, "<leader>tm", ":Tabularize methods<CR>", "Align -> or .")

map("n", "<leader>a", function()
  local fo = vim.bo.formatoptions
  if fo:find("a") then
    vim.bo.formatoptions = fo:gsub("a", "")
    vim.print("-a")
  else
    vim.bo.formatoptions = fo .. "a"
    vim.print("+a")
  end
end, "Toggle autowrap")

-- LSP features

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
  callback = function(args)
    local bmap = mkbmap(args.buf)

    bmap("n", "<leader>ld", vim.diagnostic.setqflist, "List Diagnostics")
    bmap("n", "[d", function() vim.diagnostic.jump({count = -1}) end, "Previous Diagnostic")
    bmap("n", "]d", function() vim.diagnostic.jump({count = 1}) end, "Next Diagnostic")

    bmap("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
    bmap("n", "gd", vim.lsp.buf.definition, "Go to Definition")
    bmap("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
    bmap("n", "K", vim.lsp.buf.hover, "LSP Hover")
    bmap("i", "<C-S>", vim.lsp.buf.signature_help, "Toggle Signature Help")
    bmap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder")
    bmap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")
    bmap("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "List Workspace Folders")
    bmap("n", "<leader>D", vim.lsp.buf.type_definition, "Go to Type Definition")
    bmap("n", "crn", vim.lsp.buf.rename, "LSP Rename")
    bmap("n", "<leader>lr", vim.lsp.buf.references, "List References")
    bmap({ "n", "x" }, "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, "LSP Format")

    bmap("n", "<leader>ih", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, "Toggle Inlay Hints")

    local code_actions = require("actions-preview").code_actions
    bmap("n", "crr", code_actions, "Code Actions")
    bmap("x", "<C-R><C-R>", code_actions, "Code Actions")
    bmap("x", "<C-R>", code_actions, "Code Actions")
  end,
})

vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile"}, {
  pattern = "*.qmd",
  group = vim.api.nvim_create_augroup("quarto", {clear = true}),
  callback = function(args)
    local bmap = mkbmap(args.buf)

    local runner = require("quarto.runner")
    bmap("n", "<localleader>rc", runner.run_cell,  "run cell")
    bmap("n", "<localleader>ra", runner.run_above, "run cell and above")
    bmap("n", "<localleader>rA", runner.run_all,   "run all cells")
    bmap("n", "<localleader>rl", runner.run_line,  "run line")
    bmap("v", "<localleader>r",  runner.run_range, "run visual range")
    bmap("n", "<localleader>RA", function() runner.run_all(true) end, "run all cells of all languages")
  end
})
