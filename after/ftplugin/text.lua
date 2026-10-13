vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true

local undo = "setlocal wrap< linebreak< breakindent<"
vim.b.undo_ftplugin = vim.b.undo_ftplugin and (vim.b.undo_ftplugin .. " | " .. undo) or undo
