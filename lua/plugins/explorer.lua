local root = require("config.root")

return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false, -- Handle directory arguments before netrw can open them.
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    opts = {
      hijack_netrw = true,
      hijack_directories = { enable = true, auto_open = true },
      view = { width = 35 },
      filters = { dotfiles = false, git_ignored = true },
      actions = { change_dir = { enable = false } },
    },
    keys = {
      {
        "<leader>e",
        function()
          require("nvim-tree.api").tree.open({ path = root() })
        end,
        desc = "Project explorer",
      },
      {
        "<leader>E",
        function()
          require("nvim-tree.api").tree.open({ path = vim.fn.getcwd() })
        end,
        desc = "Explorer in cwd",
      },
    },
  },
}
