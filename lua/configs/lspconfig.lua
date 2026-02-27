require("nvchad.configs.lspconfig").defaults()

-- Override NvChad's default diagnostic float to show source
vim.diagnostic.config {
  float = {
    border = "single",
    format = function(d)
      if d.source and d.source ~= "" then
        return d.source .. ": " .. d.message
      end
      return d.message
    end,
  },
}

-- local nvlsp = require "nvchad.configs.lspconfig"
-- local lspconfig = require "lspconfig"

local servers = {
  html = {},
  cssls = {},
  ts_ls = {},
  tailwindcss = {
    -- settings = {
    --   validate = false,
    -- },
    -- workspace_required = false,
  },
  solidity_ls_nomicfoundation = {},
  prismals = {},
  -- eslint = {
  --   root_dir = function(bufnr, on_dir)
  --     local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":h")
  --     if vim.fn.findfile("biome.json", dir .. ";") ~= "" then
  --       on_dir(nil)
  --       return
  --     end
  --     on_dir(vim.fs.root(bufnr, {
  --       ".eslintrc",
  --       ".eslintrc.js",
  --       ".eslintrc.cjs",
  --       ".eslintrc.mjs",
  --       ".eslintrc.json",
  --       ".eslintrc.yaml",
  --       ".eslintrc.yml",
  --       "eslint.config.js",
  --       "eslint.config.mjs",
  --       "eslint.config.cjs",
  --       "package.json",
  --     }))
  --   end,
  -- },
}

for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end

-- vim.lsp.enable(servers)

-- for _, lsp in ipairs(servers) do
--   vim.lsp.config[lsp].setup {
--     on_attach = nvlsp.on_attach,
--     on_init = nvlsp.on_init,
--     capabilities = nvlsp.capabilities,
--   }
-- end

-- read :h vim.lsp.config for changing options of lsp servers
