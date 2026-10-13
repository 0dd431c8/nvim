return {
  {
    "mason-org/mason.nvim",
    lazy = false,
    opts = {
      PATH = "prepend",
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    ft = { "go", "gomod", "gowork" },
    cmd = { "MasonToolsInstall", "MasonToolsInstallSync", "MasonToolsUpdate", "MasonToolsUpdateSync" },
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = { "gopls", "goimports", "golangci-lint" },
      auto_update = false,
      run_on_start = true,
    },
    config = function(_, opts)
      local installer = require "mason-tool-installer"
      installer.setup(opts)
      -- Filetype loading can happen after the plugin's VimEnter hook has passed.
      if vim.v.vim_did_enter == 1 then
        installer.run_on_start()
      end
    end,
  },
}
