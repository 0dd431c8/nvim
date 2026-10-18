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
lua/config/rainbow.lua     Shared rainbow color cycle
lua/config/statusline.lua  Search count and macro recording indicators
lua/config/project_diagnostics.lua Go module checks including unopened files
lua/plugins/lsp.lua        LSP servers, Mason, and mason-lspconfig
lua/plugins/completion.lua Blink completion
lua/plugins/editing.lua    Automatic pairing and rainbow bracket highlighting
lua/plugins/hover.lua      Formatted LSP hover documentation
lua/plugins/code_actions.lua Telescope code actions with diff previews
lua/plugins/treesitter.lua Parser selection
lua/plugins/indent.lua     Blink indent guides and scope highlighting
lua/plugins/telescope.lua  Telescope pickers and native FZF sorting
lua/plugins/explorer.lua   nvim-tree sidebar and directory handling
lua/plugins/lazygit.lua    LazyGit floating terminal
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
| Go | `gopls`, `golangci_lint_ls` | goimports |

Mason automatically installs the declared language servers, StyLua, goimports,
golangci-lint, oxfmt, and the Tree-sitter CLI in Neovim's data directory. Only servers listed in
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

Go uses gopls for type errors, navigation, and interactive analysis, with
golangci-lint-langserver reporting lint diagnostics when Go files open or are saved.
golangci-lint respects the project's `.golangci.*` configuration; its default
linters include `errcheck` for ignored errors. If a project overrides the enabled
linters, include `errcheck` there. Package compilation errors can prevent lint
analysis from completing. `<Space>sd` runs golangci-lint across all packages in the
current Go module and opens a Telescope report, including unopened files. This
checks saved files, respects project lint configuration, and leaves buffers and
quickfix lists unchanged. `<Space>sD` shows live diagnostics for the current buffer.
For other languages, `<Space>sd` lists diagnostics already reported by the LSP;
it does not force a full project check.

Formatting runs synchronously before save with a 1-second timeout. Conform prefers
the declared formatter and falls back to LSP formatting when it is unavailable.
Manual formatting remains available when format-on-save is disabled. StyLua and
Oxc respect project configuration; goimports formats code and updates imports.

Treesitter uses its current `main` API, with native highlighting for Lua, Vim/help,
queries, Markdown, JavaScript, TypeScript/TSX, and Go/module files. Highlighting starts when a
parser is available, including after the initial installation. Treesitter
indentation is disabled; native filetype indentation and manual folding remain.

## Editor behavior

- Absolute and relative line numbers, two-space fallback indentation, persistent
  undo, and confirmation when an operation encounters unsaved changes.
- Tab and Backspace follow the indentation width; shifts round to that width.
- blink.indent shows a thin (`▏`) rainbow guide only for the scope containing the cursor,
  hiding guides outside that scope. It uses indentation
  rather than Treesitter and updates immediately without animation.
- Rainbow delimiters colors nested bracket pairs using Treesitter. Brackets and
  indent guides share a seven-color cycle: red, peach, yellow, green, blue, mauve, teal.
- nvim-autopairs closes brackets and quotes, skips existing closing characters,
  deletes empty pairs with Backspace, and splits pairs across lines with Enter.
  Treesitter checks provide syntax context; pairing is disabled in picker prompts.
- Case-insensitive search unless the pattern contains uppercase letters.
- New splits open below or to the right and preserve text placement where possible.
- Cursor-line highlighting, four lines/eight columns of scrolling context, and
  visible trailing spaces and nonbreaking spaces. Tabs display as blank whitespace.
- Mapping timeout is 500 ms. Which-key appears after 300 ms. The swap-write and
  `CursorHold` idle interval is 250 ms.
- Code does not wrap. Text, Markdown, Git commits, plain TeX, and Typst wrap at
  word boundaries with indentation on continuation lines.
- Yanks, deletes, and pastes use the system clipboard by default. Use `ggVGy` to
  copy the entire buffer, or select text and press `y` to copy a selection.
  On macOS, Neovim uses the built-in `pbcopy` and `pbpaste` tools.
- Yanks briefly highlight copied text. Reopened regular files restore their last
  cursor position. Focus gain and terminal close/leave check for external changes.
- Diagnostics use signs and underlines, inline warnings/errors, and bordered floats.
  Updates during insert mode and inlay hints are disabled initially.
- Catppuccin Mocha supplies a solid dark background, colorful syntax and plugin UI,
  brighter lavender comments, bold keywords/functions/types, and terminal colors.
  Popup interiors and border cells share the editor background, keeping rounded
  purple outlines from appearing inside a separate dark rectangle.
- nvim-web-devicons supplies colored file icons for Telescope, nvim-tree,
  lualine, and which-key.
- Lualine shows mode, branch, changes, diagnostics, filename, filetype, and position
  in a global statusline; the duplicate built-in mode message is hidden after load.
  Its Mocha colors use a lavender normal-mode badge, maroon filename, flamingo
  position section, and a lighter `surface0` background inspired by the theme preview.
  The middle shows search progress (`[2/14]`) while search highlights are active,
  including while typing `/` or `?`, and `REC @a` while recording into register `a`.
- The command line is hidden when idle, leaving no gap below lualine. Commands and
  messages remain available; partial-command text and the built-in ruler are hidden.
- Ctrl-S saves the current buffer in normal, insert, visual, and select modes,
  preserving the current mode and using the configured format-on-save behavior.
- Built-in EditorConfig, swap files, `hidden`, `autoread`, `autoindent`, and
  incremental search remain enabled.

Blink opens completion automatically without preselection or automatic insertion.
Tab/Shift-Tab and `Ctrl-n/p` cycle candidates while the menu is open. Enter accepts
the selected candidate, otherwise inserting a newline with autopairs handling;
`Ctrl-y` also accepts.
With the menu closed, Tab/Shift-Tab jump between native snippet fields or retain
their usual editing behavior. `Ctrl-e` dismisses, and `Ctrl-Space` opens
completion/documentation. Colorful-menu gives LSP labels and type details Treesitter
syntax colors; buffer/path labels use their completion-kind colors. Completion and
documentation use rounded borders, with documentation
opening after 250 ms. Command-line completion retains Neovim's configured `wildmode`.

Signature help appears automatically on LSP trigger characters such as `(` and
updates as arguments change. The rounded popup includes parameter documentation
and highlights the active parameter; `Ctrl-k` in insert mode toggles it.
`Shift-K` (`K`) opens formatted hover documentation through pretty_hover, with
wrapping and a rounded border. Press `K` again to focus the popup, scroll with
normal movement keys, and press `q` to close it.

`gra` opens code actions in a Telescope picker with a diff preview above the action
list. Type to filter, use `Ctrl-n/p` to move between actions, and Enter to apply the
selected action. Escape cancels the picker. Visual selections use
the same mapping. Actions implemented only as server commands may lack a preview.

Navigation uses the current file's Git root, falling back to the working directory,
without changing Neovim's cwd. Telescope handles file/search/help/LSP pickers, using
the native FZF sorter. Hidden files are included; ignore rules are respected and
`.git` contents are excluded. nvim-tree replaces netrw when opening a directory and
shows a sidebar with hidden files visible and Git-ignored files filtered.
`<Space>e` expands the tree to reveal and select the active file. LazyGit
opens in a floating terminal at the same project root. Picker/explorer-local
mappings remain the upstream defaults, available through their help controls.

## Keymaps

Space is the leader; backslash is the local leader. Mappings are normal-mode unless
noted. LSP and Git mappings attach to buffers when their features are available.
Insert-mode navigation falls back to Blink's default actions while completion is open.

| Key | Action |
| --- | --- |
| `<C-s>` (normal/insert/visual/select) | Save buffer |
| `<C-a>` / `<C-e>` (insert) | Move to line start / end |
| `<C-n>` / `<C-p>` (insert) | Move to next / previous line |
| `<C-b>` / `<C-f>` (insert) | Move back / forward one character |
| `<Esc>` | Clear search highlighting |
| `s` (normal/visual/operator-pending) | Flash jump: type target text, then its label |
| `S` (normal/visual/operator-pending) | Flash Treesitter selection |
| `f` / `F` / `t` / `T` | Flash character motions; repeat with `f/F` or `t/T`, and `;` / `,` |
| `/` / `?` | Search with Flash labels to jump directly to a match |
| `<C-h/j/k/l>` | Focus the adjacent window |
| `<Space>-` / `<Space>\|` | Split below / right |
| `<` / `>` (visual) | Adjust indentation and keep the selection |
| `<Space>l` | lazy.nvim |
| `<Space>cm` / `<Space>cl` | Mason / LSP information |
| `gd` / `gD` | Definition / declaration |
| `grr` / `gri` / `grt` | References / implementations / type definitions |
| `grn` / `gra` / `K` (`Shift-K`) | Rename / code actions / formatted hover |
| `<C-k>` (insert) | Show/hide signature help |
| `[d` / `]d` | Previous / next diagnostic (native mappings) |
| `<Space>cd` | Diagnostic details |
| `<Space>cf` | Format buffer or visual selection |
| `<Space>ff` / `<Space>fF` | Files: project / cwd |
| `<Space>fb` / `<Space>fo` | Buffers / recent files |
| `<Space>sg` / `<Space>sG` | Live grep: project / cwd |
| `<Space>sw` | Search word or visual selection |
| `<Space>sd` / `<Space>sD` | Go module check (otherwise reported project diagnostics) / current buffer |
| `<Space>sh` / `<Space>sk` | Help / keymaps |
| `<Space>ss` / `<Space>sS` | Document / workspace symbols |
| `<Space>e` / `<Space>E` | Reveal active file in project explorer / explorer in cwd |
| `<Space>gg` | LazyGit |
| `[c` / `]c` | Previous / next Git hunk; native behavior in diff windows |
| `<Space>hp` / `<Space>hs` / `<Space>hr` | Preview / stage or unstage / reset hunk |
| `<Space>hs` / `<Space>hr` (visual) | Stage / reset selected lines |
| `<Space>hb` | Blame current line |
| `<Space>uf` / `<Space>uF` | Toggle format-on-save: global / buffer |
| `<Space>ud` / `<Space>uh` | Toggle diagnostics / supported inlay hints |
| `<Space>?` | Show buffer-local keymaps |

LSP navigation uses Telescope pickers, jumping directly when there is one location.
Declarations (`gD`) use native LSP navigation; workspace symbols search dynamically.
Continuous inline Git blame is disabled; use the explicit blame mapping.

## Extending and maintenance

Add a spec to an existing `lua/plugins/` file or a new file returning a spec table;
lazy.nvim imports it automatically. Use `opts` for settings and `event`, `ft`, `cmd`,
or `keys` when lazy loading is supported. Mason, nvim-tree, and Treesitter initialize
at startup; indent guides, LSP, and Git load when files open; Telescope and LazyGit
load on use, and the remaining UI loads after startup.

Add a server to the `servers` list in `lua/plugins/lsp.lua`, then put overrides in
`after/lsp/<server>.lua`. Add formatters in `lua/plugins/formatting.lua` and their
Mason package names to the installation list in `lua/plugins/lsp.lua`. Add parsers
in `lua/plugins/treesitter.lua`. Restart Neovim after changing server/tool lists.

Use `after/ftplugin/<filetype>.lua` and `vim.opt_local` for filetype-specific editor
settings. Append cleanup to `b:undo_ftplugin` for settings that need resetting when
a buffer changes filetype.

Use `:Lazy` for plugins, `:Mason` for tools, `:ConformInfo` for formatting, and
`:checkhealth vim.lsp telescope nvim-tree nvim-treesitter blink.cmp which-key` for diagnostics.
After intentional plugin updates, commit `lazy-lock.json`; `:Lazy restore` returns
to locked revisions. Mason tools and compiled parsers have separate versions and
are not pinned by lazy.nvim's lockfile. Treesitter's build hook runs `:TSUpdate`
after plugin changes.

Format Lua with `stylua init.lua lua after`; check with
`stylua --check init.lua lua after`.
