" vim:softtabstop=2:shiftwidth=2:et
" Tab preferences
set shiftwidth=2
set softtabstop=2
set autoindent
set expandtab

" Make vim auto-wrap tripple slash comments.
autocmd Filetype c,cpp set comments^=:///

execute pathogen#infect()

" Where to store swap files.  By default, they will go into ~/.vim/swap, but
" if that doesn't work, they will go in cwd.
set directory=~/.vim/swap,.

filetype plugin indent on   " enables filetype indent specific plugins

" syntastic settings
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
""let g:syntastic_always_populate_loc_list = 1
""let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_python_flake8_args = "--max-line-length=132"

" ALE settings.
let g:ale_python_flake8_options = '--builtins="Test,Condition,Testers,When,ExtendTest,CopyLogic,Any"'

" Instructions on how to tab complete filenames.
" set wildmode=longest,list,full
set wildmode=longest,list
set wildmenu

" Turn on line numbers by default.
set number

" Always keep 3 lines of context above and below the curser.
set scrolloff=3

" In case there are vim modelines at the top of the file, as there
" is with this one.
set modeline
set modelines=5


" Always show the status line.
set laststatus=2

" Look for a tags file.
set tags=./tags,tags;
" Also search for .git/tags files.
set tags^=.git/tags;~

" Make Ctrl-] show the list of options by default.
nnoremap <C-]> g<C-]>
nnoremap <C-w>] <C-w>g]


" Colors
" Have syntax highlighting in terminals which can display colours:
if has('syntax') && (&t_Co > 2)
  syntax on
else
  syntax off
endif
set background=dark
set hlsearch
set incsearch

" I so often type teh instead of the.
abbreviate teh the

" To help vim deal with pasting text
:map <F9> :set invpaste <CR>
set pt=<F9>

" Toggle vim's spell checker with <F5>
:map <F5> :setlocal spell! spelllang=en_us<cr>

" Shortcuts for c code.
map! ,bc /*  */hhi
map! ,bz #if 0#endif /* 0 */O

" License shortcuts
"    C/C++
map ,cl :0r ~/licenses/LICENSE_c<CR>
"    Python
map ,pl :0r ~/licenses/LICENSE_python<CR>
"    rst files
map ,rl :0r ~/licenses/LICENSE_rst<CR>


" Ignore whitespace when diffing files.
map ,iw :set diffopt+=iwhite<CR>

" Associate some of au test extensions with Python.
au BufRead,BufNewFile *.cli.ext set filetype=python
au BufRead,BufNewFile *.test.ext set filetype=python
au BufRead,BufNewFile *.part set filetype=python
au BufRead,BufNewFile Sconstruct set filetype=python
au BufRead,BufNewFile Makefile.inc set filetype=automake
