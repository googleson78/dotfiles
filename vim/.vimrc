" vi compatibility 
set nocompatible
" number lines
set number
"relative number lines - allows for moving aroung with numbers
set relativenumber
"st fix maybe?
" Tabs start
set tabstop=4
set softtabstop=4
set shiftwidth=4
"spaces instead of tabs
set expandtab
"searching small letters = ignore
set ignorecase
"searching non-small letters = all
set smartcase
"search globally by default
set gdefault
"don't think I need this anymore
set incsearch
set showmatch
set hlsearch
"leader
let mapleader=";"
let maplocalleader="'"
"clear highlight
nnoremap <leader><space> :noh<cr>
"bind tab to %
nnoremap <tab> %
vnoremap <tab> %
"move displayed lines, not physical
nnoremap j gj
nnoremap k gk
"jk -> esc
inoremap jk <esc>
"inoremap <esc> <nop>

"allow . t work in visual block mode for multiple lines
"vnoremap . :normal .<CR>
"switch tabs
nnoremap <F7> :tabp <CR>
nnoremap <F8> :tabn <CR>
"scrolloff
set scrolloff=5
syntax enable

"detect filetypes
filetype on
"load plugins for corresponding filetypes
filetype indent on
"load indents for corresponding filetypes
filetype plugin on

"move between splits
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

"open splits below and to the right ofj
set splitbelow
set splitright

call plug#begin()
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'flazz/vim-colorschemes'
Plug 'terryma/vim-multiple-cursors'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'tpope/vim-fugitive'
Plug 'derekelkins/agda-vim'
call plug#end()

"incsearch
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

"colorscheme
set background=dark
set termguicolors
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='hard'
colorscheme gruvbox
