local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

map("n", "<F2>", ":Neotree reveal<CR>")
map("n", "<F3>", "n")
map("n", "<S-F3>", "N")
map("", "<F4>", ":let v:hlsearch = !v:hlsearch<CR>")
map("n", "<F5>", ":UndotreeToggle<CR>")
map("n", "<F8>", ":TagbarToggle<CR>")

-- Allow :noh even in insert mode
map("i", "<F4>", "<C-O><F4>")

-- cover for search habit
map("c", "<F3>", "<CR>")

-- change to file's directory
map("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>")

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
map("n", "gb", "<C-^>")
map("n", "gB", ":ls<CR>:b ", { silent = false })

-- Select last paste, in the same mode it was pasted in
map("n", "gV", "'`[' . strpart(getregtype(), 0, 1) . '`]'", { expr = true })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Use ltag over tselect
map("n", "g<C-]>", ":exe 'ltag ' . expand('<cword>') | lopen<CR>")

-- clear all interestingwords with \\k since \K is ri.vim
map("n", "<leader><leader>k", ":call UncolorAllWords()<CR>")

-- use Grep for a recursive *
map("n", "g*", ":Grep<CR>")

-- K: doc, gKK: doc current filename
map("n", "gKK", ":call ViewDoc('doc', expand('%:p'))<CR>")

-- Tabular shortcuts
map("n", "<leader>ta", ":Tabularize first_arrow<CR>")
map("n", "<leader>te", ":Tabularize first_eq<CR>")
map("n", "<leader>tc", ":Tabularize first_colon<CR>")
map("n", "<leader>tm", ":Tabularize methods<CR>")

map("n", "<leader>a", ":call vimrc#AutoFmtToggle()<CR>")

-- LSP features

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
  callback = function(args)
    local bufopts = { buffer = args.buf }

    map("n", "<leader>d", vim.diagnostic.open_float, bufopts)
    map("n", "<leader>ld", vim.diagnostic.setqflist, bufopts)
    map("n", "[d", function()
      vim.diagnostic.goto_prev({ float = false })
    end, bufopts)
    map("n", "]d", function()
      vim.diagnostic.goto_next({ float = false })
    end, bufopts)

    map("n", "gD", vim.lsp.buf.declaration, bufopts)
    map("n", "gd", vim.lsp.buf.definition, bufopts)
    map("n", "K", vim.lsp.buf.hover, bufopts)
    map("n", "gi", vim.lsp.buf.implementation, bufopts)
    map("i", "<C-S>", vim.lsp.buf.signature_help, bufopts)
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    map("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    map("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
    map("n", "crn", vim.lsp.buf.rename, bufopts)
    map("n", "gr", vim.lsp.buf.references, bufopts)
    map({ "n", "x" }, "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, bufopts)

    local code_actions = require("actions-preview").code_actions
    map("n", "crr", code_actions, bufopts)
    map("x", "<C-R><C-R>", code_actions, bufopts)
    map("x", "<C-R>", code_actions, bufopts)
  end,
})
