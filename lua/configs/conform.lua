local function pick_js_formatter(bufnr)
  local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":h")
  if vim.fn.findfile("biome.json", dir .. ";") ~= "" then
    return { "biome" }
  end
  return { "prettierd", "prettier", stop_after_first = true }
end

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = pick_js_formatter,
    html = pick_js_formatter,
    typescript = pick_js_formatter,
    typescriptreact = pick_js_formatter,
    javascript = pick_js_formatter,
    javascriptreact = pick_js_formatter,
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
