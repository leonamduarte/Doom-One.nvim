local M = {}

---@class DoomOneConfig
M.defaults = {
  transparent = false,
  background = nil, -- "dark", "darker", "light"
  colors = {},
  highlights = {},
  styles = {
    comments = { italic = true },
    conditionals = { italic = true },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  integrations = {
    all = true,
  },
}

M.options = vim.tbl_deep_extend("force", {}, M.defaults)

function M.setup(opts)
  opts = opts or {}

  if opts.integrations ~= nil and type(opts.integrations) ~= "table" then
    vim.notify(
      string.format("[doom-one] integrations must be a table, got '%s'. Using default.", type(opts.integrations)),
      vim.log.levels.WARN
    )
    opts.integrations = vim.deepcopy(M.defaults.integrations)
  end

  M.options = vim.tbl_deep_extend("force", M.defaults, opts)
end

return M
