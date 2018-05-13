" vimrc file.
"
" Maintainer:	Taichi Sasaki <tchsskk@gmail.com>
" Last Change:	2018 May 13


" ---------------------------------------------------------------------
" Options: "{{{1
" ---------------------------------------------------------------------
let s:is_win = has('win16') || has('win32') || has('win64')

if has('mouse')
  set mouse=a
endif

" ------------------------------------------------
" General "{{{2
" ------------------------------------------------
set viewdir=$MYVIMDIR/view

if s:is_win
  let $MYVIMDIR = expand('~/vimfiles')
else
  let $MYVIMDIR = expand('~/.vim')
endif

for path in split(glob($VIM.'/plugins/*'), '\n')
  if isdirectory(path) | let &runtimepath = &runtimepath.','.path | end
endfor

set undodir=$MYVIMDIR/undo
set directory=$MYVIMDIR/tmp

" ------------------------------------------------
" Backup "{{{2
" ------------------------------------------------
set backup
set backupdir=$MYVIMDIR/backup

" ------------------------------------------------
" Edit "{{{2
" ------------------------------------------------
set backspace=indent,eol,start
set clipboard=unnamed
set formatoptions+=mM
set showmatch

" ------------------------------------------------
" Search "{{{2
" ------------------------------------------------
set hlsearch
set ignorecase
set incsearch
set smartcase
set wrapscan

" ------------------------------------------------
" Display "{{{2
" ------------------------------------------------
set background=dark
set cmdheight=2
set history=200
set laststatus=2
set nolist
set listchars=tab:>-,eol:$,trail:_,extends:>,precedes:<
set nowrap
set number
set ruler
set showcmd
set t_Co=256
set title
set visualbell
set wildmenu

" ------------------------------------------------
" Tab "{{{2
" ------------------------------------------------
set expandtab
set shiftwidth=2
set softtabstop=4
set tabstop=4

" ------------------------------------------------
" Indent "{{{2
" ------------------------------------------------
set autoindent
set smartindent

" ------------------------------------------------
" Diff "{{{2
" ------------------------------------------------
set diffopt=context:0

" ---------------------------------------------------------------------
" Map: "{{{1
" ---------------------------------------------------------------------
mapc
nmapc
vmapc
xmapc
smapc
omapc
imapc
lmapc
cmapc

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif

nmap gs <Plug>(go-def-split)

" ---------------------------------------------------------------------
" Syntax: "{{{1
" ---------------------------------------------------------------------
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" ---------------------------------------------------------------------
" Plugin: "{{{1
" ---------------------------------------------------------------------
" neobundle.vim
if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible
  endif

  set runtimepath+=$MYVIMDIR/bundle/neobundle.vim/
endif

call neobundle#begin(expand($MYVIMDIR . '/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'groenewege/vim-less'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'nsf/gocode', {'rtp': 'vim/'}
NeoBundle 'fatih/vim-go', {
\     'depends' : 'majutsushi/tagbar',
\     'autoload' : {
\         'filetypes' : 'go',
\         'commands' : ['GoInstallBinaries', 'GoUpdateBinaries'],
\     },
\ }
NeoBundle 'dgryski/vim-godef'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'cespare/vim-toml'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'rust-lang/rust.vim'

call neobundle#end()

" syntastic
let g:syntastic_check_on_open=0
let g:syntastic_check_on_wq=0

" ---------------------------------------------------------------------
" Filetype: "{{{1
" ---------------------------------------------------------------------
filetype plugin indent on


" ---------------------------------------------------------------------
" Autocommand: "{{{1
" ---------------------------------------------------------------------
if has("autocmd")
  augroup vimrcEx
    au!

    autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

    if s:is_win
      "//au GUIEnter * simalt ~x
    endif
  augroup END

endif

NeoBundleCheck
" ---------------------------------------------------------------------
" vim:ts=8:foldmethod=marker:foldlevel=0
