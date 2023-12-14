lua <<EOF
-- see https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
local telescope = require "telescope"
local actions = require "telescope.actions"
require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
      },
    },
  },
}
EOF
