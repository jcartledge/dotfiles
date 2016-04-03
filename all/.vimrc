call plug#begin()

Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
Plug 'ciaranm/securemodelines'
Plug 'digitaltoad/vim-pug'
Plug 'file-line'
Plug 'freitass/todo.txt-vim'
Plug 'gmarik/sudo-gui.vim'
Plug 'groenewege/vim-less'
Plug 'itchyny/lightline.vim'
Plug 'jelera/vim-javascript-syntax'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-git'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'xero/sourcerer.vim'

call plug#end()

set t_Co=256
colorscheme sourcerer
set bg=dark
let g:lightline = {'colorscheme': 'wombat'}

" these plugins are bundled in $VIMRUNTIME
runtime macros/matchit.vim
runtime macros/editexisting.vim

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
set clipboard=unnamed

" tree mode
let g:netrw_liststyle=3

" ctags
set tags=./tags;,tags;

" quickly edit/reload the vimrc file
nmap <silent> <leader>ev :edit $MYVIMRC<CR>
augroup sourcevimrc " {
  autocmd!
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
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
autocmd BufRead,BufNewFile *.module   set filetype=php
autocmd BufRead,BufNewFile *.install  set filetype=php
autocmd BufRead,BufNewFile *.info     set filetype=dosini

" good enough folding for bracey languages
autocmd FileType php,css,less,javascript setlocal foldmethod=marker
autocmd FileType php,css,less,javascript setlocal foldmarker={,}
autocmd FileType php,css,less,javascript normal zR

" nice folding
autocmd BufRead,BufNewFile,BufEnter * hi Folded ctermfg=242 ctermbg=236
set fillchars="fold: "
set foldtext=MyFoldText()
function! MyFoldText()
  return getline(v:foldstart) . " …"
endfunction

" good enough highlighting for JSON
autocmd BufNewFile,BufRead *.json set ft=javascript

" make space toggle folds in
noremap <SPACE> zc
noremap <RETURN> zo

" uh
autocmd BufNewFile,BufRead Gemfile set ft=ruby

" fzf
nnoremap <C-p> :FZF<cr>
vnoremap <C-p> <esc>:FZF<cr>
inoremap <C-p> <esc>:FZF<cr>

" limelight
let g:limelight_conceal_ctermfg = 240

