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
"close code preview after insert mode
let g:ycm_autoclose_preview_window_after_insertion = 1
"gotta fix ycm python compat. one day
let g:ycm_server_python_interpreter = '/usr/bin/python2.7'
"clear highlight
nnoremap <leader><space> :noh<cr>
"bind tab to %
nnoremap <tab> %
vnoremap <tab> %
"arrow keys are for losers and moving stuff around
nnoremap <up> ddkkp
nnoremap <down> ddp
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
"move displayed lines, not physical
nnoremap j gj
nnoremap k gk
"jk -> esc
inoremap jk <esc>
inoremap <esc> <nop>
nnoremap <esc> <nop>
"switch tabs
nnoremap <F7> :tabp <CR>
nnoremap <F8> :tabn <CR>
"scrolloff
set scrolloff=5
syntax enable
filetype off
filetype plugin indent on

"move between splits
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

call plug#begin()
Plug 'Valloric/YouCompleteMe'
Plug 'rdnetto/YCM-Generator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'flazz/vim-colorschemes'
Plug 'terryma/vim-multiple-cursors'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'tpope/vim-fugitive'
call plug#end()

"incsearch
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

"colorscheme
set background=dark
set termguicolors
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
