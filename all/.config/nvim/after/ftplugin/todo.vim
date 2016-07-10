" Mappings for priority
nnoremap <buffer> <silent> <leader>1 mt:s/\v^(\d{4}-\d{2}-\d{2} )?(\(\d\) )?/\1(1) <cr>:noh<cr>`t
nnoremap <buffer> <silent> <leader>2 mt:s/\v^(\d{4}-\d{2}-\d{2} )?(\(\d\) )?/\1(2) <cr>:noh<cr>`t
nnoremap <buffer> <silent> <leader>3 mt:s/\v^(\d{4}-\d{2}-\d{2} )?(\(\d\) )?/\1(3) <cr>:noh<cr>`t

" Mapping for project
nnoremap <buffer> <silent> <leader>+ A +

" Mapping for labels
nnoremap <buffer> <silent> <leader>@ A @

" Mapping for date
nnoremap <buffer> <silent> <leader>d mt:s/\v^(\d{4}-\d{2}-\d{2} )?/\=strftime("%Y-%m-%d ")<cr>:noh<cr>`t

" Mapping for do
nnoremap <buffer> <silent> <leader>x mtIx <esc>`tll
