local M = {}

function M.get(palette, config)
  return {
    DiagnosticError = { fg = palette.red },
    DiagnosticWarn = { fg = palette.yellow },
    DiagnosticInfo = { fg = palette.blue },
    DiagnosticHint = { fg = palette.cyan },
    DiagnosticOk = { fg = palette.green },
    DiagnosticUnderlineError = { sp = palette.red, undercurl = true },
    DiagnosticUnderlineWarn = { sp = palette.yellow, undercurl = true },
    DiagnosticUnderlineInfo = { sp = palette.blue, undercurl = true },
    DiagnosticUnderlineHint = { sp = palette.cyan, undercurl = true },
    DiagnosticUnderlineOk = { sp = palette.green, undercurl = true },

    -- LSP Reference highlights
    LspReferenceRead = { bg = palette.base3 },
    LspReferenceText = { bg = palette.base3 },
    LspReferenceWrite = { bg = palette.base3 },
    LspCodeLens = { fg = palette.base5 },
    LspCodeLensSeparator = { fg = palette.base5 },

    -- LSP Semantic Token Types
    ["@lsp.type.boolean"] = { link = "@boolean" },
    ["@lsp.type.builtinType"] = { link = "@type.builtin" },
    ["@lsp.type.comment"] = { link = "@comment" },
    ["@lsp.type.enum"] = { link = "@type" },
    ["@lsp.type.enumMember"] = { link = "@constant" },
    ["@lsp.type.escapeSequence"] = { link = "@string.escape" },
    ["@lsp.type.formatSpecifier"] = { link = "@punctuation.special" },
    ["@lsp.type.interface"] = { fg = palette.yellow },
    ["@lsp.type.keyword"] = { link = "@keyword" },
    ["@lsp.type.namespace"] = { link = "@module" },
    ["@lsp.type.number"] = { link = "@number" },
    ["@lsp.type.operator"] = { link = "@operator" },
    ["@lsp.type.parameter"] = { fg = palette.orange },
    ["@lsp.type.property"] = { fg = palette.cyan },
    ["@lsp.type.selfKeyword"] = { link = "@variable.builtin" },
    ["@lsp.type.typeAlias"] = { link = "@type.definition" },
    ["@lsp.type.unresolvedReference"] = { sp = palette.red, undercurl = true },
    ["@lsp.type.variable"] = { fg = palette.variable },
    ["@lsp.type.function"] = { fg = palette.magenta },
    ["@lsp.type.method"] = { fg = palette.cyan },
    ["@lsp.type.type"] = { fg = palette.yellow },

    -- LSP Semantic Token Modifiers
    ["@lsp.typemod.class.defaultLibrary"] = { link = "@type.builtin" },
    ["@lsp.typemod.enum.defaultLibrary"] = { link = "@type.builtin" },
    ["@lsp.typemod.enumMember.defaultLibrary"] = { link = "@constant.builtin" },
    ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.function.global"] = { link = "@function.builtin" },
    ["@lsp.typemod.keyword.async"] = { link = "@keyword.coroutine" },
    ["@lsp.typemod.macro.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.method.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.operator.injected"] = { link = "@operator" },
    ["@lsp.typemod.string.injected"] = { link = "@string" },
    ["@lsp.typemod.type.defaultLibrary"] = { link = "@type.builtin" },
    ["@lsp.typemod.variable.defaultLibrary"] = { fg = palette.magenta },
    ["@lsp.typemod.variable.injected"] = { link = "@variable" },
    ["@lsp.typemod.variable.readonly"] = { fg = palette.violet },
  }
end

return M
