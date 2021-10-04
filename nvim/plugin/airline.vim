let g:airline_theme='gruvbox' " set preferred theme
let g:airline_powerline_fonts = 1 " use powerline symbols
let g:airline#extensions#tabline#enabled = 1 " turn on tabline

" straight separators in tabline
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" filename formatting in tabline
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
