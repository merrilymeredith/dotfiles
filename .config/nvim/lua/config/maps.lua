
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

map.set("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>", opts)

map.set("n", "<C-h>", "<C-w>h", opts)
map.set("n", "<C-j>", "<C-w>j", opts)
map.set("n", "<C-k>", "<C-w>k", opts)
map.set("n", "<C-l>", "<C-w>l", opts)
map.set("n", "<C-\\>", "<C-w>p", opts)

map.set("n", "gb", "<C-^>", opts)
map.set("n", "gB", ":ls<CR>:b ", {noremap = true})
