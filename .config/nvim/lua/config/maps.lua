
local map = vim.keymap
local opts = {noremap = true, silent = true}

map.set("n", "<F2>", ":20Lexplore<CR>", opts)
map.set("n", "<F3>", "n", opts)
map.set("n", "<S-F3>", "N", opts)
map.set("",  "<F4>", ":let v:hlsearch = !v:hlsearch<CR>", opts)
-- map.set("n", "<F5>", ":UndotreeToggle<CR>", opts)
-- map.set("n", "<F8>", ":TagbarToggle<CR>", opts)

-- Allow :noh even in insert mode
map.set("i", "<F4>", "<C-O><F4>")

-- cover for search habit
map.set("c", "<F3>", "<CR>")

map.set("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>")

