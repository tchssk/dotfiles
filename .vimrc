" vimrc file.
"
" Maintainer:	Taichi Sasaki <taichisasaki>
" Last Change:	2013 Mar 23
" URL:
"
" This need the following files
"   colors/solarized.vim
"   plugin/matchit.vim
"   plugin/unite.vim
"   plugin/vimfiler.vim
"
" For OS X and Windows only


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


" ------------------------------------------------
" バックアップの設定 "{{{2
" ------------------------------------------------
set backup                      " バックアップを有効化
set backupdir=$MYVIMDIR/backup  " バックアップ用ディレクトリ


" ------------------------------------------------
" 編集の設定 "{{{2
" ------------------------------------------------
set backspace=indent,		" 改行等をバックスペースで削除
    \eol,start			
set clipboard=unnamed		" 無名レジスタにクリップボードレジスタを使用
set formatoptions+=mM		" テキスト挿入中の自動折り返しを日本語に対応させる
set showmatch			" 括弧入力時に対応する括弧を表示

" ------------------------------------------------
" 検索の設定 "{{{2
" ------------------------------------------------
set hlsearch			" パターンにマッチする文字列を強調表示
set ignorecase			" 大文字と小文字を区別しない
set incsearch			" インクリメント検索する
set smartcase			" 混在していれば大文字小文字を区別する
set wrapscan			" ファイルの最後まで行ったら最初に戻る

" ------------------------------------------------
" 画面表示の設定 "{{{2
" ------------------------------------------------
set background=light		" 明るい背景を使用
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
" タブ文字の設定 "{{{2
" ------------------------------------------------
set expandtab			" タブをスペースに展開
set shiftwidth=2		" 自動インデントの幅
set softtabstop=2		" タブの画面上での幅
set tabstop=2			" タブの画面上での幅

" ------------------------------------------------
" インデントの設定 "{{{2
" ------------------------------------------------
set autoindent			" 新しい行で自動的にインデントする
set smartindent			" 高度な自動インデント

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

" 行整形
map Q gq

" 空行を削除 
map <F1> :g/^\s*$/d<CR>

" コメント行を削除
map <F4> :g/\*\\|\/\//d<CR>

" 現在のバッファを、読み込まれた段階と比較
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif

" vimfiler.vim
" 現在開いているバッファのディレクトリを開く
nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir -quit<CR>

" ---------------------------------------------------------------------
" Syntax: "{{{1
" ---------------------------------------------------------------------
" 色が使える環境なら構文ハイライトを有効化
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" カラースキームを読み込む
"let g:solarized_termcolors = 256
"let g:solarized_contrast = 'high'
"colorscheme solarized


" ---------------------------------------------------------------------
" Plugin: "{{{1
" ---------------------------------------------------------------------
" neobundle.vim
if !1 | finish | endif

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
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'groenewege/vim-less'
NeoBundle 'altercation/vim-colors-solarized'

call neobundle#end()

" vimfiler.vim
let g:vimfiler_safe_mode_by_default = 0	" セーフモードを無効にした状態で起動する


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
