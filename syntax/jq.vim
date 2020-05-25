" ==============================================================================
" Vim syntax file
" Language:     jq (Command-line JSON processor)
" Author:       bfrg <https://github.com/bfrg>
" Website:      https://github.com/bfrg/vim-jq
" Last Change:  May 9, 2020
" License:      Same as Vim itself (see :h license)
" ==============================================================================

if exists('b:current_syntax')
    finish
endif

let s:keepcpo = &cpoptions
set cpoptions&vim

" Comments
syntax match jqComment "#.*$" display contains=jqTodo,@Spell
syntax keyword jqTodo contained TODO FIXME XXX

" Shebang lines:
"   #!/usr/bin/jq -f
"   #!/usr/bin/env -S jq -f
syntax match jqRun "\%^#!.*$"

" Strings and string interpolation
syntax region jqString start='"' skip='\\"' end='"' contains=jqStringInterpol,jqStringParen
syntax region jqStringInterpol matchgroup=jqOperator start='\\(' end=')' contains=jqStringParen contained
syntax region jqStringParen start='(' end=')' contains=jqStringParen contained

" Numbers
syntax match jqNumber "\<\d\+\>"

" Language keywords
syntax keyword jqImport      import include module
syntax keyword jqStatement   as break label reduce foreach
syntax keyword jqConditional if then elif else end
syntax keyword jqOperator    and or not
syntax keyword jqException   try catch
syntax keyword jqBoolean     true false
syntax keyword jqConstant    null
syntax keyword jqDef         def nextgroup=jqFunction skipwhite

" User defined functions
syntax match jqFunction "\<\w\+\>" display contained

" Variables
syntax match jqVariable "\$" nextgroup=jqVariableName
syntax match jqVariableName "\<\w\+\>" display contained

" Format strings (@json, @html, etc.)
syntax match jqFormat "@" nextgroup=jqFormatName
syntax keyword jqFormatName text json html uri csv tsv sh base64 base64d display contained

" Special operators
syntax match jqPipe "|=\||"
syntax match jqAlternate "//=\|//"


" Default highlightings
highlight default link jqRun            PreProc
highlight default link jqComment        Comment
highlight default link jqTodo           Todo
highlight default link jqString         String
highlight default link jqStringParen    String
highlight default link jqStringInterpol String
highlight default link jqNumber         Number
highlight default link jqStatement      Statement
highlight default link jqOperator       Operator
highlight default link jqDef            Statement
highlight default link jqConditional    Conditional
highlight default link jqException      Exception
highlight default link jqBoolean        Constant
highlight default link jqConstant       Constant
highlight default link jqImport         Statement
highlight default link jqFunction       Function
highlight default link jqFormat         Macro
highlight default link jqFormatName     Macro
highlight default link jqVariable       Identifier
highlight default link jqVariableName   Identifier
highlight default link jqPipe           Operator
highlight default link jqAlternate      Operator


" Builtin functions
" List is obtained by running: echo {} | jq -r builtins[]
if get(g:, 'jq_highlight_builtin_functions', 1)
    syntax keyword jqBuiltinFunction length utf8length keys keys_unsorted has in map map_values path del
    syntax keyword jqBuiltinFunction getpath setpath delpaths to_entries from_entries with_entries select
    syntax keyword jqBuiltinFunction arrays objects iterables booleans numbers normals finites strings
    syntax keyword jqBuiltinFunction nulls values scalars empty error halt halt_error paths leaf_paths
    syntax keyword jqBuiltinFunction add any all flatten range floor sqrt tonumber tostring type
    syntax keyword jqBuiltinFunction infinite nan isinfinite isnan isfinite isnormal sort sort_by
    syntax keyword jqBuiltinFunction group_by min max min_by max_by unique unique_by reverse indices
    syntax keyword jqBuiltinFunction index rindex inside startswith endswith combinations ltrimstr
    syntax keyword jqBuiltinFunction rtrimstr explode implode split join ascii_downcase ascii_upcase
    syntax keyword jqBuiltinFunction while until recurse recurse_down walk env transpose bsearch tojson
    syntax keyword jqBuiltinFunction fromjson builtins fromdateiso8601 todateiso8601 fromdate todate now
    syntax keyword jqBuiltinFunction strptime strftime strflocaltime mktime gmtime localtime test match
    syntax keyword jqBuiltinFunction capture scan splits sub gsub isempty limit first last nth acos
    syntax keyword jqBuiltinFunction acosh asin asinh atan atanh cbrt ceil cos cosh erf erfc exp exp10
    syntax keyword jqBuiltinFunction exp2 expm1 fabs floor gamma j0 j1 lgamma log log10 log1p log2 logb
    syntax keyword jqBuiltinFunction nearbyint pow10 rint round significand sin sinh sqrt tan tanh
    syntax keyword jqBuiltinFunction tgamma trunc y0 y1 atan2 copysign drem fdim fmax fmin fmod frexp
    syntax keyword jqBuiltinFunction hypot jn ldexp modf nextafter nexttoward pow remainder scalb
    syntax keyword jqBuiltinFunction scalbln yn fma input inputs debug stderr input_filename
    syntax keyword jqBuiltinFunction input_line_number truncate_stream fromstream tostream
    syntax keyword jqBuiltinFunction modulemeta INDEX JOIN IN
    highlight default link jqBuiltinFunction Function
    syntax keyword jqBuiltinFunctionContains contains
    highlight default link jqBuiltinFunctionContains Function
endif

" Module prefix (similar to namespaces in C++), e.g. mymodule::add(. + 1)
if get(g:, 'jq_highlight_module_prefix', 1)
    syntax match jqModuleName "\<\w\+\>::"me=e-2
    highlight default link jqModuleName PreProc
endif

" Imported JSON file aliases
if get(g:, 'jq_highlight_json_file_prefix', 1)
    syntax match jqJsonName "\$\<\w\+\>::"me=e-2
    highlight default link jqJsonName PreProc
endif

" Objects like .foo
if get(g:, 'jq_highlight_objects', 0)
    syntax match jqObject "\.\<\w\+\>"
    highlight default link jqObject Type
endif

" Highlight user function calls, like foo(.xyz)
if get(g:, 'jq_highlight_function_calls', 0)
    syntax match jqUserFunction "\<\w\+\>("me=e-1
    highlight default link jqUserFunction Function
endif

let b:current_syntax = 'jq'

let &cpoptions = s:keepcpo
unlet s:keepcpo
