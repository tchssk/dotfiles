" vimrc file.
"
" Maintainer:	Taichi Sasaki <tchsskk@gmail.com>
" Last Change:	2018 Apr 27


" ---------------------------------------------------------------------
" Options: "{{{1
" ---------------------------------------------------------------------
" Windows判定用
let s:is_win = has('win16') || has('win32') || has('win64')

" マウスがあれば有効化 
if has('mouse')
  set mouse=a
endif


" ------------------------------------------------
" 設定 "{{{2
" ------------------------------------------------
set viewdir=$MYVIMDIR/view	" ビューの保存ディレクトリ

" Vim関連ファイルの基点ディレクトリ
if s:is_win
  let $MYVIMDIR = expand('~/vimfiles')
else
  let $MYVIMDIR = expand('~/.vim')
endif

" plugins下のディレクトリをruntimepathへ追加する
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
" 編集の設定 "{{{2
" ------------------------------------------------
set backspace=indent,		" 改行等をバックスペースで削除
    \eol,start			
set clipboard=unnamed		" 無名レジスタにクリップボードレジスタを使用
set formatoptions+=mM		" テキスト挿入中の自動折り返しを日本語に対応させる
set showmatch			" 括弧入力時に対応する括弧を表示

" ------------------------------------------------
" Search "{{{2
" ------------------------------------------------
set hlsearch
set ignorecase
set incsearch
set smartcase
set wrapscan

" ------------------------------------------------
" 画面表示の設定 "{{{2
" ------------------------------------------------
set background=dark		" 暗い背景を使用
set cmdheight=2			" コマンドラインの高さ
set history=200			" コマンドラインの履歴件数
set laststatus=2		" 常にステータス行を表示
set nolist			" タブや改行を非表示
set listchars=tab:>-,eol:$,	" listモード表示設定
    \trail:_,extends:>,
    \precedes:<
set nowrap			" 長い行を折り返さない
set number			" 行番号を表示
set ruler			" ルーラを表示
set showcmd			" 画面下にコマンドラインを表示
set t_Co=256			" 256色利用可能にする
set title			" タイトルを表示
set visualbell			" ビープを音ではなく画面に表示
set wildmenu			" コマンドライン補完に拡張モードを使用

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
" 差分モードの設定 "{{{2
" ------------------------------------------------
set diffopt=context:0		" 変更箇所以外すべて折り畳み


" ---------------------------------------------------------------------
" Map: "{{{1
" ---------------------------------------------------------------------
" マッピングをすべて削除
mapc
nmapc
vmapc
xmapc
smapc
omapc
imapc
lmapc
cmapc

" 現在のバッファを、読み込まれた段階と比較
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif

nmap gs <Plug>(go-def-split)

" ---------------------------------------------------------------------
" Syntax: "{{{1
" ---------------------------------------------------------------------
" 色が使える環境なら構文ハイライトを有効化
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
" ファイル形式に応じたプラグインやインデントを有効化
filetype plugin indent on


" ---------------------------------------------------------------------
" Autocommand: "{{{1
" ---------------------------------------------------------------------
if has("autocmd")
  augroup vimrcEx
    au!

    " ファイルを開いた時に、最後に開かれていた時の行にジャンプ
    autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

    " Windowを最大化
    if s:is_win
      "//au GUIEnter * simalt ~x
    endif
  augroup END

endif

NeoBundleCheck
" ---------------------------------------------------------------------
" vim:ts=8:foldmethod=marker:foldlevel=0
