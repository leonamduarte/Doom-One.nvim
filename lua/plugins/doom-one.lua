-- lazy.nvim spec for Doom-One.nvim
-- Place in: lua/plugins/themes/doom-one.lua
--
-- This file is auto-loaded by lazy.nvim when placed in your plugins directory.
-- No additional configuration needed — just drop it in and restart Neovim.

return {
  {
    "bashln/Doom-One.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- Optional: customize your theme here
      -- background = "dark",
      -- transparent = false,
      -- styles = {
      --   comments = { italic = true },
      --   conditionals = { italic = true },
      -- },
    },
    config = function(_, opts)
      require("doom-one").setup(opts)
      vim.cmd.colorscheme("doom-one")
    end,
  },
}
