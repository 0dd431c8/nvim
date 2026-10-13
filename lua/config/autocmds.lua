local function augroup(name)
  return vim.api.nvim_create_augroup("UserConfig" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("Yank"),
  desc = "Briefly highlight yanked text",
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("Checktime"),
  desc = "Check for files changed outside Neovim",
  callback = function()
    if vim.fn.getcmdwintype() == "" then
      vim.cmd.checktime()
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("CodeWrapping"),
  desc = "Reset wrapping inherited from a prose buffer",
  callback = function(event)
    local prose = { "text", "markdown", "gitcommit", "plaintex", "typst" }
    if vim.bo[event.buf].buftype == "" and not vim.tbl_contains(prose, event.match) then
      vim.opt_local.wrap = false
      vim.opt_local.linebreak = false
      vim.opt_local.breakindent = false
    end
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("LastPosition"),
  desc = "Restore the last cursor position in regular files",
  callback = function(event)
    local buf = event.buf
    -- BufReadPost can run before Neovim assigns the filetype.
    local filetype = vim.bo[buf].filetype
    if filetype == "" then
      filetype = vim.filetype.match({ buf = buf })
    end
    if
      vim.bo[buf].buftype ~= ""
      or vim.tbl_contains({ "gitcommit", "gitrebase" }, filetype)
      or vim.b[buf].user_last_position
      or vim.api.nvim_get_current_buf() ~= buf
    then
      return
    end

    vim.b[buf].user_last_position = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(buf) then
      local line = vim.api.nvim_buf_get_lines(buf, mark[1] - 1, mark[1], false)[1]
      vim.api.nvim_win_set_cursor(0, { mark[1], math.min(mark[2], #line) })
    end
  end,
})
