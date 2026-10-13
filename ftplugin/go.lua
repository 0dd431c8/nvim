local map = function(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { buffer = true, desc = "Go " .. desc })
end

map("<leader>Gl", function()
  vim.cmd "update"
  require("configs.go").lint()
end, "lint package")

map("<leader>Gt", function()
  require("configs.go").run { "test", "-v", "." }
end, "test package")

map("<leader>Ga", function()
  require("configs.go").run({ "test", "./..." }, true)
end, "test module")

map("<leader>Gr", function()
  require("configs.go").run { "run", "." }
end, "run package")

map("<leader>Gv", function()
  require("configs.go").run({ "vet", "./..." }, true)
end, "vet module")
