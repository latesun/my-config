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

" Go plugin
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

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

" Theme
Plug 'morhetz/gruvbox'

" Auto completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Python plugin
Plug 'davidhalter/jedi-vim'

" Syntax checker
Plug 'dense-analysis/ale'

" Undo history
Plug 'mbbill/undotree'

" Align
Plug 'junegunn/vim-easy-align'


call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASE SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Jump where exited last time
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Change leader key
let g:mapleader=';'

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

" Theme
colorscheme gruvbox


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Defx
let g:maplocalleader=';'
nnoremap <silent> <LocalLeader>e
	\ :<C-u>Defx -resume -toggle -buffer-name=tab`tabpagenr()`<CR>
nnoremap <silent> <LocalLeader>a
	\ :<C-u>Defx -resume -buffer-name=tab`tabpagenr()` -search=`expand('%:p')`<CR>

call defx#custom#option('_', {
	\ 'winwidth': 35,
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
let g:airline_theme='gruvbox'
" Enable powerline fonts
let g:airline_powerline_fonts=1
" Enable buffer top tabline
let g:airline#extensions#tabline#enabled=1
" Set time display format
let g:airline#extensions#clock#format = '%H:%M:%S'
let g:airline#extensions#tabline#buffer_nr_show = 1

" Easy-motion
nmap ss <Plug>(easymotion-s2)

" Open git-blame plugin, to avoid other plugin cover
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>

" Vim-go
let g:go_def_mode='godef'
let g:go_info_mode='gopls'
let g:go_fmt_command = "goimports"
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
autocmd BufWritePre *.go :GoImports

" Jedi
let g:jedi#completions_enabled = 0
let g:jedi#goto_command = "<C-]>"

" Ale
let g:ale_linters = {
	\ 'go': ['golint', 'go vet', 'go build'],
	\ 'python': ['pylint'],
	\}

let g:ale_fixers = {
	\ 'json': ['prettier'],
	\ 'python': ['yapf'],
	\}
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'


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

" Open buffers
nnoremap <leader>b :Buffers<cr>

" Tagbar
nnoremap tt :TagbarToggle<CR>

" Fzf
nnoremap <C-p> :FZF<cr>

" Ale format
nnoremap ff :ALEFix<CR>

" Undo
nnoremap <leader>u :UndotreeToggle<CR>

" coc
let g:coc_global_extensions = ['coc-snippets', 'coc-python', 'coc-json']

inoremap <silent><expr> <TAB>
	\ pumvisible() ? coc#_select_confirm() :
	\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()

inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return ! col || getline('.')[col - 1] =~? '\s'
endfunction

augroup user_plugin_coc
	autocmd!
	autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END

" use <c-space>for trigger completion
inoremap <silent><expr> <C-space> coc#refresh()

" Movement within 'ins-completion-menu'
imap <expr><C-j>   pumvisible() ? "\<Down>" : "\<C-j>"
imap <expr><C-k>   pumvisible() ? "\<Up>" : "\<C-k>"

" Scroll pages in menu
inoremap <expr><C-f> pumvisible() ? "\<PageDown>" : "\<Right>"
inoremap <expr><C-b> pumvisible() ? "\<PageUp>" : "\<Left>"
imap     <expr><C-d> pumvisible() ? "\<PageDown>" : "\<C-d>"
imap     <expr><C-u> pumvisible() ? "\<PageUp>" : "\<C-u>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap gs <Plug>(coc-git-chunkinfo)
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" show commit contains current position
nmap gC <Plug>(coc-git-commit)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim', 'help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		let l:found = CocAction('doHover')
	endif
endfunction
