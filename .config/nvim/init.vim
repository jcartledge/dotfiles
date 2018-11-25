" Basic editor config {{{
set hidden number relativenumber
set expandtab tabstop=2 shiftwidth=2
set smartindent
set autoread
set showmatch
set laststatus=0
set ignorecase smartcase
set scrolloff=2
set whichwrap+=<,>,[,]
set nobackup noswapfile
set mouse=a
set mousemodel=popup_setpos
set shortmess=atI
set clipboard+=unnamedplus
set undofile
set undodir=~/.vimundo
set colorcolumn=81
set inccommand=nosplit
set lbr formatoptions=l
set list listchars=tab:⇥\ ,trail:·
set splitright splitbelow
" - nice folding {{{
set fillchars="fold: "
set foldlevelstart=99
set foldtext=MyFoldText()
function! MyFoldText()
  let line=getline(v:foldstart)
  if match(line, "/\*\\*") == -1
    " not a docblock
    return line
  else
    " docblock - is it @file?
    let firstLine=getline(v:foldstart + 1)
    let secondLine=getline(v:foldstart + 2)
    let description=(match(firstLine, "@file") == -1) ? firstLine : secondLine
    return line . substitute(description, "^\\s*\\*", "", "") . " */"
  end
endfunction
" - }}}
" }}}

" Plugins {{{
" - Install and initialise vim-plug {{{
let $PLUGDOTVIM=fnamemodify($MYVIMRC, ':p:h') . '/autoload/plug.vim'
if empty(glob($PLUGDOTVIM))
  silent !curl -fLo $PLUGDOTVIM --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
" - }}}
" - Language {{{
Plug 'Shougo/context_filetype.vim'
Plug 'dzeban/vim-log-syntax'
Plug 'freitass/todo.txt-vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'heavenshell/vim-jsdoc'
Plug 'sheerun/vim-polyglot'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'vim-scripts/confluencewiki.vim'
" - }}}
" - Code display {{{
Plug 'Konfekt/FastFold'
Plug 'ap/vim-css-color', {'for': ['css', 'scss']}
Plug 'veloce/vim-behat'
" - }}}
" - Integrations {{{
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'lambdalisue/gina.vim'
Plug 'w0rp/ale'
" - }}}
" - Interface {{{
Plug '907th/vim-auto-save'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'airblade/vim-gitgutter'
Plug 'djoshea/vim-autoread'
Plug 'gcmt/wildfire.vim'
Plug 'gmarik/sudo-gui.vim'
Plug 'henrik/vim-indexed-search'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'jiangmiao/auto-pairs'
Plug 'jszakmeister/vim-togglecursor'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'machakann/vim-highlightedyank'
Plug 'mattn/emmet-vim'
Plug 'rhysd/conflict-marker.vim'
Plug 'tpope/vim-sleuth'
Plug 'tyru/caw.vim'
Plug 'vim-scripts/confluencewiki.vim'
Plug 'vim-scripts/file-line'
Plug 'wellle/targets.vim'
" - }}}
" - Commands {{{
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-git'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
" - }}}
" - Colors {{{
Plug 'reedes/vim-colors-pencil'
Plug 'sonjapeterson/1989.vim'
Plug 'brendonrapp/smyck-vim'
" - }}}

call plug#end()

" - Plugins bundled in $VIMRUNTIME {{{
runtime macros/matchit.vim
" - }}}
" }}}

" Plugin settings {{{
" - auto-save {{{
let g:auto_save=1
let g:auto_save_events = ["InsertLeave", "TextChanged", "FocusLost"]
" - }}}
" - caw {{{
let g:caw_operator_keymappings=1
" - }}}
" - deoplete {{{
let g:deoplete#enable_at_startup=1
" - }}}
" - gitgutter {{{
set signcolumn=yes
let g:gitgutter_sign_modified='±'
let g:gitgutter_sign_modified_removed='±'
let g:gitgutter_sign_removed='-'
" - }}}
" - ale {{{
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_echo_msg_format = '%linter%: %s'
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'css': ['prettier'],
\}
" - }}}
" - behat {{{
let g:feature_filetype='behat'
" - }}}
" - php {{{
let php_folding=2
let php_phpdoc_folding=1
" - }}}
" - auto-pairs {{{
" Interferes with markdown checkboxes.
let g:AutoPairsMapSpace=0
" - }}}
" - netrw {{{
let g:netrw_liststyle=3
let g:netrw_banner=0
" - }}}
" - javascript {{{
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1
" - }}}
" - sort-imports {{{
let g:import_sort_auto = 1
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
set bg=light
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
" - - folding shortcuts {{{
nnoremap <Space> za
nnoremap <left> zc
nnoremap <right> zo
" - - }}}
" - - TAB to switch buffers {{{
nnoremap <tab> <c-^>
" - - }}}
" - - TAB in insert to autocomplete {{{
imap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" - - }}}
" - }}}
" - Plugins {{{
" - - Goyo {{{
nnoremap <leader><space> :Goyo<cr>
" - - }}}
" - - EasyAlign {{{
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" - - }}}
" - - fzf {{{
map <silent> <C-p> :FZF<cr>
map <silent> <C-t> :call LanguageClient_workspace_symbol()<cr>
map <silent> <C-r> :call LanguageClient_textDocument_documentSymbol()<cr>
map <silent> <C-f> :Ag<cr>
map <silent> <C-b> :Buffers<cr>
" - - }}}
" - - netrw {{{
nnoremap <silent> - :Ex<CR>
" - - }}}
" - - LanguageClient {{{
nnoremap <silent> gh :ALEHover<CR>
nnoremap <silent> <C-x> :call LanguageClient_contextMenu()<CR>
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
  autocmd FileType css,scss,less setlocal foldmethod=marker
  autocmd FileType css,scss,less setlocal foldmarker={,}
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
augroup end
" - }}}
" - javascript folding {{{
augroup javascript_folding
    autocmd!
    autocmd FileType javascript setlocal foldmethod=syntax
augroup END
" - }}}
" }}}

function! OpenTest ()
  if expand("%") =~ ".test."
    let l:altFilePath = substitute(expand("%"), ".test.", ".", "")
  else
    let l:altFilePath = expand("%:r") . ".test." . expand("%:e")
  endif
  execute "edit " . l:altFilePath
endfunction

nnoremap <silent> <leader>t :call OpenTest()<cr>
