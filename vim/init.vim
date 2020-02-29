"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use vim-plug as plugins manager
call plug#begin()

" Start page
Plug 'mhinz/vim-startify'

" Directory tree
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'

" Icons
Plug 'ryanoasis/vim-devicons'

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'enricobacis/vim-airline-clock'

" Opearte words surrouding
Plug 'tpope/vim-surround'

" Display indent line
Plug 'Yggdroot/indentLine'

" Fuzzy query
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Search and replace
Plug 'brooth/far.vim'

" Show tag
Plug 'majutsushi/tagbar'

" Highlight what you are interested in
Plug 'lfv89/vim-interestingwords'

" Underline the word at the cursor position
Plug 'itchyny/vim-cursorword'

" Jump anywhere you want
Plug 'easymotion/vim-easymotion'

" Go development plugin
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Python development plugin
Plug 'davidhalter/jedi-vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'

" Asynchronous linting
Plug 'neomake/neomake'

" Code format
Plug 'sbdchd/neoformat'
Plug 'Chiel92/vim-autoformat'

" Code commentary
Plug 'tpope/vim-commentary'

" Show who writed the code in status line
Plug 'zivyangll/git-blame.vim'

" Display code git status
Plug 'airblade/vim-gitgutter'

" Heavy git tool
Plug 'tpope/vim-fugitive'

" Auto complete pairs
Plug 'Raimondi/delimitMate'

" Use tab to complete
Plug 'ervandew/supertab'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASE SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Jump where exited last time
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Change leader key
let mapleader=","

" Disable compatible old vi
set nocompatible

" Show number line
set number

" Enable auto indent
set expandtab
set autoindent
set cindent
set tabstop=4
set shiftwidth=4
filetype indent on

" avoid `[200~` paste error
set t_BE=

" Enable syntax highlight
syntax on

" Highlight search result
set hlsearch

" Ignore case
set ignorecase

" Disable auto backup
set nobackup

" Disable generate swap file
set noswapfile

" Enable auto refresh current file when modified elsewhere
set autoread
au CursorHold,CursorHoldI * checktime

" Enable auto save when quit unexpertedly
set autowrite

" Prompt when quit without save
set confirm

" Display cursor line
set cursorline

" Enable window modify
set modifiable

set clipboard+=unnamedplus

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Airline theme
let g:airline_theme='onedark'
" Enable powerline fonts
let g:airline_powerline_fonts=1
" Enable buffer top tabline
let g:airline#extensions#tabline#enabled=1
" Set time display format
let g:airline#extensions#clock#format = '%H:%M:%S'

" Easy-motion
nmap ss <Plug>(easymotion-s2)

" Indent line
autocmd Filetype json let g:indentLine_setConceal = 0
let g:vim_json_syntax_conceal = 0
let g:indentLine_color_term = 239
let g:indentLine_char = '¦'

" Open git-blame plugin, to avoid other plugin cover
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>

" python syntax
let g:deoplete#enable_at_startup = 1
let g:jedi#completions_enabled = 0
let g:python_highlight_all = 1
let g:jedi#goto_command = "<C-]>"
let g:python3_host_prog = '/usr/bin/python'

" Enable vim-go autocomplete import on saving
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
autocmd BufWritePre *.go :GoImports
" autocmd BufWritePre *.go :GoMetaLinter

" Rust autosave
let g:rustfmt_autosave = 1

" Set gitgutter update time 100ms
set updatetime=100

" Enable alignment
let g:neoformat_basic_format_align = 1

" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

augroup fmt
    autocmd!
    autocmd BufWritePre * undojoin | Neoformat
augroup END

call neomake#configure#automake('nrwi', 500)
let g:neomake_python_flake8_maker = {
            \ 'args': ['--ignore=E221,E241,E272,E251,W702,E203,E201,E202',  '--format=default'],
            \ 'errorformat':
            \ '%E%f:%l: could not compile,%-Z%p^,' .
            \ '%A%f:%l:%c: %t%n %m,' .
            \ '%A%f:%l: %t%n %m,' .
            \ '%-G%.%#',
            \ }
let g:neomake_python_enabled_makers = ['flake8']


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SHORTCUT KEY SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Change save key
inoremap <leader>w <Esc>:w<cr>

" Change esc key
inoremap jj <Esc>

" Use ctrl + h/j/k/l switch window
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" NERDTree
nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader>g :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" Tagbar
nnoremap <leader>t :TagbarToggle<CR>
