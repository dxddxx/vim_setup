" Install Vim-Plug

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" General Settings

set relativenumber number
set wildmenu showmode showcmd laststatus=2
set hlsearch
" https://www.johnhawthorn.com/2012/09/vi-escape-delays/
set timeoutlen=1000 ttimeoutlen=0
filetype on
syntax on
set spelllang=en_us,en_gb,cjk
" Scroll and wrap
set scrolloff=512
set nowrap
set noautoindent
" Tabs and spces
set tabstop=4 shiftwidth=4 expandtab
set list listchars=tab:│->,leadmultispace:│\ \ \ 
" idk saw this on youtube
set path+=**

" Remaps

map <Space> <Leader>
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
" Quarto
command! QmdRender !quarto render %
command! QmdPreview !quarto preview % --quiet
" Python
command! PyRun !python3 %

" Plugins

call plug#begin()
" https://blog.sidebits.tech/vim-straightforward-lsp-setup-with-autocompletion/
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
" Colos
Plug 'jeffkreeftmeijer/vim-dim'
Plug 'ghifarit53/tokyonight-vim'
call plug#end()

" Plugin Configuration

" LSP diagnostics
let g:lsp_diagnostics_virtual_text_align = "after"
let g:lsp_diagnostics_virtual_text_padding_left = 8

" Color scheme

set termguicolors
colorscheme tokyonight
" Spell Underline
" (Not all terminals support underlines)
" (Does not work in nvim)
hi clear SpellBad
hi SpellBad cterm=underline ctermul=1
hi clear SpellCap
hi SpellCap cterm=underline ctermul=3
hi clear SpellRare
hi SpellRare cterm=underline ctermul=5
hi clear SpellLocal
hi SpellLocal cterm=underline ctermul=4

" Netrw

" let g:netrw_banner=0
let g:netrw_winsize=25
let g:netrw_liststyle=4

function! NetrwMap()
    set number relativenumber
    " hack fix for netrw window navigation
    nnoremap <buffer> <c-l> :wincmd l<cr>
    nmap <buffer> h -^
    nmap <buffer> l <CR>
endfunction

augroup netrw_map
    autocmd!
    autocmd filetype netrw call NetrwMap()
augroup END

" Status Line

function! LineCountBar()
    if mode() == 'v' || mode() == 'V' || mode() == "\<C-v>"
        let line_count = (abs(line('.') - line('v')) + 1)
    else
        let line_count = line('.')
    endif
    let full_bar = line_count . '/' . line('$') . 'L '
    return full_bar
endfunction

function! WordCountBar()
    if mode() == 'v' || mode() == 'V' || mode() == "\<C-v>"
        let char_count = wordcount().visual_chars
        let word_count = wordcount().visual_words
    else
        let char_count = wordcount().cursor_chars
        let word_count = wordcount().cursor_words
    endif
    let full_bar = char_count . '/' . wordcount().chars . 'C '
    let full_bar .= word_count . '/' . wordcount().words . 'W '
    let full_bar .= LineCountBar()
    return full_bar
endfunction

" File Name, File type, Modified, Break
set statusline=\ %f\ %y\ %m%= 
set statusline+=%{LineCountBar()}

" Text File Specific

function! TextFileConfig()
    set spell
    set wrap linebreak
    set list listchars=tab:│->
    noremap j gj
    noremap k gk
    " numbered jumps in wrapped text
    noremap <expr> j v:count ? 'j' : 'gj'
    noremap <expr> k v:count ? 'k' : 'gk'
    set statusline=\ %f\ %y\ %m%= 
    set statusline+=%{WordCountBar()}
endfunction

augroup text_file_config
    autocmd!
    autocmd filetype markdown,text,tex,quarto call TextFileConfig()
augroup END
