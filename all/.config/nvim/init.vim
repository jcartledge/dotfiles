" Basic editor config {{{
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
set colorcolumn=81
set inccommand=nosplit
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
let g:netrw_liststyle=3
set lbr formatoptions=l
set list listchars=tab:⇥\ ,trail:·

" - nice folding {{{
set foldlevel=99
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
" - }}}
" }}}

" Plugins {{{
call plug#begin()

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

" - Language {{{
Plug 'dzeban/vim-log-syntax'
Plug 'sheerun/vim-polyglot'
Plug 'freitass/todo.txt-vim'
" - }}}
" - Code display {{{
Plug 'Konfekt/FastFold'
Plug 'ap/vim-css-color', {'for': ['css', 'scss']}
Plug 'veloce/vim-behat'
Plug 'vim-scripts/confluencewiki.vim'
" - }}}
" - Integrations {{{
Plug 'christoomey/vim-tmux-navigator'
Plug 'joonty/vdebug'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'ludovicchabant/vim-gutentags'
Plug 'neomake/neomake'
Plug 'tpope/vim-fugitive'
" - }}}
" - Interface {{{
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'airblade/vim-gitgutter'
Plug 'file-line'
Plug 'gmarik/sudo-gui.vim'
Plug 'henrik/vim-indexed-search'
Plug 'jiangmiao/auto-pairs'
Plug 'jszakmeister/vim-togglecursor'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'machakann/vim-highlightedyank'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'
Plug 'rhysd/conflict-marker.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'
" - }}}
" - Commands {{{
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-git'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
" - }}}
" - Colors {{{
Plug 'reedes/vim-colors-pencil'
Plug 'rakr/vim-two-firewatch'
Plug 'AlessandroYorba/Sierra'
" - }}}

call plug#end()

" - Plugins bundled in $VIMRUNTIME {{{
runtime macros/matchit.vim
" - }}}
" }}}

" Plugin settings {{{
" - vdebug {{{
if !exists('g:vdebug_options')
  let g:vdebug_options = {}
endif
if !exists('g:vdebug_options.path_maps')
  let g:vdebug_options.path_maps = {}
endif
let g:vdebug_options["break_on_open"] = 0
" - }}}
" - gitgutter {{{
let g:gitgutter_sign_column_always = 1
let g:gitgutter_sign_modified = '±'
let g:gitgutter_sign_modified_removed = '±'
let g:gitgutter_sign_removed = '-'
" - }}}
" - neomake {{{
autocmd! BufWritePost,BufEnter * silent Neomake
autocmd! InsertLeave,TextChanged,FocusLost * silent! update|Neomake
let g:neomake_vim_enabled_makers = ['vimlint']
let g:neomake_javascript_enabled_makers = ['semistandard']
" - }}}
" - behat {{{
let g:feature_filetype='behat'
" - }}}
" - airline {{{
let g:airline_theme='pencil'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols={}
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#fnamecollapse=0
let g:airline#extensions#tabline#fnametruncate=0
let g:airline#extensions#tabline#buffer_nr_show = 1
" - }}}
" - fzf {{{
let $FZF_DEFAULT_COMMAND='ag --hidden --ignore=.git -g ""'
" - }}}
" - deoplete {{{
let g:deoplete#enable_at_startup = 1
" - }}}
" - php {{{
let php_folding=2
let php_phpdoc_folding=1
" - }}}
" - auto-pairs {{{
" Interferes with markdown checkboxes.
let g:AutoPairsMapSpace = 0
" - }}}
" }}}

" Colours {{{
if (has("termguicolors"))
  set termguicolors
endif
let g:pencil_higher_contrast_ui=0
let g:pencil_gutter_color=1
let g:pencil_terminal_italics=1
colorscheme pencil
nnoremap <silent> <leader>d :set bg=dark<cr>
nnoremap <silent> <leader>l :set bg=light<cr>
" }}}

" Mappings {{{
" - Core {{{
" - - redo {{{
        nnoremap U <c-r>
" - - }}}
" - - quickly edit the vimrc {{{
        nnoremap <silent> <leader>ev :edit $MYVIMRC<CR>
" - - }}}
" - - clear search highlight {{{
nnoremap <leader>/ :noh<CR><ESC>
" - - }}}
" - - make space toggle folds {{{
nnoremap <Space> za
" - - }}}
" - - TAB to switch buffers {{{
nnoremap <tab> <c-^>
" - - }}}
" - - TAB in insert to autocomplete
imap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" - - }}}
" - }}}
" - Plugins {{{
" - - Goyo {{{
nnoremap <leader><space> :Goyo<cr>
" - - }}}
" - - Tagbar {{{
nnoremap <leader>t :TagbarToggle<cr>
" - - }}}
" - - UndoTree {{{
nnoremap <leader>u :UndotreeToggle\|UndotreeFocus<CR>
" - - }}}
" - - EasyAlign {{{
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" - - }}}
" - - fzf {{{
map <silent> <C-p> :FZF<cr>
map <silent> <C-t> :Tags<cr>
map <silent> <C-r> :BTags<cr>
map <silent> <C-f> :Ag<cr>
map <silent> <C-b> :Buffers<cr>
" - - }}}
" - }}}
" }}}

" Autocommands {{{
" - drupal stuff {{{
augroup drupal
  autocmd BufRead,BufNewFile *.module set filetype=php
  autocmd BufRead,BufNewFile *.install set filetype=php
  autocmd BufRead,BufNewFile *.info set filetype=dosini
augroup end
" - }}}
" - good enough folding for bracey languages {{{
augroup folding
  autocmd!
  autocmd FileType css,scss,less,javascript setlocal foldmethod=marker
  autocmd FileType css,scss,less,javascript setlocal foldmarker={,}
  autocmd FileType css,scss,less,javascript normal zR
augroup end
" - }}}
" - highlight php docblocks {{{
function! PhpSyntaxOverride()
  hi! def link phpDocTags phpDefine
  hi! def link phpDocParam phpType
endfunction
augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup end
" - }}}
" - vimrc {{{
augroup vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC nested silent source $MYVIMRC
  autocmd BufRead $MYVIMRC silent setlocal foldmethod=marker
  autocmd BufRead $MYVIMRC normal zM
augroup end
" - }}}
" }}}
