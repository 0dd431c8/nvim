local M = {}
local running = {}

local function show_results(root, issues)
  local Path = require("plenary.path")
  local severities = { error = "ERROR", warning = "WARN", refactor = "INFO", convention = "HINT" }
  local items = {}
  for _, issue in ipairs(issues) do
    local pos = issue.Pos
    if pos and pos.Filename then
      local filename = pos.Filename
      if not Path:new(filename):is_absolute() then
        filename = vim.fs.joinpath(root, filename)
      end
      items[#items + 1] = {
        filename = vim.fs.normalize(filename),
        lnum = math.max(pos.Line or 1, 1),
        col = math.max(pos.Column or 1, 1),
        text = (issue.FromLinter or "golangci-lint") .. ": " .. (issue.Text or ""):gsub("\n", " "),
        type = severities[issue.Severity]
          or (issue.FromLinter == "typecheck" and "ERROR" or "WARN"),
      }
    end
  end
  if #items == 0 then
    vim.notify("No Go project diagnostics found (saved files).")
    return
  end

  table.sort(items, function(a, b)
    if a.type ~= b.type then
      return vim.diagnostic.severity[a.type] < vim.diagnostic.severity[b.type]
    elseif a.filename ~= b.filename then
      return a.filename < b.filename
    elseif a.lnum ~= b.lnum then
      return a.lnum < b.lnum
    end
    return a.col < b.col
  end)

  local opts = { cwd = root }
  local config = require("telescope.config").values
  require("telescope.pickers")
    .new(opts, {
      prompt_title = "Go Project Diagnostics (saved files)",
      finder = require("telescope.finders").new_table({
        results = items,
        entry_maker = require("telescope.make_entry").gen_from_diagnostics(opts),
      }),
      previewer = config.qflist_previewer(opts),
      sorter = config.generic_sorter(opts),
    })
    :find()
end

function M.show()
  local root = require("config.root")()
  if vim.bo.filetype == "NvimTree" then
    root = require("nvim-tree.core").get_cwd() or root
  end
  local filename = vim.api.nvim_buf_get_name(0)
  local go_root =
    vim.fs.root(filename ~= "" and vim.bo.buftype == "" and filename or root, "go.mod")
  if not go_root then
    require("telescope.builtin").diagnostics({ root_dir = root })
    return
  end
  if running[go_root] then
    vim.notify("Go project diagnostics are already running.")
    return
  end
  if vim.fn.executable("golangci-lint") ~= 1 then
    vim.notify(
      "Install golangci-lint through :Mason before checking the Go project.",
      vim.log.levels.ERROR
    )
    return
  end

  -- Scan saved files without opening them or changing cwd, buffers, or quickfix lists.
  local command = {
    "golangci-lint",
    "run",
    "--output.json.path=stdout",
    "--show-stats=false",
    "--issues-exit-code=0",
    "--path-mode=abs",
    "--allow-parallel-runners",
    "--max-issues-per-linter=0",
    "--max-same-issues=0",
    "--uniq-by-line=false",
  }
  for _, format in ipairs({
    "text",
    "tab",
    "html",
    "checkstyle",
    "code-climate",
    "junit-xml",
    "teamcity",
    "sarif",
  }) do
    command[#command + 1] = "--output." .. format .. ".path="
  end
  command[#command + 1] = "./..."

  running[go_root] = true
  vim.notify("Checking saved Go files across the module…")
  return vim.system(command, { cwd = go_root, text = true }, function(result)
    vim.schedule(function()
      running[go_root] = nil
      if result.code ~= 0 then
        vim.notify(
          "Go project check failed:\n" .. vim.trim(result.stderr or ""),
          vim.log.levels.ERROR
        )
        return
      end
      local ok, report = pcall(vim.json.decode, result.stdout or "")
      if not ok or type(report) ~= "table" then
        vim.notify("golangci-lint returned invalid JSON diagnostics.", vim.log.levels.ERROR)
        return
      end
      show_results(go_root, type(report.Issues) == "table" and report.Issues or {})
    end)
  end)
end

return M
