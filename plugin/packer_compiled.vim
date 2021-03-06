" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time("Luarocks path setup", true)
local package_path_str = "/Users/nmrvtz/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/nmrvtz/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/nmrvtz/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/nmrvtz/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/nmrvtz/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time("Luarocks path setup", false)
time("try_loadstring definition", true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time("try_loadstring definition", false)
time("Defining packer_plugins", true)
_G.packer_plugins = {
  ["TrueZen.nvim"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/TrueZen.nvim"
  },
  everforest = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/everforest"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/friendly-snippets"
  },
  ["galaxyline.nvim"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  kommentary = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/kommentary"
  },
  ["lightspeed.nvim"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/lightspeed.nvim"
  },
  ["lsp-colors.nvim"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["material.nvim"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/material.nvim"
  },
  neoformat = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/neoformat"
  },
  ["neoscroll.nvim"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/neoscroll.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-base16.lua"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/nvim-base16.lua"
  },
  ["nvim-bufferline.lua"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  sonokai = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/sonokai"
  },
  ["startuptime.vim"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/startuptime.vim"
  },
  ["telescope-media-files.nvim"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/telescope-media-files.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["trouble.nvim"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/trouble.nvim"
  },
  ["vim-auto-save"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/vim-auto-save"
  },
  ["vim-closetag"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/vim-closetag"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/vim-devicons"
  },
  ["vim-hybrid-material"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/vim-hybrid-material"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  },
  ["zephyr-nvim"] = {
    loaded = true,
    path = "/Users/nmrvtz/.local/share/nvim/site/pack/packer/start/zephyr-nvim"
  }
}

time("Defining packer_plugins", false)
if should_profile then save_profiles() end

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
