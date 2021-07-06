" target: ~/.config/nvim/init.vim
" vim:foldmethod=marker

" vim-plug {{{
call plug#begin('~/.local/share/nvim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'folke/lsp-colors.nvim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/playground'

Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'

" search
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'

" status/tabline
Plug 'vim-airline/vim-airline'

" -- Git --
Plug 'airblade/vim-gitgutter' " shows git status in sidebar
Plug 'tpope/vim-fugitive' " wrapper for git commands
Plug 'tpope/vim-rhubarb'

" runs test files in a variety of languages
Plug 'janko-m/vim-test'

" displays color previews for hex values like #c0ffee and rgb(100, 100, 100).
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" shows contents of registers when you need it.
Plug 'junegunn/vim-peekaboo'

" colors
Plug 'flazz/vim-colorschemes'
Plug 'morhetz/gruvbox'

Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" Load this last
Plug 'ryanoasis/vim-devicons'

call plug#end()
" }}}

let g:gruvbox_vert_split = 'bg4'
colorscheme gruvbox " set preferred colors
set background=light   " Setting light mode

runtime lua/lsp.lua
runtime lua/treesitter.lua

au BufRead,BufNewFile *.sbt set filetype=scala

syntax enable " enables syntax highlighting
filetype plugin indent on " enables filetype detection, and loads filetype plugin and indent files

set backupdir=~/.local/share/nvim/backup " set location for backup files
set backupcopy=auto " let vim decide how to write the backup file

set list " show invisibles

set number " display line numbers
set mouse=a " enable mouse support in all modes
set incsearch " show pattern matches, as they are typed
set cursorline " highlight current line
set termguicolors " 24 bit color
set hidden " allow buffers to become hidden when they are abandoned
set foldcolumn=1 "show folds in a single column on the left
set splitbelow " new windows go below
set splitright " new windows go to the right
set expandtab " use spaces for tabs
set tabstop=2 " number of spaces to fill a tab
set shiftwidth=0 " use tabstop value for determining indentation spaces

" updatetime is set here to reduce the time for gitgutter to update
set updatetime=200 " ms to wait before writing swap file to disk.
set inccommand=nosplit " show substitution results incrementally

match Todo /\s\+$/ " highlight trailing whitespace with Todo group

" ---------------
" -- Colorizer --
" ---------------
let g:colorizer_maxlines = 1000 " mitigates inefficiencies on large files

" ---------
" -- Ack --
" ---------
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" -------------
" -- Airline --
" -------------
let g:airline_theme='gruvbox' " set preferred theme
let g:airline_powerline_fonts = 1 " use powerline symbols
let g:airline#extensions#tabline#enabled = 1 " turn on tabline

" straight separators in tabline
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" filename formatting in tabline
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" --------------
" -- Prettier --
" --------------
let g:prettier#config#single_quote = 'true'
let g:prettier#config#trailing_comma = 'all'
let g:prettier#exec_cmd_async = 1

" ---------
" -- FZF --
" ---------

" Leader shortcuts
nmap <leader>f :Files<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>t :TestFile<CR>
nmap <leader>d :bd<CR>
nmap <leader>c :noh<CR>
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" configure FZF to use Ag
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

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
