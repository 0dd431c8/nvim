return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    dependencies = {
      "windwp/nvim-autopairs", -- Load pair mappings before Blink captures its fallbacks.
      { "xzbdmw/colorful-menu.nvim", opts = {} },
    },
    opts = {
      keymap = {
        preset = "default",
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
      },
      appearance = { nerd_font_variant = "mono" },
      completion = {
        list = { selection = { preselect = false, auto_insert = false } },
        menu = {
          border = "rounded",
          draw = {
            -- Keep syntax colors visible even on the selected row.
            cursorline_priority = 0,
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  local colorful = require("colorful-menu")
                  -- Buffer/path items get kind colors too; LSP syntax ranges
                  -- and fuzzy-match accents are applied on top.
                  local highlights = {
                    { 0, #colorful.blink_components_text(ctx), group = ctx.kind_hl },
                  }
                  vim.list_extend(highlights, colorful.blink_components_highlight(ctx))
                  return highlights
                end,
              },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 250,
          window = { border = "rounded" },
        },
      },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
      snippets = { preset = "default" },
      signature = {
        enabled = true,
        window = { border = "rounded", max_width = 80, max_height = 12, show_documentation = true },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      cmdline = { enabled = false },
      term = { enabled = false },
    },
  },
}
