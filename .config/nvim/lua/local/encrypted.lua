local util = require("config.util")

local safe_filter_file = util.safe_filter_file

local g = vim.api.nvim_create_augroup("encrypted", { clear = true })
local filepattern = { "*.gpg", "*.gpg.*" }

local function autocmd(event, opts)
  util.autocmd(g, event, filepattern, opts)
end

autocmd({ "BufReadPre", "FileReadPre" }, {
  command = [[ setl noswapfile noundofile nobackup viminfo= ]]
})

autocmd("BufReadPost", function(_)
  safe_filter_file("gpg -d")
end)

autocmd("BufWritePre", function(_)
  safe_filter_file("gpg -se -a --default-recipient-self")
end)

autocmd("BufWritePost", { command = [[ silent undo ]] })
