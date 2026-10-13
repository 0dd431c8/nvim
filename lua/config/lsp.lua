local M = {}

function M.setup(opts)
  vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
  })

  vim.diagnostic.config({
    severity_sort = true,
    update_in_insert = false,
    virtual_text = { severity = { min = vim.diagnostic.severity.WARN } },
    virtual_lines = false,
    float = { border = "rounded", source = "if_many" },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.INFO] = "",
        [vim.diagnostic.severity.HINT] = "",
      },
    },
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserConfigLsp", { clear = true }),
    desc = "Set mappings for supported LSP features",
    callback = function(event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if not client then
        return
      end

      local function map(lhs, rhs, desc, method, mode)
        if not method or client:supports_method(method, event.buf) then
          vim.keymap.set(mode or "n", lhs, rhs, { buffer = event.buf, desc = desc })
        end
      end

      map("gd", function()
        Snacks.picker.lsp_definitions()
      end, "Go to definition", "textDocument/definition")
      map("gD", function()
        Snacks.picker.lsp_declarations()
      end, "Go to declaration", "textDocument/declaration")
      map("grr", function()
        Snacks.picker.lsp_references()
      end, "References", "textDocument/references")
      map("gri", function()
        Snacks.picker.lsp_implementations()
      end, "Implementations", "textDocument/implementation")
      map("grt", function()
        Snacks.picker.lsp_type_definitions()
      end, "Type definitions", "textDocument/typeDefinition")
      map("grn", vim.lsp.buf.rename, "Rename symbol", "textDocument/rename")
      map("gra", vim.lsp.buf.code_action, "Code actions", "textDocument/codeAction", { "n", "x" })
      map("K", vim.lsp.buf.hover, "Hover documentation", "textDocument/hover")
      map("<leader>ss", function()
        Snacks.picker.lsp_symbols()
      end, "Document symbols", "textDocument/documentSymbol")
      map("<leader>sS", function()
        Snacks.picker.lsp_workspace_symbols()
      end, "Workspace symbols", "workspace/symbol")
      map("<leader>uh", function()
        local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
        vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
      end, "Toggle inlay hints", "textDocument/inlayHint")
    end,
  })

  -- An allowlist keeps servers left over from another config inactive.
  require("mason-lspconfig").setup({
    ensure_installed = opts.servers,
    automatic_enable = opts.servers,
  })
end

return M
