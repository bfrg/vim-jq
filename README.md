vim-jq
======

Vim plugin for [jq](https://github.com/stedolan/jq) files.


Syntax highlighting
-------------------

Options:
```vim
" Don't highlight builtin functions/filters (default: 1)
let g:jq_highlight_builtin_functions = 0

" Don't highlight module prefix, like NAME:: (default: 1)
let g:jq_highlight_module_prefix = 0

" Don't highlight imported JSON file prefix, like $NAME:: (default: 1)
let g:jq_highlight_json_file_prefix = 0

" Highlight objects like .foo (default: 0)
let g:jq_highlight_objects = 1

" Highlight all function calls (default: 0)
let g:jq_highlight_function_calls = 1
```

Mappings
--------

* Jump to `[count]` next/previous function definition: `]]`/`[[`.
* Jump to `[count]` next/previous nested function definition: `]m`/`[m`.


License
-------

Distributed under the same terms as Vim itself. See `:help license`.
