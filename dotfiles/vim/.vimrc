" Plug {{{
if 1 " eval compiled in
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd!
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
"File Search:
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf.vim'
"File Browser:
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'mkitt/tabline.vim'
Plug 'ryanoasis/vim-devicons'
"Color:
Plug 'morhetz/gruvbox'
"Golang:
"Plug 'fatih/vim-go'
Plug 'govim/govim'
"Autocomplete:
"Plug 'ncm2/ncm2'
"Plug 'ncm3/ncm2-go'
"Plug 'roxma/nvim-yarp'
"Plug 'roxma/vim-hug-neovim-rpc'
"Plug 'stamblerre/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
"Snippets:
Plug 'ncm2/ncm2-ultisnips'
Plug 'SirVer/ultisnips'
"Git:
Plug 'tpope/vim-fugitive'
call plug#end()
endif
" }}}

" Settings {{{
set nocompatible                " Enables us Vim specific features
filetype off                    " Reset filetype detection first ...
filetype plugin indent on       " ... and enable filetype detection
set ttyfast                     " Indicate fast terminal conn for faster redraw
set lazyredraw					" don't redraw in the middle of macros
set cursorline                  " Highlight the current line the cursor is on
set nocursorcolumn              " Do not highlight column (speeds up highlighting)
set autoindent                  " Enabile Autoindent
set backspace=indent,eol,start  " Makes backspace key more powerful.
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set noerrorbells                " No beeps
set showcmd                     " Show me what I'm typing
set autowrite                   " Automatically save before :next, :make etc.

set shiftwidth=4 tabstop=4 softtabstop=4 noet
set pastetoggle=<F12>			" F12 to toggle paste mode

set timeoutlen=500
" do not clear screen on exit
set t_ti= t_te=
" }}}

" Clipboard {{{
" Enable to copy to clipboard for operations like yank, delete, change and put
" http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
if has('unnamedplus')
  set clipboard^=unnamed
  set clipboard^=unnamedplus
endif
vnoremap <LeftRelease> "*ygv
"set clipboard=autoselect

"COPY/PASTE:
"-----------
"Increases the memory limit from 50 lines to 1000 lines
:set viminfo='100,<1000,s10,h
" }}}

" NUMBERING {{{
"----------
:set number
" }}}

" INDENTATION {{{
"Highlights code for multiple indents without reselecting
vnoremap < <gv
vnoremap > >gv
" }}}

" COLOR {{{
colorscheme gruvbox
" }}}

" Go {{{
  " Show by default 4 spaces for a tab
autocmd! BufEnter,BufNewFile *.go,go.mod setlocal noexpandtab tabstop=4 shiftwidth=4 fileencoding=utf-8
" }}}

" AUTOCOMPLETE {{{
"Cycle through completion entries with tab/shift+tab
inoremap <expr> <TAB> pumvisible() ? "\<c-n>" : "\<TAB>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<TAB>"
"Allow getting out of pop with Down/Up arrow keys
inoremap <expr> <down> pumvisible() ? "\<C-E>" : "\<down>"
inoremap <expr> <up> pumvisible() ? "\<C-E>" : "\<up>"
" }}}

" SNIPPETS {{{
"Change default expand since TAB is used to cycle options
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" }}}

" FILE SEARCH {{{
"allows FZF to open by pressing CTRL-F
"map <C-f> :FZF<CR>
"allow FZF to search hidden 'dot' files
"let $FZF_DEFAULT_COMMAND = "find -L"
" }}}

" FILE BROWSER {{{
"allows NERDTree to open/close by typing 'n' then 't'
map nt :NERDTreeTabsToggle<CR>
"Start NERDtree when dir is selected (e.g. "vim .") and start NERDTreeTabs
let g:nerdtree_tabs_open_on_console_startup=2
"Add a close button in the upper right for tabs
let g:tablineclosebutton=1
"Automatically find and select currently opened file in NERDTree
let g:nerdtree_tabs_autofind=1
"Add folder icon to directories
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
"Hide expand/collapse arrows
let g:NERDTreeDirArrowExpandable = "\u00a0"
let g:NERDTreeDirArrowCollapsible = "\u00a0"
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
highlight! link NERDTreeFlags NERDTreeDir
" }}}

" SHORTCUTS {{{
"Open file at same line last closed
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g'\"" | endif
endif
" }}}

" SOURCING {{{
"Automatically reloads neovim configuration file on write (w)
autocmd! bufwritepost init.vim source %
" }}}

" MOUSE {{{
"Allow using mouse helpful for switching/resizing windows
set mouse=a
if 1 == 0
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
if &term =~ '^screen' || exists('$TMUX')
  " tmux knows the extended mouse mode
  set ttymouse=xterm2
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
endif
endif
" }}}

" Remove trailing witespace
"autocmd BufWritePre * TrailerTrim

" TEXT SEARCH {{{
"Makes Search Case Insensitive
set ignorecase
" }}}

" SWAP {{
set dir=~/.local/share/nvim/swap/
set noswapfile
set nobackup                    " Don't create annoying backup files
set nowritebackup
"set backup_dir=~/.local/share/nvim/backup/
" }}}

" GIT (FUGITIVE) {{{
map fgb :Gblame<CR>
map fgs :Gstatus<CR>
map fgl :Glog<CR>
map fgd :Gdiff<CR>
map fgc :Gcommit<CR>
map fga :Git add %:p<CR>
" }}}

" SYNTAX HIGHLIGHTING {{{
set t_Co=8
set background=light
if $TERM =~ "256color"
	set t_Co=256
endif
syntax on
" }}}

" HIGHLIGHTING {{{
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
" }}}

" Encoding {{{
set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats
set fileencodings=utf-8,iso-8859-2
set encoding=utf-8
if expand('$LANG') =~ '[Ii][Ss][Oo]-*8859-*2$'
	set encoding=iso8859-2
endif
" }}}
"
" Markdown {{{
au BufRead,BufNewFile *.md set filetype=markdown
" }}}

" Undo {{{
" This enables us to undo files even if you exit Vim.
if has('persistent_undo')
  set undofile
  let undo_dir=expand('~/.vimundo')
  if !filewritable(undo_dir)
    silent execute expand('!mkdir ' . undo_dir)
  endif
  execute expand('set undodir=' . undo_dir)
endif
" }}}

" Other {{{
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter Makefile setlocal noexpandtab
augroup END
" }}}

" vim: foldmethod=marker foldlevel=0:
