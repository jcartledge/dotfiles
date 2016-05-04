" Mappings for priority
nnoremap <buffer> <silent> <leader>1 :s/\v^(\d{4}-\d{2}-\d{2} )?(\(\d\) )?/\1(1) <cr>:noh<cr>
nnoremap <buffer> <silent> <leader>2 :s/\v^(\d{4}-\d{2}-\d{2} )?(\(\d\) )?/\1(2) <cr>:noh<cr>
nnoremap <buffer> <silent> <leader>3 :s/\v^(\d{4}-\d{2}-\d{2} )?(\(\d\) )?/\1(3) <cr>:noh<cr>

"Mapping for labels
nnoremap <buffer> <silent> <leader>@ A @

"Mapping for date
nnoremap <buffer> <silent> <leader>d :s/\v^(\d{4}-\d{2}-\d{2} )?/\=strftime("%Y-%m-%d ")<cr>:noh<cr>
