return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = false,
      preview_config = { border = "rounded" },
      on_attach = function(buf)
        local gitsigns = require("gitsigns")
        local function map(lhs, rhs, desc, mode)
          vim.keymap.set(mode or "n", lhs, rhs, { buffer = buf, desc = desc })
        end
        map("]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end, "Next Git hunk")
        map("[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end, "Previous Git hunk")
        map("<leader>hp", gitsigns.preview_hunk, "Preview hunk")
        map("<leader>hs", gitsigns.stage_hunk, "Stage or unstage hunk")
        map("<leader>hr", gitsigns.reset_hunk, "Reset hunk")
        map("<leader>hs", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Stage selected hunk", "x")
        map("<leader>hr", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Reset selected hunk", "x")
        map("<leader>hb", function()
          gitsigns.blame_line({ full = true })
        end, "Blame current line")
      end,
    },
  },
}
