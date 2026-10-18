local textobject_keys = {}

for key, capture in pairs({
  af = "@function.outer",
  ["if"] = "@function.inner",
  aa = "@parameter.outer",
  ia = "@parameter.inner",
}) do
  textobject_keys[#textobject_keys + 1] = {
    key,
    function()
      require("nvim-treesitter-textobjects.select").select_textobject(capture, "textobjects")
    end,
    mode = { "x", "o" },
    desc = "Select " .. capture,
  }
end

for key, method in pairs({
  ["]f"] = "goto_next_start",
  ["[f"] = "goto_previous_start",
  ["]F"] = "goto_next_end",
  ["[F"] = "goto_previous_end",
}) do
  textobject_keys[#textobject_keys + 1] = {
    key,
    function()
      require("nvim-treesitter-textobjects.move")[method]("@function.outer", "textobjects")
    end,
    mode = { "n", "x", "o" },
    desc = method:gsub("_", " ") .. " of function",
  }
end

return {
  {
    "andymass/vim-matchup",
    lazy = false,
    main = "match-up",
    opts = {
      treesitter = { stopline = 500 },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = { max_lines = 3 },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      select = { lookahead = true },
      move = { set_jumps = true },
    },
    keys = textobject_keys,
  },
}
