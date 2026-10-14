return {
  {
    "aznhe21/actions-preview.nvim",
    lazy = true,
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {
      backend = { "telescope" },
      diff = { algorithm = "patience", ctxlen = 3 },
      telescope = {
        sorting_strategy = "ascending",
        layout_strategy = "vertical",
        layout_config = {
          width = 0.85,
          height = 0.8,
          prompt_position = "top",
          preview_height = 0.6,
          preview_cutoff = 10,
        },
        winblend = 0,
        border = true,
        mappings = {
          i = {
            ["<Esc>"] = function(buf)
              require("telescope.actions").close(buf)
            end,
          },
        },
      },
    },
  },
}
