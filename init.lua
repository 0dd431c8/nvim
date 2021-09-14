-- load all plugins
require "pluginList"
require "misc-utils"

require "top-bufferline"
require "statusline"

require("colorizer").setup()
-- require("neoscroll").setup() -- smooth scroll

-- lsp stuff
require "nvim-lspconfig"
require "compe-completion"

local cmd = vim.cmd
local g = vim.g

g.mapleader = " "
g.auto_save = 0

-- colorscheme related stuff
cmd "syntax on"

-- cmd "colorscheme everforest"
--[[ require('rose-pine').set()
vim.g.rose_pine_variant = 'moon' ]]
--[[ local base16 = require "base16"
base16(base16.themes["eighties"], true) ]]

local catppuccino = require("catppuccino")
catppuccino.load("dark_catppuccino")

--[[ g.material_style = 'palenight'
g.material_contrast = false
g.material_borders = true
g.material_disable_background = false
require('material').set() ]]

--[[ g.sonokai_style = "andromeda"
g.sonokai_enable_italic = 1
g.sonokai_disable_italic_comment = 1
cmd "colorscheme sonokai" ]]

require "colors"

-- blankline

g.indentLine_enabled = 1
g.indent_blankline_char = "▏"

g.indent_blankline_filetype_exclude = {"help", "terminal"}
g.indent_blankline_buftype_exclude = {"terminal"}

g.indent_blankline_show_trailing_blankline_indent = false
g.indent_blankline_show_first_indent_level = false

cmd "set nohlsearch"

require "treesitter-nvim"
require "mappings"

require "telescope-nvim"
require "nvimTree" -- file tree stuff
require "file-icons"

-- git signs , lsp symbols etc
require "gitsigns-nvim"
require("nvim-autopairs").setup()
require("lspkind").init()

-- hide line numbers in terminal windows
vim.api.nvim_exec([[
   au BufEnter term://* setlocal nonumber
]], false)

-- setup for TrueZen.nvim
require "zenmode"
require "whichkey"
