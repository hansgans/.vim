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
Plugin 'dzeban/vim-log-syntax'

" Navigation
Plugin 'wincent/command-t' "Fast file navigation
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'neomake/neomake'
Plugin 'xolox/vim-misc'
Plugin 'easymotion/vim-easymotion'

" Git
Plugin 'airblade/vim-gitgutter' "Git diff
Plugin 'tpope/vim-fugitive' "Git interface

" Vim as an IDE
Plugin 'vim-scripts/a.vim' "Open corresponding header files to source file and otherwise
Plugin 'tpope/vim-surround' "automatically insert braces, quotes
Plugin 'xolox/vim-easytags' "Automatic generation of tag files (VERY SLOW startup for large tag files)
Plugin 'majutsushi/tagbar' "Tag bar
Plugin 'scrooloose/nerdcommenter' 
Plugin 'davidhalter/jedi-vim' " Improved autocompletition for python
"Plugin 'vim-syntastic/syntastic' "Syntax checking (using neomake currently)
Plugin 'zchee/deoplete-jedi'
if has('nvim')
  Plugin 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plugin 'Shougo/deoplete.nvim'
  Plugin 'roxma/nvim-yarp'
  Plugin 'roxma/vim-hug-neovim-rpc'
endif
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'rhysd/vim-clang-format'
Plugin 'Chiel92/vim-autoformat' " Auto format source code
Plugin 'python-mode/python-mode'
Plugin 'vhdirk/vim-cmake' " CMake

Plugin 'chrisbra/vim-diff-enhanced'
Plugin 'rkitover/vimpager' "Use vim as pager (provides highlighting)
Plugin 'ctrlpvim/ctrlp.vim' "Ctrl+P search for filename in normal mode

Plugin 'sukima/xmledit'

" Tex plugins
Plugin 'lervag/vimtex'
Plugin 'beloglazov/vim-online-thesaurus'

call vundle#end()

filetype plugin indent on

" disable clipboard to improve startup time
"set clipboard=exclude:.*

set shiftwidth=2	" number of spaces to use for auto intent
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
set guifont=Meslo\ LG\ S\ Regular\ for\ Powerline:h13
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
	set background=dark
	"set background=light
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


" vimpager
"let g:vimpager.gvim = 0

" jedi-vim
" We want to use jedi autocompletition for python
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 1
let g:jedi#auto_vim_configuration = 1
"let g:neocomplete#force_omni_input_patterns.python = 
	  "\ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*' 
		" alternative pattern: '\h\w*\|[^. \t]\.\w*'

" deoplete enable at startup
let g:deoplete#enable_at_startup = 1

"Settings for vimtex
let g:vimtex_complete_enabled=1
let g:vimtex_toc_enabled=1
let g:vimtex_fold_enabled=1
let g:vimtex_indent_enabled=1
let g:vimtex_view_enable=1
let g:vimtex_view_method='general'
if has("mac")
let g:vimtex_view_general_viewer='/Applications/Skim.app/Contents/SharedSupport/displayline'
endif
let g:vimtex_view_general_options='@line @pdf @tex'
let g:vimtex_quickfix_latexlog = {'default' : 0} " disable warnings
" let g:vimtex_latexmk_continuous=1  "Deprecated
let g:vimtex_compiler_latexmk = {
        \ 'backend' : 'nvim',
        \ 'background' : 1,
        \ 'build_dir' : '',
        \ 'callback' : 1,
        \ 'continuous' : 0,
        \ 'executable' : 'latexmk',
        \ 'options' : [
        \   '-pdf',
        \   '-verbose',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
		\	'-shell-escape',
        \ ],
        \}

" Enable spell checking by default for TeX files
au BufRead,BufNewFile *.tex set spell
" Enable spell checking by default for TeX files
au BufRead,BufNewFile *.tex set filetype=tex
" Configure vimtex to work with deoplete
if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete

"Settings for XML editing
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax
function! DoPrettyXML()
	" save the filetype so we can restore it later
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
	" easy enough to delete if you don't want it.
	" delete the fake tags
	2d
	$d
	" restore the 'normal' indentation, which is one extra level
	" too deep due to the extra tags we wrapped around the document.
	silent %<
	" Remove empty lines (and lines containting white spaces/tabs 
	" only
	g/^\s*$/d
	" back to home
	1
	" restore the filetype exe "set ft="
	set ft=xml
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
" vim-diff-enhanced
"
" started In Diff-Mode set diffexpr (plugin not loaded yet)
"if &diff
  "let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
"endif

"
" NERTCommenter
" 
" Use // comments in .c files
let g:NERDAltDelims_c = 1
" Default delimiter for bib files is wrong
let g:NERDCustomDelimiters = { 'bib' : { 'left': '%' } }

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
	let g:nerdtree_tabs_open_on_gui_startup = 0

	"	Close vim if NERDTree is the last window open
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	let g:NERDTreeDirArrowExpandable = '>'
	let g:NERDTreeDirArrowCollapsible = '-'
	"	Start NERDTree automatically if no files are open
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
endif

"
" Syntax checking
"
let g:neomake_open_list = 2 " open window in case of errors
"let g:neomake_python_enabled_makers = ['pep8', 'pylint']
let g:neomake_python_enabled_makers = ['pep8']
" Run neomake in normal mode and buffer write
call neomake#configure#automake('nw')
"let g:neomake_tex_enabled_makers = ['lacheck']
let g:neomake_tex_enabled_makers = [] " disable syntax checking for tex documents

" Old sytastic configuration
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0
"" Symbols not available in terminal
""let g:syntastic_error_symbol = '✘'
""let g:syntastic_warning_symbol = "▲"
"" use cpp checker for files for .C, c, .h ending (e.g. root scripts)
"let g:syntastic_c_checkers = ['cpp/clang_check']
"" Args can be specified in .syntastic_clang_check_config 
""	one argument per line (w/o -extra-arg= option)
"let g:syntastic_cpp_clang_check_args = "-extra-arg=\"-std=c++11\"" 
""let g:syntastic_cpp_clang_check_args = "-extra-arg=\"-I/opt/local/include/root\" \
""										 -extra-arg=\"-std=c++11\""
"let g:syntastic_python_checkers = ['pylint']
"" Disable (style) warnings
"let g:syntastic_python_pylint_args = '--disable=all --enable=E'
"augroup mySyntastic
  "au!
  "au FileType tex let b:syntastic_mode = "passive"
"augroup END

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
let g:pymode_options = 0              " do not change relativenumber
let g:pymode_indent = 1               " use vim-python-pep8-indent (upstream of pymode)
let g:pymode_lint = 0                 " prefer syntastic; pymode has problems when PyLint was invoked already before VirtualEnvActivate..!?!
let g:pymode_virtualenv = 0           " use virtualenv plugin (required for pylint?!)
let g:pymode_doc = 0                  " use pydoc
let g:pymode_rope_completion = 0      " use YouCompleteMe instead (python-jedi)
let g:pymode_syntax_space_errors = 0  " using MyWhitespaceSetup
let g:pymode_trim_whitespaces = 0
let g:pymode_debug = 0
let g:pymode_rope = 0 " disable rope, we use jedi-vim for tab completion
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
let g:clang_format#code_style = "llvm"

"
" Highlight overline lines
"
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp,*.c,*.h,*.C,*.py,*.tex
			\ if exists('+colorcolumn') |
			\ set textwidth=80 |
			\ set colorcolumn=+1 |
			\ highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9 guifg=white |
			\ match OverLength /\%>81v.\+/ |
			\ else |
			\ 	au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1) |
			\ endif

