" install vim-plug if it's missing
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

" https://github.com/numirias/security/blob/master/doc/2019-06-04_ace-vim-neovim.md
set nomodeline
" disable vi compatibility
set nocompatible
" number lines
set number
" relative number lines - allows for moving aroung with numbers
set relativenumber
" Tabs start
set tabstop=2
set softtabstop=2
set shiftwidth=2
" spaces instead of tabs
set expandtab
" searching small letters = ignore
set ignorecase
" searching non-small letters = all
set smartcase
" search globally by default
set gdefault
" incremental search
set incsearch
set showmatch
set hlsearch
" nvim only!
set inccommand=split
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
" consider '-' a part of keywords
set iskeyword+=-
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

" disallow backspace from deleting text that wasn't entered in the current
" "insert" session
set backspace=1

" allow "per project" vimrcs
set exrc
" don't load vimrcs not owned by me
set secure

" share register with system clipboard by default
set clipboard=unnamed

let g:clipboard = {
  \   'name': 'helic',
  \   'copy': {
  \      '+': 'hel yank --agent nvim',
  \      '*': 'hel yank --agent nvim',
  \    },
  \   'paste': {
  \      '+': 'xsel -bo --display :0',
  \      '*': 'xsel -bo --display :0',
  \   },
  \ }

" copy file and overwrite old one instead of renaming and writing a new one
" this is used because some tools (`spago`) get triggered twice with
" `backupcopy=no`
set backupcopy=yes

" agda indent
autocmd FileType agda setlocal tabstop=2 softtabstop=2 shiftwidth=2

" fuck the racket repl
autocmd FileType scheme setlocal makeprg=/usr/bin/racket\ %

autocmd FileType idris call SetIdrisIndent()

" clear trailing whitespace on save
autocmd BufWritePre ?* %s/\s\+$//e

autocmd FileType haskell call s:SetFormatOnSave()
autocmd FileType nix call s:SetFormatOnSave()
autocmd FileType go call s:SetFormatOnSave()

function! s:SetFormatOnSave()
  autocmd BufWritePre <buffer> call LanguageClient#textDocument_formatting_sync()
endfunction
" enable undo history saving
set undofile
" directory for undo files
set undodir=~/.vim/.undohistory/

" try to not autojump to next item when highlighting with *
nnoremap <silent> * :let @/= '\<' . expand('<cword>') . '\>' <bar> set hls <cr>

call plug#begin()
" rely on system fzf, so that we get it from nix, so it's not broken
" (most likely)
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" grep
Plug 'dyng/ctrlsf.vim'

" stuff inside vim
Plug 'terryma/vim-multiple-cursors'
Plug 'easymotion/vim-easymotion'

" git
Plug 'tpope/vim-fugitive'

" agda
Plug 'derekelkins/agda-vim'

" idris
Plug 'idris-hackers/idris-vim'

" gruvbox, but with modified haskell + purescript
" and possibly my own stuff (soon)
Plug 'googleson78/gruvbox'

" eye candy
Plug 'AndrewRadev/discotheque.vim'

" sql?
Plug 'tpope/vim-dadbod'

" edit tags
Plug 'AndrewRadev/id3.vim'

" purescript
Plug 'purescript-contrib/purescript-vim'

" haskell
Plug 'neovimhaskell/haskell-vim'

" dhall
Plug 'vmchale/dhall-vim'

" elm
Plug 'dtaskoff/elm-vim'

" md
" should have npm installed!
" we use this because the linker for the binary this downloads otherwise is
" hardcoded, which doesn't work with nix(os)
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install' }

" LSP
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'ayu-theme/ayu-vim'

" matching parens get same colour, different matches are different colours
Plug 'kien/rainbow_parentheses.vim'

" go to next haskell indentation level
Plug 'axelf4/vim-haskell'

" highlight hovered words
Plug 'dominikduda/vim_current_word'

" nix
Plug 'LnL7/vim-nix'

" indentation based block objects
Plug 'michaeljsmith/vim-indent-object'
call plug#end()

" try out nil for nix when it has formatting
"  \ 'haskell': ['nix-shell', '/home/googleson78/git/ghc.nix', '--pure', '--arg', 'withHadrianDeps', 'true', '--arg', 'withIde', 'true', '--run', 'haskell-language-server-wrapper --lsp'],
"
let g:LanguageClient_serverCommands = {
  \ 'haskell': ['haskell-language-server-wrapper', 'lsp'],
  \ 'elm': ['elm-language-server'],
  \ 'nix': ['nil'],
  \ }
let g:LanguageClient_selectionUI = "fzf"
let g:LanguageClient_rootMarkers = ['ghc.root']
let g:LanguageClient_settingsPath = "/home/googleson78/.vim/lc-settings/settings.json"

command! Cprev try | cprev | catch | clast | catch | endtry
command! Cnext try | cnext | catch | cfirst | catch | endtry

nmap <space>h :call LanguageClient#textDocument_definition()<cr>
nmap <space>j :call LanguageClient#textDocument_hover()<cr>
nmap <space>k :call LanguageClient#textDocument_codeAction()<cr>
nmap <space>l :call LanguageClient#handleCodeLensAction()<cr>
nmap <space>; :call LanguageClient#textDocument_references()<cr>
nmap <space>x :Cprev<cr>
nmap <space>c :Cnext<cr>

set signcolumn=no


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

nnoremap <space>w :Buffers<cr>
nnoremap <space>q :Files<cr>
nnoremap <space>o <Plug>CtrlSFCwordExec
vnoremap <space>o <Plug>CtrlSFVwordExec
" hs
nnoremap <space>t :CtrlSF -R '(data\|newtype\|type) <c-r><c-w>'<cr>
nnoremap <space>f :CtrlSF -R '<c-r><c-w>[ ]*::'<cr>


" idris settings

function SetIdrisIndent()
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
endfunction

" markdownpreview

" don't close window after switching buffers
let g:mkdp_auto_close = 0

" allow using MarkdownPreview from all files (not only md)
let g:mkdp_command_for_global = 1

" colorscheme
set termguicolors

" gruvbox stuff
set background=dark
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_contrast_light='medium'
colorscheme gruvbox

" enable rainbow parens on startup
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" don't highlight current word
let g:vim_current_word#highlight_current_word = 0

let g:LanguageClient_loggingLevel = 'INFO'
let g:LanguageClient_virtualTextPrefix = ''
let g:LanguageClient_loggingFile =  expand('~/.local/share/nvim/LanguageClient.log')
let g:LanguageClient_serverStderr = expand('~/.local/share/nvim/LanguageServer.log')
let g:LanguageClient_waitOutputTimeout = 6000
