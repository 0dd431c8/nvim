return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = { "catppuccin", "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<Tab>", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
      { "]b", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
      { "[B", "<cmd>BufferLineMovePrev<CR>", desc = "Move buffer left" },
      { "]B", "<cmd>BufferLineMoveNext<CR>", desc = "Move buffer right" },
      { "<leader>bb", "<cmd>BufferLinePick<CR>", desc = "Pick buffer" },
      { "<leader>bp", "<cmd>BufferLineTogglePin<CR>", desc = "Toggle buffer pin" },
      { "<leader>bd", "<cmd>bdelete<CR>", desc = "Delete buffer" },
    },
    opts = function()
      return {
        highlights = require("catppuccin.special.bufferline").get_theme(),
        options = {
          mode = "buffers",
          diagnostics = "nvim_lsp",
          separator_style = "thin",
          show_buffer_close_icons = false,
          show_close_icon = false,
          -- Mouse actions must respect unsaved changes, just like the delete mapping.
          close_command = "bdelete %d",
          right_mouse_command = "bdelete %d",
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "left",
              separator = true,
            },
          },
        },
      }
    end,
  },
}
