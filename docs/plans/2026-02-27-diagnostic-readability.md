# Diagnostic Readability Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Make Neovim diagnostics more readable with better inline display, a project-wide diagnostic panel, and formatted float windows.

**Architecture:** Install tiny-inline-diagnostic.nvim to replace built-in virtual_text with severity-colored inline messages. Add trouble.nvim as a toggleable diagnostic list panel. Override NvChad's default diagnostic config to add source info in floats.

**Tech Stack:** Neovim, Lua, lazy.nvim, NvChad, base46, tiny-inline-diagnostic.nvim, trouble.nvim

---

### Task 1: Install and configure tiny-inline-diagnostic.nvim

**Files:**
- Modify: `lua/plugins/init.lua` (add plugin spec after line 181)
- Modify: `lua/configs/lspconfig.lua:1` (add diagnostic config override after defaults call)

**Step 1: Add plugin spec to `lua/plugins/init.lua`**

Add before the final closing `}` (before line 182):

```lua
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000,
    config = function()
      vim.diagnostic.config { virtual_text = false }
      require("tiny-inline-diagnostic").setup {
        preset = "modern",
        options = {
          multiple_diag_under_cursor = false,
          show_source = true,
        },
      }
    end,
  },
```

Key details:
- `event = "LspAttach"` — loads only when an LSP server attaches
- `priority = 1000` — ensures it loads early enough to override virtual_text
- `vim.diagnostic.config { virtual_text = false }` inside config — disables built-in virtual_text so the plugin takes over
- `multiple_diag_under_cursor = false` — shows only highest severity per line
- `show_source = true` — displays which LSP/linter produced the diagnostic

**Step 2: Verify the plugin loads**

Run: `nvim some_file.lua` — open a file with known diagnostics.
Expected: Diagnostics appear with colored backgrounds and arrow indicators instead of plain text.

**Step 3: Commit**

```
git add lua/plugins/init.lua
git commit -m "feat: add tiny-inline-diagnostic for better inline diagnostics"
```

---

### Task 2: Install and configure trouble.nvim

**Files:**
- Modify: `lua/plugins/init.lua` (add plugin spec)
- Modify: `lua/mappings.lua` (add keybindings)

**Step 1: Add plugin spec to `lua/plugins/init.lua`**

Add after the tiny-inline-diagnostic spec:

```lua
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
    },
    opts = {},
  },
```

Key details:
- `cmd = "Trouble"` + `keys` — lazy-loads only when you use the keybindings or run `:Trouble`
- `opts = {}` — uses sensible defaults (icons, sorting, grouping all work out of the box)
- Keybindings are defined in the plugin spec via `keys` so they're co-located with the plugin

**Step 2: Add keybindings to `lua/mappings.lua`**

Add after the existing leap mappings (after line 13):

```lua
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
```

Note: These are duplicated in both `keys` (for lazy-loading) and `mappings.lua` (for discoverability via NvChad's which-key). The `keys` table in the plugin spec ensures trouble.nvim loads when the mapping is pressed.

**Step 3: Verify trouble.nvim works**

Run: `nvim some_file.lua`, then press `<leader>xx`.
Expected: A panel opens at the bottom showing all diagnostics across the project, grouped by file.

Press `<leader>xd`.
Expected: Panel shows only diagnostics for the current buffer.

**Step 4: Commit**

```
git add lua/plugins/init.lua lua/mappings.lua
git commit -m "feat: add trouble.nvim diagnostic panel with keybindings"
```

---

### Task 3: Improve diagnostic float formatting

**Files:**
- Modify: `lua/configs/lspconfig.lua:1` (add override after defaults call)

**Step 1: Add diagnostic float format override**

In `lua/configs/lspconfig.lua`, add after line 1 (`require("nvchad.configs.lspconfig").defaults()`):

```lua
-- Override NvChad's default diagnostic float to show source
vim.diagnostic.config {
  float = {
    border = "single",
    format = function(d)
      if d.source then
        return d.source .. ": " .. d.message
      end
      return d.message
    end,
  },
}
```

Key details:
- This runs after `defaults()` which calls `diagnostic_config()`, so it overrides just the float section
- `vim.diagnostic.config` merges with existing config, so signs/underline remain unchanged
- `d.source` may be nil for some diagnostics, so we guard against it

**Step 2: Verify float formatting**

Run: `nvim some_file.lua`, move cursor to a diagnostic, press `<C-w>d` or `vim.diagnostic.open_float()`.
Expected: Float shows `ts_ls: Cannot find name 'x'` format instead of just `Cannot find name 'x'`.

**Step 3: Commit**

```
git add lua/configs/lspconfig.lua
git commit -m "feat: show diagnostic source in float windows"
```
