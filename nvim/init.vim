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
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'w0rp/ale'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --js-completer' }
Plug 'wesQ3/vim-windowswap'
Plug 'tpope/vim-fugitive'
"Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
"Plug 'autozimu/LanguageClient-neovim', {
"    \ 'branch': 'next',
"    \ 'do': 'bash install.sh',
"    \ }
" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'

" initialize plugin system
call plug#end()

" Key Bindings

" variables
let mapleader = ","
let maplocalleader = "\\"

nnoremap <leader>e <ESC>:NERDTreeToggle<CR>
nnoremap <leader>t <ESC>:NERDTree<CR>
nnoremap <leader>qq <ESC>:qall!<CR>
nnoremap <leader>w <ESC>:qall<CR>

" Window Splitting
nnoremap <C-J> <C-W><C-J> 
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Plugin Settings
" 
" YouCompleteMe
let g:ycm_autoclose_preview_window_after_insertion = 1

" LanguageClient 
" Automatically start language servers.
"let g:LanguageClient_autoStart = 1
"let g:LanguageClient_serverCommmands = {
"  \ 'javascript' : 'javascript-typescript-langserver',
"  \ 'typescript' : 'javascript-typescript-langserver',
"  \ }


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
set incsearch
set mouse=a

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

" Don't offer to open certain files/directories
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
set wildignore+=node_modules/*,bower_components/*


" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Or if you have Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

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

" Automatic Bindings
augroup everything
autocmd!

" Open NerdTree when no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Close Vim if NerdTree is the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" End Automatic Bindings
augroup END
