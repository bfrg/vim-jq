" ==============================================================================
" Vim syntax file
" Language:     jq (Command-line JSON processor)
" Author:       bfrg <https://github.com/bfrg>
" Website:      https://github.com/bfrg/vim-jq
" Last Change:  June 21, 2019
" License:      Same as Vim itself (see :h license)
" ==============================================================================

if exists('b:current_syntax')
    finish
endif

let s:keepcpo = &cpoptions
set cpoptions&vim

" Comments
syntax match JqComment "#.*$" display contains=JqTodo,@Spell
syntax keyword JqTodo contained TODO FIXME XXX

" Shebang lines:
"   #!/usr/bin/jq -f
"   #!/usr/bin/env -S jq -f
syntax match JqRun "\%^#!.*$"

" Strings and string interpolation
syntax region JqString start='"' end='"' contains=JqStringInterpol
syntax region JqStringInterpol matchgroup=JqOperator start='\\(' end=')' contained

" Numbers
syntax match JqNumber "\<\d\+\>"

" Language keywords
syntax keyword JqImport      import include module
syntax keyword JqStatement   as break label reduce foreach
syntax keyword JqConditional if then elif else end
syntax keyword JqOperator    and or not
syntax keyword JqException   try catch
syntax keyword JqBoolean     true false
syntax keyword JqConstant    null
syntax keyword JqDef         def nextgroup=JqFunction skipwhite

" User defined functions
syntax match JqFunction "\<\w\+\>" display contained

" Variables
syntax match JqVariable "\$" nextgroup=JqVariableName
syntax match JqVariableName "\<\w\+\>" display contained

" Format strings (@json, @html, etc.)
syntax match JqFormat "@" nextgroup=JqFormatName
syntax keyword JqFormatName text json html uri csv tsv sh base64 base64d display contained

" Special operators
syntax match JqPipe "|=\||"
syntax match JqAlternate "//=\|//"


" Default highlightings
highlight default link JqRun            PreProc
highlight default link JqComment        Comment
highlight default link JqTodo           Todo
highlight default link JqString         String
highlight default link JqStringInterpol String
highlight default link JqNumber         Number
highlight default link JqStatement      Statement
highlight default link JqOperator       Operator
highlight default link JqDef            Statement
highlight default link JqConditional    Conditional
highlight default link JqException      Exception
highlight default link JqBoolean        Constant
highlight default link JqConstant       Constant
highlight default link JqImport         Statement
highlight default link JqFunction       Function
highlight default link JqFormat         Macro
highlight default link JqFormatName     Macro
highlight default link JqVariable       Identifier
highlight default link JqVariableName   Identifier
highlight default link JqPipe           Operator
highlight default link JqAlternate      Operator


" Builtin functions
" List is obtained by running: echo {} | jq -r builtins[]
if get(g:, 'jq_highlight_builtin_functions', 1)
    syntax keyword JqBuiltinFunction length utf8length keys keys_unsorted has in map map_values path del
    syntax keyword JqBuiltinFunction getpath setpath delpaths to_entries from_entries with_entries select
    syntax keyword JqBuiltinFunction arrays objects iterables booleans numbers normals finites strings
    syntax keyword JqBuiltinFunction nulls values scalars empty error halt halt_error paths leaf_paths
    syntax keyword JqBuiltinFunction add any all flatten range floor sqrt tonumber tostring type
    syntax keyword JqBuiltinFunction infinite nan isinfinite isnan isfinite isnormal sort sort_by
    syntax keyword JqBuiltinFunction group_by min max min_by max_by unique unique_by reverse indices
    syntax keyword JqBuiltinFunction index rindex inside startswith endswith combinations ltrimstr
    syntax keyword JqBuiltinFunction rtrimstr explode implode split join ascii_downcase ascii_upcase
    syntax keyword JqBuiltinFunction while until recurse recurse_down walk env transpose bsearch tojson
    syntax keyword JqBuiltinFunction fromjson builtins fromdateiso8601 todateiso8601 fromdate todate now
    syntax keyword JqBuiltinFunction strptime strftime strflocaltime mktime gmtime localtime test match
    syntax keyword JqBuiltinFunction capture scan splits sub gsub isempty limit first last nth acos
    syntax keyword JqBuiltinFunction acosh asin asinh atan atanh cbrt ceil cos cosh erf erfc exp exp10
    syntax keyword JqBuiltinFunction exp2 expm1 fabs floor gamma j0 j1 lgamma log log10 log1p log2 logb
    syntax keyword JqBuiltinFunction nearbyint pow10 rint round significand sin sinh sqrt tan tanh
    syntax keyword JqBuiltinFunction tgamma trunc y0 y1 atan2 copysign drem fdim fmax fmin fmod frexp
    syntax keyword JqBuiltinFunction hypot jn ldexp modf nextafter nexttoward pow remainder scalb
    syntax keyword JqBuiltinFunction scalbln yn fma input inputs debug stderr input_filename
    syntax keyword JqBuiltinFunction input_line_number truncate_stream fromstream tostream contains
    syntax keyword JqBuiltinFunction modulemeta INDEX JOIN IN
    highlight default link JqBuiltinFunction Function
endif

" Module prefix (similar to namespaces in C++), e.g. mymodule::add(. + 1)
if get(g:, 'jq_highlight_module_prefix', 1)
    syntax match JqModuleName "\<\w\+\>::"me=e-2
    highlight default link JqModuleName PreProc
endif

" Imported JSON file aliases
if get(g:, 'jq_highlight_json_file_prefix', 1)
    syntax match JqJsonName "\$\<\w\+\>::"me=e-2
    highlight default link JqJsonName PreProc
endif

" Objects like .foo
if get(g:, 'jq_highlight_objects', 0)
    syntax match JqObject "\.\<\w\+\>"
    highlight default link JqObject Type
endif

" Highlight user function calls, like foo(.xyz)
if get(g:, 'jq_highlight_function_calls', 0)
    syntax match JqUserFunction "\<\w\+\>("me=e-1
    highlight default link JqUserFunction Function
endif

let b:current_syntax = 'jq'

let &cpoptions = s:keepcpo
unlet s:keepcpo
