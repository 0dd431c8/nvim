local root = require("config.root")

return {
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    opts = {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob",
          "!.git",
        },
      },
      pickers = {
        find_files = {
          find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
        },
        oldfiles = { only_cwd = false },
      },
      extensions = {
        fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("fzf")
    end,
    keys = {
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files({ cwd = root() })
        end,
        desc = "Find project files",
      },
      {
        "<leader>fF",
        function()
          require("telescope.builtin").find_files({ cwd = vim.fn.getcwd() })
        end,
        desc = "Find files in cwd",
      },
      {
        "<leader>fb",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Find buffers",
      },
      {
        "<leader>fo",
        function()
          require("telescope.builtin").oldfiles()
        end,
        desc = "Recent files",
      },
      {
        "<leader>sg",
        function()
          require("telescope.builtin").live_grep({ cwd = root() })
        end,
        desc = "Grep project",
      },
      {
        "<leader>sG",
        function()
          require("telescope.builtin").live_grep({ cwd = vim.fn.getcwd() })
        end,
        desc = "Grep cwd",
      },
      {
        "<leader>sw",
        function()
          local mode = vim.fn.mode()
          local search
          if mode == "v" or mode == "V" or mode == "\22" then
            search = table.concat(
              vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = mode }),
              "\n"
            )
          end
          require("telescope.builtin").grep_string({
            cwd = root(),
            search = search,
            additional_args = search and search:find("\n", 1, true) and { "--multiline" } or nil,
          })
        end,
        mode = { "n", "x" },
        desc = "Search word or selection",
      },
      {
        "<leader>sd",
        function()
          require("config.project_diagnostics").show()
        end,
        desc = "Project diagnostics",
      },
      {
        "<leader>sD",
        function()
          require("telescope.builtin").diagnostics({ bufnr = 0 })
        end,
        desc = "Buffer diagnostics",
      },
      {
        "<leader>sh",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "Search help",
      },
      {
        "<leader>sk",
        function()
          require("telescope.builtin").keymaps()
        end,
        desc = "Search keymaps",
      },
    },
  },
}
