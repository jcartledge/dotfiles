" Basic editor config
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

" nice folding
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

" Plugins
" Install and initialise vim-plug
let $PLUGDOTVIM=fnamemodify($MYVIMRC, ':p:h') . '/autoload/plug.vim'
if empty(glob($PLUGDOTVIM))
  silent !curl -fLo $PLUGDOTVIM --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
" Language
Plug 'Shougo/context_filetype.vim'
Plug 'dzeban/vim-log-syntax'
Plug 'hail2u/vim-css3-syntax'
Plug 'sheerun/vim-polyglot'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
" Integrations
Plug 'Shougo/neco-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'lambdalisue/gina.vim'
" Interface
Plug '907th/vim-auto-save'
Plug 'airblade/vim-gitgutter'
Plug 'djoshea/vim-autoread'
Plug 'gcmt/wildfire.vim'
Plug 'gmarik/sudo-gui.vim'
Plug 'henrik/vim-indexed-search'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'jszakmeister/vim-togglecursor'
Plug 'junegunn/vim-peekaboo'
Plug 'machakann/vim-highlightedyank'
Plug 'mtth/scratch.vim'
Plug 'rhysd/conflict-marker.vim'
Plug 'tyru/caw.vim'
Plug 'vim-scripts/file-line'
Plug 'wellle/targets.vim'
" Commands
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-git'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
" Non-oni
if !exists("g:gui_oni")
  Plug 'tmsvg/pear-tree'
  Plug 'vim-airline/vim-airline'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'neoclide/coc-neco'
  Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
  Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
  Plug 'rakr/vim-one'
endif

call plug#end()

" Plugins bundled in $VIMRUNTIME
runtime macros/matchit.vim

" Plugin settings
" airline
let g:airline#extensions#disable_rtp_load=1
let g:airline#extensions#obsession#enabled=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_extensions=['branch', 'hunks', 'coc', 'tabline']
let g:airline_section_error='%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning='%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
let g:airline_theme='one'
" auto-save
let g:auto_save=1
let g:auto_save_events = ["InsertLeave", "TextChanged", "FocusLost"]
" caw
let g:caw_operator_keymappings=1
" coc
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'
" gitgutter
let g:gitgutter_sign_modified='±'
let g:gitgutter_sign_modified_removed='±'
let g:gitgutter_sign_removed='-'
" netrw
let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_winsize=20
" javascript
let g:javascript_plugin_jsdoc = 1

" Colours
if !exists("g:gui_oni")
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
  call one#highlight('jsModuleKeyword', '', '', 'bold')
  call one#highlight('jsVariableDef', '', '', 'bold')
  call one#highlight('jsObjectKey', '', '', 'bold')
  call one#highlight('jsFuncCall', '', '', 'bold')
  call one#highlight('jsDestructuringBlock', '', '', 'bold')
  call one#highlight('jsNoise', 'BBBBBB', '', 'none')
  call one#highlight('jsCommentTodo', 'EEEEEE', 'EE6666', 'bold')
  call one#highlight('xmlTag', '', '', 'bold')
  call one#highlight('xmlEndTag', '', '', 'bold')
  call one#highlight('xmlTagName', '', '', 'bold')
  call one#highlight('xmlAttrib', '', '', 'italic')
  call one#highlight('String', '', '', 'bold')
  call one#highlight('Function', '', '', 'bold')
  call one#highlight('Noise', 'BBBBBB', '', 'none')
  call one#highlight('Search', '333333', 'AACCFF', 'none')
  call one#highlight('IncSearch', '333333', 'AACCFF', 'none')
  call one#highlight('CocHighlightText', '', 'ECECEC', 'none')
  call one#highlight('CocErrorSign', 'EE6666', '', 'bold')
  call one#highlight('CocErrorHighlight', '', 'EECCCC', '')
  call one#highlight('CocWarningSign', 'EE9966', '', 'bold')
  call one#highlight('CocWarningHighlight', 'EEEECC', '', '')
  call one#highlight('CocInfoSign', '6666EE', '', 'bold')
  call one#highlight('CocInfoHighlight', '', '', 'underline')
  call one#highlight('CocHintSign', '66EE66', '', 'bold')
  call one#highlight('CocHintHighlight', '', '', 'underline')
endif

" Mappings
" Core
" U: redo
nnoremap U <c-r>
" \ev: quickly edit the vimrc
nnoremap <silent> <leader>ev :edit $MYVIMRC<CR>
" <esc><esc>: clear search highlight and close preview, help, loclist and quickfix
nnoremap <silent> <esc><esc> :nohlsearch<cr>:helpclose<cr>:pclose<cr>:lclose<cr>:cclose<cr>
" TAB: switch buffers in normal mode
nnoremap <tab> <c-^>
" TAB: autocomplete in insert mode
" imap <expr><tab> pumvisible() ? "\<cr>" : "\<tab>"
" gt: switch between implementation and test
function! OpenTest ()
  if expand("%") =~ "\.test\."
    let l:altFilePath = substitute(expand("%"), ".test.", ".", "")
  else
    let l:altFilePath = expand("%:r") . ".test." . expand("%:e")
  endif
  execute "edit " . l:altFilePath
endfunction
nnoremap <silent> gt :call OpenTest()<cr>
" gb: git blame for the current line
nnoremap <silent> gb :execute "!git blame -L" . line(".").",".line(".") . " " . expand("%")<cr>
" F10: show highlight group under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" ;;: insert semicolon at eol
inoremap ;; <c-o>A;
" <leader>t: run tests for current file
function! YarnTest()
  execute "below split|terminal yarn test \#:r"
endfunction
nnoremap <silent> <leader>t :call YarnTest()<cr>
" Plugins
" Coc
if !exists("g:gui_oni")
  " Remap for rename current word
  nmap <leader>rn <Plug>(coc-rename)
  " Remap for format selected region
  vmap <leader>f <Plug>(coc-format-selected)
  nmap <leader>f <Plug>(coc-format-selected)
  " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
  vmap <leader>a <Plug>(coc-codeaction-selected)
  nmap <leader>a <Plug>(coc-codeaction-selected)
  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
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
" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" fzf
if !exists("g:gui_oni")
  map <silent> <C-p> :FZF<cr>
  map <silent> <C-f> :Ag<cr>
  map <silent> <C-b> :Buffers<cr>
endif
" netrw
if !exists("g:gui_oni")
  nnoremap <silent> - :Lexplore %:h<CR>
endif
" pear-tree
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

" Autocommands
augroup cursorline
  autocmd! InsertEnter * setlocal cursorcolumn cursorline
  autocmd! InsertLeave * setlocal nocursorline nocursorcolumn
augroup end
" coc
if !exists("g:gui_oni")
  augroup coc
    autocmd!
    " Close preview after completion.
    autocmd CompleteDone * silent! pclose
    " highlight current word
    autocmd CursorHold * silent call CocActionAsync('highlight')
  augroup end
endif
" netrw
if !exists("g:gui_oni")
  augroup netrw
    autocmd!
    autocmd FileType netrw silent nnoremap <buffer> <tab> :q<cr>
  augroup end
endif
