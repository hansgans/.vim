set nocompatible

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Vim looking good
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Navigation
Plugin 'wincent/command-t' "Fast file navigation
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'vim-syntastic/syntastic'
Plugin 'xolox/vim-misc'

" Git
Plugin 'airblade/vim-gitgutter'

" Vim as an IDE
Plugin 'vim-scripts/a.vim' "Open corresponding header files to source file and otherwise
Plugin 'tpope/vim-fugitive' "use ctags
Plugin 'tpope/vim-surround' "automatically insert braces, quotes
Plugin 'xolox/vim-easytags' "VERY SLOW startup!
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Shougo/neocomplete'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'rhysd/vim-clang-format'
Plugin 'python-mode/python-mode'

Plugin 'rkitover/vimpager' "Use vim as pager (provides highlighting)
Plugin 'ctrlpvim/ctrlp.vim' "Ctrl+P search for filename in normal mode

Plugin 'sukima/xmledit'

" Tex plugins
Plugin 'lervag/vimtex'
Plugin 'beloglazov/vim-online-thesaurus'

call vundle#end()

filetype plugin indent on

"call pathogen#runtime_append_all_bundles()
"call pathogen#helptags()

" disable clipboard to improve startup time
set clipboard=exclude:.*

set shiftwidth=4	" number of spaces to use for auto intent
set tabstop=4 		" space representing one tab stop
set softtabstop=4 		" space representing one tab stop
set foldmethod=marker
set autoindent
set nobackup
set nowritebackup
set noswapfile
set wildmenu
set wildmode=list:longest,full
set mouse=a
set cursorline		" line below curser
set guifont=Monaco:h12
syntax on			" syntax highlighting
set backspace=indent,eol,start
set autochdir
set shell=/bin/bash "zsh downt work with vcscommand"
set hlsearch
set statusline=%F%m%r%h%w\ line\ %04l(%p%%),\ row\ %04v
" Always show status bar
set laststatus=2
set grepprg=grep\ -nH\ $*
"Set mapleader
let mapleader = '\'

" We need this for plugins like Syntastic and vim-gitgutter which put symbols
" in the sign column.
hi clear SignColumn

" show the matching part of the pair for [] {} and ()
set showmatch

" File type specific config
" use cpp syntax for *.cint files
au BufNewFile,BufRead,BufEnter *.cint set filetype=cpp
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.c,*.h match BadWhitespace /\s\+$/
" Wrap text after a certain number of characters
au BufRead,BufNewFile *.c,*.h set textwidth=79


" Set color scheme
if has('gui_running')
	set background=light
else
	set background=dark
endif
colorscheme solarized

" neocomplete plugin
if v:version < 704
	let g:loaded_neocomplete = 1 " disable
else
	let g:neocomplete#enable_at_startup = 1
	if !exists('g:neocomplete#sources#omni#input_patterns')
		let g:neocomplete#sources#omni#input_patterns = {}
	endif
	let g:neocomplete#sources#omni#input_patterns.tex =
				\ '\v\\\a*(ref|cite)\a*([^]]*\])?\{([^}]*,)*[^}]*'
endif

" neosnippet plugin
if v:version < 701
	let g:loaded_neosnippet = 1 " disable
else
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
endif

"Settings for vimtex
let g:vimtex_complete_enabled=1
let g:vimtex_toc_enable=1
let g:vimtex_view_enable=1
let g:vimtex_view_method='general'
if has("mac")
let g:vimtex_view_general_viewer='/Applications/Skim.app/Contents/SharedSupport/displayline'
endif
let g:vimtex_view_general_options='@line @pdf @tex'
let g:vimtex_latexmk_continuous=1
" Enable spell checking by default for TeX files
au BufRead,BufNewFile *.tex set spell
" Enable spell checking by default for TeX files
au BufRead,BufNewFile *.tex set filetype=tex

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

"
" AirLine is a nice status/tabline
"
" Show airline for tabs too
let g:airline#extensions#tabline#enabled = 1
" Fancy arrow symbols, requires a patched font
" To install a patched font, run over to
"     https://github.com/abertsch/Menlo-for-Powerline
" download all the .ttf files, double-click on them and click "Install"
" Finally, uncomment the next line
"let g:airline_powerline_fonts = 1
" Show PASTE if in paste mode
let g:airline_detect_paste=1
" Use the solarized theme for the Airline status bar
let g:airline_theme='solarized'

"
" Thesaurus
"
" Key mapping for thesaurus
let g:online_thesaurus_map_keys = 0
nnoremap <leader>g :OnlineThesaurusCurrentWord<CR>
" Needed to remove some error message
let g:airline#extensions#whitespace#mixed_indent_algo = 2
let g:airline#extensions#whitespace#checks = [ 'indent' ]

" TagBar (useful with ctags)
if v:version < 701
	let g:loaded_tagbar = 1 " disable
endif
nnoremap <silent> <Leader>b :TagbarToggle<CR>

"
" NERDTree
" 
if v:version < 701
	let g:loaded_nerd_tree = 1 " disable
else

	" Open/close NERDTree Tabs with \t
	nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
	"map <C-n> :NERDTreeToggle<CR><CR>
	" To have NERDTree always open on startup
	let g:nerdtree_tabs_open_on_console_startup = 0

	"	Close vim if NERDTree is the last window open
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	let g:NERDTreeDirArrowExpandable = '>'
	let g:NERDTreeDirArrowCollapsible = '-'
	"	Start NERDTree automatically if no files are open
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
endif

"
" Syntastic 
"
"let g:syntastic_error_symbol = '✘'
"let g:syntastic_warning_symbol = "▲"
augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END

"
" vim-easytags 
"
" Where to look for tags files
set tags=./tags;,~/.vimtags
"set tags+=./tags;,tags; " search for files in current directory
"set tags+=~/.tags/*/tags " load tag files in home directory
" Sensible defaults
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

" ----- majutsushi/tagbar settings -----
" Open/close tagbar with \b
nmap <silent> <leader>b :TagbarToggle<CR>
" Uncomment to open tagbar automatically whenever possible
"autocmd BufEnter * nested :call tagbar#autoopen(0)

"
" PYTHON: plugin python-mode 
"
" disable rope, we use jedi-vim for tab completion
let g:pymode_rope = 0
" expand tabs to spaces in python files
au BufRead,BufNewFile *.py,*.pyw set expandtab
" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red
" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /\s\+$/
" Wrap text after a certain number of characters
au BufRead,BufNewFile *.py,*.pyw set textwidth=79
" Enable line numbers
au BufRead,BufNewFile *.py,*.pyw set number
" Full python syntax highlighting
let python_highlight_all=1

" 
" vim-gitgutter
"
" In vim-airline, only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1

"
" delimitMate 
"
let delimitMate_expand_cr = 1
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType tex let b:delimitMate_quotes = ""
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

"
" vim-clang-format
"
let g:clang_format#code_style = "mozilla"
