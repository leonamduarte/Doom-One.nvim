local M = {}

local core_modules = {
  "editor",
  "syntax",
  "treesitter",
  "lsp",
}

local all_plugins = {
  "telescope",
  "gitsigns",
  "nvimtree",
  "lualine",
  "bufferline",
  "which-key",
  "indent-blankline",
  "dashboard",
  "noice",
  "trouble",
  "notify",
  "flash",
  "render-markdown",
  "headlines",
  "markview",
  "neotree",
  "oil",
  "fzf",
  "cmp",
  "dap",
  "todo-comments",
}

function M.get(palette, config)
  local highlights = {}

  for _, module in ipairs(core_modules) do
    local groups = require("doom-one.groups." .. module).get(palette, config)
    highlights = vim.tbl_deep_extend("force", highlights, groups)
  end

  local integrations = config.integrations or {}
  if integrations.all then
    for _, plugin in ipairs(all_plugins) do
      local ok, mod = pcall(require, "doom-one.groups.plugins." .. plugin)
      if ok then
        highlights = vim.tbl_deep_extend("force", highlights, mod.get(palette, config))
      else
        vim.notify(
          "[doom-one] Failed to load integration: " .. plugin,
          vim.log.levels.WARN
        )
      end
    end
  else
    for plugin, enabled in pairs(integrations) do
      if enabled then
        local ok, mod = pcall(require, "doom-one.groups.plugins." .. plugin)
        if ok then
          highlights = vim.tbl_deep_extend("force", highlights, mod.get(palette, config))
        else
          vim.notify(
            "[doom-one] Failed to load integration: " .. plugin,
            vim.log.levels.WARN
          )
        end
      end
    end
  end

  return highlights
end

return M
