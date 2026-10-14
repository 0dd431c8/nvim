local root = require("config.root")

return {
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitCurrentFile",
      "LazyGitConfig",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    keys = {
      {
        "<leader>gg",
        function()
          require("lazygit").lazygit(root())
        end,
        desc = "LazyGit",
      },
    },
  },
}
