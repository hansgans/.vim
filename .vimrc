call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
au BufWinLeave *.* mkview
au BufWinEnter *.* silent loadview
set sw=3
set tabstop=4
set foldmethod=marker
filetype plugin on
filetype indent on
set nobackup
set nowritebackup
set noswapfile
set wildmenu
set wildmode=list:longest,full
set mouse=a
"set ofu=syntaxcomplete#Complete
set guifont=Monospace\ 9
syntax on

set shell=/bin/bash "zsh downt work with vcscommand"
let mapleader = ","
set hlsearch
set statusline=%F%m%r%h%w\ line\ %04l(%p%%),\ row\ %04v
set laststatus=2

let g:Tex_MultipleCompileFormats = "dvi,pdf"
let g:Tex_ViewRule_pdf='Skim'
let g:tex_flavor='latex'
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
"highlight   clear
"highlight   Pmenu         ctermfg=0 ctermbg=2
"highlight   PmenuSel      ctermfg=0 ctermbg=7
"highlight   PmenuSbar     ctermfg=7 ctermbg=0
"highlight   PmenuThumb    ctermfg=0 ctermbg=7

"function! UpdateTags()
	"execute ":!/opt/local/bin/ctags -R --languages=C++ --c++-kinds=+cdefgmptl --fields=+iaS --extra=+q ./"
	"echohl StatusLine | echo "C/C++ tag updated" | echohl None
"endfunction
"nnoremap <F4> :call UpdateTags()

let g:clang_auto_select=1
let g:clang_complete_auto=1
let g:clang_complete_copen=1
let g:clang_hl_errors=1
let g:clang_periodic_quickfix=0
let g:clang_snippets=1
let g:clang_snippets_engine="clang_complete"
let g:clang_conceal_snippets=1
let g:clang_exec="clang"
let g:clang_user_options=""
let g:clang_auto_user_options="path, .clang_complete"
let g:clang_use_library=1
"let g:clang_library_path="/directory/of/libclang.so/"
let g:clang_sort_algo="priority"
let g:clang_complete_macros=1
let g:clang_complete_patterns=0
