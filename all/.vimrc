call plug#begin()

Plug 'xero/sourcerer.vim'

" shows a git diff in the gutter (sign column) and stages/reverts hunks.
Plug 'airblade/vim-gitgutter'

" Secure, user-configurable modeline support
Plug 'ciaranm/securemodelines'

Plug 'file-line'
Plug 'gmarik/sudo-gui.vim'
Plug 'groenewege/vim-less'
Plug 'jelera/vim-javascript-syntax'
Plug 'itchyny/lightline.vim'
Plug 'jszakmeister/vim-togglecursor'

" add completion from current buffer for command line mode ':'
" after a '/', and in command line mode '/' and '?'.
Plug 'skammer/vim-css-color'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'chriskempson/base16-vim'
Plug 'freitass/todo.txt-vim'
Plug 'kien/ctrlp.vim'
call plug#end()

set clipboard=unnamed

if !has('gui_running')
  set t_Co=256
endif
set bg=dark
colorscheme sourcerer

" these plugins are bundled in $VIMRUNTIME
ru macros/matchit.vim
ru macros/editexisting.vim

" basic editor config
syntax on
filetype plugin indent on
set hidden number
set expandtab tabstop=2 shiftwidth=2
set autoindent smartindent
set autoread
set incsearch hlsearch showmatch
set ignorecase smartcase
set wildmode=list:longest
set scrolloff=2
set backspace=indent,eol,start whichwrap+=<,>,[,]
set nobackup noswapfile
set encoding=utf-8
set mouse=a
set mousemodel=popup_setpos
set display+=lastline
set shortmess=atI
set laststatus=2

" quickly edit/reload the vimrc file
nmap <silent> <leader>ev :tabedit $MYVIMRC<CR>
augroup sourcevimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup end " }

" clear search highlight
nmap <leader><leader> :noh<CR><ESC>

" resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" save when focus lost
au FocusLost * silent! w

" The following two options interfere with one another.
"
" To display tabs and trailing space use :set list
" for word wrapping use :set nolist
nmap <silent> <leader>w :set list!<cr>

" word wrapping
set lbr formatoptions=l

" highlight whitespace
set list listchars=tab:»·,trail:·

" spellcheck
nmap <silent> <leader>s :setlocal invspell<CR>

" gitgutter
let g:gitgutter_sign_column_always = 1

" useful for browsing URLs, opening files in their default app etc
" relies on OS X CLI open command
nmap <silent> go :call system("open " . expand('<cWORD>'))<CR>
vmap <silent> go :call system("open " . @*)<CR>

" drupal stuff
if has("autocmd")
  autocmd BufRead,BufNewFile *.module   set filetype=php
  autocmd BufRead,BufNewFile *.install  set filetype=php
  autocmd BufRead,BufNewFile *.info     set filetype=dosini
endif

" good enough folding for bracey languages
au FileType php,css,less,javascript setlocal foldmethod=marker
au FileType php,css,less,javascript setlocal foldmarker={,}
au FileType php,css,less,javascript normal zR

" good enough highlighting for JSON
autocmd BufNewFile,BufRead *.json set ft=javascript

" make space toggle folds in
noremap <SPACE> za

" uh
autocmd BufNewFile,BufRead Gemfile set ft=ruby

