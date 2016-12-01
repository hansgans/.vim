call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
"Do we want to save the current view to ~/.vim/view ?
"au BufWinLeave *.* mkview
"au BufWinEnter *.* silent loadview
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
set guifont=Monaco:h12
syntax on
set backspace=indent,eol,start
set autochdir
set shell=/bin/bash "zsh downt work with vcscommand"
set hlsearch
set statusline=%F%m%r%h%w\ line\ %04l(%p%%),\ row\ %04v
set laststatus=2
set grepprg=grep\ -nH\ $*
"Set mapleader
let mapleader = '\'
"use cpp syntax for *.cint files
au BufNewFile,BufRead,BufEnter *.cint set filetype=cpp

"set decent color scheme
colorscheme peachpuff
" neocomplete plugin
let g:neocomplete#enable_at_startup = 1
if !exists('g:neocomplete#sources#omni#input_patterns')
   let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.tex =
		 \ '\v\\\a*(ref|cite)\a*([^]]*\])?\{([^}]*,)*[^}]*'

" neosnippet plugin
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
		 \ "\<Plug>(neosnippet_expand_or_jump)"
		 \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
		 \ "\<Plug>(neosnippet_expand_or_jump)"
		 \: "\<TAB>"
" For conceal markers. Simple math is displayer by its unicode characters
if has('conceal')
   "set conceallevel=2 concealcursor=niv
endif"  

"Settings for VimLatex
"let g:Tex_TEXINPUTS= "..:"
"let g:Tex_DefaultTargetFormat="pdf"
"let g:Tex_CompileRule_pdf='make'
"let g:Tex_ViewRule_pdf='Skim'
"let g:Tex_MultipleCompileFormats = "dvi"
""let g:tex_flavor='latex'
"let g:Tex_UseMakefile=1
"let g:Tex_GotoError=0

"Settings for vimtex
let g:vimtex_complete_enabled=1
let g:vimtex_view_enable=1
let g:vimtex_view_method='general'
let g:vimtex_view_general_viewer='/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options='@line @pdf @tex'
"let g:vimtex_view_general_options_latexmk='skim'
let g:vimtex_latexmk_continuous=1

"Settings for XML editing
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax
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


" AirLine is a nice status/tabline
let g:airline#extensions#tabline#enabled = 1
"let g:airline_powerline_fonts = 1

" Key mapping for thesaurus
let g:online_thesaurus_map_keys = 0
nnoremap <leader>g :OnlineThesaurusCurrentWord<CR>
" Needed to remove some error message
let g:airline#extensions#whitespace#mixed_indent_algo = 2
let g:airline#extensions#whitespace#checks = [ 'indent' ]

" TagBar (useful with ctags)
nnoremap <silent> <Leader>b :TagbarToggle<CR>

set tags=./tags;,tags;
set tags+=~/.tags/boss665p01
set tags+=~/.tags/root6
set tags+=~/.tags/gaudi
