# ESLint + Prettier Integration Design

**Date:** 2026-02-24

## Goal

Add ESLint (as-you-type diagnostics via LSP) and Prettier (formatting via conform.nvim) alongside the existing Biome setup. Project detection determines which toolchain is active: Biome takes priority when `biome.json` is found in the project tree, otherwise ESLint + Prettier are used.

## Approach

**No new plugins required.** Two existing config files are modified:

### `lua/configs/lspconfig.lua`
- Add `eslint` to the servers list with a custom `root_dir` function
- `root_dir` searches upward for `biome.json`; returns `nil` if found (LSP won't attach), otherwise finds the nearest ESLint root marker (`package.json`, `.eslintrc.*`)

### `lua/configs/conform.lua`
- Replace static formatter lists for `js/ts/css/html` filetypes with a `pick_js_formatter(bufnr)` function
- Function searches upward for `biome.json`; returns `{ "biome" }` if found, otherwise `{ "prettierd", "prettier", stop_after_first = true }`

### Detection logic
Both places use `vim.fn.findfile("biome.json", dir .. ";")` — the `;` suffix triggers upward directory traversal from the buffer's directory.

## Required Mason installs
User runs `:MasonInstall eslint-lsp prettierd` once.
