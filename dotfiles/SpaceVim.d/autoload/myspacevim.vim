function! myspacevim#before() abort
    "echom "myspacevim#before LANG=" . $LANG
    let g:loaded_netrw = 0
    let g:loaded_netrwPlugin = 0
endfunction

function! myspacevim#after() abort
    let g:loaded_netrw = 0
    let g:loaded_netrwPlugin = 0
    let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck']
    let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
    set autochdir
    set fileencodings=utf-8,iso8859-2
    set ignorecase smartcase
    silent let hostname = system("hostname")
    echom "myspacevim#after LANG=" . $LANG . " hostname=" . hostname
    if $LANG =~? "\.iso-\?8859[-_]2$" || hostname =~? "\.unosoft\.local"
        set termencoding=iso8859-2
        set listchars=
        set fillchars=
    endif
    au BufNewFile,BufRead *.sql set filetype=sql fileencoding=iso8859-2

	if has('win32') || has('win64')
		call dein#add('tbodt/deoplete-tabnine', { 'build': 'powershell.exe .\install.ps1' })
	else
		call dein#add('tbodt/deoplete-tabnine', { 'build': './install.sh' })
	endif
endfunction

