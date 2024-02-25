" General Settings
set number
set relativenumber
set nu

filetype on
syntax on
set spell

set scrolloff=512
set autoindent
set background=dark
set linebreak
set termguicolors
set hlsearch

set noexpandtab
set tabstop=4
set shiftwidth=4
set list
set listchars=tab:\|\ 

" Remaps

map <Space> <Leader>

nnoremap j gj
nnoremap k gk

nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

" Vim Plug
" https://github.com/junegunn/vim-plug/
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin()

" Vim LSP
" https://blog.sidebits.tech/vim-straightforward-lsp-setup-with-autocompletion/
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Fuzzy Finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Tab to Auto Complete
" Plug 'vim-scripts/SuperTab'

" VimTex for LaTeX
Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_method='skim'
let g:vimtex_view_skim_sync = 1
let g:vimtex_view_skim_activate = 1 

" NerdTree
Plug 'preservim/nerdtree'

" Colorscheme
Plug 'ghifarit53/tokyonight-vim'

" Pseudocode Highlight
Plug 'joelbeedle/pseudo-syntax'

call plug#end()

colorscheme tokyonight
let NERDTreeShowLineNumbers=1 
