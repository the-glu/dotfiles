"""""""""""
" Plugins "
"""""""""""

" Bootstrap autoload
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/bundle')

" Some nice defaults
Plug 'tpope/vim-sensible'

" Surround
Plug 'tpope/vim-surround'

" Fix . for some plugins
Plug 'tpope/vim-repeat'

" Highlight all search results
Plug 'haya14busa/incsearch.vim'

" Undo tree
Plug 'sjl/gundo.vim', {'on': 'GundoToggle'}
nnoremap <silent> <leader>u <Esc>:<C-u>GundoToggle<CR>

" Better targets (cin" !)
Plug 'wellle/targets.vim'

" Nerd tree
Plug 'scrooloose/nerdtree'
let g:NERDTreeMouseMode=2
autocmd vimenter * if !argc() | NERDTree | endif
map <silent> <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']

" Tag list
Plug 'majutsushi/tagbar'
let g:tagbar_autofocus = 1
map <C-t> :TagbarToggle<CR>

" Syntaxe checking
Plug 'scrooloose/syntastic'
let g:syntastic_auto_loc_list=0
let g:syntastic_enable_loc_list=0
let g:syntastic_enable_highlighting=1
let g:syntastic_error_symbol='✗→'
let g:syntastic_style_error_symbol='✗→'
let g:syntastic_warning_symbol='⚠→'
let g:syntastic_style_warning_symbol='⚠→'
let g:syntastic_aggregate_errors=1
let g:Powerline_symbols = 'unicode'

let g:syntastic_python_checkers=['flake8', 'pyflakes', 'pep8', 'py3kwarn']
let g:syntastic_python_checker_args='--ignore=E501'
let g:syntastic_python_flake8_post_args='--ignore=E501,E128,E225'
let g:syntastic_python_pep8_post_args='--ignore=E501,E128,E225'
let g:syntastic_scala_checkers=[]
let g:syntastic_java_checkers=[]
"Always check when buffers are opened
let g:syntastic_check_on_open=1


" Git signs
Plug 'airblade/vim-gitgutter'
let g:gitgutter_eager = 0 " only update on read/write
let g:gitgutter_sign_column_always = 0

" Tab with buffers
Plug 'ervandew/supertab'
let g:airline#extensions#tabline#enabled = 1

" Python completion
Plug 'davidhalter/jedi-vim'
let g:jedi#use_tabs_not_buffers = 0
set splitbelow

" gc to comment
Plug 'tomtom/tcomment_vim'

Plug 'justinmk/vim-sneak'

" clipboard management
Plug 'svermeulen/vim-easyclip'
let g:EasyClipDoSystemSync=0

" Python settings
Plug 'klen/python-mode'
let g:pymode_lint_on_write = 0
let g:pymode_lint_signs = 0
let g:pymode_folding = 0

" vv selection
Plug 'gorkunov/smartpairs.vim'
let g:smartpairs_nextpairs_key_i = ''

" Automatic tab detection
Plug 'tpope/vim-sleuth'

" Git commands
Plug 'tpope/vim-fugitive'

" Multiple cursors
Plug 'terryma/vim-multiple-cursors'
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

Plug 'bufkill.vim'


" Airline
Plug 'bling/vim-airline'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_powerline_fonts=1

Plug 'ctrlpvim/ctrlp.vim'

Plug 'ryanoasis/vim-webdevicons'

Plug 'unblevable/quick-scope'

call plug#end()

""""""""""""""""""""
" General settings "
""""""""""""""""""""

set hidden

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
" Case sensitive only if upper
set ignorecase smartcase

set cmdheight=2
set switchbuf=useopen
set numberwidth=5
set showtabline=2
set shell=zsh
set scrolloff=3
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=

" No backups
set nobackup
set nowritebackup

set wildmode=longest,list

" Better ladder
let mapleader=" "

" Line numbers
set nu

" Folding
set foldcolumn=1
set foldmethod=indent
set foldlevel=99

set mouse=a
set listchars=tab:⇝·,trail:⚠,extends:⇝,precedes:⇜,eol:⚡
set list

set incsearch
set hlsearch

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,htmldjango,javascript,sass,cucumber set ai sw=4 sts=4 et
  autocmd FileType python set sw=4 sts=4 et

  autocmd! BufRead,BufNewFile *.sass setfiletype sass

  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

  " Indent p tags
  autocmd FileType html,eruby if !exists("g:html_indent_tags") || g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif

  autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
  autocmd FileType htmldjango set omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css set omnifunc=csscomplete#CompleteCSS

augroup END

""""""""""
" Colors "
""""""""""

" Highlight currentline
set cursorline
hi CursorLine term=bold gui=bold cterm=bold guibg=Grey40

:set t_Co=256
:set background=dark
:color grb256

set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 10

if has("gui_running") || has('nvim')
    colorscheme codeschool
    set foldcolumn=0
endif

hi NonText ctermfg=64 guifg=#7A7912
hi SpecialKey ctermfg=64 guifg=#7A7912

highlight SyntasticErrorSign  guifg=#ff2222 guibg=#3E3D32 ctermfg=0 ctermbg=1
highlight SyntasticWarningSign  guifg=#ff2222 guibg=#3E3D32 ctermfg=0 ctermbg=3
highlight SyntasticStyleErrorSign  guifg=#ff2222 guibg=#3E3D32 ctermfg=0 ctermbg=1
highlight SyntasticStyleWarningSign  guifg=#ff2222 guibg=#3E3D32 ctermfg=0 ctermbg=3

highlight SignColumn ctermbg=8 guibg=#3E3D32
highlight GitGutterAdd  guifg=#009900 guibg=#3E3D32 ctermfg=2 ctermbg=8
highlight GitGutterChange guifg=#bbbb00 guibg=#3E3D32 ctermfg=3 ctermbg=8
highlight GitGutterDelete  guifg=#ff2222 guibg=#3E3D32 ctermfg=1 ctermbg=8

"""""""""""""""
" Status line "
"""""""""""""""

:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

""""""""""""""""
" Key mappings "
""""""""""""""""

map <c-c> <esc>
:nnoremap <CR> :nohlsearch<cr>
set pastetoggle=<F10>

" F6: Highlight the word under cursor in darkred
highlight ManualHighlight ctermbg=darkred guibg=darkred

noremap <silent> <F6> :exe printf('match ManualHighlight /%s/', escape(expand('<cword>'), '/\'))<CR>
noremap <silent> <c-F6> :match ManualHighlight //<CR>

inoremap <silent> <c-s> <c-o>:w<CR>
nnoremap <silent> <C-S> :<C-u>w<CR>
map <Leader>w :BD<Return>

vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Copy paste in copy/paste global buffer
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Fast buffer navigation
map <c-left> :bprevious<CR>
map <c-right> :bnext<CR>

" Select with <enter> completion
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Always select the first element
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

"""""""""""""""""
" Misc commands "
"""""""""""""""""

" Sudo write
cmap w!! w !sudo tee % > /dev/null

"""""""""""
" Tab key "
"""""""""""

" Complete only if not @ the beggining of a line
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

