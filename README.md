# Neovim

A modular Lua configuration for Neovim 0.12+, with lazy.nvim and native LSP.
Language support covers Lua, TypeScript/JavaScript, and Go.

## Requirements

- Neovim 0.12+, Git, curl, tar, unzip, and a C compiler.
- Node.js/npm and Go for the selected Mason packages.
- ripgrep (`rg`) and `fd` for file/search pickers; `lazygit` for Git's terminal UI.
- A Nerd Font selected in your terminal for icons.

On first launch, lazy.nvim installs plugins, Mason installs declared tools, and
Treesitter installs its parsers asynchronously. Leave Neovim open until these
finish. Open `:Mason` to follow tool installation and `:messages` for parser output.
Mason provides a current Tree-sitter CLI before parser compilation begins.

## Structure

```text
init.lua                   Leaders and startup order
lua/config/options.lua     Editor options
lua/config/keymaps.lua     Global, native keymaps
lua/config/autocmds.lua    Core autocommands
lua/config/lazy.lua        Plugin manager bootstrap
lua/config/lsp.lua         Native LSP integration, diagnostics, attach mappings
lua/config/mason.lua       Installation helper for non-LSP tools
lua/config/treesitter.lua  Parser installation and native highlighting
lua/config/root.lua        Navigation root helper
lua/plugins/lsp.lua        LSP servers, Mason, and mason-lspconfig
lua/plugins/completion.lua Blink completion
lua/plugins/treesitter.lua Parser selection
lua/plugins/snacks.lua     Picker, explorer, and LazyGit
lua/plugins/formatting.lua Conform formatters and save behavior
lua/plugins/git.lua        Gitsigns and buffer-local hunk mappings
lua/plugins/ui.lua         Lualine, which-key, and file icons
lua/plugins/theme.lua      Catppuccin Mocha and palette/highlight customizations
after/lsp/*.lua            Overrides merged with nvim-lspconfig server defaults
after/ftplugin/*.lua       Local display settings for prose
lazy-lock.json             Pinned plugin revisions
.stylua.toml               Lua formatting settings
```

Editor options and core mappings load before lazy.nvim. Plugin specs and settings
live together in `lua/plugins/`; larger integration functions live in `lua/config/`.
There is no distribution or preset configuration dependency.

## Languages and tools

| Language | Language servers | Formatter |
| --- | --- | --- |
| Lua | `lua_ls` | StyLua |
| TypeScript / JavaScript / JSX / TSX | `ts_ls`, plus `oxlint` in Oxc projects | oxfmt |
| Go | `gopls` | goimports |

Mason automatically installs the declared language servers, StyLua, goimports,
oxfmt, and the Tree-sitter CLI in Neovim's data directory. Only servers listed in
`lua/plugins/lsp.lua` are automatically enabled; unrelated existing Mason packages
stay inactive.

LSP configuration uses `vim.lsp.config()` and mason-lspconfig's native server
activation. nvim-lspconfig supplies server defaults; Blink supplies completion
capabilities. Neovim-specific Lua settings apply only to this configuration's
workspace and defer to a project `.luarc.json` or `.luarc.jsonc`.

Oxlint supplies lint diagnostics and code actions alongside TypeScript's language
server. Its project detection uses Oxc configuration or a package manifest declaring
Oxc. Both the Oxlint LSP and Conform's oxfmt formatter prefer project-local
`node_modules/.bin` executables, with Mason executables available as fallbacks.
Lint fixes are explicit code actions; formatting on save runs oxfmt. Prettier and
ESLint are not configured.

Formatting runs synchronously before save with a 1-second timeout. Conform prefers
the declared formatter and falls back to LSP formatting when it is unavailable.
Manual formatting remains available when format-on-save is disabled. StyLua and
Oxc respect project configuration; goimports formats code and updates imports.

Treesitter uses its current `main` API, with native highlighting for Lua, Vim/help,
queries, JavaScript, TypeScript/TSX, and Go/module files. Highlighting starts when a
parser is available, including after the initial installation. Treesitter
indentation is disabled; native filetype indentation and manual folding remain.

## Editor behavior

- Absolute and relative line numbers, two-space fallback indentation, persistent
  undo, and confirmation when an operation encounters unsaved changes.
- Tab and Backspace follow the indentation width; shifts round to that width.
- Case-insensitive search unless the pattern contains uppercase letters.
- New splits open below or to the right and preserve text placement where possible.
- Cursor-line highlighting, four lines/eight columns of scrolling context, and
  visible tabs, trailing spaces, and nonbreaking spaces.
- Mapping timeout is 500 ms. Which-key appears after 300 ms. The swap-write and
  `CursorHold` idle interval is 250 ms.
- Code does not wrap. Text, Markdown, Git commits, plain TeX, and Typst wrap at
  word boundaries with indentation on continuation lines.
- Yanks briefly highlight copied text. Reopened regular files restore their last
  cursor position. Focus gain and terminal close/leave check for external changes.
- Diagnostics use signs and underlines, inline warnings/errors, and bordered floats.
  Updates during insert mode and inlay hints are disabled initially.
- Catppuccin Mocha supplies a solid dark background, colorful syntax and plugin UI,
  brighter lavender comments, bold keywords/functions/types, and terminal colors.
- Lualine shows mode, branch, changes, diagnostics, filename, filetype, and position
  in a global statusline; the duplicate built-in mode message is hidden after load.
  Its Mocha colors use a lavender normal-mode badge, maroon filename, flamingo
  position section, and a lighter `surface0` background inspired by the theme preview.
- The command line is hidden when idle, leaving no gap below lualine. Commands and
  messages remain available; partial-command text and the built-in ruler are hidden.
- Ctrl-S saves the current buffer in normal, insert, visual, and select modes,
  preserving the current mode and using the configured format-on-save behavior.
- Built-in EditorConfig, swap files, `hidden`, `autoread`, `autoindent`, and
  incremental search remain enabled.

Blink opens completion automatically without preselection or automatic insertion.
Tab/Shift-Tab and `Ctrl-n/p` cycle candidates while the menu is open. Enter accepts
the selected candidate, otherwise inserting a newline; `Ctrl-y` also accepts.
With the menu closed, Tab/Shift-Tab jump between native snippet fields or retain
their usual editing behavior. `Ctrl-e` dismisses, and `Ctrl-Space` opens
completion/documentation. Colorful-menu gives LSP labels and type details Treesitter
syntax colors; buffer/path labels use their completion-kind colors. Completion and
documentation use rounded borders, with documentation
opening after 250 ms. Command-line completion retains Neovim's configured `wildmode`.

Navigation uses the current file's Git root, falling back to the working directory,
without changing Neovim's cwd. Hidden files are included; ignore rules are respected.
Snacks explorer replaces netrw when opening a directory. Picker/explorer-local
mappings remain the upstream defaults, available through their help controls.

## Keymaps

Space is the leader; backslash is the local leader. Mappings are normal-mode unless
noted. LSP and Git mappings attach to buffers when their features are available.

| Key | Action |
| --- | --- |
| `<C-s>` (normal/insert/visual/select) | Save buffer |
| `<Esc>` | Clear search highlighting |
| `<C-h/j/k/l>` | Focus the adjacent window |
| `<Space>-` / `<Space>\|` | Split below / right |
| `<` / `>` (visual) | Adjust indentation and keep the selection |
| `<Space>l` | lazy.nvim |
| `<Space>cm` / `<Space>cl` | Mason / LSP information |
| `gd` / `gD` | Definition / declaration |
| `grr` / `gri` / `grt` | References / implementations / type definitions |
| `grn` / `gra` / `K` | Rename / code actions / hover |
| `[d` / `]d` | Previous / next diagnostic (native mappings) |
| `<Space>cd` | Diagnostic details |
| `<Space>cf` | Format buffer or visual selection |
| `<Space>ff` / `<Space>fF` | Files: project / cwd |
| `<Space>fb` / `<Space>fr` | Buffers / recent files |
| `<Space>sg` / `<Space>sG` | Live grep: project / cwd |
| `<Space>sw` | Search word or visual selection |
| `<Space>sh` / `<Space>sk` | Help / keymaps |
| `<Space>ss` / `<Space>sS` | Document / workspace symbols |
| `<Space>e` / `<Space>E` | Explorer: project / cwd |
| `<Space>gg` | LazyGit |
| `[c` / `]c` | Previous / next Git hunk; native behavior in diff windows |
| `<Space>hp` / `<Space>hs` / `<Space>hr` | Preview / stage or unstage / reset hunk |
| `<Space>hs` / `<Space>hr` (visual) | Stage / reset selected lines |
| `<Space>hb` | Blame current line |
| `<Space>uf` / `<Space>uF` | Toggle format-on-save: global / buffer |
| `<Space>ud` / `<Space>uh` | Toggle diagnostics / supported inlay hints |
| `<Space>?` | Show buffer-local keymaps |

LSP navigation uses Snacks pickers, jumping directly when there is one result.
Continuous inline Git blame is disabled; use the explicit blame mapping.

## Extending and maintenance

Add a spec to an existing `lua/plugins/` file or a new file returning a spec table;
lazy.nvim imports it automatically. Use `opts` for settings and `event`, `ft`, `cmd`,
or `keys` when lazy loading is supported. Mason, Snacks, and Treesitter initialize
at startup; LSP and Git attach when files open; the UI loads after startup.

Add a server to the `servers` list in `lua/plugins/lsp.lua`, then put overrides in
`after/lsp/<server>.lua`. Add formatters in `lua/plugins/formatting.lua` and their
Mason package names to the installation list in `lua/plugins/lsp.lua`. Add parsers
in `lua/plugins/treesitter.lua`. Restart Neovim after changing server/tool lists.

Use `after/ftplugin/<filetype>.lua` and `vim.opt_local` for filetype-specific editor
settings. Append cleanup to `b:undo_ftplugin` for settings that need resetting when
a buffer changes filetype.

Use `:Lazy` for plugins, `:Mason` for tools, `:ConformInfo` for formatting, and
`:checkhealth vim.lsp snacks nvim-treesitter blink.cmp which-key` for diagnostics.
After intentional plugin updates, commit `lazy-lock.json`; `:Lazy restore` returns
to locked revisions. Mason tools and compiled parsers have separate versions and
are not pinned by lazy.nvim's lockfile. Treesitter's build hook runs `:TSUpdate`
after plugin changes.

Format Lua with `stylua init.lua lua after`; check with
`stylua --check init.lua lua after`.
