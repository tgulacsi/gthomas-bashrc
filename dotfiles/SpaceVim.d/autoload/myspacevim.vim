function! myspacevim#before() abort
    "echom "myspacevim#before LANG=" . $LANG
endfunction

function! myspacevim#after() abort
    let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck']
    let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
    set autochdir
    set fileencodings=utf-8,iso8859-2
    silent let hostname = system("hostname")
    echom "myspacevim#after LANG=" . $LANG . " hostname=" . hostname
    if $LANG =~? "\.iso-\?8859[-_]2$" || hostname =~? "\.unosoft\.local"
        set termencoding=iso8859-2
        set listchars=
        set fillchars=
    endif
    au BufNewFile,BufRead *.sql set filetype=sql fileencoding=iso8859-2
endfunction

