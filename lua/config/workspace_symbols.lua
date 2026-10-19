local M = {}

function M.show()
  local root = require("config.root")()
  root = vim.fs.normalize(vim.uv.fs_realpath(root) or root)
  local prefix = root:gsub("/$", "") .. "/"
  local opts = { cwd = root, prompt_title = "Project Workspace Symbols" }
  local make_entry = require("telescope.make_entry").gen_from_lsp_symbols(opts)

  opts.entry_maker = function(item)
    local filename = item.filename
    if not filename or filename == "" then
      return nil
    end
    if not vim.startswith(filename, "/") then
      filename = root .. "/" .. filename
    end
    filename = vim.fs.normalize(vim.uv.fs_realpath(filename) or filename)
    if vim.startswith(filename, prefix) then
      return make_entry(item)
    end
  end

  require("telescope.builtin").lsp_dynamic_workspace_symbols(opts)
end

return M
