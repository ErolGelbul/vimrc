syntax enable

let mapleader = " "

" Line Numbers

set number
set relativenumber

" Cursor

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Vim Backup

set nobackup
set nowb
set noswapfile

" Tabs

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

" Line Length

set lbr
set textwidth=80

" Indentation

set autoindent
set smartindent
set breakindent
set breakindentopt=shift:4

" Search

set hlsearch
set ignorecase
set incsearch
set smartcase

" Text Rendering

set wrap
set scrolloff=1

" UI Stuff

set laststatus=2
set ruler

" Allow backspacing over indention, line breaks and insertion start.

set backspace=indent,eol,start

colorscheme monokai
