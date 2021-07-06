-- target: ~/.config/nvim/lua/treesitter.lua

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "javascript", "typescript", "tsx", "query", "lua" },
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
  indent = { enable = true },
}
