return {
  root_dir = nvim_lsp.util.root_pattern("tsconfig.json"),
  capabilities = capabilities,
  single_file_support = false,
  init_options = {
    hostInfo = "neovim",
    maxTsServerMemory = 12288,
  },
};
