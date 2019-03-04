" disable vi compatibility
set nocompatible
" number lines
set number
" relative number lines - allows for moving aroung with numbers
set relativenumber
" Tabs start
set tabstop=4
set softtabstop=4
set shiftwidth=4
" spaces instead of tabs
set expandtab
" searching small letters = ignore
set ignorecase
" searching non-small letters = all
set smartcase
" search globally by default
set gdefault
" don't think I need this anymore
set incsearch
set showmatch
set hlsearch
" leader
let mapleader=";"
let maplocalleader="`"
" run make and open the quickfix buffer
nnoremap <leader>e :make<cr>:copen<cr><cr>
nnoremap <leader>r :cclose<cr>
" clear highlight
nnoremap <leader><space> :noh<cr>
" bind tab to %
nnoremap <tab> %
vnoremap <tab> %
" move displayed lines, not physical
nnoremap j gj
nnoremap k gk
" jk -> esc
inoremap jk <esc>

" switch tabs
nnoremap <F7> :tabp <CR>
nnoremap <F8> :tabn <CR>
" scrolloff
set scrolloff=5
syntax enable

" detect filetypes
filetype on
" load plugins for corresponding filetypes
filetype indent on
" load indents for corresponding filetypes
filetype plugin on

" move between splits
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" open splits below and to the right of
set splitbelow
set splitright

" auto save and restore folds
set viewoptions-=options

" disable these for now becaus they mess with my quickfix
"autocmd BufWinLeave ?* mkview
"autocmd BufWinEnter ?* silent loadview

set backspace=1

" fuck the racket repl
autocmd FileType scheme setlocal makeprg=/usr/bin/racket\ %

autocmd FileType idris call SetIdrisIndent()

" clear trailing whitespace on save
autocmd BufWritePost ?* %s/\s\+$//e

call plug#begin()
" fuzzy searching different stuff
" files mostly
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" grep
Plug 'dyng/ctrlsf.vim'

" stuff inside vim
Plug 'terryma/vim-multiple-cursors'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'

" smarter numberlines
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" git
Plug 'tpope/vim-fugitive'

" agda
Plug 'derekelkins/agda-vim'

" idris
Plug 'idris-hackers/idris-vim'

" rice
Plug 'flazz/vim-colorschemes'

" eye candy
Plug 'AndrewRadev/discotheque.vim'
call plug#end()

" incsearch
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)


" ctrlsf settings
" focus on the ctrlsf window when it's done
" TODO doesn't work with longer search? TODO
let g:ctrlsf_auto_focus = {
    \ "at" : "done"
    \ }

" search from project root by default (finds .git)
" currently trying out current dir, just open vim in project root
let g:ctrlsf_default_root = 'cwd'

" use compact mode by default
let g:ctrlsf_default_view_mode = 'compact'

" maps to not conflict with my binds
let g:ctrlsf_mapping = {
    \ "open"    : ["<CR>", "o"],
    \ "openb"   : "O",
    \ "split"   : "<C-x>",
    \ "vsplit"  : "<C-v>",
    \ "tab"     : "<C-t>",
    \ "tabb"    : "T",
    \ "popen"   : "p",
    \ "popenf"  : "P",
    \ "quit"    : "q",
    \ "next"    : "n",
    \ "prev"    : "N",
    \ "pquit"   : "q",
    \ "loclist" : "",
    \ "chgmode" : "M",
    \ "stop"    : "<C-C>",
    \ }

" open window on the right
let g:ctrlsf_position = 'right'

nmap <space>w :Buffers<cr>
nmap <space>q :Files<cr>
nmap <space>o <Plug>CtrlSFCwordExec
vmap <space>o <Plug>CtrlSFVwordExec

" idris settings

function SetIdrisIndent()
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
endfunction

" colorscheme
"set termguicolors
"colorscheme af

" gruvbox stuff
set background=dark
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='hard'
colorscheme gruvbox
