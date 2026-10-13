return {
  {
    "mason-org/mason.nvim",
    version = "^2.0.0",
    lazy = false,
    opts = { ui = { border = "rounded" } },
    config = function(_, opts)
      require("mason").setup(opts)
      require("config.mason").ensure_installed({ "stylua", "goimports", "oxfmt" })
    end,
    keys = {
      { "<leader>cm", "<cmd>Mason<CR>", desc = "Manage language tools" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    opts = { servers = { "lua_ls", "ts_ls", "gopls", "oxlint" } },
    config = function(_, opts)
      require("config.lsp").setup(opts)
    end,
    keys = {
      { "<leader>cl", "<cmd>checkhealth vim.lsp<CR>", desc = "LSP information" },
    },
  },
  { "mason-org/mason-lspconfig.nvim", version = "^2.0.0", lazy = true },
}
