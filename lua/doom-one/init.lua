local M = {}

M.config = require("doom-one.config")

local valid_backgrounds = { dark = true, darker = true, vibrant = true, light = true }
local variants = { "dark", "darker", "vibrant", "light" }

function M.setup(opts)
  M.config.setup(opts)
end

function M.load()
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "doom-one"

  local config = M.config.options
  local background = config.background or vim.o.background

  if valid_backgrounds[background] then
    local bg_value = (background == "light") and "light" or "dark"
    if vim.o.background ~= bg_value then
      vim.o.background = bg_value
    end
  end

  local base_palette = require("doom-one.palette").get_palette(background)
  local palette = vim.tbl_deep_extend("force", base_palette, config.colors or {})
  local highlights = require("doom-one.groups").get(palette, config)

  local custom_highlights = config.highlights
  if type(custom_highlights) == "function" then
    custom_highlights = custom_highlights(palette)
  end
  if type(custom_highlights) == "table" then
    highlights = vim.tbl_deep_extend("force", highlights, custom_highlights)
  end

  for group, spec in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, spec)
  end
end

function M.cycle()
  local config = M.config.options
  local current = config.background or vim.o.background

  local idx = nil
  for i, v in ipairs(variants) do
    if v == current then
      idx = i
      break
    end
  end

  if idx == nil then
    idx = 0
  end

  local next_idx = (idx % #variants) + 1
  local next_variant = variants[next_idx]
  config.background = next_variant
  M.load()
  vim.notify(string.format("[doom-one] Switched to '%s' variant", next_variant), vim.log.levels.INFO)
end

function M._command_handler(opts)
  local fargs = opts.fargs
  if #fargs == 0 then
    M.cycle()
    return
  end

  local action = fargs[1]
  if action == "cycle" then
    M.cycle()
  elseif action == "set" and fargs[2] then
    local variant = fargs[2]
    if valid_backgrounds[variant] then
      M.config.options.background = variant
      M.load()
      vim.notify(string.format("[doom-one] Set variant to '%s'", variant), vim.log.levels.INFO)
    else
      vim.notify(
        string.format("[doom-one] Invalid variant '%s'. Valid: dark, darker, vibrant, light", variant),
        vim.log.levels.ERROR
      )
    end
  elseif action == "info" then
    local config = M.config.options
    local current = config.background or vim.o.background
    vim.notify(
      string.format("[doom-one] Current variant: '%s' | Transparent: %s", current, tostring(config.transparent)),
      vim.log.levels.INFO
    )
  else
    vim.notify("[doom-one] Usage: :DoomOne [cycle|set <variant>|info]", vim.log.levels.WARN)
  end
end

function M._command_complete(arglead)
  local trimmed = vim.trim(arglead)
  local words = trimmed == "" and {} or vim.split(trimmed, "%s+")
  if #words == 0 then
    return vim.tbl_filter(function(a) return a:find(arglead, 1, true) == 1 end, { "cycle", "set", "info" })
  elseif #words == 1 then
    return vim.tbl_filter(function(a) return a:find(words[1], 1, true) == 1 end, { "cycle", "set", "info" })
  elseif words[1] == "set" then
    return vim.tbl_filter(function(v) return v:find(words[2] or "", 1, true) == 1 end, variants)
  end
  return {}
end

if not vim.g.doom_one_command_registered then
  vim.api.nvim_create_user_command("DoomOne", M._command_handler, {
    nargs = "*",
    complete = M._command_complete,
    desc = "Doom-One colorscheme controls: cycle, set <variant>, or info",
  })
  vim.g.doom_one_command_registered = true
end

return M
