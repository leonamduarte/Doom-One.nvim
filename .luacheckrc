-- Luacheck configuration for Doom-One.nvim

-- Allow vim, vim.g, vim.o, vim.api, vim.cmd, vim.log, vim.tbl_extend,
-- vim.tbl_deep_extend, vim.fn as Neovim globals
globals = {
  "vim",
}

-- Ignore "unused argument" for `config` parameter (standard contract)
unused_args = false

-- Ignore "unused top-level function" for module pattern
unused_secondaries = false

-- Files to check
files = {
  "lua/",
  "colors/",
}

-- Exclude patterns
exclude_files = {
  "lua/doom-one/groups/plugins/*.lua",
}
