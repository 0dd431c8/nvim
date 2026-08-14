require("nvchad.configs.lspconfig").defaults()

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

local servers = {
  "html",
  "cssls",
  "ts_ls",
  "tailwindcss",
  "solidity_ls_nomicfoundation",
  "prismals",
}

vim.lsp.enable(servers)
