-- Navigation uses the current file's repository without changing cwd.
return function()
  local path = vim.api.nvim_buf_get_name(0)
  if path == "" or vim.bo.buftype ~= "" then
    path = vim.fn.getcwd()
  end
  return vim.fs.root(path, ".git") or vim.fn.getcwd()
end
