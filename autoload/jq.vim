" ==============================================================================
" File:         autoload/jq.vim
" Author:       bfrg <https://github.com/bfrg>
" Website:      https://github.com/bfrg/vim-jq
" Last Change:  June 25, 2019
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

function! jq#jq_cfile() abort
    if match(getline('.'), '^\s*\(#\+\)\?\s*\(import\|include\)') == -1
        return expand('<cfile>')
    else
        let l:newfile = substitute(expand('<cfile>'), '\(\(\w\+/\)*\)\(\w\+\)$', '\1\3/\3', '')
        return findfile(expand('<cfile>')) != ''
                \ ? expand('<cfile>')
                \ : findfile(l:newfile) != '' ? l:newfile : expand('<cfile>')
    endif
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
