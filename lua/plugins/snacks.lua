local root = require("config.root")

return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      picker = {
        enabled = true,
        sources = {
          files = { hidden = true },
          grep = { hidden = true },
          explorer = { hidden = true, layout = { preset = "sidebar" } },
        },
      },
      explorer = { enabled = true, replace_netrw = true },
      lazygit = { enabled = true },
    },
    keys = {
      {
        "<leader>ff",
        function()
          Snacks.picker.files({ cwd = root() })
        end,
        desc = "Find project files",
      },
      {
        "<leader>fF",
        function()
          Snacks.picker.files({ cwd = vim.fn.getcwd() })
        end,
        desc = "Find files in cwd",
      },
      {
        "<leader>fb",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Find buffers",
      },
      {
        "<leader>fr",
        function()
          Snacks.picker.recent()
        end,
        desc = "Recent files",
      },
      {
        "<leader>sg",
        function()
          Snacks.picker.grep({ cwd = root() })
        end,
        desc = "Grep project",
      },
      {
        "<leader>sG",
        function()
          Snacks.picker.grep({ cwd = vim.fn.getcwd() })
        end,
        desc = "Grep cwd",
      },
      {
        "<leader>sw",
        function()
          Snacks.picker.grep_word({ cwd = root() })
        end,
        mode = { "n", "x" },
        desc = "Search word or selection",
      },
      {
        "<leader>sh",
        function()
          Snacks.picker.help()
        end,
        desc = "Search help",
      },
      {
        "<leader>sk",
        function()
          Snacks.picker.keymaps()
        end,
        desc = "Search keymaps",
      },
      {
        "<leader>e",
        function()
          Snacks.explorer({ cwd = root() })
        end,
        desc = "Project explorer",
      },
      {
        "<leader>E",
        function()
          Snacks.explorer({ cwd = vim.fn.getcwd() })
        end,
        desc = "Explorer in cwd",
      },
      {
        "<leader>gg",
        function()
          Snacks.lazygit({ cwd = root() })
        end,
        desc = "LazyGit",
      },
    },
  },
}
