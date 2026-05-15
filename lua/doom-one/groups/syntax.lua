local M = {}

function M.get(palette, config)
  local styles = config.styles or {}

  return {
    Comment = vim.tbl_extend("force", { fg = palette.comment_color }, styles.comments or {}),
    Constant = { fg = palette.violet },
    String = vim.tbl_extend("force", { fg = palette.green }, styles.strings or {}),
    Character = { fg = palette.green },
    Number = vim.tbl_extend("force", { fg = palette.orange }, styles.numbers or {}),
    Boolean = vim.tbl_extend("force", { fg = palette.violet }, styles.booleans or {}),
    Float = { fg = palette.orange },
    Identifier = vim.tbl_extend("force", { fg = palette.variable }, styles.variables or {}),
    Function = vim.tbl_extend("force", { fg = palette.magenta }, styles.functions or {}),
    Statement = { fg = palette.keyword_color },
    Conditional = vim.tbl_extend("force", { fg = palette.keyword_color }, styles.conditionals or {}),
    Repeat = vim.tbl_extend("force", { fg = palette.keyword_color }, styles.loops or {}),
    Label = { fg = palette.violet },
    Operator = vim.tbl_extend("force", { fg = palette.blue }, styles.operators or {}),
    Keyword = vim.tbl_extend("force", { fg = palette.keyword_color }, styles.keywords or {}),
    Exception = { fg = palette.keyword_color },
    PreProc = { fg = palette.violet },
    Include = { fg = palette.violet },
    Define = { fg = palette.violet },
    Macro = { fg = palette.violet },
    PreCondit = { fg = palette.violet },
    Type = vim.tbl_extend("force", { fg = palette.yellow }, styles.types or {}),
    StorageClass = { fg = palette.yellow },
    Structure = { fg = palette.yellow },
    Typedef = { fg = palette.yellow },
    Special = { fg = palette.blue },
    SpecialChar = { fg = palette.orange },
    Tag = { fg = palette.red },
    Delimiter = { fg = palette.base7 },
    SpecialComment = { fg = palette.base5 },
    Debug = { fg = palette.red },
    Underlined = { fg = palette.blue, underline = true },
    Ignore = { fg = palette.base5 },
    Error = { fg = palette.red, bold = true },
    Todo = { fg = palette.magenta, bold = true },
  }
end

return M
