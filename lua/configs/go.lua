local M = {}

-- Run from the buffer's package/module, regardless of Neovim's working directory.
function M.run(args, whole_module)
  local filename = vim.api.nvim_buf_get_name(0)
  if filename == "" then
    vim.notify("Save the Go file before running a command", vim.log.levels.WARN)
    return
  end

  vim.cmd "update"
  local directory = vim.fs.dirname(filename)
  local cwd = whole_module and (vim.fs.root(directory, "go.mod") or directory) or directory
  local command = { "go" }
  vim.list_extend(command, args)

  vim.cmd "botright 12new"
  vim.bo.bufhidden = "wipe"
  vim.fn.jobstart(command, { term = true, cwd = cwd })
  vim.cmd "startinsert"
end

return M
