function! myspacevim#before() abort
endfunction

function! myspacevim#after() abort
    let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck']
    let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
endfunction

