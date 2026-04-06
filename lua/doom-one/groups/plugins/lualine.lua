local M = {}

function M.get(palette, config)
  return {
    -- Lualine basic highlights if needed
  }
end

function M.theme(palette)
  local colors = palette or M._resolve_palette()

  return {
    normal = {
      a = { bg = colors.blue, fg = colors.base0, gui = "bold" },
      b = { bg = colors.base4, fg = colors.fg },
      c = { bg = colors.base2, fg = colors.fg },
    },
    insert = {
      a = { bg = colors.green, fg = colors.base0, gui = "bold" },
      b = { bg = colors.base4, fg = colors.fg },
    },
    visual = {
      a = { bg = colors.magenta, fg = colors.base0, gui = "bold" },
      b = { bg = colors.base4, fg = colors.fg },
    },
    replace = {
      a = { bg = colors.red, fg = colors.base0, gui = "bold" },
      b = { bg = colors.base4, fg = colors.fg },
    },
    command = {
      a = { bg = colors.orange, fg = colors.base0, gui = "bold" },
      b = { bg = colors.base4, fg = colors.fg },
    },
    inactive = {
      a = { bg = colors.base1, fg = colors.base5, gui = "bold" },
      b = { bg = colors.base1, fg = colors.base5 },
      c = { bg = colors.base1, fg = colors.base5 },
    },
  }
end

function M._resolve_palette()
  local ok, config = pcall(require, "doom-one.config")
  if ok and config.options and config.options.background then
    return require("doom-one.palette").get_palette(config.options.background)
  end
  return require("doom-one.palette").get_palette(vim.o.background)
end

return M
