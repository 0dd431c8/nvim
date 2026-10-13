return {
  { "nvim-tree/nvim-web-devicons", lazy = true, opts = {} },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "catppuccin", "nvim-tree/nvim-web-devicons" },
    opts = function()
      local colors = require("catppuccin.palettes").get_palette("mocha")
      return {
        options = {
          theme = "catppuccin-mocha",
          globalstatus = true,
          component_separators = "|",
          section_separators = "",
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = {
            { "filename", path = 1, color = { fg = colors.mantle, bg = colors.maroon } },
          },
          lualine_x = { "filetype" },
          lualine_y = { "progress" },
          lualine_z = { { "location", color = { fg = colors.mantle, bg = colors.flamingo } } },
        },
        extensions = { "lazy", "mason", "quickfix" },
      }
    end,
    config = function(_, opts)
      require("lualine").setup(opts)
      vim.opt.showmode = false
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      preset = "classic",
      delay = 300,
      spec = {
        { "<leader>c", group = "Code" },
        { "<leader>f", group = "Files" },
        { "<leader>g", group = "Git" },
        { "<leader>h", group = "Hunks" },
        { "<leader>s", group = "Search" },
        { "<leader>u", group = "Toggles" },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer-local keymaps",
      },
    },
  },
}
