local M = {}

function M.get(palette, config)
  local styles = config.styles or {}
  local blend = require("doom-one.palette").blend
  local bg = config.transparent and "NONE" or palette.bg

  return {
    -- TreeSitter: Identifiers & Variables
    ["@variable"] = vim.tbl_extend("force", { fg = palette.variable }, styles.variables or {}),
    ["@variable.builtin"] = { fg = palette.magenta },
    ["@variable.parameter"] = { fg = palette.orange },
    ["@variable.parameter.builtin"] = { fg = palette.orange },
    ["@variable.member"] = vim.tbl_extend("force", { fg = palette.cyan }, styles.properties or {}),
    ["@property"] = vim.tbl_extend("force", { fg = palette.cyan }, styles.properties or {}),

    -- TreeSitter: Constants
    ["@constant"] = { link = "Constant" },
    ["@constant.builtin"] = { fg = palette.orange },
    ["@constant.macro"] = { fg = palette.violet },

    -- TreeSitter: Modules & Labels
    ["@module"] = { fg = palette.yellow },
    ["@module.builtin"] = { fg = palette.yellow },
    ["@label"] = { link = "Label" },

    -- TreeSitter: Strings & Literals
    ["@string"] = { link = "String" },
    ["@string.documentation"] = { fg = palette.green },
    ["@string.regexp"] = { fg = palette.green },
    ["@string.escape"] = { fg = palette.orange },
    ["@string.special"] = { fg = palette.orange },
    ["@string.special.symbol"] = { fg = palette.orange },
    ["@string.special.url"] = { fg = palette.dark_cyan, underline = true },
    ["@string.special.path"] = { fg = palette.green },
    ["@character"] = { link = "Character" },
    ["@character.special"] = { link = "SpecialChar" },
    ["@number"] = { link = "Number" },
    ["@number.float"] = { fg = palette.orange },
    ["@boolean"] = { link = "Boolean" },

    -- TreeSitter: Types
    ["@type"] = { link = "Type" },
    ["@type.builtin"] = { fg = palette.yellow },
    ["@type.definition"] = { fg = palette.yellow },
    ["@attribute"] = { fg = palette.yellow },
    ["@attribute.builtin"] = { fg = palette.yellow },

    -- TreeSitter: Functions
    ["@function"] = { link = "Function" },
    ["@function.builtin"] = { fg = palette.magenta },
    ["@function.call"] = { fg = palette.magenta },
    ["@function.macro"] = { fg = palette.violet },
    ["@function.method"] = { fg = palette.cyan },
    ["@function.method.call"] = { fg = palette.magenta },
    ["@constructor"] = { fg = palette.yellow },
    ["@operator"] = { link = "Operator" },

    -- TreeSitter: Keywords
    ["@keyword"] = { link = "Keyword" },
    ["@keyword.coroutine"] = { link = "@keyword" },
    ["@keyword.function"] = { link = "@keyword" },
    ["@keyword.operator"] = { link = "@keyword" },
    ["@keyword.import"] = { link = "Include" },
    ["@keyword.type"] = { fg = palette.yellow },
    ["@keyword.modifier"] = { fg = palette.yellow },
    ["@keyword.repeat"] = { link = "Repeat" },
    ["@keyword.return"] = { link = "@keyword" },
    ["@keyword.debug"] = { link = "Debug" },
    ["@keyword.exception"] = { link = "Exception" },
    ["@keyword.conditional"] = { link = "Conditional" },
    ["@keyword.conditional.ternary"] = { link = "@keyword.conditional" },
    ["@keyword.directive"] = { link = "@keyword" },
    ["@keyword.directive.define"] = { link = "@keyword.directive" },

    -- TreeSitter: Punctuation
    ["@punctuation.bracket"] = { fg = palette.base7 },
    ["@punctuation.delimiter"] = { fg = palette.base7 },
    ["@punctuation.special"] = { fg = palette.blue },

    -- TreeSitter: Comments
    ["@comment"] = { link = "Comment" },
    ["@comment.documentation"] = { link = "Comment" },
    ["@comment.error"] = { link = "DiagnosticError" },
    ["@comment.warning"] = { link = "DiagnosticWarn" },
    ["@comment.hint"] = { link = "DiagnosticHint" },
    ["@comment.info"] = { link = "DiagnosticInfo" },
    ["@comment.todo"] = { fg = palette.yellow },

    -- TreeSitter: Tags (HTML/JSX)
    ["@tag"] = { fg = palette.magenta },
    ["@tag.attribute"] = { fg = palette.orange, italic = true },
    ["@tag.delimiter"] = { fg = palette.base7 },
    ["@tag.builtin"] = { fg = palette.red },
    ["@tag.javascript"] = { fg = palette.magenta },
    ["@tag.tsx"] = { fg = palette.magenta },
    ["@tag.attribute.tsx"] = { fg = palette.orange, italic = true },

    -- TreeSitter: Diff
    ["@diff.plus"] = { fg = palette.green },
    ["@diff.minus"] = { fg = palette.red },
    ["@diff.delta"] = { fg = palette.yellow },

    -- TreeSitter: Markup (Markdown, RST, etc.)
    ["@markup.heading"] = { fg = palette.red, bold = true },
    ["@markup.heading.1"] = { fg = palette.red, bg = blend(palette.red, bg, 0.1), bold = true },
    ["@markup.heading.2"] = {
      fg = palette.orange,
      bg = blend(palette.orange, bg, 0.1),
      bold = true,
    },
    ["@markup.heading.3"] = {
      fg = palette.yellow,
      bg = blend(palette.yellow, bg, 0.1),
      bold = true,
    },
    ["@markup.heading.4"] = { fg = palette.green, bg = blend(palette.green, bg, 0.1), bold = true },
    ["@markup.heading.5"] = { fg = palette.blue, bg = blend(palette.blue, bg, 0.1), bold = true },
    ["@markup.heading.6"] = {
      fg = palette.magenta,
      bg = blend(palette.magenta, bg, 0.1),
      bold = true,
    },
    ["@markup.strong"] = { bold = true },
    ["@markup.italic"] = { italic = true },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.link"] = { fg = palette.cyan },
    ["@markup.link.label"] = { fg = palette.blue, underline = true },
    ["@markup.link.url"] = { fg = palette.dark_cyan, underline = true },
    ["@markup.raw"] = { bg = palette.base3 },
    ["@markup.raw.block"] = { fg = palette.teal },
    ["@markup.list"] = { fg = palette.blue },
    ["@markup.list.checked"] = { fg = palette.green },
    ["@markup.list.unchecked"] = { fg = palette.base5 },
    ["@markup.quote"] = { fg = palette.base6, italic = true },
    ["@markup.math"] = { fg = palette.violet },
  }
end

return M
