call plug#begin()

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

Plug 'Konfekt/FastFold'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color', {'for': ['css', 'scss']}
Plug 'christoomey/vim-tmux-navigator'
Plug 'easymotion/vim-easymotion'
Plug 'file-line'
Plug 'freitass/todo.txt-vim'
Plug 'gmarik/sudo-gui.vim'
Plug 'henrik/vim-indexed-search'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'
Plug 'neomake/neomake'
Plug 'sheerun/vim-polyglot'
Plug 'sjl/vitality.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'

" Colors
Plug 'xero/sourcerer.vim'
Plug 'reedes/vim-colors-pencil'

call plug#end()

set t_Co=256
colorscheme sourcerer
set bg=dark

" these plugins are bundled in $VIMRUNTIME
runtime macros/matchit.vim

" basic editor config
set hidden number relativenumber
set expandtab tabstop=2 shiftwidth=2
set smartindent
set autoread
set showmatch
set ignorecase smartcase
set scrolloff=2
set whichwrap+=<,>,[,]
set nobackup noswapfile
set mousemodel=popup_setpos
set shortmess=atI
set clipboard+=unnamedplus
set undofile
set undodir=~/.vimundo

" insert line in normal mode
nnoremap <cr> o<esc>

" undotree
nnoremap <leader>u :UndotreeToggle\|UndotreeFocus<CR>

" gitgutter
let g:gitgutter_sign_column_always = 1
let g:gitgutter_sign_modified = '±'
let g:gitgutter_sign_modified_removed = '±'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed = '-'

" neomake
autocmd! BufWritePost,BufEnter * silent Neomake
autocmd! InsertLeave,TextChanged * silent! update|Neomake
autocmd! FocusLost * silent! stopinsert|update|Neomake

let g:neomake_vim_enabled_makers = ['vimlint']
let g:neomake_javascript_enabled_makers = ['semistandard']

" airline
let g:airline_theme='pencil'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols={}
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" vitality
let g:vitality_always_assume_iterm = 1

" quickly edit/reload the vimrc file
nnoremap <silent> <leader>ev :edit $MYVIMRC<CR>
augroup sourcevimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC nested silent source $MYVIMRC
augroup end

" clear search highlight
nnoremap <leader>/ :noh<CR><ESC>

" better search highlight
highlight Search ctermbg=blue

" The following two options interfere with one another.
"
" To display tabs and trailing space use :set list
" for word wrapping use :set nolist
nnoremap <silent> <leader>w :set list!<cr>

" word wrapping
set lbr formatoptions=l

" highlight whitespace
set list listchars=tab:⇥\ ,trail:·
" hi Specialkey ctermfg=236 ctermbg=None

" spellcheck in textish files
autocmd FileType txt,markdown,todo nnoremap <silent> <leader>s :setlocal invspell<CR>

" useful for browsing URLs, opening files in their default app etc
" relies on OS X CLI open command
nnoremap <silent> go :call system("open " . expand('<cWORD>'))<CR>
vnoremap <silent> go :call system("open " . @*)<CR>

" drupal stuff
autocmd BufRead,BufNewFile *.module   set filetype=php
autocmd BufRead,BufNewFile *.install  set filetype=php
autocmd BufRead,BufNewFile *.info     set filetype=dosini

" good enough folding for bracey languages
autocmd FileType css,scss,less,javascript setlocal foldmethod=marker
autocmd FileType css,scss,less,javascript setlocal foldmarker={,}
autocmd FileType css,scss,less,javascript normal zR

" nice folding
autocmd BufRead,BufNewFile,BufEnter * hi Folded ctermfg=242 ctermbg=236
set fillchars="fold: "
set foldtext=MyFoldText()
function! MyFoldText()
  let line = getline(v:foldstart)
  if match(line, "/\*\\*") == -1
    " not a docblock
    return line . " …"
  else
    " docblock - is it @file?
    let firstLine = getline(v:foldstart + 1)
    let secondLine = getline(v:foldstart + 2)
    let description = (match(firstLine, "@file") == -1) ? firstLine : secondLine
    return line . substitute(description, "^\\s*\\*", "", "") . " */"
  end
endfunction

" make space toggle folds
noremap <SPACE> za

" uh
autocmd BufNewFile,BufRead Gemfile set ft=ruby

" fzf
map <silent> <C-p> :FZF<cr>
map <silent> <C-t> :Tags<cr>
map <silent> <C-r> :BTags<cr>
map <silent> <C-f> :Ag<cr>
map <silent> <C-b> :Buffers<cr>

" syntax folding for php
" autocmd FileType php setlocal foldmethod=syntax
" autocmd FileType php setlocal foldlevel=99
let php_folding=2
let php_phpdoc_folding=1
nnoremap <leader>f :set foldlevel=0<cr>

" highlight php docblocks
function! PhpSyntaxOverride()
  hi! def link phpDocTags phpDefine
  hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END

" auto-pairs
" Interferes with markdown checkboxes.
let g:AutoPairsMapSpace = 0

" Split shell
nnoremap <c-z> :silent !tmux split-window<cr>

" Tab to switch buffers
nnoremap <tab> <c-^>

" deoplete
let g:deoplete#enable_at_startup = 1
