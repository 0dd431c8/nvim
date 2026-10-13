return {
  on_init = function(client)
    local root = client.config.root_dir
    if not root or vim.uv.fs_realpath(root) ~= vim.uv.fs_realpath(vim.fn.stdpath("config")) then
      return
    end
    if vim.uv.fs_stat(root .. "/.luarc.json") or vim.uv.fs_stat(root .. "/.luarc.jsonc") then
      return
    end

    -- Provide Neovim's APIs only for this config; other Lua projects keep
    -- their own runtime and workspace settings.
    client.config.settings = vim.tbl_deep_extend("force", client.config.settings or {}, {
      Lua = {
        runtime = { version = "LuaJIT" },
        workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
      },
    })
  end,
}
