require('lualine').setup {
  options = {
    theme = 'catppuccin-frappe',
    component_separators = '',
    section_separators = '',
  },
  sections = {
    lualine_c = { 'filename', 'nvim_treesitter#statusline' },
  }
}
