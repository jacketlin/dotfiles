" set up pathogen, https://github.com/tpope/vim-pathogen
"
set nocompatible                                             " don't bother with vi compatibility
syntax enable                                                " enable syntax highlighting
let mapleader = ','

set autoindent
set autoread                                                 " reload files when changed on disk, i.e. via `git checkout`
set backspace=2                                              " Fix broken backspace in some setups
set backupcopy=yes                                           " see :help crontab
if $TMUX == ''
  set clipboard+=unnamed
endif
set cursorline                                               " highlight current line
set diffopt+=vertical                                        " prefer vertical split when diffing files
set directory-=.                                             " don't store swapfiles in the current directory
set encoding=utf-8
set expandtab                                                " expand tabs to spaces
set nohlsearch                                               " Don't highlight all search matches, which nvim does by default
set ignorecase                                               " case-insensitive search
set incsearch                                                " search as you type
set laststatus=2                                             " always show statusline
set list                                                     " show trailing whitespace
set listchars=tab:▸\ ,trail:▫
set nowrap
set number                                                   " show line numbers
set pastetoggle=<leader>p
set ruler                                                    " show where you are
set scrolloff=3                                              " show context above/below cursorline
set shell=/bin/bash
set shiftwidth=2                                             " normal mode indentation commands use 2 spaces
set showcmd
set showmatch                                                " jump to matching brackets on insertion
set smartcase                                                " case-sensitive search if any caps
set softtabstop=2                                            " insert mode tab and backspace use 2 spaces
set tabstop=8                                                " actual tabs occupy 8 characters
set tags=./tags;                                             " start with current file's directory for tags file search, then move up. See http://vim.wikia.com/wiki/Browsing_programs_with_tags
set timeoutlen=1000 ttimeoutlen=0                            " speed
set t_ti= t_te=                                              " Prevent Vim from clobbering the scrollback buffer. See http://www.shallowsky.com/linux/noaltscreen.html
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu                                                 " show a navigable menu for tab completion
set wildmode=longest,list,full

" Use the old vim regex engine (version 1, as opposed to version 2, which was
" introduced in Vim 7.3.969). The Ruby syntax highlighting is significantly
" slower with the new regex engine.
" via https://github.com/garybernhardt/dotfiles/commit/99b7d2537ad98dd7a9d3c82b8775f0de1718b356
set re=1

" Enable basic mouse behavior such as resizing buffers.
set mouse=a
if exists('$TMUX') && !has('nvim') " Support resizing in tmux
  set ttymouse=xterm2
endif

" plugin configuration
filetype on " without this vim emits a zero exit status, later, because of :ft off
filetype off
call plug#begin('~/.vim/plugged')

Plug 'kien/ctrlp.vim'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-fugitive'
Plug 'austintaylor/vim-indentobject'
Plug 'pangloss/vim-javascript'
Plug 'kchmck/vim-coffee-script'
Plug 'vim-ruby/vim-ruby'
Plug 'groenewege/vim-less'
Plug 'tpope/vim-surround'
Plug 'elixir-lang/vim-elixir'
Plug 'mileszs/ack.vim'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-vinegar'
Plug 'davidoc/taskpaper.vim'
Plug 'wting/rust.vim'
Plug 'jnwhiteh/vim-golang'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-markdown'
Plug 'mustache/vim-mustache-handlebars'
Plug 'mtth/scratch.vim'
Plug 'scrooloose/syntastic'
Plug 'mtscout6/syntastic-local-eslint.vim'
Plug 'neomake/neomake'
Plug 'benjie/neomake-local-eslint.vim'
Plug 'reedes/vim-colors-pencil'
Plug 'mxw/vim-jsx'
Plug 'trevordmiller/nova-vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'keith/swift.vim'
Plug 'jparise/vim-graphql'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'edkolev/tmuxline.vim'

call plug#end()
filetype plugin indent on

" keyboard shortcuts
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <leader>l :Align
nmap <leader>a :Ack<space>
nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>d :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>
nmap <leader>t :FZF<CR>
nmap <leader>T :CtrlPClearCache<CR>:CtrlP<CR>
nmap <leader>] :TagbarToggle<CR>
nmap <leader><space> :call whitespace#strip_trailing()<CR>
nmap <leader>g :GitGutterToggle<CR>
nmap <leader>c <Plug>Kwbd
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
map <leader>w :w!<cr>
inoremap jk <ESC>

" color setup
:set t_Co=256 " 256 colors
set background=dark
try
  colorscheme onehalfdark
catch /^Vim\%((\a\+)\)\=:E185/
  color aps256
endtry

" itchyny/lightline.vim configuration
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ }
let g:lightline.separator = {
  \   'left': '', 'right': ''
  \}
let g:lightline.subseparator = {
  \   'left': '', 'right': '' 
  \}

" Toggling cursor shape based on insert-mode versus normal-mode
" ---
" tmux and iTerm2 cursor fun
" via @andyfowler https://gist.github.com/1195581
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" plugin settings
let g:ctrlp_match_window = 'order:ttb,max:20'
let g:NERDSpaceDelims=1
let g:gitgutter_enabled = 0

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  let g:ackprg = 'ag --nogroup --column'

  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" fdoc is yaml
autocmd BufRead,BufNewFile *.fdoc set filetype=yaml
" md is markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =
" ruby files
autocmd BufNewFile,BufRead Gemfile set filetype=ruby
autocmd BufNewFile,BufRead Podfile set filetype=ruby
autocmd BufNewFile,BufRead *.ru set filetype=ruby
" gradle
autocmd BufNewFile,BufRead *.gradle setf groovy
" handlebars & erb
autocmd BufRead,BufNewFile *.{handlebars,handlebars.erb,hbs,hbs.erb} setl ft=html syntax=mustache

if filereadable(".vim.custom")
  so .vim.custom
endif

" Configure for a nicer prose writing environment
nnoremap <leader>P :call ProseToggle()<cr>
command! Prose :call ProseToggle()
let g:prose_is_toggled = 0
function! ProseToggle()
  if g:prose_is_toggled
    set nowrap
    nunmap j
    nunmap k
    let g:prose_is_toggled = 0
  else
    set wrap linebreak nolist
    noremap j gj
    noremap k gk
    let g:prose_is_toggled = 1
  endif
endfunction

" Send last yanked text to clipper – https://github.com/wincent/clipper
nnoremap <leader>y :call system('nc localhost 8377', @0)<CR>

" syntastic setup – https://github.com/scrooloose/syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
" Use eslint javascript checker if .eslintrc file is present – https://github.com/scrooloose/syntastic/issues/1484
let g:syntastic_javascript_checkers = []
autocmd FileType javascript let b:syntastic_checkers = syntastic#util#findFileInParent('.eslintrc', expand('%:p:h', 1)) !=# '' ? ['eslint'] : []

" For NeoVim, we'll use Neomake instead of syntastic
" See https://robots.thoughtbot.com/my-life-with-neovim#asynchronous-checkers
if has('nvim')
  " Run NeoMake on read and write operations
  autocmd! BufReadPost,BufWritePost * Neomake

  " Disable inherited syntastic
  let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": [],
    \ "passive_filetypes": []
  \}

  let g:neomake_serialize = 1
  let g:neomake_serialize_abort_on_error = 1
endif

"" spelling
" Good tips found here: https://robots.thoughtbot.com/opt-in-project-specific-vim-spell-checking-and-word-completion
"
" ## Commands
"
" - z= get spelling suggestions when cursor is placed over word
" - zg add misspelling to dictionary file
" - [s ]s navigate across misspellings
"
autocmd BufRead,BufNewFile *.md set filetype=markdown

" Spell-check Markdown files
autocmd FileType markdown setlocal spell

" Spell-check Git messages
autocmd FileType gitcommit setlocal spell

" jsx
let g:jsx_ext_required = 0

" Set spellfile to location that is guaranteed to exist,
" can be symlinked to Dropbox or kept in Git
" and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" fzf
" https://github.com/junegunn/fzf
set rtp+=/usr/local/opt/fzf

" nvALT replacement
" https://github.com/Alok/notational-fzf-vim
let g:nv_search_paths = ['~/Dropbox/Documents/notes']
let g:nv_use_short_pathnames = 1
nnoremap <leader>s :NV<CR>

" coc.vim configuration -- https://github.com/neoclide/coc.nvim
source ~/.vim/coc.vim
