" vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

Bundle 'Auto-Pairs'
Bundle 'HTML-AutoCloseTag'
Bundle 'IndexedSearch'
Bundle 'Raimondi/delimitMate'
Bundle 'YankRing.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'bingaman/vim-sparkup'
Bundle 'ciaranm/securemodelines'
Bundle 'claco/jasmine.vim'
Bundle 'digitaltoad/vim-jade'
Bundle 'empanda/vim-varnish'
Bundle 'ervandew/supertab'
Bundle 'file-line'
Bundle 'gmarik/sudo-gui.vim'
Bundle 'godlygeek/tabular'
Bundle 'groenewege/vim-less'
Bundle 'jcartledge/snipmate-snippets'
Bundle 'jcartledge/snipmate.vim'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'majutsushi/tagbar'
Bundle 'mileszs/ack.vim'
Bundle 'preview'
Bundle 'rodjek/vim-puppet'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'shemerey/vim-peepopen'
Bundle 'sherlock.vim'
Bundle 'skammer/vim-css-color'
Bundle 'sunaku/vim-ruby-minitest'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'vim-coffee-script'
Bundle 'wavded/vim-stylus'

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
set display=lastline
set shortmess=atI

" quickly edit/reload the vimrc file
nmap <silent> <leader>ev :tabedit $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" clear search highlight
nmap <leader><leader> :noh<CR><ESC>

" resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Insert cursor in CLI
" http://paste.stevelosh.com/4f83354246f98e0007000000?vim
 if exists('$TMUX')
   let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
   let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
 else
   let &t_SI = "\<Esc>]50;CursorShape=1\x7"
   let &t_EI = "\<Esc>]50;CursorShape=0\x7"
 endif

 " gui options
 if has("gui_running")
   set background=light
   set guioptions-=T  " remove toolbar
   set guioptions-=m  " remove menubar
   set guioptions+=c  " console dialogs not popups
   " mac-specific stuff
   if has("gui_macvim")
     set macmeta
     set guifont=Menlo\ Regular:h13
   endif
 endif

" colours
colorscheme solarized

" ctags: look for tags file in current directory, or recurse up
set tags=tags;/

" format xml on load
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

" save when focus lost
au FocusLost * silent! w

" get out of insert mode with motion keys
imap jj <Esc>j
imap kk <Esc>k
imap hhh <Esc>h
imap lll <Esc>l

" shift-arrow to navigate windows
nmap <S-Left>   <C-w>h
nmap <S-Right>  <C-w>l
nmap <S-Down>   <C-w>j
nmap <S-Up>     <C-w>k

" sensible tab navigation
nmap <C-Tab>    :tabn<CR>
nmap <C-S-Tab>  :tabN<CR>
imap <C-Tab>    <Esc>:tabn<CR>
imap <C-S-Tab>  <Esc>:tabN<CR>

" The following two options interfere with one another.
"
" To display tabs and trailing space use :set list
" for word wrapping use :set nolist
nmap <silent> <leader>w :set list!<cr>

" word wrapping
set lbr formatoptions=l

" highlight whitespace
set list listchars=tab:»·,trail:·

" tagbar
let g:tagbar_ctags_bin="/usr/local/bin/ctags" " brew ctags, not the default mac one
nmap <silent> <leader>T :TagbarToggle<CR>

" nerdtree
nmap <silent> <leader>f :NERDTreeToggle<CR>

" spellcheck
nmap <silent> <leader>s :setlocal invspell<CR>

" ack command
let g:ackprg="ack -H --nocolor --nogroup --column"

" syntastic setup
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_disabled_filetypes=['html']

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

" Load my snippets
let g:snippets_dir = '~/.vim/bundle/snipmate-snippets'
let g:snips_author = "jcartledge@gmail.com"

" Try to force snipmate and supertab to be nice
let g:SuperTabDefaultCompletionType = 'context'
" Give up and remap supertab
" let g:SuperTabMappingForward        = '<c-space>'
" let g:SuperTabMappingBackward       = '<s-c-space>'

" Autoclosetag
au FileType xhtml,xml so ~/.vim/bundle/HTML-AutoCloseTag/ftplugin/html_autoclosetag.vim

" Encryption
set cm=blowfish
