return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      parsers = {
        "regex", -- Syntax highlighting in Snacks search prompts.
        "lua",
        "luadoc",
        "vim",
        "vimdoc",
        "query",
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
