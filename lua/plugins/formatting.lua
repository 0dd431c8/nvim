return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports" },
        javascript = { "oxfmt" },
        javascriptreact = { "oxfmt" },
        typescript = { "oxfmt" },
        typescriptreact = { "oxfmt" },
      },
      default_format_opts = { lsp_format = "fallback", timeout_ms = 1000 },
      format_on_save = function(buf)
        if vim.g.autoformat == false or vim.b[buf].autoformat == false then
          return
        end
        return { timeout_ms = 1000, lsp_format = "fallback" }
      end,
    },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = false })
        end,
        mode = { "n", "x" },
        desc = "Format buffer or selection",
      },
      {
        "<leader>uf",
        function()
          vim.g.autoformat = vim.g.autoformat == false
          vim.notify("Global format on save: " .. (vim.g.autoformat and "on" or "off"))
        end,
        desc = "Toggle global format on save",
      },
      {
        "<leader>uF",
        function()
          vim.b.autoformat = vim.b.autoformat == false
          vim.notify("Buffer format on save: " .. (vim.b.autoformat and "on" or "off"))
        end,
        desc = "Toggle buffer format on save",
      },
    },
  },
}
