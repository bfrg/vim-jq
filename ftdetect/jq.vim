autocmd BufNewFile,BufRead,StdinReadPost *.[jxy]q set filetype=jq
autocmd BufNewFile,BufRead,StdinReadPost * if getline(1) =~# '^#!\f\+\(\s\(-\S\+\)\?\)*\<[jxy]q\>' | set filetype=jq | endif
