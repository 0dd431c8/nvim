# ESLint + Prettier Integration Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Add ESLint (as-you-type LSP diagnostics) and Prettier (format-on-save via conform.nvim) that activate only in projects without a `biome.json`.

**Architecture:** Both `lspconfig.lua` and `conform.lua` use `vim.fn.findfile("biome.json", dir .. ";")` to search upward from the buffer's directory. If `biome.json` is found, Biome handles everything as before. Otherwise ESLint LSP attaches and Prettier is selected as the formatter.

**Tech Stack:** Neovim 0.11+ built-in LSP (`vim.lsp.config`/`vim.lsp.enable`), nvim-lspconfig, conform.nvim, Mason for installing `eslint-lsp` and `prettierd`.

---

### Task 1: Update `conform.lua` with dynamic formatter selection

**Files:**
- Modify: `lua/configs/conform.lua`

**Step 1: Replace static formatter lists with a picker function**

Open `lua/configs/conform.lua` and replace the entire file with:

```lua
local function pick_js_formatter(bufnr)
  local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":h")
  if vim.fn.findfile("biome.json", dir .. ";") ~= "" then
    return { "biome" }
  end
  return { "prettierd", "prettier", stop_after_first = true }
end

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = pick_js_formatter,
    html = pick_js_formatter,
    typescript = pick_js_formatter,
    typescriptreact = pick_js_formatter,
    javascript = pick_js_formatter,
    javascriptreact = pick_js_formatter,
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
```

**Step 2: Verify the file looks correct**

Read `lua/configs/conform.lua` and confirm:
- `pick_js_formatter` function is defined at top
- All JS/TS/CSS/HTML filetypes reference the function (not a static list)
- `lua` still uses `{ "stylua" }`

**Step 3: Commit**

```bash
git add lua/configs/conform.lua
git commit -m "feat: dynamic formatter selection based on biome.json presence"
```

---

### Task 2: Add ESLint LSP with biome guard

**Files:**
- Modify: `lua/configs/lspconfig.lua`

**Step 1: Add eslint to the servers table with a root_dir guard**

Open `lua/configs/lspconfig.lua`. The current servers table is:

```lua
local servers = {
  html = {},
  cssls = {},
  ts_ls = {},
  tailwindcss = {},
  solidity_ls_nomicfoundation = {},
  prismals = {},
}
```

Add `eslint` with a custom `root_dir`:

```lua
local servers = {
  html = {},
  cssls = {},
  ts_ls = {},
  tailwindcss = {},
  solidity_ls_nomicfoundation = {},
  prismals = {},
  eslint = {
    root_dir = function(bufnr)
      local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":h")
      if vim.fn.findfile("biome.json", dir .. ";") ~= "" then
        return nil
      end
      return vim.fs.root(bufnr, {
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.mjs",
        ".eslintrc.json",
        ".eslintrc.yaml",
        ".eslintrc.yml",
        "eslint.config.js",
        "eslint.config.mjs",
        "eslint.config.cjs",
        "package.json",
      })
    end,
  },
}
```

**Step 2: Verify the file looks correct**

Read `lua/configs/lspconfig.lua` and confirm:
- `eslint` entry is present in `servers` table
- `root_dir` function checks for `biome.json` first and returns `nil` if found
- Falls back to `vim.fs.root` with ESLint config file markers
- The `for name, opts in pairs(servers)` loop below is unchanged (it will pick up `eslint` automatically)

**Step 3: Commit**

```bash
git add lua/configs/lspconfig.lua
git commit -m "feat: add eslint LSP with biome.json project guard"
```

---

### Task 3: Install eslint-lsp and prettierd via Mason

**Step 1: Open Neovim and install the tools**

In Neovim, run:

```
:MasonInstall eslint-lsp prettierd
```

Wait for both installs to complete.

**Step 2: Verify installs**

Run `:Mason` and confirm `eslint-lsp` and `prettierd` show as installed.

---

### Task 4: Smoke test the integration

**Step 1: Test in a non-Biome project**

Open a `.ts` or `.js` file in a project that has no `biome.json` (but has a `package.json` or `.eslintrc`).

- Run `:LspInfo` — confirm `eslint` is listed as an active client
- Introduce a lint error (e.g., an unused variable) — confirm a diagnostic appears inline as you type
- Save the file — confirm Prettier formats it (not Biome)

**Step 2: Test in a Biome project**

Open a `.ts` file in a project that has `biome.json`.

- Run `:LspInfo` — confirm `eslint` is NOT listed
- Run `:ConformInfo` — confirm the formatter shown is `biome`, not `prettierd`

**Step 3: Test Lua formatting is unaffected**

Open any `.lua` file and save it — confirm `stylua` still formats it.
