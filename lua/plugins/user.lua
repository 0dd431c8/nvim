-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },
  {
    "alephium/ralph-lsp",
    init = function()
      -- expose directly from inside nvim
      local path = vim.env.PATH
      path = path .. ":" .. "/home/odd/Downloads/ralph-lsp-0.1.0-SNAPSHOT/bin"
      vim.env.PATH = path
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
}
