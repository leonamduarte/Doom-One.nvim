local M = {}

local health = vim.health

local function start()
  if health.start then
    health.start("doom-one.nvim")
  else
    health.report_start("doom-one.nvim")
  end
end

local function ok(msg)
  if health.ok then
    health.ok(msg)
  else
    health.report_ok(msg)
  end
end

local function warn(msg)
  if health.warn then
    health.warn(msg)
  else
    health.report_warn(msg)
  end
end

local function error(msg)
  if health.error then
    health.error(msg)
  else
    health.report_error(msg)
  end
end

local function info(msg)
  if health.info then
    health.info(msg)
  else
    health.report_info(msg)
  end
end

local plugin_require_map = {
  ["telescope.nvim"] = "telescope",
  ["gitsigns.nvim"] = "gitsigns",
  ["nvim-tree.lua"] = "nvim-tree",
  ["lualine.nvim"] = "lualine",
  ["bufferline.nvim"] = "bufferline",
  ["nvim-cmp"] = "cmp",
  ["neo-tree.nvim"] = "neo-tree",
}

local function _plugin_available(plugin_repo)
  local mod_name = plugin_require_map[plugin_repo]
  if mod_name then
    local mod_ok, _ = pcall(require, mod_name)
    if mod_ok then return true end
  end

  local paths = {
    vim.o.packpath,
    vim.fn.stdpath("data") .. "/lazy",
  }
  for _, path in ipairs(paths) do
    if vim.fn.globpath(path, plugin_repo, false, true) ~= "" then return true end
  end

  return false
end

function M.check()
  start()

  -- Neovim version
  local nvim_version = vim.version()
  info(string.format("Neovim %d.%d.%d", nvim_version.major, nvim_version.minor, nvim_version.patch))

  -- termguicolors
  if vim.o.termguicolors then
    ok("termguicolors is enabled")
  else
    warn("termguicolors is not enabled; colors may not render correctly")
  end

  -- Module loading
  local ok_doom, doom_one = pcall(require, "doom-one")
  if ok_doom then
    ok("doom-one module loaded successfully")
  else
    error("Failed to load doom-one module: " .. tostring(doom_one))
    return
  end

  -- Config validation
  local ok_config, config = pcall(require, "doom-one.config")
  if not ok_config then
    error("Failed to load doom-one config")
    return
  end

  local opts = config.options
  if not opts then
    error("doom-one config.options is nil")
    return
  end

  if opts.background then
    local valid_bg = { dark = true, darker = true, light = true }
    if valid_bg[opts.background] then
      ok(string.format("Background variant: %s", opts.background))
    else
      error(
        string.format(
          "Invalid background variant: %s (expected dark, darker, or light)",
          opts.background
        )
      )
    end
  else
    info("Background variant: default (uses vim.o.background)")
  end

  if opts.transparent then info("Transparent mode: enabled") end

  -- Integrations
  if opts.integrations and opts.integrations.all then
    info("Plugin integrations: all enabled")
  elseif opts.integrations then
    local enabled = {}
    for name, val in pairs(opts.integrations) do
      if val and name ~= "all" then table.insert(enabled, name) end
    end
    if #enabled > 0 then
      info("Plugin integrations: " .. table.concat(enabled, ", "))
    else
      warn("No plugin integrations enabled")
    end
  else
    warn("Plugin integrations not configured")
  end

  -- Palette validation
  local ok_palette, palette_mod = pcall(require, "doom-one.palette")
  if ok_palette then
    local palette = palette_mod.get_palette(opts.background or vim.o.background)
    local required_colors =
      { "bg", "fg", "red", "blue", "green", "yellow", "magenta", "cyan", "variable" }
    local missing = {}
    for _, color in ipairs(required_colors) do
      if palette[color] == nil then table.insert(missing, color) end
    end
    if #missing == 0 then
      ok("Palette contains all required colors")
    else
      error("Missing palette colors: " .. table.concat(missing, ", "))
    end
  else
    error("Failed to load doom-one palette")
  end

  -- Check for conflicting colorschemes
  local current = vim.g.colors_name
  if current == "doom-one" then
    ok("doom-one is the active colorscheme")
  elseif current then
    warn(string.format("Active colorscheme is '%s', not 'doom-one'", current))
  else
    warn("No colorscheme is currently active")
  end

  -- Plugin integration availability
  local plugins = {
    telescope = "telescope.nvim",
    gitsigns = "gitsigns.nvim",
    nvimtree = "nvim-tree.lua",
    lualine = "lualine.nvim",
    bufferline = "bufferline.nvim",
    cmp = "nvim-cmp",
    neotree = "neo-tree.nvim",
  }

  local check = opts.integrations
  for plugin_name, plugin_repo in pairs(plugins) do
    local should_check = (check and check.all) or (check and check[plugin_name])
    if should_check then
      if _plugin_available(plugin_repo) then
        ok(string.format("Plugin available: %s", plugin_repo))
      else
        warn(string.format("Plugin not found: %s (integration will be skipped)", plugin_repo))
      end
    end
  end
end

return M
