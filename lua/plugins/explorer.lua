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
          local tree = require("nvim-tree.api").tree
          if vim.bo.filetype == "NvimTree" then
            tree.focus()
            return
          end
          local buf = vim.api.nvim_get_current_buf()
          local path = root()
          tree.open({ path = path })
          if require("nvim-tree.core").get_cwd() ~= path then
            tree.change_root(path)
          end
          tree.find_file({ buf = buf, focus = true })
        end,
        desc = "Reveal active file in project explorer",
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
