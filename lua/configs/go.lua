local M = {}

function M.lint()
  if vim.bo.filetype ~= "go" or vim.bo.buftype ~= "" or vim.fn.executable "golangci-lint" ~= 1 then
    return
  end

  local filename = vim.api.nvim_buf_get_name(0)
  if filename == "" or not vim.uv.fs_stat(filename) then
    return
  end

  local directory = vim.fs.dirname(filename)
  local root = vim.fs.root(directory, "go.mod")
  if not root then
    return
  end

  require("lint").try_lint("golangcilint", {
    cwd = root,
    wrap_linter = function(linter)
      -- Always analyze the package, including when Neovim starts outside the module.
      linter.args[#linter.args] = directory
      table.insert(linter.args, "--allow-serial-runners")
      return linter
    end,
  })
end

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
