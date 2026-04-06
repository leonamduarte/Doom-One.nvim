local M = {}

M.colors = {
  dark = {
    bg = "#282c34",
    fg = "#bbc2cf",

    bg_alt = "#21242b",
    fg_alt = "#5b6268",

    base0 = "#1b2229",
    base1 = "#1c1f24",
    base2 = "#202328",
    base3 = "#23272e",
    base4 = "#3f444a",
    base5 = "#5b6268",
    base6 = "#73797e",
    base7 = "#9ca0a4",
    base8 = "#dfdfdf",

    grey = "#3f444a",
    red = "#ff6c6b",
    orange = "#da8548",
    green = "#98be65",
    teal = "#4db5bd",
    yellow = "#ecbe7b",
    blue = "#51afef",
    dark_blue = "#2257a0",
    magenta = "#c678dd",
    violet = "#a9a1e1",
    cyan = "#46d9ff",
    dark_cyan = "#5699af",
    variable = "#dcaeea",
  },
  darker = {
    bg = "#1c1f24",
    fg = "#bbc2cf",

    bg_alt = "#17191e",
    fg_alt = "#5b6268",

    base0 = "#0f1115",
    base1 = "#111317",
    base2 = "#14161b",
    base3 = "#1a1c21",
    base4 = "#3f444a",
    base5 = "#5b6268",
    base6 = "#73797e",
    base7 = "#9ca0a4",
    base8 = "#dfdfdf",

    grey = "#3f444a",
    red = "#ff6c6b",
    orange = "#da8548",
    green = "#98be65",
    teal = "#4db5bd",
    yellow = "#ecbe7b",
    blue = "#51afef",
    dark_blue = "#2257a0",
    magenta = "#c678dd",
    violet = "#a9a1e1",
    cyan = "#46d9ff",
    dark_cyan = "#5699af",
    variable = "#dcaeea",
  },
  vibrant = {
    bg = "#1a1b26", -- High contrast background
    fg = "#c0caf5",

    bg_alt = "#16161e",
    fg_alt = "#565f89",

    base0 = "#15161e",
    base1 = "#1a1b26",
    base2 = "#24283b",
    base3 = "#292e42",
    base4 = "#414868",
    base5 = "#5b6268",
    base6 = "#73797e",
    base7 = "#9ca0a4",
    base8 = "#dfdfdf",

    grey = "#3f444a",
    red = "#ff6c6b",
    orange = "#da8548",
    green = "#98be65",
    teal = "#4db5bd",
    yellow = "#ecbe7b",
    blue = "#51afef",
    dark_blue = "#2257a0",
    magenta = "#c678dd",
    violet = "#a9a1e1",
    cyan = "#46d9ff",
    dark_cyan = "#5699af",
    variable = "#dcaeea",
  },
  light = {
    bg = "#fafafa",
    fg = "#383a42",

    bg_alt = "#f0f0f0",
    fg_alt = "#c6c7c7",

    base0 = "#f0f0f0",
    base1 = "#e7e7e7",
    base2 = "#dfdfdf",
    base3 = "#c6c7c7",
    base4 = "#9ca0a4",
    base5 = "#424242",
    base6 = "#2e2e2e",
    base7 = "#1e1e1e",
    base8 = "#1b2229",

    grey = "#9ca0a4",
    red = "#e45649",
    orange = "#da8548",
    green = "#50a14f",
    teal = "#4db5bd",
    yellow = "#986801",
    blue = "#4078f2",
    dark_blue = "#a0bcf8",
    magenta = "#a626a4",
    violet = "#b751b6",
    cyan = "#0184bc",
    dark_cyan = "#005478",
    variable = "#a626a4",
  },
}

function M.get_palette(background)
  return M.colors[background] or M.colors.dark
end

local function hex_to_rgb(hex)
  if type(hex) ~= "string" then
    return nil
  end
  hex = hex:gsub("#", "")
  if #hex ~= 6 then
    return nil
  end
  local r = tonumber("0x" .. hex:sub(1, 2))
  local g = tonumber("0x" .. hex:sub(3, 4))
  local b = tonumber("0x" .. hex:sub(5, 6))
  if r == nil or g == nil or b == nil then
    return nil
  end
  return r, g, b
end

local function rgb_to_hex(r, g, b)
  return string.format("#%02x%02x%02x", r, g, b)
end

function M.blend(foreground, background, alpha)
  if background == "NONE" then
    return "NONE"
  end
  if type(foreground) ~= "string" then
    return foreground
  end
  alpha = alpha or 0.15
  local r1, g1, b1 = hex_to_rgb(foreground)
  local r2, g2, b2 = hex_to_rgb(background)
  if r1 == nil or r2 == nil then
    return foreground
  end
  local r = math.floor(r1 * alpha + r2 * (1 - alpha))
  local g = math.floor(g1 * alpha + g2 * (1 - alpha))
  local b = math.floor(b1 * alpha + b2 * (1 - alpha))
  return rgb_to_hex(r, g, b)
end

return M
