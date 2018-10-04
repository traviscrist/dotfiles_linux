" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes
Plug 'mhartington/oceanic-next' 
Plug 'vim-airline/vim-airline'
Plug 'othree/yajs.vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'othree/html5.vim'
Plug 'airblade/vim-gitgutter'

" initialize plugin system
call plug#end()

" various settings
set autoindent                 " Minimal automatic indenting for any filetype.
set shiftround
set backspace=indent,eol,start " Proper backspace behavior.
set hidden                     " Possibility to have more than one
                               " unsaved buffers.
"set incsearch                  " Incremental search, hit '<CR>' to stop.
set ruler                      " Shows the current line number at the bottom.
                               " right of the screen.
set wildmenu                   " Great command-line completion, use '<Tab>' to
                               " move around and '<CR>' to validate.<Paste>
set nocompatible            " Disable compatibility to old-time vi
set showmatch               " Show matching brackets.
set ignorecase              " Do case insensitive matching
set hlsearch                " highlight search results

"line length and numbering
"set textwidth=120 
set number                  " add line numbers
set tabstop=2               " number of columns occupied by a tab character
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=2            " width for autoindents
"set fo-=l "idk what this does 

"Window Splitting
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J> 
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Or if you have Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

" netrw setup
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END

"Syntax and Colors
filetype plugin indent on
syntax enable
colorscheme OceanicNext
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
let g:airline_theme='oceanicnext'

"Copy From Vim
set clipboard+=unnamedplus

" 'matchit.vim' is built-in so let's enable it!
" " Hit '%' on 'if' to jump to 'else'.
runtime macros/matchit.vim
