require('nvim-treesitter').setup {
  -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
  install_dir = vim.fn.stdpath('data') .. '/site'
}

require('nvim-treesitter').install {
  "javascript",
  "typescript",
  "tsx",
  "query",
  "lua",
  "json",
  "jsonc",
  "css",
  "graphql",
  "php",
  "proto",
  "java",
  "prisma",
  "vimdoc",
}
