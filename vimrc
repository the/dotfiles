set nocompatible
set ruler
set title
set titlestring=%f title
set nobackup
set noswapfile
set hidden " allow hiding a buffer with unsaved changes
set mouse=a
set hlsearch
set autoindent
set nostartofline
set laststatus=2
set cmdheight=2
set number
set path+=**

colorscheme darkblue 
syntax on

set tabstop=4
set expandtab

filetype plugin indent on

imap § <ESC>

" netrw
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_winsize=25
let g:netrw_liststyle=3

" NERDTree
:nnoremap <C-g> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Golang
let g:go_fmt_command = "goimports"
