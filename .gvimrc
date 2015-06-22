" gvimrc file.
"
" Maintainer:	Taichi Sasaki <taichisasaki>
" Last Change:	2013 Mar 23
" URL:		
"
" This need the following files
"   .vimrc


" ---------------------------------------------------------------------
" Options: "{{{1
" ---------------------------------------------------------------------
" GUIを開始
gui

" ツールバーを表示しない
set guioptions-=T

" スクロールバーを表示しない
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" ------------------------------------------------
" 検索の設定 "{{{2
" ------------------------------------------------
set hlsearch			" パターンにマッチする文字列を強調表示

" ------------------------------------------------
" ウインドウの設定 "{{{2
" ------------------------------------------------
set columns=192			" 幅
set lines=48			" 高さ

" 透過
""if has('kaoriya') 
""  set transparency=248
""elseif has('macvim')
""  set transparency=10
""endif


" ------------------------------------------------
" フォントの設定 "{{{2
" ------------------------------------------------
if has('win32')
  " Windows用
  set guifont=Migu_1M:h9:cSHIFTJIS,MS_Gothic:h9:cSHIFTJIS
  " 行間隔の設定
  set linespace=1
  " 一部のUCS文字の幅を自動計測して決める
  if has('kaoriya')
    set ambiwidth=auto
  endif
elseif has('mac')
  " Mac用
  set guifont=Monaco:h10,Osaka−等幅:h14
  set linespace=1
elseif has('xfontset')
  " UNIX用 (xfontsetを使用)
  set guifontset=a14,r14,k14
endif

" ------------------------------------------------
" 日本語入力に関する設定 "{{{2
" ------------------------------------------------
if has('multi_byte_ime') || has('xim')
  " IME ON時のカーソルの色を設定(設定例:紫)
  highlight CursorIM guibg=Purple guifg=NONE
  " 挿入モード・検索モードでのデフォルトのIME状態設定
  set iminsert=0 imsearch=0
  if has('xim') && has('GUI_GTK')
    " XIMの入力開始キーを設定:
    " 下記の s-space はShift+Spaceの意味でkinput2+canna用設定
    "set imactivatekey=s-space
  endif
  " 挿入モードでのIME状態を記憶させない場合、次行のコメントを解除
  "inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif

if has("autocmd")
  augroup hack234
    autocmd!
    if has('win32')
      autocmd FocusGained * set transparency=248
      autocmd FocusLost * set transparency=128
    endif
  augroup END
endif

" ---------------------------------------------------------------------
" Syntax: "{{{1
" ---------------------------------------------------------------------
" 色が使える環境なら構文ハイライトを有効化
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" カラースキームを読み込む
if has('win32')
  colorscheme solarized
elseif has('mac')
  colorscheme hybrid
endif


" ---------------------------------------------------------------------
" vim:foldmethod=marker:foldlevel=0
