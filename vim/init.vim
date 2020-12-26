"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" INIT
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use vim-plug as plugins manager
call plug#begin("~/.config/nvim/plugged")

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
Plug 'gcmt/wildfire.vim'

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

" Undo history
Plug 'mbbill/undotree'

" Align
Plug 'junegunn/vim-easy-align'

" Translator
Plug 'ianva/vim-youdao-translater'

" Protobuf format
Plug 'rhysd/vim-clang-format'

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

set colorcolumn=121

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
" If there is a capital letter, switch to case-sensitivce lookup
set smartcase

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
let g:go_def_mode='gopls'
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
let g:go_highlight_function_calls = 1
let g:syntastic_go_checkers = ['golint', 'govet', 'golangci-lint']
autocmd BufWritePre *.go :GoImports

" Vim-interestingwords
let g:interestingWordsRandomiseColors = 1


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

" Undo
nnoremap <leader>u :UndotreeToggle<CR>

" Youdao
vnoremap <leader>t :<C-u>Ydv<CR>
nnoremap <leader>t :<C-u>Ydc<CR>
" Input a word to translate
noremap <leader>yd :<C-u>Yde<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COC CONFIG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" coc
let g:coc_global_extensions = ["coc-snippets", "coc-json", "coc-yaml", "coc-prettier"]

command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -nargs=0 Format :call CocAction('format')

nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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
