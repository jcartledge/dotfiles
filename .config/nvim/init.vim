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
set foldlevelstart=99
" - nice folding {{{
set fillchars=fold:\ 
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
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax
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
Plug 'hail2u/vim-css3-syntax'
Plug 'sheerun/vim-polyglot'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
" - }}}
" - Code display {{{
Plug 'Konfekt/FastFold'
" - }}}
" - Integrations {{{
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'lambdalisue/gina.vim'
Plug 'mileszs/ack.vim'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
" - }}}
" - Interface {{{
Plug '907th/vim-auto-save'
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
Plug 'tyru/caw.vim'
Plug 'vim-airline/vim-airline'
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
Plug 'rakr/vim-one'
" - }}}

call plug#end()

" - Plugins bundled in $VIMRUNTIME {{{
runtime macros/matchit.vim
" - }}}
" }}}

" Plugin settings {{{
" - ack {{{
let g:ackprg = "ag --vimgrep"
let g:ackhighlight = 1
let g:ack_autofold_results = 1
let g:ackpreview = 1
let g:ack_qhandler = "botright copen 20"
" - }}}
" - airline {{{
let g:airline_theme='one'
let g:airline#extensions#disable_rtp_load = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_extensions = ['branch', 'hunks', 'coc', 'tabline']
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
" - }}}
" - auto-save {{{
let g:auto_save=1
let g:auto_save_events = ["InsertLeave", "TextChanged", "FocusLost"]
" - }}}
" - caw {{{
let g:caw_operator_keymappings=1
" - }}}
" - coc {{{
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" - }}}
" - gitgutter {{{
set signcolumn=yes
let g:gitgutter_sign_modified='±'
let g:gitgutter_sign_modified_removed='±'
let g:gitgutter_sign_removed='-'
" - }}}
" - netrw {{{
let g:netrw_liststyle=3
let g:netrw_banner=0
" - }}}
" - javascript {{{
let g:javascript_plugin_jsdoc = 1
" - }}}
" }}}

" Colours {{{
if (has("termguicolors"))
  set termguicolors
endif
let g:one_allow_italics = 1
colorscheme one
set background=light
call one#highlight('Folded', 'AAAAAA', 'EEEEEE', 'none')
call one#highlight('jsParens', 'BBBBBB', '', 'none')
call one#highlight('jsFuncBraces', 'BBBBBB', '', 'none')
call one#highlight('jsObjectBraces', 'BBBBBB', '', 'none')
call one#highlight('jsDestructuringBraces', 'BBBBBB', '', 'none')
call one#highlight('jsNoise', 'BBBBBB', '', 'none')
call one#highlight('Noise', 'BBBBBB', '', 'none')
call one#highlight('Search', '333333', 'AACCFF', 'none')
call one#highlight('IncSearch', '333333', 'AACCFF', 'none')
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
" - - TAB to switch buffers {{{
nnoremap <tab> <c-^>
" - - }}}
" - - TAB in insert to autocomplete {{{
imap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" - - }}}
" - }}}
" - Plugins {{{
" - - Coc {{{
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" Remap for format selected region
vmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)
" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)
" - - }}}
" - - Goyo {{{
nnoremap <leader><space> :Goyo<cr>
" - - }}}
" - - EasyAlign {{{
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" - - }}}
" - - fzf {{{
map <silent> <C-p> :FZF<cr>
map <silent> <C-f> :Ag<cr>
map <silent> <C-b> :Buffers<cr>
" - - }}}
" - - netrw {{{
nnoremap <silent> - :Ex<CR>
" - - }}}
" - }}}
" }}}

" Autocommands {{{
" - vimrc {{{
augroup vimrc
  autocmd!
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

" `gt` to switch between implementation and test.
function! OpenTest ()
  if expand("%") =~ "\.test\."
    let l:altFilePath = substitute(expand("%"), ".test.", ".", "")
  else
    let l:altFilePath = expand("%:r") . ".test." . expand("%:e")
  endif
  execute "edit " . l:altFilePath
endfunction
nnoremap <silent> gt :call OpenTest()<cr>

" `gb` to git blame for the current line.
nnoremap <silent> gb :execute "!git blame -L" . line(".").",".line(".") . " " . expand("%")<cr>

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
