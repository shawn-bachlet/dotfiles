let mapleader = " "

let &t_ut=''

syntax on

filetype plugin indent on

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Give more space for displaying messages.
set cmdheight=2

" hide mode due to lightline
"set noshowmode

" highlight cursor position
set cursorline
set cursorcolumn

" Fix issue with yanking to clipboard
" https://stackoverflow.com/questions/3961859/how-to-copy-to-clipboard-in-vim
set clipboard=unnamed

set showmatch
set matchtime=3

set nocompatible

set number

set nowrap

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

" Display extra whitespace
set list listchars=tab:».,trail:.,nbsp:.

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" set spell spelllang=en_us

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Saving
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>wq :wq<CR>

" Run simformat
function! <SID>RunSimformat()
  if &filetype == "haskell"
    let l:pos=getpos(".")
    exe "%!simformat -e"
    call setpos(".", l:pos)
    write
  else
    write
  endif
endfunc

nnoremap <leader>sf :call <SID>RunSimformat()<cr>
" Delete whitespace

function! <SID>DeleteWhiteSpace()
  %s/\s\+$//
endfun
nnoremap <leader>wd :call <SID>DeleteWhiteSpace()<cr>

function! Write()
  if &filetype == "haskell"
    let l:pos=getpos(".")
    exe "%!simformat -e"
    call setpos(".", l:pos)
  endif
  call <SID>DeleteWhiteSpace()
  write
endfunc
map :w<cr> :call Write()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Install:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin()

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'sdiehl/vim-ormolu'

Plug 'morhetz/gruvbox'
Plug 'overcache/NeoSolarized'
Plug 'romgrk/doom-one.vim'
Plug 'NLKNguyen/papercolor-theme'

Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'knsh14/vim-github-link'
Plug 'neovimhaskell/haskell-vim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh'
    \ }
Plug 'LnL7/vim-nix'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Configuration:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" preservim/nerdtree
map <Leader>n :NERDTreeToggle<CR>

" junegunn/fzf.vim
map <Leader>f :Files<CR>
map <Leader>b :Buffers<CR>
map <Leader>h :History<CR>
map <Leader>/ :Rg<CR>
" map <Leader>sf :Ag (<Bslash>b)<C-r><C-w><Bslash>b[ <Bslash>t<Bslash>n]+::<CR>
" map <Leader>st :Rg (((data<Bar>newtype<Bar>type)\s+)<Bar>class .*)\b<C-r><C-w>\b<CR>

command! -bar -nargs=? -complete=buffer Buffers
  \ call fzf#vim#buffers(
  \   <q-args>,
  \   fzf#vim#with_preview({'options': ['--info=inline']}, 'down:60%'),
  \   0)

command! -nargs=? -complete=dir Files
  \ call fzf#vim#files(
  \   <q-args>,
  \   fzf#vim#with_preview({'options': ['--info=inline']}, 'down:60%'),
  \   0)

command! -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always -- '.shellescape(<q-args>),
  \   1,
  \   fzf#vim#with_preview({'options': ['--border', '--info=inline']}, 'down:60%'),
  \   0)

" Do conceals of wide stuff, like ::, forall, =>, etc.
let g:haskell_conceal_wide = 1
let g:haskell_conceal_bad = 1

let g:haskell_indent_if = 0
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1
let g:haskell_indent_where = 6
let g:haskell_indent_before_where = 2
let g:haskell_indent_after_bare_where = 2

let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

" Syntastic
"map <Leader>s :SyntasticToggleMode<CR>

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

"/sdiehl/vim-ormolu
let g:ormolu_disable=1
nnoremap <Leader>of :call RunOrmolu()<CR>

"/morhetz/gruvbox
" set background=dark " Setting light mode
" autocmd vimenter * ++nested colorscheme gruvbox
" let g:gruvbox_contrast_light='hard'

"neosolarized
"colorscheme NeoSolarized

"Doom One color theme
let g:doom_one_terminal_colors = v:true

"PaperColor theme
"set t_Co=256   " This is may or may not needed.
"set background=light
"colorscheme PaperColor

"knsh14/vim-github-link
noremap <Leader>gl :GetCommitLink<CR>

"/itchyny/lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \ },
      \ }

" Statusline
function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif

  return ''
endfunction

"nvim-lua/completion-nvim
autocmd BufEnter * lua require'completion'.on_attach()
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" Coc config
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-cursor)
nmap <leader>a  <Plug>(coc-codeaction-cursor)

" LanguageClient
set rtp+=~/.vim/pack/XXX/start/LanguageClient-neovim
let g:LanguageClient_serverCommands = { 'haskell': ['haskell-language-server-wrapper', '--lsp'] }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
map <Leader>lk :call LanguageClient#textDocument_hover()<CR>
map <Leader>lg :call LanguageClient#textDocument_definition()<CR>
map <Leader>lr :call LanguageClient#textDocument_rename()<CR>
map <Leader>lf :call LanguageClient#textDocument_formatting()<CR>
map <Leader>lb :call LanguageClient#textDocument_references()<CR>
map <Leader>la :call LanguageClient#textDocument_codeAction()<CR>
map <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>

" Groovy file syntax highlighting for Jenkinsfiles
au BufNewFile,BufRead *.jenkinsfile setf groovy
