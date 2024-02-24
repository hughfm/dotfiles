require("catppuccin").setup {
  integrations = {
    notify = true,
    cmp = true,
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
      },
      underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
      },
      inlay_hints = {
          background = true,
      },
    },
    telescope = {
      enabled = true,
      border = true,
    },
    gitgutter = true,
  },
}
