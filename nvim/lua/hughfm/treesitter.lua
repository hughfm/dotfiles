-- target: ~/.config/nvim/lua/hughfm/treesitter.lua

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "javascript", "typescript", "tsx", "query", "lua", "json", "jsonc", "css", "graphql", "php", "proto", "java", "prisma", "vimdoc" },
  highlight = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      scope_incremental = "<CR>",
      node_incremental = "<TAB>",
      node_decremental = "<S-TAB>",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    lsp_interop = {
      enable = true,
      border = 'double',
      peek_definition_code = {
        ["df"] = "@function.outer",
        ["dF"] = "@class.outer",
      },
    },
  },
  indent = { enable = true },
}
