syntax on 

let mapleader = " "

set number
set relativenumber


set backupdir=/timp
set directory=~/.vim/tmp,.
set backup

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set backspace=indent,eol,start


call plug#begin('~/.vim/plugged')


Plug 'flazz/vim-colorschemes'

call plug#end()
colorscheme Dim
colorscheme gruvbox
