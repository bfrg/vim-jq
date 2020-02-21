autocmd BufNewFile,BufRead,StdinReadPost *.jq set filetype=jq
autocmd BufNewFile,BufRead,StdinReadPost *
	\ if getline(1) =~ '^#!.*\<jq\>' |
	\   set ft=jq |
	\ endif
