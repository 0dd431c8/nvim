local opt = vim.opt

-- Editing
opt.number = true
opt.relativenumber = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = -1 -- Follow shiftwidth for Tab and Backspace.
opt.shiftround = true
opt.smartindent = true
opt.undofile = true
opt.confirm = true
opt.clipboard = "unnamedplus" -- Use the system clipboard for default yank, delete, and put.

-- Native Treesitter folds; keep code expanded until explicitly folded.
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99

-- Completion and timing
opt.completeopt = { "menu", "menuone", "noselect", "popup" }
opt.wildmode = "longest:full,full"
opt.updatetime = 250
opt.timeoutlen = 500

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Windows and appearance
opt.cmdheight = 0 -- Show the command line only while it is in use.
opt.showcmd = false
opt.ruler = false -- Lualine displays the cursor position.
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.wrap = false -- Prose filetypes enable wrapping in after/ftplugin/.
opt.list = true
opt.listchars:append({ tab = "  " }) -- Keep tabs blank outside the active indent guide.

-- Keep native defaults for EditorConfig, showmode, swapfile, hidden,
-- autoread, autoindent, and incsearch.
