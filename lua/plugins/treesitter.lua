return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      parsers = {
        "lua",
        "luadoc",
        "vim",
        "vimdoc",
        "query",
        "markdown", -- Render hover and signature documentation with syntax colors.
        "markdown_inline",
        "javascript",
        "typescript",
        "tsx",
        "go",
        "gomod",
        "gosum",
        "gowork",
      },
    },
    config = function(_, opts)
      require("config.treesitter").setup(opts)
    end,
  },
}
