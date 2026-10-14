local rainbow = require("config.rainbow")

return {
  {
    "saghen/blink.indent",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      static = { enabled = false },
      scope = { enabled = true, char = "▏", highlights = rainbow },
      mappings = {
        object_scope = "",
        object_scope_with_border = "",
        goto_top = "",
        goto_bottom = "",
      },
    },
  },
}
