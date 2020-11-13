set ruler
set title
set titlestring=%f title
set nobackup
set noswapfile
set hidden " allow hiding a buffer with unsaved changes

colorscheme darkblue 
syntax on

set tabstop=4
set expandtab

let g:netrw_browse_split=4
let g:netrw_altv=1

set number

imap § <ESC>

:nnoremap <C-g> :Vexplore<CR>

filetype plugin indent on

let g:go_fmt_command = "goimports"
