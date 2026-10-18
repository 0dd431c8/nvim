local map = vim.keymap.set

map("i", "<C-a>", "<Home>", { desc = "Move to line start" })
map("i", "<C-e>", "<End>", { desc = "Move to line end" })
map("i", "<C-n>", "<Down>", { desc = "Move to next line" })
map("i", "<C-b>", "<Left>", { desc = "Move back one character" })
map("i", "<C-f>", "<Right>", { desc = "Move forward one character" })
map("i", "<C-p>", "<Up>", { desc = "Move to previous line" })

map({ "n", "i" }, "<C-s>", "<cmd>silent write<CR>", { desc = "Save buffer", silent = true })
-- Leave selection mode while writing so format-on-save covers the whole buffer.
map("x", "<C-s>", "<Esc><cmd>silent write<CR>gv", { desc = "Save buffer", silent = true })
map("s", "<C-s>", "<Esc><cmd>silent write<CR>gv<C-g>", { desc = "Save buffer", silent = true })

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlighting" })

map("x", "<", "<gv", { desc = "Indent left and keep selection" })
map("x", ">", ">gv", { desc = "Indent right and keep selection" })

map("n", "<C-h>", "<C-w>h", { desc = "Focus left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus right window" })

map("n", "<leader>-", "<cmd>split<CR>", { desc = "Split window below" })
map("n", "<leader>|", "<cmd>vsplit<CR>", { desc = "Split window right" })
map("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Open plugin manager" })

-- Neovim supplies [d and ]d for diagnostic navigation.
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Diagnostic details" })
map("n", "<leader>ud", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })
