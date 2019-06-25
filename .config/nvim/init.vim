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
set pumblend=20
set scrolloff=2
set shortmess=atIc
set showmatch
set signcolumn=auto:2
set smartindent
set splitright
set undodir=~/.vimundo
set undofile
set updatetime=100
set wildoptions=pum
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

" PLUGINS: Install vim-packager
let $PACKAGERDOTVIM=fnamemodify($MYVIMRC, ':p:h') . '/pack/packager/opt/vim-packager'
if empty(glob($PACKAGERDOTVIM))
  silent !git clone https://github.com/kristijanhusak/vim-packager $PACKAGERDOTVIM
  autocmd VimEnter * PackagerInstall
endif

function! PackagerInit() abort
  packadd vim-packager
  call packager#init()
  call packager#add('kristijanhusak/vim-packager', { 'type': 'opt' })

  " PLUGINS: Language
  call packager#add('Shougo/context_filetype.vim')
  call packager#add('dzeban/vim-log-syntax')
  call packager#add('hail2u/vim-css3-syntax')
  call packager#add('ianks/vim-tsx')
  call packager#add('sheerun/vim-polyglot')
  call packager#add('styled-components/vim-styled-components', { 'branch': 'main' })

  " PLUGINS: Integrations
  call packager#add('Shougo/neco-vim')
  call packager#add('christoomey/vim-tmux-navigator')
  call packager#add('editorconfig/editorconfig-vim')
  call packager#add('jcartledge/git-blame-nvim')
  call packager#add('neoclide/coc-neco')
  call packager#add('neoclide/coc.nvim', {'branch': 'release'})
  call packager#add('prettier/vim-prettier')
  call packager#add('tpope/vim-fugitive')

  " PLUGINS: COC extensions
  call packager#add('andys8/vscode-jest-snippets', {'do': 'yarn install --frozen-lockfile'})
  call packager#add('iamcco/coc-vimlsp', {'do': 'yarn install --frozen-lockfile'})
  call packager#add('neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'})
  call packager#add('neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'})
  call packager#add('neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'})
  call packager#add('neoclide/coc-jest', {'do': 'yarn install --frozen-lockfile'})
  call packager#add('neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'})
  call packager#add('neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'})
  call packager#add('neoclide/coc-pairs', {'do': 'yarn install --frozen-lockfile'})
  call packager#add('neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'})
  call packager#add('neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'})
  call packager#add('neoclide/coc-stylelint', {'do': 'yarn install --frozen-lockfile'})
  call packager#add('neoclide/coc-tslint', {'do': 'yarn install --frozen-lockfile'})
  call packager#add('neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'})
  call packager#add('neoclide/coc-yank', {'do': 'yarn install --frozen-lockfile'})

  " PLUGINS: Interface
  call packager#add('907th/vim-auto-save')
  call packager#add('TaDaa/vimade')
  call packager#add('airblade/vim-gitgutter')
  call packager#add('djoshea/vim-autoread')
  call packager#add('gcmt/wildfire.vim')
  call packager#add('gmarik/sudo-gui.vim')
  call packager#add('henrik/vim-indexed-search')
  call packager#add('jeffkreeftmeijer/vim-numbertoggle')
  call packager#add('jszakmeister/vim-togglecursor')
  call packager#add('junegunn/vim-peekaboo')
  call packager#add('junegunn/vim-slash')
  call packager#add('rakr/vim-one')
  call packager#add('rhysd/conflict-marker.vim')
  call packager#add('tyru/caw.vim')
  call packager#add('vim-airline/vim-airline')
  call packager#add('vim-scripts/file-line')
  call packager#add('wellle/targets.vim')

  " PLUGINS: Commands
  call packager#add('tpope/vim-abolish')
  call packager#add('tpope/vim-eunuch')
  call packager#add('tpope/vim-obsession')
  call packager#add('tpope/vim-git')
  call packager#add('tpope/vim-repeat')
  call packager#add('tpope/vim-surround')
  call packager#add('tpope/vim-unimpaired')
endfunction

command! PackagerInstall call PackagerInit() | call packager#install()
command! -bang PackagerUpdate call PackagerInit() | call packager#update({ 'force_hooks': '<bang>' })
command! PackagerClean call PackagerInit() | call packager#clean()
command! PackagerStatus call PackagerInit() | call packager#status()

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
" powerline symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''

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
if (has("termguicolors"))
  set termguicolors
endif
let g:one_allow_italics = 1
set background=light
colorscheme one
highlight CocErrorHighlight guibg=#FFDDDD gui=none
highlight CocHighlightText guibg=#ECECEC gui=none
highlight CocHintHighlight gui=underline
highlight CocInfoHighlight gui=underline
highlight CocWarningHighlight gui=underline
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

" MAPPINGS: ;; = insert semicolon at eol, same for ,, and ::
inoremap ;; <c-o>A;
inoremap ,, <c-o>A,

" MAPPINGS: insert ooo = new line below, OOO = new line above
inoremap ooo <c-o>o
inoremap OOO <c-o>O

" MAPPINGS: <leader>t = run tests for current file
function! YarnTest()
  execute "below split|terminal yarn test \#:r"
endfunction
nnoremap <silent> <leader>t :call YarnTest()<cr>

" MAPPINGS: Plugins
" -----------------

" MAPPINGS: Coc
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
" :(
nnoremap <silent> <leader>c :CocRestart<cr>

" lists
map <silent> <C-p> :exe 'CocList files'<cr>
map <silent> <C-f> :exe 'CocList grep'<cr>
map <silent> <C-b> :exe 'CocList buffers'<cr>
map <silent> <C-e> :exe 'CocList locationlist'<cr>
map <silent> <C-y> :exe 'CocList yank'<cr>

" MAPPINGS: EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" MAPPINGS: netrw
nnoremap <silent> - :Lexplore %:h<CR>

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
augroup coc
  autocmd!
  " Close preview after completion.
  autocmd CompleteDone * silent! pclose
  " highlight current word
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup end

" AUTOCOMMANDS: netrw
augroup netrw
  autocmd!
  autocmd FileType netrw silent nnoremap <buffer> <tab> :q<cr>
augroup end
