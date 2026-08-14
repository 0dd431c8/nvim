require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "jj", "<ESC>")
map("n", "K", require("pretty_hover").hover)
map("n", "gR", ":Telescope lsp_references<CR>")
map("n", "s", "<Plug>(leap-forward)")
map("n", "S", "<Plug>(leap-backward)")
