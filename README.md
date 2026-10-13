**This repo is supposed to be used as config by NvChad users!**

- The main nvchad repo (NvChad/NvChad) is used as a plugin by this repo.
- So you just import its modules , like `require "nvchad.options" , require "nvchad.mappings"`
- So you can delete the .git from this repo ( when you clone it locally ) or fork it :)

# Credits

1) Lazyvim starter https://github.com/LazyVim/starter as nvchad's starter was inspired by Lazyvim's . It made a lot of things easier!

## Go development

Requires Neovim 0.11+ and Go on your PATH. Lazy installs the Go plugins, and
Mason installs `gopls`, `goimports`, and `golangci-lint` when opening a Go file. Mason's
bin directory is added to Neovim's PATH; `gofmt` comes with Go.

For an explicit setup, run `:Lazy install`, then `:MasonToolsInstall` and
`:TSInstall go gomod gosum gowork`. Restart Neovim after the first installation.

`gopls` provides completion, navigation, renaming, code actions, and diagnostics,
including Staticcheck. Saving Go files runs `goimports` and `gofmt` to organize
imports and format code. Existing completion and Go snippets work through nvim-cmp.

`golangci-lint` runs asynchronously through nvim-lint when opening or saving a Go
file inside a module. It analyzes the current package from the nearest `go.mod`
directory and respects your project's `.golangci.yml` / `.golangci.yaml`. Without
a configuration file, it uses its default linters. Findings appear alongside LSP
diagnostics and in Trouble (`<leader>dd`). It does not run on every InsertLeave.
Use `:MasonToolsInstall` to install the linter in an existing setup.

The leader is Space. These shortcuts are available in Go buffers:

| Shortcut | Action |
| --- | --- |
| `<leader>Gt` | Test the current package (`go test -v .`) |
| `<leader>Ga` | Test all packages in the nearest module (`go test ./...`) |
| `<leader>Gr` | Run the current package (`go run .`) |
| `<leader>Gv` | Vet all packages in the nearest module (`go vet ./...`) |
| `<leader>Gl` | Save and lint the current package (`golangci-lint`) |

Run/test/vet commands save the current file and show output in a terminal split.
Press `<C-x>` to leave terminal mode, then `:q` to close the split. Commands run
from the current file's package or module, so they also work when Neovim starts
outside the project. Module commands target the nearest `go.mod`, even inside a
multi-module `go.work` workspace.

Existing LSP shortcuts include `gd` (definition), `gR` (references),
`<leader>ra` (rename), `gra` (code actions), and `K` (documentation).
Use `:checkhealth vim.lsp`, `:ConformInfo`, and `:Mason` to inspect tooling.

Configuration follows the official [gopls settings](https://go.dev/gopls/settings)
and [Conform](https://github.com/stevearc/conform.nvim) documentation. Linting uses
[nvim-lint](https://github.com/mfussenegger/nvim-lint) and
[golangci-lint](https://golangci-lint.run/docs/configuration/file/).
