
local map = vim.keymap
local opts = {noremap = true, silent = true}

map.set("n", "<F2>", ":20Lexplore<CR>", opts)
map.set("n", "<F3>", "n", opts)
map.set("n", "<S-F3>", "N", opts)
map.set("",  "<F4>", ":let v:hlsearch = !v:hlsearch<CR>", opts)
map.set("n", "<F5>", ":UndotreeToggle<CR>", opts)
map.set("n", "<F8>", ":TagbarToggle<CR>", opts)

-- Allow :noh even in insert mode
map.set("i", "<F4>", "<C-O><F4>")

-- cover for search habit
map.set("c", "<F3>", "<CR>", opts)

-- change to file's directory
map.set("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>", opts)

-- window switching
map.set("n", "<C-h>", "<C-w>h", opts)
map.set("n", "<C-j>", "<C-w>j", opts)
map.set("n", "<C-k>", "<C-w>k", opts)
map.set("n", "<C-l>", "<C-w>l", opts)
map.set("n", "<C-\\>", "<C-w>p", opts)

-- buffer switching
map.set("n", "gb", "<C-^>", opts)
map.set("n", "gB", ":ls<CR>:b ", {noremap = true})

-- Select last paste, in the same mode it was pasted in
map.set("n", "gV", "'`[' . strpart(getregtype(), 0, 1) . '`]'", {noremap=true, expr=true})

-- Use ltag over tselect
map.set("n", "g<C-]>", ":exe 'ltag ' . expand('<cword>') | lopen<CR>", opts)

-- clear all interestingwords with \\k since \K is ri.vim
map.set("n", "<leader><leader>k", ":call UncolorAllWords()<CR>", opts)

-- mark line
map.set("n", "<leader>l", "V<leader>k", opts)

-- use Grep for a recursive *
map.set("n", "g*", ":Grep<CR>", opts)

-- K: doc, gKK: doc current filename
map.set("n", "gKK", ":call ViewDoc('doc', expand('%:p'))<CR>", opts)

-- Tabular shortcuts
map.set("n", "<leader>ta", ":Tabularize first_arrow<CR>", opts)
map.set("n", "<leader>te", ":Tabularize first_eq<CR>", opts)
map.set("n", "<leader>tc", ":Tabularize first_colon<CR>", opts)
map.set("n", "<leader>tm", ":Tabularize methods<CR>", opts)

map.set("n", "<leader>a", ":call vimrc#AutoFmtToggle()<CR>", opts)

-- LSP features
map.set('n', '<leader>d', vim.diagnostic.open_float, opts)
map.set('n', '[d', vim.diagnostic.goto_prev, opts)
map.set('n', ']d', vim.diagnostic.goto_next, opts)
map.set('n', '<leader>ld', vim.diagnostic.setloclist, opts)

vim.api.nvim_create_augroup("lsp_attach", {})

vim.api.nvim_create_autocmd("LspAttach", {
  group = "lsp_attach",
  callback = function(args)
    local bufnr = args.buf
    local bufopts = { noremap=true, silent=true, buffer=bufnr }

    map.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    map.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    map.set('n', 'K', vim.lsp.buf.hover, bufopts)
    map.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    map.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    map.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    map.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    map.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    map.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    map.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    map.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    map.set('n', 'gr', vim.lsp.buf.references, bufopts)
    map.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  end,
})

