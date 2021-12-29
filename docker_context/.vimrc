" vim:softtabstop=2:shiftwidth=2:et
" Tab preferences
set shiftwidth=2
set softtabstop=2
set autoindent
set expandtab

" Where to store swap files.  By default, they will go into ~/.vim/swap, but
" if that doesn't work, they will go in cwd.
set directory=~/.vim/swap,.

" Make vim auto-wrap tripple slash comments.
autocmd Filetype c,cpp set comments^=:///


"------------------------------------------------------------------------------
" Plugins
"------------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

" For better file browsing.
Plug 'preservim/nerdtree'

" Supports 'git vimdiff', as well as being handy in its own right.
Plug 'will133/vim-dirdiff'

" There were display/windowing issues with this.
" Plug 'Xuyuanp/nerdtree-git-plugin'

" vim/git integration.
Plug 'tpope/vim-fugitive'

" Use gcc to comment out a line, gc in visual mode to comment out a block.
Plug 'tpope/vim-commentary'

" Highlight and fix whitespace issues.
Plug 'git://github.com/ntpeters/vim-better-whitespace.git'

" For fuzzy file searching.
" Didn't seem worth the functionality it added. I couldn't get the navigation
" in lists to work quite right, maybe because of bad interactions with other
" plugins.
" Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
" Plug 'junegunn/fzf.vim'

" --------------
" Python Plugins
" --------------

" Python syntax highlighting.
Plug 'vim-python/python-syntax'

" Automatic PEP 8 compliance.
Plug 'dense-analysis/ale'

" Automatic quote, paren, and other character pairing.
" On the net, I found the mistakes this introduced more annoying than
" the help it provided.
"Plug 'jiangmiao/auto-pairs'

" Some Python IDE features such as refactoring.
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop'  }

" Automatic completion.
Plug 'ycm-core/YouCompleteMe'

" Static type checking.
" Commenting out because I think that Ale can handle this fine.
"Plug 'integralist/vim-mypy'

" Must be kept last after all Plug commands.
call plug#end()
"------------------------------------------------------------------------------
" End Plugins
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
" Plugin Configuration
"------------------------------------------------------------------------------

filetype plugin indent on   " enables filetype indent specific plugins

" --------
" nerdtree
" --------

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" -------------
" python-syntax
" -------------

let g:python_highlight_all = 1

" ---
" ALE
" ---
let g:ale_python_flake8_options = '--max-line-length 79 --builtins="Test,Condition,Testers,When,ExtendTest,ExtendTestRun,CopyLogic,Any"'

" -----------
" python-mode
" -----------
let g:pymode_options_max_line_length = 79
let g:pymode_rope = 1
let g:pymode_lint_checkers = ['mypy', 'pyflakes', 'pep8', 'mccabe', 'pep257']

" This resolves a conflict with YouCompleteMe.
let g:pymode_rope_completion = 0

" -------------
" YouCompleteMe
" -------------
set encoding=utf-8

"------------------------------------------------------------------------------
" End Plugin Configuration
"------------------------------------------------------------------------------

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
