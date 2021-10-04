-- target: ~/.config/nvim/lua/eslint.lua

local nvim_lsp = require('lspconfig')

local config = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = { "%f:%l:%c: %m" },
}

local log_path = "~/efm.log"

local efm_languages = {
  typescript = { config },
  typescriptreact = { config }
}

nvim_lsp.efm.setup {
  root_dir = nvim_lsp.util.root_pattern(
    ".eslintrc.cjs",
    ".eslintrc.js",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    ".eslintrc.json",
    "package.json"
  ),
  settings = {
    languages = efm_languages,
    log_level = 1,
    log_file = log_path,
  },
  filetypes = vim.tbl_keys(efm_languages),
  init_options = { documentFormatting = true, codeAction = true },
}
