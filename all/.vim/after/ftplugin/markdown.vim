" Mappings for headings
nnoremap <buffer> <leader>h1 mmYp<c-v>$r=`m
nnoremap <buffer> <leader>h2 mmYp<c-v>$r-`m

" Complete checklist item
nnoremap <buffer> <silent> <leader>x mm:s/\v(\s*- \[) \]/\1x]<cr>:noh<cr>`m
