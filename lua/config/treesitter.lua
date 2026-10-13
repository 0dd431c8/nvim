local M = {}

function M.setup(opts)
  local treesitter = require("nvim-treesitter")
  treesitter.setup({})

  local function highlight(buf)
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "" then
      -- Missing parsers are normal during the first asynchronous installation.
      pcall(vim.treesitter.start, buf)
    end
  end

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("UserConfigTreesitter", { clear = true }),
    desc = "Enable native Treesitter highlighting when a parser is available",
    callback = function(event)
      highlight(event.buf)
    end,
  })

  require("config.mason").ensure_installed({ "tree-sitter-cli" }, function()
    -- Parser compilation needs a current CLI, not an older executable on PATH.
    treesitter.install(opts.parsers):await(function(err, success)
      if err or success == false then
        vim.schedule(function()
          vim.notify("Treesitter parser installation failed; see :messages", vim.log.levels.ERROR)
        end)
        return
      end
      vim.schedule(function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_loaded(buf) then
            highlight(buf)
          end
        end
      end)
    end)
  end)
end

return M
