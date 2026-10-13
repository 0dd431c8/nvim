local M = {}

-- Mason handles downloads; this only declares which non-LSP tools we need.
-- on_ready is useful for consumers that must wait for an executable.
function M.ensure_installed(names, on_ready)
  local registry = require("mason-registry")
  registry.refresh(vim.schedule_wrap(function(success)
    if not success then
      vim.notify("Could not refresh Mason's registry; see :MasonLog", vim.log.levels.ERROR)
      return
    end

    local remaining = #names
    local function ready()
      remaining = remaining - 1
      if remaining == 0 and on_ready then
        vim.schedule(on_ready)
      end
    end

    for _, name in ipairs(names) do
      local ok, package = pcall(registry.get_package, name)
      if not ok then
        vim.notify("Unknown Mason package: " .. name, vim.log.levels.ERROR)
      elseif package:is_installed() then
        ready()
      else
        package:once("install:success", vim.schedule_wrap(ready))
        package:once(
          "install:failed",
          vim.schedule_wrap(function()
            vim.notify("Failed to install " .. name .. "; see :MasonLog", vim.log.levels.ERROR)
          end)
        )
        if not package:is_installing() then
          package:install()
        end
      end
    end
  end))
end

return M
