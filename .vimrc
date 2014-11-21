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
set backspace=indent,eol,start
set autochdir
set shell=/bin/bash "zsh downt work with vcscommand"
set hlsearch
set statusline=%F%m%r%h%w\ line\ %04l(%p%%),\ row\ %04v
set laststatus=2

au BufNewFile,BufRead,BufEnter *.cint set filetype=cpp

"Settings for VimLatex
let g:Tex_TEXINPUTS= "..:"
let g:Tex_DefaultTargetFormat="pdf"
let g:Tex_CompileRule_pdf='make'
let g:Tex_ViewRule_pdf='Skim'
let g:Tex_MultipleCompileFormats = "dvi"
"let g:tex_flavor='latex'
let g:Tex_UseMakefile=1
let g:Tex_GotoError=0

set grepprg=grep\ -nH\ $*
let mapleader = '\'

"Append MacPorts to $PATH
"let $PATH .= '.:/opt/local/bin:/opt/local/sbin'

function! DoPrettyXML()
   save the filetype so we can restore it later
   let l:origft = &ft
   set ft=
   " delete the xml header if it exists. This will
   " permit us to surround the document with fake tags
   " without creating invalid xml.
   1s/<?xml .*?>//e
   " insert fake tags around the entire document.
   " This will permit us to pretty-format excerpts of
   " XML that may contain multiple top-level elements.
   0put ='<PrettyXML>'
   $put ='</PrettyXML>'
   silent %!xmllint --format -
   " xmllint will insert an <?xml?> header. it's
   easy enough to delete
   " if you don't want it.
   " delete the fake tags
   2d
   $d
   " restore the 'normal' indentation,
   which is one extra level
   " too deep due to the extra tags
   we wrapped around the document.
   silent %<
   " back to home
   1
   " restore the filetype
   exe "set ft=" .
   l:origft
endfunction
command! PrettyXML call DoPrettyXML()
