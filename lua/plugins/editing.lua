return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      disable_filetype = { "TelescopePrompt" },
    },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPre", "BufNewFile" },
    submodules = false,
    main = "rainbow-delimiters.setup",
    opts = { highlight = require("config.rainbow") },
  },
}
