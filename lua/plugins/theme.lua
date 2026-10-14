return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1100, -- Apply the palette before the other UI plugins initialize.
    opts = {
      flavour = "mocha",
      transparent_background = false,
      term_colors = true,
      auto_integrations = true,
      styles = {
        comments = { "italic" },
        keywords = { "bold" },
        functions = { "bold" },
        types = { "bold" },
        booleans = { "bold" },
      },
      integrations = {
        rainbow_delimiters = true,
        nvimtree = true,
        telescope = { enabled = true },
        blink_cmp = { style = "bordered" },
        lualine = {
          mocha = function(colors)
            -- Match the preview's lavender mode badge and lighter statusline.
            local overrides = {}
            for _, mode in ipairs({
              "normal",
              "insert",
              "terminal",
              "command",
              "visual",
              "replace",
              "inactive",
            }) do
              overrides[mode] = {
                b = { fg = colors.overlay1, bg = colors.surface0 },
                c = { fg = colors.text, bg = colors.surface0 },
              }
            end
            overrides.normal.a = { bg = colors.lavender }
            return overrides
          end,
        },
      },
      custom_highlights = function(colors)
        return {
          -- Use more of the palette without changing its base colors.
          Comment = { fg = colors.lavender, style = { "italic" } },
          ["@comment"] = { fg = colors.lavender, style = { "italic" } },
          ["@variable"] = { fg = colors.pink },
          ["@variable.parameter"] = { fg = colors.flamingo },
          ["@variable.member"] = { fg = colors.teal },
          ["@property"] = { fg = colors.teal },
          ["@constant"] = { fg = colors.yellow },
          ["@module"] = { fg = colors.rosewater },
          ["@operator"] = { fg = colors.sky },
          ["@punctuation.bracket"] = { fg = colors.lavender },
          ["@punctuation.delimiter"] = { fg = colors.rosewater },
          CursorLineNr = { fg = colors.peach, style = { "bold" } },
          FloatBorder = { fg = colors.mauve },
          WinSeparator = { fg = colors.sapphire },
          Search = { fg = colors.base, bg = colors.yellow, style = { "bold" } },
          IncSearch = { fg = colors.base, bg = colors.peach, style = { "bold" } },
          CurSearch = { fg = colors.base, bg = colors.pink, style = { "bold" } },
          BlinkCmpMenuBorder = { fg = colors.mauve },
          BlinkCmpMenuSelection = { bg = colors.surface1 },
          BlinkCmpLabelMatch = { fg = colors.peach, style = { "bold" } },
        }
      end,
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-nvim")
    end,
  },
}
