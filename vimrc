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
set belloff=all
set clipboard=unnamed

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
let g:go_fmt_autosave=1
let g:go_fmt_command="goimports"

" Terraform
let g:terraform_align=1
let g:terraform_fmt_on_save=1

" Plugins
" https://github.com/junegunn/vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'preservim/nerdtree'
Plug 'hashivim/vim-terraform'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
call plug#end()
