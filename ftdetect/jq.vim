autocmd BufNewFile,BufRead,StdinReadPost *.jq set filetype=jq
autocmd BufNewFile,BufRead,StdinReadPost * if getline(1) =~# '^#!\f\+\<jq\>' | set filetype=jq | endif
