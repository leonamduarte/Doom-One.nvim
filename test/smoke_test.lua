-- Doom-One.nvim - Smoke Test

-- Run with: nvim --headless -c "luafile test/smoke_test.lua" -c "q"

local function test(name, fn)
  local ok, err = pcall(fn)
  if ok then
    print("[PASS] " .. name)
  else
    print("[FAIL] " .. name .. ": " .. tostring(err))
    vim.cmd("cquit")
  end
end

test("Module loads without error", function()
  local doom_one = require("doom-one")
  assert(doom_one ~= nil, "require('doom-one') returned nil")
end)

test("Load works without setup() — defaults applied", function()
  local config = require("doom-one.config")
  assert(config.options.integrations ~= nil, "config.options.integrations should not be nil")
  assert(config.options.integrations.all == true, "config.options.integrations.all should default to true")
  assert(config.options.transparent == false, "config.options.transparent should default to false")
end)

test("Setup function works", function()
  local doom_one = require("doom-one")
  doom_one.setup({
    transparent = false,
    background = "dark",
  })
end)

test("Load function works (dark)", function()
  local doom_one = require("doom-one")
  doom_one.setup({ background = "dark" })
  doom_one.load()
  assert(vim.g.colors_name == "doom-one", "colors_name not set")
end)

test("Load function works (darker)", function()
  local doom_one = require("doom-one")
  doom_one.setup({ background = "darker" })
  doom_one.load()
end)

test("Load function works (light)", function()
  local doom_one = require("doom-one")
  doom_one.setup({ background = "light" })
  doom_one.load()
end)

test("Transparent mode works", function()
  local doom_one = require("doom-one")
  doom_one.setup({ transparent = true })
  doom_one.load()
  local hl = vim.api.nvim_get_hl(0, { name = "Normal" })
  assert(hl.bg == nil or hl.bg == -1, "Transparent mode should not set bg")
end)

test("Color overrides work", function()
  local doom_one = require("doom-one")
  doom_one.setup({
    background = "dark",
    colors = { bg = "#000000" },
  })
  doom_one.load()
  local hl = vim.api.nvim_get_hl(0, { name = "Normal" })
  assert(hl.bg == 0, "Color override should set bg to #000000")
end)

test("Highlight overrides work", function()
  local doom_one = require("doom-one")
  doom_one.setup({
    background = "dark",
    highlights = {
      Comment = { fg = "#FF0000", italic = true },
    },
  })
  doom_one.load()
  local hl = vim.api.nvim_get_hl(0, { name = "Comment" })
  assert(hl.italic == true, "Highlight override should set italic")
end)

test("Function-based highlights work", function()
  local doom_one = require("doom-one")
  doom_one.setup({
    background = "dark",
    highlights = function(palette)
      return {
        Comment = { fg = palette.red },
      }
    end,
  })
  doom_one.load()
end)

test("Palette module returns valid palettes", function()
  local palette_mod = require("doom-one.palette")
  for _, variant in ipairs({ "dark", "darker", "light" }) do
    local p = palette_mod.get_palette(variant)
    assert(p.bg ~= nil, variant .. " palette missing bg")
    assert(p.fg ~= nil, variant .. " palette missing fg")
    assert(p.red ~= nil, variant .. " palette missing red")
    assert(p.blue ~= nil, variant .. " palette missing blue")
  end
end)

test("Blend function handles edge cases", function()
  local palette_mod = require("doom-one.palette")
  assert(palette_mod.blend("#ff0000", "NONE", 0.5) == "NONE", "blend with NONE bg should return NONE")
  local result = palette_mod.blend("#ff0000", "#000000", 0.5)
  assert(result:match("^#[0-9a-f]+$"), "blend should return valid hex color")
end)

test("Blend function rejects invalid input gracefully", function()
  local palette_mod = require("doom-one.palette")
  assert(palette_mod.blend(nil, "#000000", 0.5) == nil, "nil foreground should return nil")
  assert(palette_mod.blend("#ff", "#000000", 0.5) == "#ff", "short hex should return unchanged foreground")
  assert(palette_mod.blend("red", "#000000", 0.5) == "red", "named color should return unchanged foreground")
end)

test("Styles are applied", function()
  local doom_one = require("doom-one")
  doom_one.setup({
    background = "dark",
    styles = {
      comments = { italic = true, bold = true },
      functions = { bold = true },
    },
  })
  doom_one.load()
  local hl = vim.api.nvim_get_hl(0, { name = "Comment" })
  assert(hl.italic == true, "Comment should be italic")
  assert(hl.bold == true, "Comment should be bold")
end)

print("\nAll smoke tests passed!")
