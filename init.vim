echo ">^.^<"
let mapleader = " "

syntax on

filetype plugin indent on

colorscheme desert

set cursorline
set cursorcolumn

set clipboard=unnamed

set nocompatible
set number
set nowrap
set showmode
set tw=80

set smartcase
set smarttab

set smartindent
set autoindent
set softtabstop=2
set shiftwidth=2

set expandtab
set incsearch
set mouse=a
set history=1000

set completeopt=menuone,menu,longest

set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
set wildmode=longest,list,full
set wildmenu
set completeopt+=longest

set t_Co=256

set cmdheight=1

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Run simformat
function! <SID>RunSimformat()
  let l = line('.')
  let c = col('.')
  %!simformat
  cal cursor(l, c)
endfun
nnoremap <leader>sf :call <SID>RunSimformat()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Install:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'sdiehl/vim-ormolu'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Configuration:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <Leader>n :NERDTreeToggle<CR>
map <Leader>f :Files<CR>
map <Leader>l :Lines<CR>
map <Leader>b :Buffers<CR>
map <Leader>h :History<CR>
map <Leader>/ :Rg<CR>

" Do conceals of wide stuff, like ::, forall, =>, etc.
let g:haskell_conceal_wide = 1
let g:haskell_conceal_bad = 1

let g:haskell_indent_if = 3
let g:haskell_indent_case = 5
let g:haskell_indent_let = 4
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1

syntax match hsNiceOperator "\<forall\>" display conceal cchar=∀
syntax match hsNiceOperator "`elem`" conceal cchar=∈
syntax match hsNiceOperator "`notElem`" conceal cchar=∉

syntax match hsStructure
  \ "()"
  \ display conceal cchar=∅

syntax match hsStructure
  \ '\s=>\s'ms=s+1,me=e-1
  \ display conceal cchar=⇒

syntax match hsOperator
  \ '\s\~>\s'ms=s+1,me=e-1
  \ display conceal cchar=⇝

syntax match hsOperator
  \ '\s>>>\s'ms=s+1,me=e-1
  \ display conceal cchar=↠

syntax match hsOperator
  \ '\s<<<\s'ms=s+1,me=e-1
  \ display conceal cchar=↞

syntax match hsStructure
  \ '\s-<\s'ms=s+1,me=e-1
  \ display conceal cchar=↢

syntax match hsStructure
  \ '\s>-\s'ms=s+1,me=e-1
  \ display conceal cchar=↣

syntax match hsStructure
  \ '\s-<<\s'ms=s+1,me=e-1
  \ display conceal cchar=⇺

syntax match hsNiceOperator "\<not\>" conceal cchar=¬

let g:multi_cursor_select_all_word_key = '<C-a>'

"/sdiehl/vim-ormolu
let g:ormolu_disable=1
nnoremap <Leader>of :call RunOrmolu()<CR>

"/morhetz/gruvbox
autocmd vimenter * ++nested colorscheme gruvbox
