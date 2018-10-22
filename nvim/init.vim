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
"Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'w0rp/ale'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --js-completer' }
"Plug 'wesQ3/vim-windowswap'
"Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 't9md/vim-choosewin'
"Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'wincent/ferret'
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'
Plug 'Raimondi/delimitMate' 
"Plug 'jhawthorn/fzy'

" Devicons Must be last
Plug 'ryanoasis/vim-devicons'
" initialize plugin system
call plug#end()

" Key Bindings

" variables
let mapleader = ","
let maplocalleader = "\\"

nnoremap <leader>e <ESC>:NERDTreeToggle<CR>
nnoremap <leader>t <ESC>:NERDTreeFocus<CR>
nnoremap <leader>xx <ESC>:qall!<CR>
nnoremap <leader>x <ESC>:q<CR>
nnoremap <leader>w <ESC>:qall<CR>
nnoremap <leader>p <ESC>:GFiles<CR>
nnoremap <leader>o <ESC>:F<CR>
vnoremap // y/<C-R>"<CR>

" Window Splitting
nnoremap <C-J> <C-W><C-J> 
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Plugin Settings
" 
" vim choosewin
" invoke with '-'
nmap  -  <Plug>(choosewin)
" if you want to use overlay feature
let g:choosewin_overlay_enable = 1

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_insertion = 1

" LanguageClient 
" Automatically start language servers.
" let g:LanguageClient_autoStart = 1
" let g:LanguageClient_serverCommmands = {
"   \ 'javascript' : ['/usr/bin/javascript-typescript-stdio'],
"   \ 'typescript' : ['/usr/bin/javascript-typescript-stdio'],
"   \ }
" " Use deoplete.
" let g:deoplete#enable_at_startup = 1
" " Let <Tab> also do completion
" inoremap <silent><expr> <Tab>
" \ pumvisible() ? "\<C-n>" :
" \ deoplete#mappings#manual_complete()
" nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" " Or map each action separately
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" NerdTree
let NERDTreeQuitOnOpen = 1

" devicons
set encoding=UTF-8

" various settings
set autoindent                 " Minimal automatic indenting for any filetype.
set shiftround
set backspace=indent,eol,start " Proper backspace behavior.
set hidden                     " Possibility to have more than one

" Swap Files and Backups
set backupdir=~/.temp/backup//
set directory=~/.temp/swp//
set undodir=~/.temp/undo//

set ruler                      " Shows the current line number at the bottom.
                               " right of the screen.
set wildmenu                   " Great command-line completion, use '<Tab>' to
                               " move around and '<CR>' to validate.<Paste>          
                               
set nocompatible            " Disable compatibility to old-time vi
set showmatch               " Show matching brackets.
set ignorecase              " Do case insensitive matching
set hlsearch                " highlight search results
set incsearch                  " Incremental search, hit '<CR>' to stop.
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

" fzf + ripgrep
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --smart-case --follow --color "always"
  \ --glob "!.git/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

" Fonts
set guifont=SourceCodePro\ Nerd\ Font

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

" deoplete
" Close the documentation window when completion is done
"autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif


" End Automatic Bindings
augroup END
