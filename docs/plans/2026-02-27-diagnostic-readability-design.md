# Diagnostic Readability Improvements

## Problem

Current diagnostic display is hard to read:
- Inline virtual text is noisy — raw messages clutter code
- Hard to tell severity at a glance without reading the message
- Missing context — no source (e.g. eslint, ts_ls) shown with diagnostics

## Solution

Three changes: replace inline display with tiny-inline-diagnostic.nvim, add trouble.nvim as a diagnostic panel, and improve float formatting.

## Changes

### 1. tiny-inline-diagnostic.nvim

Install `rachartier/tiny-inline-diagnostic.nvim` to replace built-in virtual_text.

Configuration:
- Preset: `"modern"` (colored background + arrow indicator)
- Show only highest-severity diagnostic per line (`multiple_diag_under_cursor = false`)
- Show source in message via `show_source = true`
- Disable built-in `virtual_text` in `vim.diagnostic.config()` (the plugin takes over)
- base46 already has theme integration for this plugin (Catppuccin colors apply automatically)

### 2. trouble.nvim

Install `folke/trouble.nvim` as a diagnostic list panel.

Keybindings:
- `<leader>xx` — toggle project-wide diagnostics
- `<leader>xd` — toggle current buffer diagnostics

### 3. Float formatting

Update `vim.diagnostic.config()` float with a custom format function:
- Format: `source: message` (e.g. "eslint: 'x' is declared but never used")
- Keep existing `border = "single"`

### 4. Files to modify

- `lua/plugins/init.lua` — add tiny-inline-diagnostic.nvim and trouble.nvim plugin specs
- `lua/mappings.lua` — add trouble.nvim keybindings
- `lua/configs/lspconfig.lua` — override diagnostic config (disable virtual_text, add float format)
