nmap <leader>f :Files<CR>
nmap <leader>b :Buffers<CR>

let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.5, 'highlight': 'Comment' } }

" FZF colors to match colorscheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(
  \   <q-args>,
  \   fzf#vim#with_preview('up:50%'),
  \   <bang>0
  \ )

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(
  \   <q-args>,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:50%'),
  \   <bang>0
  \ )

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --sort path --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview('up:50%'),
  \   <bang>0
  \ )
