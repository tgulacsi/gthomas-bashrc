" A sensible vimrc for Go development
"
" Please note that the following settings are some default that I used
" for years. However it might be not the case for you (and your
" environment). I highly encourage to change/adapt the vimrc to your own
" needs. Think of a vimrc as a garden that needs to be maintained and fostered
" throughout years. Keep it clean and useful - Fatih Arslan

if 1 " eval compiled in
    let iCanHazVimPlug=1
    let vimplug_file=expand('~/.vim/autoload/plug.vim')
    if !filereadable(vimplug_file) && empty(glob("~/.vim/plugged"))
        echo "Installing vim-plug..."
        echo ""
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        let iCanHazVimPlug=0
    endif

	call plug#begin('~/.vim/plugged')
	" Make sure you use single quotes

    "Add your bundles here
	Plug 'fatih/vim-go'
	Plug 'fatih/molokai'
	Plug 'AndrewRadev/splitjoin.vim'
	Plug 'SirVer/ultisnips'
	Plug 'ctrlpvim/ctrlp.vim'

    Plug 'altercation/vim-colors-solarized'
    "Plug 'tpope/vim-vividchalk'

    "Plug 'bling/vim-airline'
    "Plug 'scrooloose/syntastic'
	"Plug 'scrooloose/nerdtree'
    "Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-markdown'
    "Plug 'tpope/vim-vinegar'
	Plug 'csexton/trailertrash.vim'
	"Plug 'majutsushi/tagbar'
	"Plug 'ervandew/supertab'
	call plug#end()

    if iCanHazVimPlug == 0
        echo "Installing vim-plug, please ignore key map error messages"
        echo ""
        :PlugInstall
    endif
endif

""""""""""""""""""""""
"      Settings      "
""""""""""""""""""""""
set nocompatible                " Enables us Vim specific features
filetype off                    " Reset filetype detection first ...
filetype plugin indent on       " ... and enable filetype detection
set ttyfast                     " Indicate fast terminal conn for faster redraw
"set ttymouse=xterm2              " Indicate terminal type for mouse codes
"set ttyscroll=4                 " Speedup scrolling
set laststatus=2                " Show status line always
set encoding=utf-8              " Set default encoding to UTF-8
set fileencodings=utf-8,iso-8859-2
set autoread                    " Automatically read changed files
set autoindent                  " Enabile Autoindent
set backspace=indent,eol,start  " Makes backspace key more powerful.
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set noerrorbells                " No beeps
set number                      " Show line numbers
set showcmd                     " Show me what I'm typing
set noswapfile                  " Don't use swapfile
set nobackup                    " Don't create annoying backup files
set splitright                  " Vertical windows should be split to right
set splitbelow                  " Horizontal windows should split to bottom
set autowrite                   " Automatically save before :next, :make etc.
set hidden                      " Buffer should still exist if window is closed
set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats
set noshowmatch                 " Do not show matching brackets by flickering
set noshowmode                  " We show the mode with airline or lightline
set showcmd
set ruler
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not it begins with upper case
set completeopt=menu,menuone    " Show popup menu, even if there is one entry
set pumheight=10                " Completion window max size
set nocursorcolumn              " Do not highlight column (speeds up highlighting)
set nocursorline                " Do not highlight cursor (speeds up highlighting)
set lazyredraw                  " Wait to redraw
set shiftwidth=4 tabstop=4 softtabstop=4
set pastetoggle=<F12>			" F12 to toggle paste mode
set backup
set writebackup

" backup to spec dirset backupdir=~/.vimbackup
let backup_dir=expand("~/.vimbackup")
if !filewritable(backup_dir)
  silent execute expand('!mkdir ' . backup_dir)
endif
execute expand('set backupdir=' . backup_dir)

" Enable to copy to clipboard for operations like yank, delete, change and put
" http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
if has('unnamedplus')
  set clipboard^=unnamed
  set clipboard^=unnamedplus
endif

" This enables us to undo files even if you exit Vim.
if has('persistent_undo')
  set undofile
  let undo_dir=expand('~/.vimundo')
  if !filewritable(undo_dir)
    silent execute expand('!mkdir ' . undo_dir)
  endif
  execute expand('set undodir=' . undo_dir)
endif

set encoding=utf-8
if expand('$LANG') =~ '[Ii][Ss][Oo]-*8859-*2$'
	set encoding=iso8859-2
endif

" Colorscheme
let g:rehash256 = 1
let g:molokai_original = 1
if hostname() =~ "[.]unosoft[.]local$"
	set t_Co=8
	colorscheme zellner
else
	set t_Co=256
	colorscheme molokai
endif
syntax enable

" do not clear screen on exit
set t_ti= t_te=


""""""""""""""""""""""
"      Mappings      "
""""""""""""""""""""""

" Set leader shortcut to a comma ','. By default it's the backslash
"let mapleader = ","
let mapleader = "\<Space>"

" Jump to next error with Ctrl-n and previous error with Ctrl-p. Close the
" quickfix window with <leader>a
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
" save a file
nnoremap <Leader>w :w<CR>

" Visual linewise up and down by default (and use gj gk to go quicker)
noremap <Up> gk
noremap <Down> gj
noremap j gj
noremap k gk

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Act like D and C
nnoremap Y y$

" Enter automatically into the files directory
autocmd BufEnter * silent! lcd %:p:h


"""""""""""""""""""""
"      Plugins      "
"""""""""""""""""""""

augroup backup
	autocmd!
	autocmd BufWritePre,FileWritePre * let &l:backupext = '~' . strftime('%F_%R') . '~'
augroup END

" Remove trailing witespace
autocmd BufWritePre * TrailerTrim

" Python
autocmd FileType python set et

" Markdown
au BufRead,BufNewFile *.md set filetype=markdown

" vim-go
if &encoding=~"iso-*8859-2"
    let gi2=expand('~/bin/goimports2')
    if !filereadable(gi2)
		let content = ['#!/bin/sh', 'iconv -f iso-8859-2 -t utf-8 "$2" >"$2".utf8 && gofmt "$1" "$2".utf8 && iconv -f utf-8 -t iso-8859-2 "$2".utf8 >"$2"']
		silent execute '!mkdir -p ~/bin'
		call writefile(content, gi2)
		silent execute '!chmod 0755 ' . gi2
	endif
	let g:go_fmt_command = "goimports2"
else
	let g:go_fmt_command = "goimports"
endif

let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
let g:go_metalinter_enabled = ['vet', 'errcheck']

" Open :GoDeclsDir with ctrl-g
nmap <C-g> :GoDeclsDir<cr>
imap <C-g> <esc>:<C-u>GoDeclsDir<cr>


augroup go
  autocmd!

  " Show by default 4 spaces for a tab
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 fileencoding=utf-8

  " :GoBuild and :GoTestCompile
  autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

  " :GoTest
  autocmd FileType go nmap <leader>t  <Plug>(go-test)

  " :GoRun
  autocmd FileType go nmap <leader>r  <Plug>(go-run)

  " :GoDoc
  autocmd FileType go nmap <Leader>d <Plug>(go-doc)

  " :GoCoverageToggle
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

  " :GoInfo
  autocmd FileType go nmap <Leader>i <Plug>(go-info)

  " :GoMetaLinter
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)

  " :GoDef but opens in a vertical split
  autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
  " :GoDef but opens in a horizontal split
  autocmd FileType go nmap <Leader>s <Plug>(go-def-split)

  " :GoAlternate  commands :A, :AV, :AS and :AT
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
