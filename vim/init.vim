"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use vim-plug as plugins manager
call plug#begin()

" Start page
Plug 'mhinz/vim-startify'

" Directory tree
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kristijanhusak/defx-icons'
Plug 'kristijanhusak/defx-git'

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

" C/C++
Plug 'zchee/deoplete-clang'
Plug 'jsfaint/gen_tags.vim'

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
let mapleader=';'
let maplocalleader=';'

" Disable compatible old vi
set nocompatible

" Show number line
set number

" Enable auto indent
set autoindent
set cindent
set tabstop=4
set shiftwidth=4
filetype indent on

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Defx
nnoremap <silent> <LocalLeader>e
			\ :<C-u>Defx -resume -toggle -buffer-name=tab`tabpagenr()`<CR>
nnoremap <silent> <LocalLeader>a
			\ :<C-u>Defx -resume -buffer-name=tab`tabpagenr()` -search=`expand('%:p')`<CR>

call defx#custom#option('_', {
			\ 'winwidth': 28,
			\ 'split': 'vertical',
			\ 'direction': 'topleft',
			\ 'show_ignored_files': 0,
			\ 'buffer_name': 'defxplorer',
			\ 'toggle': 1,
			\ 'columns': 'indent:git:icons:filename',
			\ 'resume': 1,
			\ 'ignored_files':
			\     '.mypy_cache,.pytest_cache,.git,.hg,.svn,.stversions,.idea,.vscode'
			\   . ',__pycache__,.sass-cache,*.egg-info,.DS_Store,*.pyc,*.swp'
			\ })

autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
	nnoremap <silent><buffer><expr> <CR> defx#do_action('multi', ['drop'])
	nnoremap <silent><buffer><expr> q defx#do_action('quit')
	nnoremap <silent><buffer><expr> o defx#do_action('open_tree')
	nnoremap <silent><buffer><expr> O defx#do_action('open_tree_recursive')
	nnoremap <silent><buffer><expr> x defx#do_action('close_tree')
	nnoremap <silent><buffer><expr> d defx#do_action('remove')
	nnoremap <silent><buffer><expr> r defx#do_action('rename')
	nnoremap <silent><buffer><expr> R defx#do_action('redraw')
	nnoremap <silent><buffer><expr> c defx#do_action('copy')
	nnoremap <silent><buffer><expr> m defx#do_action('move')
	nnoremap <silent><buffer><expr> p defx#do_action('paste')
	nnoremap <silent><buffer><expr> n defx#do_action('new_file')
	nnoremap <silent><buffer><expr> N defx#do_action('new_directory')
	nnoremap <silent><buffer><expr> U defx#do_action('cd', ['..'])
	nnoremap <silent><buffer><expr> s defx#do_action('drop', 'split')
	nnoremap <silent><buffer><expr> v defx#do_action('drop', 'vsplit')
	nnoremap <silent><buffer><expr> yy defx#do_action('yank_path')
endfunction

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

" Enable deoplete when starting up
let g:deoplete#enable_at_startup = 1

" Enable python completion
let g:jedi#completions_enabled = 0
let g:python_highlight_all = 1
let g:jedi#goto_command = "<C-]>"
" MacOS
" let g:python3_host_prog = '/usr/local/bin/python3'

" Enable vim-go autocomplete import on saving
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
autocmd BufWritePre *.go :GoImports
" autocmd BufWritePre *.go :GoMetaLinter

" Update code status interval for gitgutter
set updatetime=100

" Enable alignment
let g:neoformat_basic_format_align = 1

" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

call neomake#configure#automake('nrwi', 500)


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

" Tagbar
nnoremap tt :TagbarToggle<CR>

" Neoformat
nnoremap ff :Neoformat<CR>
