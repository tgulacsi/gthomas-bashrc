set nocompatible              " be iMproved, required

" show statusline always
set laststatus=2  
" indents
set shiftwidth=4 tabstop=4 softtabstop=4 autoindent
set fileencodings=utf-8,iso-8859-2
set showmatch
set ruler showmode showcmd
" search
set incsearch hlsearch
" F12 to toggle paste mode
set pastetoggle=<F12>
" aganist "No write since last change"
set hidden

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'fatih/vim-go'
call vundle#end()
filetype plugin indent on

set t_Co=256
syntax on
set background=dark
colorscheme zellner
