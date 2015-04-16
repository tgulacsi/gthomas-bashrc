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

if 1 " eval compiled in
    let iCanHazVimPlug=1
    let vimplug_file=expand('~/.vim/autoload/plug.vim')
    if !filereadable(vimplug_file)
        echo "Installing vim-plug..."
        echo ""
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        let iCanHazVimPlug=0
    endif

	call plug#begin('~/.vim/plugged')
	" Make sure you use single quotes

    "Add your bundles here
    Plug 'altercation/vim-colors-solarized'
    Plug 'tpope/vim-vividchalk'

    Plug 'bling/vim-airline'
    Plug 'scrooloose/syntastic'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-markdown'
    Plug 'tpope/vim-vinegar'
	Plug 'ludovicchabant/vim-gutentags'
	Plug 'csexton/trailertrash.vim'

    Plug 'fatih/vim-go'

	call plug#end()

    if iCanHazVimPlug == 0
        echo "Installing vim-plug, please ignore key map error messages"
        echo ""
        :PlugInstall
    endif
endif
"
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"


" show statusline always
set laststatus=2
" indents
set shiftwidth=4 tabstop=4 softtabstop=4 autoindent
set fileencodings=utf-8,iso-8859-2
set showmatch ruler showcmd
" search
set incsearch hlsearch
" F12 to toggle paste mode
set pastetoggle=<F12>
" aganist "No write since last change"
set hidden
syntax on
filetype plugin on
filetype indent on


" backup to spec dirset backupdir=~/.vimbackup
let backup_dir=expand("~/.vimbackup")
if !filewritable(backup_dir)
  silent execute expand('!mkdir ' . backup_dir)
endif
execute expand('set backupdir=' . backup_dir)
set backup writebackup

augroup backup
	autocmd!
	autocmd BufWritePre,FileWritePre * let &l:backupext = '~' . strftime('%F_%R') . '~'
augroup END

" Remove trailing witespace
autocmd BufWritePre * TrailerTrim

" Python
autocmd FileType python set et

" Go
let g:go_auto_type_info = 0
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 0
autocmd FileType go setlocal fileencoding=utf-8 encoding=utf-8 noet nolist

set autochdir
" color
set background=dark
if hostname() =~ ".*lnx.*"
	colorscheme zellner
	set t_Co=256
else
	set background=light
	colorscheme solarized
endif

" do not clear screen on exit
set t_ti= t_te=
