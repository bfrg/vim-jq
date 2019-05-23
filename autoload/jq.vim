" ==============================================================================
" File:         autoload/jq.vim
" Author:       bfrg <https://github.com/bfrg>
" Website:      https://github.com/bfrg/vim-jq
" Last Change:  June 21, 2019
" License:      Same as Vim itself (see :h license)
" ==============================================================================

let s:save_cpo = &cpoptions
set cpoptions&vim

function! jq#jump(mode, pattern, flags, count) abort
    if a:mode == 'x'
        normal! gv
    endif
    let l:cnt = a:count
    mark '
    while l:cnt > 0
        call search(a:pattern, a:flags)
        let l:cnt = l:cnt - 1
    endwhile
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
