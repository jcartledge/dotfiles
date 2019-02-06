" =======
" CONFIG:
" =======

set autoread
set clipboard+=unnamedplus
set cmdheight=2
set colorcolumn=101
set expandtab tabstop=2 shiftwidth=2
set foldlevelstart=99
set foldmethod=syntax
set hidden number relativenumber
set ignorecase smartcase
set inccommand=nosplit
set laststatus=0
set lbr formatoptions=l
set list listchars=tab:⇥\ ,trail:·
set mouse=a
set mousemodel=popup_setpos
set nobackup noswapfile
set scrolloff=2
set shortmess=atIc
set showmatch
set signcolumn=yes
set smartindent
set splitright
set undodir=~/.vimundo
set undofile
set updatetime=100
set whichwrap+=<,>,[,]

" CONFIG: nice folding
let g:vimsyn_folding='af'
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

" ========
" PLUGINS:
" ========

" PLUGINS: Install and initialise vim-plug
let $PLUGDOTVIM=fnamemodify($MYVIMRC, ':p:h') . '/autoload/plug.vim'
if empty(glob($PLUGDOTVIM))
  silent !curl -fLo $PLUGDOTVIM --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()

" PLUGINS: Language
Plug 'Shougo/context_filetype.vim'
Plug 'dzeban/vim-log-syntax'
Plug 'hail2u/vim-css3-syntax'
Plug 'ianks/vim-tsx'
Plug 'sheerun/vim-polyglot'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" PLUGINS: Integrations
Plug 'Shougo/neco-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'jcartledge/git-blame-nvim'

" PLUGINS: Interface
Plug '907th/vim-auto-save'
Plug 'airblade/vim-gitgutter'
Plug 'djoshea/vim-autoread'
Plug 'gcmt/wildfire.vim'
Plug 'gmarik/sudo-gui.vim'
Plug 'henrik/vim-indexed-search'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'jszakmeister/vim-togglecursor'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-slash'
Plug 'machakann/vim-highlightedyank'
Plug 'rhysd/conflict-marker.vim'
Plug 'tyru/caw.vim'
Plug 'vim-scripts/file-line'
Plug 'wellle/targets.vim'

" PLUGINS: Commands
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-git'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" PLUGINS: Non-oni
if !exists("g:gui_oni")
  Plug 'vim-airline/vim-airline'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'neoclide/coc-neco'
  Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
  Plug 'rakr/vim-one'
endif

call plug#end()

" PLUGINS: bundled in $VIMRUNTIME
runtime macros/matchit.vim

" ================
" PLUGIN SETTINGS:
" ================

" PLUGIN SETTINGS: airline
let g:airline#extensions#obsession#enabled=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_section_error='%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning='%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
let g:airline_theme='one'

" PLUGIN SETTINGS: auto-save
let g:auto_save=1
let g:auto_save_events = ["InsertLeave", "TextChanged", "FocusLost"]

" PLUGIN SETTINGS: caw
let g:caw_operator_keymappings=1

" PLUGIN SETTINGS: coc
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'

" PLUGIN SETTINGS: gitgutter
let g:gitgutter_sign_modified='±'
let g:gitgutter_sign_modified_removed='±'
let g:gitgutter_sign_removed='-'

" PLUGIN SETTINGS: netrw
let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_winsize=20

" PLUGIN SETTINGS: javascript
let g:javascript_plugin_jsdoc = 1

" PLUGIN SETTINGS: colours
if !exists("g:gui_oni")
  if (has("termguicolors"))
    set termguicolors
  endif
  let g:one_allow_italics = 1
  colorscheme one
  set background=light
  highlight CocErrorHighlight guibg=#FFDDDD
  highlight CocErrorSign guifg=#EE3333 guibg=#FFDDDD gui=italic
  highlight CocHighlightText guibg=#ECECEC gui=none
  highlight CocHintHighlight gui=underline
  highlight CocHintSign guifg=#66EE66 guibg=#DDFFDD gui=italic
  highlight CocInfoHighlight gui=underline
  highlight CocInfoSign guifg=#6666EE guibg=#DDDDFF gui=italic
  highlight CocWarningHighlight guifg=#EEEECC
  highlight CocWarningSign guifg=#EE9966 guibg=#FFDDCC gui=italic
  highlight Folded guifg=#AAAAAA guibg=#EEEEEE gui=none
  highlight Function gui=bold
  highlight IncSearch guifg=#333333 guibg=#AACCFF gui=none
  highlight Noise guifg=#BBBBBB gui=none
  highlight Search guifg=#333333 guibg=#AACCFF gui=none
  highlight String gui=bold
  highlight jsCommentTodo guifg=#EEEEEE guibg=#EE6666 gui=bold
  highlight jsDestructuringBlock gui=bold
  highlight jsDestructuringBraces guifg=#BBBBBB gui=none
  highlight jsFuncBraces guifg=#BBBBBB gui=none
  highlight jsFuncCall gui=bold
  highlight jsModuleKeyword gui=bold
  highlight jsNoise guifg=#BBBBBB gui=none
  highlight jsObjectBraces guifg=#BBBBBB gui=none
  highlight jsObjectKey gui=bold
  highlight jsParens guifg=#BBBBBB gui=none
  highlight jsVariableDef gui=bold
  highlight xmlAttrib gui=italic
  highlight xmlEndTag gui=bold
  highlight xmlTag gui=bold
  highlight xmlTagName gui=bold
endif

" =========
" MAPPINGS:
" =========

" MAPPINGS: Core
" --------------

" MAPPINGS: U = redo
nnoremap U <c-r>

" MAPPINGS: \ev = quickly edit the vimrc
nnoremap <silent> <leader>ev :edit $MYVIMRC<CR>

" MAPPINGS: <esc><esc> = clear search highlight and close preview, help, loclist and quickfix
nnoremap <silent> <esc><esc> :nohlsearch<cr>:helpclose<cr>:pclose<cr>:lclose<cr>:cclose<cr>

" MAPPINGS: TAB = switch buffers in normal mode
nnoremap <tab> <c-^>

" MAPPINGS: gt = switch between implementation and test
function! OpenTest ()
  if expand("%") =~ "\.test\."
    let l:altFilePath = substitute(expand("%"), ".test.", ".", "")
  else
    let l:altFilePath = expand("%:r") . ".test." . expand("%:e")
  endif
  execute "edit " . l:altFilePath
endfunction
nnoremap <silent> gt :call OpenTest()<cr>

" MAPPINGS: splits stuff
nnoremap <silent> <leader>\|<cr> :vsplit\<cr>
nnoremap <silent> <leader>\|t :vsplit\|call OpenTest()<cr>
nnoremap <silent> <leader>\|ga :vsplit\|terminal git add --patch<cr>

" MAPPINGS: F10 = show highlight group under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" ;; = insert semicolon at eol
inoremap ;; <c-o>A;

" MAPPINGS: <leader>t = run tests for current file
function! YarnTest()
  execute "below split|terminal yarn test \#:r"
endfunction
nnoremap <silent> <leader>t :call YarnTest()<cr>

" MAPPINGS: Plugins
" -----------------

" MAPPINGS: Coc
if !exists("g:gui_oni")
  " Remap for rename current word
  nmap <leader>rn <Plug>(coc-rename)
  " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
  vmap <leader>a <Plug>(coc-codeaction-selected)
  nmap <leader>a <Plug>(coc-codeaction-selected)
  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  " List
  nnoremap <silent> <c-c> :CocList --normal<cr>
  " Document symbols
  nnoremap <silent> <c-t> :CocList --normal outline<cr>
  " Snippets
  inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<TAB>"
  " Use K for show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>
  function! s:show_documentation()
      if &filetype == 'vim'
          execute 'h '.expand('<cword>')
      else
          call CocAction('doHover')
      endif
  endfunction
endif

" MAPPINGS: EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" MAPPINGS: fzf
if !exists("g:gui_oni")
  map <silent> <C-p> :FZF<cr>
  map <silent> <C-f> :Ag<cr>
  map <silent> <C-b> :Buffers<cr>
endif

" MAPPINGS: netrw
if !exists("g:gui_oni")
  nnoremap <silent> - :Lexplore %:h<CR>
endif

" =============
" AUTOCOMMANDS:
" =============

" AUTOCOMMANDS: cursorline
augroup cursorline
  autocmd!
  autocmd InsertEnter * setlocal cursorcolumn cursorline
  autocmd InsertLeave * setlocal nocursorline nocursorcolumn
augroup end

" AUTOCOMMANDS: coc
if !exists("g:gui_oni")
  augroup coc
    autocmd!
    " Close preview after completion.
    autocmd CompleteDone * silent! pclose
    " highlight current word
    autocmd CursorHold * silent call CocActionAsync('highlight')
  augroup end
endif

" AUTOCOMMANDS: netrw
if !exists("g:gui_oni")
  augroup netrw
    autocmd!
    autocmd FileType netrw silent nnoremap <buffer> <tab> :q<cr>
  augroup end
endif
