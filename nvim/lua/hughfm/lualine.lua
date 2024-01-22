require('lualine').setup {
  options = { theme = 'catppuccin-frappe' },
  sections = {
    lualine_c = { 'filename', 'nvim_treesitter#statusline' },
  }
}
