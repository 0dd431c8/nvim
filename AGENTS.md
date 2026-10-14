# Repository Guidelines

## Project Structure & Module Organization

This repository is a modular Lua configuration for Neovim 0.12+, using lazy.nvim and native LSP.

- `init.lua`: leaders and startup order; core configuration loads before plugins.
- `lua/config/`: editor options, keymaps, autocommands, and shared integration helpers.
- `lua/plugins/`: feature-specific lazy.nvim specs, such as `completion.lua`, `telescope.lua`, and `code_actions.lua`. Each module returns a spec table.
- `after/lsp/`: server overrides merged with nvim-lspconfig defaults.
- `after/ftplugin/`: filetype-specific editor settings.
- `lazy-lock.json`: pinned plugin revisions; `.stylua.toml`: Lua formatting rules.

There are no dedicated test or asset directories. Update `README.md` when changing documented behavior or mappings.

## Build, Test, and Development Commands

Run these from the configured Neovim directory:

- `nvim`: launch interactively; first startup installs plugins, Mason tools, and parsers asynchronously.
- `nvim --headless '+qa'`: smoke-check startup; this does not verify asynchronous installation or UI behavior.
- `stylua init.lua lua after`: format Lua sources.
- `stylua --check init.lua lua after`: check formatting without modifying files.
- `git diff --check`: catch whitespace errors before committing.

Inside Neovim, use `:Lazy`, `:Mason`, and `:ConformInfo` to inspect plugins, tools, and formatters. Run `:checkhealth vim.lsp telescope nvim-tree nvim-treesitter blink.cmp which-key` for diagnostics. Git, a C compiler, and make support native plugin builds.

## Coding Style & Naming Conventions

Use two-space indentation, Unix newlines, double quotes, and StyLua's 100-column target. Name modules in lowercase snake_case and keep plugin options beside their specs. Move substantial reusable logic into `lua/config/`.

Use native `vim.lsp.config()` and the current Treesitter `main` API. Preserve project-root navigation through `config.root` without changing cwd. Use `vim.opt_local` in filetype overrides and register cleanup in `b:undo_ftplugin`.

## Testing Guidelines

No automated test framework or coverage threshold is configured. For behavior changes, use focused headless Lua assertions and temporary fixtures outside the repository. Check affected Lua, JavaScript/TypeScript, or Go buffers interactively, including mappings, popup focus, and visual selections where relevant. Let tool and parser installation finish before evaluating failures.

## Commit & Pull Request Guidelines

Use concise imperative subjects, such as `Improve LSP documentation and code action UI`; historical `feat:` and `fix:` prefixes are also established. Keep commits focused. Include `lazy-lock.json` for intentional plugin changes.

PR descriptions should explain the resulting behavior and validation, link relevant issues, and include screenshots for visible UI changes. Exclude generated parsers, installed tools, and machine-local paths or secrets.
