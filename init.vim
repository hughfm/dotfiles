" target: ~/.config/nvim/init.vim
" vim:foldmethod=marker

" vim-plug {{{
call plug#begin('~/.local/share/nvim/plugged')

" search
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'

" status/tabline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" -- Git --
Plug 'airblade/vim-gitgutter' " shows git status in sidebar
Plug 'tpope/vim-fugitive' " wrapper for git commands

" intellisense engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" runs test files in a variety of languages
Plug 'janko-m/vim-test'

" displays color previews for hex values like #c0ffee and rgb(100, 100, 100).
Plug 'lilydjwg/colorizer'

" shows contents of registers when you need it.
Plug 'junegunn/vim-peekaboo'

" auto-formatting
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" colors
Plug 'flazz/vim-colorschemes'
Plug 'morhetz/gruvbox'

Plug 'junegunn/vim-easy-align'

" ----------------------
" -- Language Support --
" ----------------------
Plug 'derekwyatt/vim-scala'
Plug 'chr4/nginx.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'HerringtonDarkholme/yats.vim' " (Typescript)
Plug 'fatih/vim-go'
Plug 'zirrostig/vim-jack-syntax'
Plug 'jparise/vim-graphql'
Plug 'elixir-lang/vim-elixir'

" Load this last
Plug 'ryanoasis/vim-devicons'

call plug#end()
" }}}

source ~/dotfiles/vim-coc-mappings.vim

au BufRead,BufNewFile *.sbt set filetype=scala
autocmd FileType json syntax match Comment +\/\/.\+$+ " coc.vim uses jsonc for config
let g:airline#extensions#coc#enabled = 1

syntax enable " enables syntax highlighting
let g:gruvbox_vert_split = 'bg4'
colorscheme gruvbox " set preferred colors
filetype plugin indent on " enables filetype detection, and loads filetype plugin and indent files

set backupdir=~/.local/share/nvim/backup " set location for backup files
set backupcopy=auto " let vim decide how to write the backup file

set nobackup " (coc.vim recommends)
set nowritebackup " (coc.vim recommends)

set cmdheight=2 " size of command prompt (coc.vim recommends)

set shortmess+=c " Don't give |ins-completion-menu| messages (coc.vim recommends)
set signcolumn=yes " Always show signcolumns (coc.vim recommends)

set list " show invisibles
" set listchars=tab:▸-,space:·,eol:¬,trail:·,nbsp:_ " configure characters for invisibles

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

" let g:netrw_keepdir=0 " keeps netrw directory in sync with current directory

match Todo /\s\+$/ " highlight trailing whitespace with Todo group

" --------------
" -- Deoplete --
" --------------
" let g:deoplete#enable_at_startup = 1 " auto-start

" -------------
" -- Neomake --
" -------------
" call neomake#configure#automake('nrwi', 500) " run on ALL changes
" let g:neomake_serialize = 1 " run makers sequentially
" let g:neomake_serialize_abort_on_error = 1 " bail after any maker error
" let g:neomake_open_list = 2 " open location/quickfix list and preserve cursor position

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
let g:airline_theme='base16' " set preferred theme
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
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview('up:50%'),
  \   <bang>0
  \ )
