" -[ Bell ]-
set visualbell
set noerrorbells

" -[ General behaviour ]-
" general
set nocompatible
set nowrap
syntax on
filetype plugin indent on

" search
set nohls
set incsearch
set showmatch

" identing
set autoindent
set smartindent

" command mode
set wildmenu
set wildmode=list:longest,full

" -[ Look ]-
" general
set showcmd
set showmode
set number
set colorcolumn=80

" statusline
set statusline=%<%f\ %y%h%m%r\ PWD:%{getcwd()}%=%-14.(%l,%c%V%)\ %P
set laststatus=2

" colours
"set t_Co=256
"colorscheme candycode

set ruler
set tabstop=4
set textwidth=79

" -[ FileTypes ]-
" mail
autocmd FileType mail,human set formatoptions+=t textwidth=72

" Python stuff
autocmd FileType python let python_highlight_all = 1
autocmd FileType python let python_slow_sync = 1
autocmd FileType python set expandtab shiftwidth=4 softtabstop=4 
autocmd FileType python set completeopt=preview

" PKGBUILD stuff
autocmd FileType PKGBUILD set expandtab shiftwidth=2 softtabstop=4 

" sh stuff
autocmd FileType sh set expandtab shiftwidth=2 softtabstop=4 

" LaTeX
autocmd Filetype tex,latex set grepprg=grep\ -nH\ $
autocmd Filetype tex,latex let g:tex_flavor = "latex"


" -[ Mappings ]-"
" taglist
nnoremap <silent> <F8> :TlistToggle<CR>
inoremap <silent> <F8> <esc>:TlistToggle<CR>a
nnoremap <silent> <F9> :TlistUpdate<CR>
inoremap <silent> <F9> <esc>:TlistUpdate<CR>a


" -[ Plugins and Scripts ]-
" taglist
let Tlist_Use_Right_Window = 1
let Tlist_Compart_Format = 1
let Tlist_Show_Menu = 1
let Tlist_Exit_OnlyWindow = 1

" NERD_tree config
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc$', '\.swp$']
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\~$']
let NERDTreeShowBookmarks=1
map <F3> :NERDTreeToggle<CR>
"
" Syntax for multiple tag files are
" set tags=/my/dir1/tags, /my/dir2/tags
set tags=tags;$HOME/.vim/tags/
"
" TagList Plugin Configuration
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
let Tlist_Use_Right_Window = 1
let Tlist_File_Fold_Auto_Close = 1
map <F7> :TlistToggle<CR>
"
" Viewport Controls
" ie moving between split panes
map <silent>,h <C-w>h
map <silent>,j <C-w>j
map <silent>,k <C-w>k
map <silent>,l <C-w>l


