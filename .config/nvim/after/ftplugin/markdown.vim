" Mappings for headings
nnoremap <buffer> <leader>h1 Yp<c-v>$r=$
nnoremap <buffer> <leader>h2 Yp<c-v>$r-$

" Complete checklist item
nnoremap <buffer> <silent> <leader>x mm:s/\v(\s*- \[) \]/\1x]<cr>:noh<cr>`m

" Add bullet on newline when in a list
setlocal comments=b:-,b:+,b:*
setlocal formatoptions+=ro

" F5 to preview
nnoremap <buffer> <f5> :w !markdown\|(echo "<link rel=stylesheet href=https://cdn.rawgit.com/sindresorhus/github-markdown-css/gh-pages/github-markdown.css><div class=markdown-body>" && cat)\|browser<cr>
