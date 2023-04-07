" XDG support {{{1

if empty($MYVIMRC) | let $MYVIMRC = expand('<sfile>:p') | endif

if empty($XDG_CACHE_HOME)  | let $XDG_CACHE_HOME  = $HOME."/.cache"       | endif
if empty($XDG_CONFIG_HOME) | let $XDG_CONFIG_HOME = $HOME."/.config"      | endif
if empty($XDG_DATA_HOME)   | let $XDG_DATA_HOME   = $HOME."/.local/share" | endif
if empty($XDG_STATE_HOME)  | let $XDG_STATE_HOME  = $HOME."/.local/state" | endif

set runtimepath^=$XDG_CONFIG_HOME/vim
set runtimepath+=$XDG_DATA_HOME/vim
set runtimepath+=$XDG_CONFIG_HOME/vim/after

set packpath^=$XDG_DATA_HOME/vim,$XDG_CONFIG_HOME/vim
set packpath+=$XDG_CONFIG_HOME/vim/after,$XDG_DATA_HOME/vim/after

let g:netrw_home = $XDG_DATA_HOME."/vim"
call mkdir($XDG_DATA_HOME."/vim/spell", 'p', 0700)

set backupdir=$XDG_STATE_HOME/vim/backup | call mkdir(&backupdir, 'p', 0700)
set directory=$XDG_STATE_HOME/vim/swap   | call mkdir(&directory, 'p', 0700)
set undodir=$XDG_STATE_HOME/vim/undo     | call mkdir(&undodir,   'p', 0700)
set viewdir=$XDG_STATE_HOME/vim/view     | call mkdir(&viewdir,   'p', 0700)

if !has('nvim') | set viminfofile=$XDG_STATE_HOME/vim/viminfo | endif

" BASICS {{{1

set nocompatible
filetype plugin indent on
syntax enable
set backup undofile
colorscheme monokai

" Open file at the last known position
autocmd BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' | exec "norm! g`\"" | endif

" COMMANDS {{{1

com! -range -nargs=+  Align            <line1>,<line2>!column -Lts<args> -o<args>
com! -bang            ColorUp          set syntax=ON | exec "colo " . (<bang>0 ? "darkness" : "colorUp")
com!                  CountSpell       echo utils#CountSpell()
com!                  ExecCurrentLine  normal :.w !sh<CR>
com! -nargs=1         FillLine         exec "norm! $" | exec "FillToColumn" <q-args> &tw
com! -nargs=+         FillToColumn     exec {str,r -> "norm! a".repeat(str, (r-col("."))/len(str))}(<f-args>)
com! -nargs=+         Grep             silent! exec "grep -R <args> ."
com! -nargs=+         GrepRename       exec {a,b -> 'tabe | lv /\C\<' . a . '\>/j ** | cdo s/\C\<' . a . '\>/' . b . '/gc | up'}(<f-args>) | q
com!                  InstallPlugins   call utils#InstallPlugins()
com! -nargs=1         SetFormatProg    exec {prg -> 'let [ &l:formatprg, &l:formatexpr ] = [ "'.prg.' 2> /dev/null", "" ]'}(<args>)
com! -range=%         Sort             normal :<line1>,<line2>sort i<CR>
com! -nargs=?         Spelling         if empty("<args>") | setl spell! | else | setl spell spelllang=<args> | endif
com!                  SudoW            exec 'silent! write !sudo tee % >/dev/null' | edit!
com!                  SyntaxStack      echo join(reverse(map(synstack(line('.'), col('.')), 'synIDattr(v:val,"name")')),' ')
com! -nargs=+         Vimgrep          exec "vimgrep /".<q-args>."/j **"
com! -range           VisSort          sil! keepj <line1>,<line2>call utils#VisSort()

if has('nvim')
  cnoreabbrev term sp\|term
endif

" MAPPINGS {{{1

nnoremap <Leader>= gg=G``
nnoremap <Leader>q m"gggqG`"
nnoremap <Leader>r :exec {o -> {n -> n != "" ? '%s/\C\<' . o . '\>/' . n . '/g' : ''}(input(o." > ", o))}(expand('<cword>'))<CR>
nnoremap <silent> <C-l> :nohlsearch<C-r>=has('diff')?'<bar>diffupdate':''<CR><CR><C-l>
nnoremap <silent> <F8> :if has("nvim") <bar> split <bar> endif <bar> term<CR>
nnoremap <silent> <Leader>b :bnext<CR>
nnoremap j gj
nnoremap k gk

tnoremap <silent> <C-\><C-\> <C-\><C-n>

map gh <nop>

" OPTIONS {{{1

set keywordprg=:Man
set makeprg=Make
set modeline nomodelineexpr
set number
set scrolloff=5
set sessionoptions=blank,buffers,folds,tabpages,winsize
set shortmess+=I shortmess-=S
set spellsuggest=double,5
set splitbelow splitright
set ttimeoutlen=10
set vb t_vb=
set wildmenu wildmode=full wildoptions=
set updatetime=250

set ruler
set colorcolumn=+1
set fillchars+=vert:│

set hidden
set switchbuf=usetab

set diffopt=internal,filler,closeoff,indent-heuristic,algorithm:histogram
let g:diff_translations = 0

set hlsearch
set ignorecase
set incsearch
set smartcase

set mouse=a
set mousemodel=popup_setpos
silent! set ttymouse=sgr

set list
set listchars=tab:<\ >,trail:_
set listchars+=extends:>,precedes:<
hi! ListCharsTabs ctermfg=235
autocmd BufWinEnter * call matchadd("ListCharsTabs", '\t')

set guioptions=c
set guicursor=a:block
let &guifont = has("win32") ? "Consolas:h11:cANSI:qDRAFT" : "DejaVu Sans Mono 11"

set title
set titlestring=
set titlestring+=%t%(\ %M%)%(\ (%{expand(\"%:p:~:.:h\")}/)%)
set titlestring+=\ \|\ %{$USER}@%{hostname()}:%{substitute(getcwd(),$HOME,'~','')}

set complete+=kspell
set completeopt=menuone,noinsert,noselect
set omnifunc=syntaxcomplete#Complete
set pumheight=20

set nowrap
set linebreak
set relativenumber
set autoindent
set smartindent
set breakindent
set breakindentopt=shift:4
let &showbreak = "↳  "

set path=**,./
set tags+=.tags/tags;

set smarttab
set backspace=indent,eol,start
set cindent
set expandtab
set shiftround
set shiftwidth=0   " If 0, then uses value of 'tabstop'
set softtabstop=-1 " If negative, then uses 'shiftwidth' (which can use 'tabstop')
set tabstop=4
set textwidth=80

set showcmd
set signcolumn=yes

set laststatus=2
set statusline=%!lines#StatusLine()

set showtabline=2
set tabline=%!lines#TabLine()

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

augroup FORMATOPTIONS
  autocmd!
  autocmd BufWinEnter * set fo-=c fo-=r fo-=o " Disable continuation of comments to the next line
  autocmd BufWinEnter * set formatoptions+=j  " Remove a comment leader when joining lines
  autocmd BufWinEnter * set formatoptions+=l  " Don't break a line after a one-letter word
  autocmd BufWinEnter * set formatoptions+=n  " Recognize numbered lists
  autocmd BufWinEnter * set formatoptions-=q  " Don't format comments
  autocmd BufWinEnter * set formatoptions-=t  " Don't autowrap text using 'textwidth'
augroup END

" folds {{{
set foldmethod=indent
set foldtext=MyFoldText()
set nofoldenable

" PLUGINS {{{1

let g:plugins = {
      \   "repos": [
      \     "ctrlpvim/ctrlp.vim",
      \     "dense-analysis/ale",
      \     "editorconfig/editorconfig-vim",
      \     "Jorengarenar/miniSnip",
      \     "jpalardy/vim-slime",
      \     "junegunn/gv.vim",
      \     "markonm/traces.vim",
      \     "mbbill/undotree",
      \     "mhinz/vim-signify",
      \     "prabirshrestha/vim-lsp",
      \     "preservim/tagbar",
      \     "tpope/vim-fugitive",
      \   ],
      \   "files": [
      \     [ "autoload/lsp/ale.vim",  "github.com/rhysd/vim-lsp-ale/raw/master/autoload/lsp/ale.vim" ],
      \     [ "autoload/repeat.vim",   "github.com/tpope/vim-repeat/raw/master/autoload/repeat.vim" ],
      \     [ "plugin/commentary.vim", "github.com/tpope/vim-commentary/raw/master/plugin/commentary.vim" ],
      \     [ "plugin/eunuch.vim",     "github.com/tpope/vim-eunuch/raw/master/plugin/eunuch.vim" ],
      \     [ "plugin/rsi.vim",        "github.com/tpope/vim-rsi/raw/master/plugin/rsi.vim" ],
      \     [ "plugin/surround.vim",   "github.com/tpope/vim-surround/raw/master/plugin/surround.vim" ],
      \   ]
      \ }

packadd cfilter
packadd matchit
packadd termdebug
source  $VIMRUNTIME/ftplugin/man.vim

" ~ {{{2

let g:termdebug_wide = 1

let g:EditorConfig_enable_for_new_buf = 1

let g:traces_preview_window = "new"

let g:fastfold_fold_command_suffixes  = [ 'C', 'm', 'M', 'N', 'x', 'X' ]
let g:fastfold_fold_movement_commands = []
let g:fastfold_minlines = 0
let g:fastfold_savehook = 0

let g:miniSnip_extends = {
      \   "arduino"  : [ "cpp", "c" ],
      \   "cpp"      : [ "c" ],
      \   "html"     : [ "css", "javascript" ],
      \   "markdown" : [ "html" ],
      \   "php"      : [ "html" ],
      \   "tex"      : [ "plaintex" ],
      \ }

let g:undotree_SetFocusWhenToggle = 1
nnoremap <F1> :UndotreeToggle<CR>

let g:signify_sign_change = '~'
highlight link  SignifySignChange  DiffText

" }}}2

" ~ {{{1

if has("cscope") && (executable("cscope") || executable("gtags-cscope"))
  set cscopetag
  set cscopetagorder=0
  set cscopepathcomp=2
  set cscopequickfix=a-,c-,d-,e-,f-,g-,i-,s-,t-

  call cscope#init()
endif

augroup MERGETOOL
  autocmd!
  if join(argv()) =~ '.*_LOCAL_.*_BASE_.*_REMOTE_.*'
    autocmd BufReadPost  *_LOCAL_*   setl stl=\ LOCAL
    autocmd BufReadPost  *_BASE_*    setl stl=\ BASE
    autocmd BufReadPost  *_REMOTE_*  setl stl=\ REMOTE
  endif
augroup END

augroup TRIM_TRAILING_WHITESPACE
  autocmd!
  autocmd BufWritePre * sil! undoj | sil! keepp keepj %s/\v(\s+$|\_s+%$)//e
augroup END

augroup NO_NESTED_VIM
  autocmd!

  if !has("nvim") && $vimInstanceExists
    au BufNewFile,BufReadPre * exec 'bd | !printf "\033]51;[\"drop\", \"'. expand('%:p') . '\"]\007"' | q
  endif
  let $vimInstanceExists = 1

augroup END

augroup VISUALBLOCK_NOSTARTOFLINE
  autocmd!
  exec "autocmd ModeChanged *:\<C-v> let g:sol_old = &sol | set nosol"
  exec "autocmd ModeChanged \<C-v>:* let &startofline = g:sol_old"
augroup END

augroup OTHER
  autocmd!

  " Automatically open QuickFix
  autocmd QuickFixCmdPost [^l]* nested cwindow
  autocmd QuickFixCmdPost    l* nested lwindow

  " Undo if filter shell command returned an error
  autocmd ShellFilterPost * if v:shell_error | undo | endif

  " Set fold method to syntax
  autocmd FileType dosini,make,m3u,todo  setlocal foldmethod=syntax

augroup END

silent! helptags ALL

set secure exrc