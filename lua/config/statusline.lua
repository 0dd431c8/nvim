local M = {}

local function searching()
  local command = vim.fn.getcmdtype()
  return command == "/" or command == "?"
end

function M.active()
  return vim.fn.reg_recording() ~= "" or searching() or vim.v.hlsearch == 1
end

function M.search()
  local pattern = searching() and vim.fn.getcmdline() or vim.fn.getreg("/")
  if pattern == "" or (not searching() and vim.v.hlsearch == 0) then
    return ""
  end

  local ok, count = pcall(vim.fn.searchcount, { pattern = pattern, maxcount = 9999, timeout = 20 })
  if not ok or not count.total then
    return ""
  end
  if count.incomplete == 1 then
    return "[?/…]"
  end

  return ("[%s%d/%s%d]"):format(
    count.current > count.maxcount and ">" or "",
    math.min(count.current, count.maxcount),
    count.incomplete == 2 and ">" or "",
    math.min(count.total, count.maxcount)
  )
end

function M.recording()
  local register = vim.fn.reg_recording()
  return register ~= "" and ("REC @" .. register) or ""
end

function M.setup()
  vim.api.nvim_create_autocmd(
    { "RecordingEnter", "RecordingLeave", "CmdlineChanged", "CmdlineLeave" },
    {
      group = vim.api.nvim_create_augroup("UserConfigStatusline", { clear = true }),
      desc = "Refresh search counts and macro recording status",
      callback = function(event)
        if event.event == "CmdlineChanged" and not searching() then
          return
        end
        -- RecordingLeave fires before reg_recording() clears; redraw after the event.
        vim.schedule(function()
          require("lualine").refresh({ place = { "statusline" }, force = true })
        end)
      end,
    }
  )
end

return M
