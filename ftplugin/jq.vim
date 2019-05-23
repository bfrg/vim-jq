" ==============================================================================
" Vim filetype plugin file
" Language:     jq (Command-line JSON processor)
" Author:       bfrg <https://github.com/bfrg>
" Website:      https://github.com/bfrg/vim-jq
" Last Change:  June 21, 2019
" License:      Same as Vim itself (see :h license)
" ==============================================================================

if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpoptions
set cpoptions&vim

setlocal comments=:#
setlocal commentstring=#\ %s
setlocal suffixesadd=.jq
setlocal include=^\\s*\\(import\\\|include\\)
setlocal define=^\\s*def
setlocal formatoptions=cqornlj

let b:undo_ftplugin = 'setlocal comments< commentstring< suffixesadd< include<'
        \ . ' define< formatoptions<'


" Append default module search paths to &path
" Note: if ~/.jq is a file, it is sourced by jq into the main program
let s:paths = split(copy(&path), ',')
let s:default_paths = []
if !filereadable(expand('~/.jq'))
    if !count(s:paths, expand('~/.jq'))
        call add(s:default_paths, expand('~/.jq'))
    endif
endif
call add(s:default_paths, simplify(fnamemodify(exepath('jq'), ':h') . '/../lib/jq'))
" call add(s:default_paths, simplify(fnamemodify(exepath('jq'), ':h') . '/../lib'))
let &l:path = join(extend(s:paths, s:default_paths), ',')
unlet s:paths s:default_paths
let b:undo_ftplugin .= ' | setlocal path<'


" matchit.vim
if exists('g:loaded_matchit')
    let b:match_words =
            \   '\<if\>:\<elif\>:\<else\>:\<end\>,'
            \ . '\<try\>:\<catch\>,'
            \ . '\<def\>:\%(([^)]*\|#.\{-}\)\@<!;'
    let b:match_skip = 'synIDattr(synID(line("."), col("."), 1), "name") =~? "comment"'
    let b:undo_ftplugin .= ' | unlet b:match_words b:match_skip'
endif


if !exists('g:no_plugin_maps') && !exists('g:no_jq_maps')
    " Go to [count] next global function definition
    nnoremap <silent> <buffer> ]] :<c-u>call jq#jump('n', '^def', 'W',  v:count1)<cr>
    xnoremap <silent> <buffer> ]] :<c-u>call jq#jump('x', '^def', 'W',  v:count1)<cr>
    onoremap <silent> <buffer> ]] :<c-u>call jq#jump('o', '^def', 'W',  v:count1)<cr>

    " Go to [count] previous global function definition
    nnoremap <silent> <buffer> [[ :<c-u>call jq#jump('n', '^def', 'Wb', v:count1)<cr>
    xnoremap <silent> <buffer> [[ :<c-u>call jq#jump('x', '^def', 'Wb', v:count1)<cr>
    onoremap <silent> <buffer> [[ :<c-u>call jq#jump('o', '^def', 'Wb', v:count1)<cr>

    " Go to [count] next nested function definition
    nnoremap <silent> <buffer> ]m :<c-u>call jq#jump('n', '^\s\+\zsdef', 'W',  v:count1)<cr>
    xnoremap <silent> <buffer> ]m :<c-u>call jq#jump('x', '^\s\+\zsdef', 'W',  v:count1)<cr>
    onoremap <silent> <buffer> ]m :<c-u>call jq#jump('o', '^\s\+\zsdef', 'W',  v:count1)<cr>

    " Go to [count] previous nested function definition
    nnoremap <silent> <buffer> [m :<c-u>call jq#jump('n', '^\s\+\zsdef', 'Wb', v:count1)<cr>
    xnoremap <silent> <buffer> [m :<c-u>call jq#jump('x', '^\s\+\zsdef', 'Wb', v:count1)<cr>
    onoremap <silent> <buffer> [m :<c-u>call jq#jump('o', '^\s\+\zsdef', 'Wb', v:count1)<cr>

    let b:undo_ftplugin .=
            \   ' | execute "nunmap <buffer> ]]" | execute "nunmap <buffer> [["'
            \ . ' | execute "xunmap <buffer> ]]" | execute "xunmap <buffer> [["'
            \ . ' | execute "ounmap <buffer> ]]" | execute "ounmap <buffer> [["'
            \ . ' | execute "nunmap <buffer> ]m" | execute "nunmap <buffer> [m"'
            \ . ' | execute "xunmap <buffer> ]m" | execute "xunmap <buffer> [m"'
            \ . ' | execute "ounmap <buffer> ]m" | execute "ounmap <buffer> [m"'
endif

let &cpoptions = s:cpo_save
unlet s:cpo_save
