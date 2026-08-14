local function find_monorepo_root()
  local dir = vim.fn.expand "%:p:h"
  while dir ~= "/" do
    if vim.fn.executable(dir .. "/node_modules/.bin/oxfmt") == 1 then
      return dir
    end
    dir = vim.fn.fnamemodify(dir, ":h")
  end
  return nil
end

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "oxfmt" },
    html = { "oxfmt" },
    json = { "oxfmt" },
    jsonc = { "oxfmt" },
    typescript = { "oxfmt" },
    typescriptreact = { "oxfmt" },
    javascript = { "oxfmt" },
    javascriptreact = { "oxfmt" },
  },

  formatters = {
    oxfmt = {
      cwd = find_monorepo_root,
    },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
