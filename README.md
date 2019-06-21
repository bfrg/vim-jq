vim-jq
======

Vim plugin for [jq](https://github.com/stedolan/jq) files.


Syntax highlighting
-------------------

#### Screenshot

<dl><p align="center">
<img src="https://user-images.githubusercontent.com/6266600/59893960-28064380-93df-11e9-9fa2-bf2933e4d6ea.png" width="480"/>
</p></dl>

#### Syntax highlighting options

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
" This will highlight all words directly followed by an opening parenthesis
let g:jq_highlight_function_calls = 1
```

Mappings
--------

* Jump to `[count]` next/previous function definition: `]]`/`[[`.
* Jump to `[count]` next/previous nested function definition: `]m`/`[m`.


License
-------

Distributed under the same terms as Vim itself. See `:help license`.
