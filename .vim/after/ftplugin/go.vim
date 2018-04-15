set noexpandtab
set tabstop=4
set shiftwidth=4
set updatetime=10
set path+=$GOPATH/src/**

let g:go_fmt_command = "goimports"
let g:syntastic_go_checkers = ['go', 'govet', 'golint']
let g:tagbar_left = 1

au VimEnter,TabNew *.go :TagbarOpen
