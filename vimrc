set encoding=utf-8
scriptencoding utf-8
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

Plug 'michaeljsmith/vim-indent-object'

" Undo tree
Plug 'sjl/gundo.vim', {'on': 'GundoToggle'}
nnoremap <silent> <leader>u <Esc>:<C-u>GundoToggle<CR>

" Better targets (cin" !)
Plug 'wellle/targets.vim'

" Nerd tree
Plug 'scrooloose/nerdtree'

let g:NERDTreeMouseMode=1
autocmd vimenter * if !argc() | NERDTree | endif
map <silent> <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']

" Tag list
Plug 'majutsushi/tagbar'
let g:tagbar_autofocus = 1
map <C-t> :TagbarToggle<CR>

let g:python3_host_prog="/usr/bin/python"

" Git signs
Plug 'airblade/vim-gitgutter'
let g:gitgutter_eager = 0 " only update on read/write
let g:gitgutter_sign_column_always = 0

" Tab with buffers
let g:airline#extensions#tabline#enabled = 1

set splitbelow

" gc to comment
Plug 'tomtom/tcomment_vim'

Plug 'justinmk/vim-sneak'

" clipboard management
Plug 'svermeulen/vim-easyclip'
let g:EasyClipDoSystemSync=0

" vv selection
Plug 'gorkunov/smartpairs.vim'
let g:smartpairs_nextpairs_key_i = ''

" Automatic tab detection
Plug 'tpope/vim-sleuth'

" Git commands
Plug 'tpope/vim-fugitive'

" Multiple cursors
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
let g:VM_maps = {}
let g:VM_maps['Find Under'] = '<C-d>'
let g:VM_maps['Find Subword Under'] = '<C-d>'
let g:VM_maps['Find Prev'] = '<C-p>'
let g:VM_maps['Skip Region'] = '<C-x>'
autocmd User visual_multi_mappings imap <buffer><expr> <CR> pumvisible() && complete_info(['selected']).selected != -1 ? "\<C-y>" : "\<Plug>(VM-I-Return)"

Plug 'vim-scripts/bufkill.vim'


" Airline
Plug 'bling/vim-airline'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_powerline_fonts=1
function! s:AirlineAfterTheme()
	hi StatusLine cterm=NONE gui=NONE
	hi StatusLineNC cterm=NONE gui=NONE
	hi StatusLineTerm cterm=NONE gui=NONE
	hi StatusLineTermNC cterm=NONE gui=NONE
endfunction
autocmd User AirlineAfterTheme call s:AirlineAfterTheme()

Plug 'ctrlpvim/ctrlp.vim'

Plug 'ryanoasis/vim-webdevicons'

Plug 'unblevable/quick-scope'

Plug 'saltstack/salt-vim'

Plug 'jplaut/vim-arduino-ino'

Plug 'posva/vim-vue'

"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"let g:deoplete#enable_at_startup = 1

Plug 'Shougo/context_filetype.vim'

"Plug 'zchee/deoplete-jedi'

Plug 'sheerun/vim-polyglot'

Plug 'psliwka/vim-smoothie'
"Plug 'karb94/neoscroll.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': 'master' }

"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'rktjmp/lush.nvim'
Plug 'adisen99/codeschool.nvim'

Plug 'neovim/nvim-lspconfig'

Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}

Plug 'linux-cultist/venv-selector.nvim'

Plug 'stevearc/conform.nvim'

"Plug 'tomtomjhj/coq-lsp.nvim'

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
"  
set foldcolumn=1
set foldmethod=indent
set foldlevel=99

set mouse=a
" set listchars=tab:⇝·,trail:⚠,extends:⇝,precedes:⇜,eol:⚡
" set listchars=tab:⇝·,trail:⚠,extends:⇝,precedes:⇜,eol:▹
set listchars=tab:\ \ ,trail:⚠,extends:⇝,precedes:⇜,eol:▹
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

  "for ruby, autoindent with four spaces, always expand tabs
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
set termguicolors

" Highlight currentline
set cursorline
hi CursorLine term=bold gui=bold cterm=bold guibg=Grey40

:set t_Co=256
:set background=dark

set guifont="DejaVu Sans Mono for Powerline Plus Nerd File Types Mono 10"

if has("gui_running") || has('nvim')
    " colorscheme codeschool
    set foldcolumn=0
endif

lua << EOF
    require('lush')(require('codeschool').setup({
  plugins = {
    "buftabline",
    "coc",
    "cmp", -- nvim-cmp
    "fzf",
    "gitgutter",
    "gitsigns",
    "lsp",
    "lspsaga",
    "nerdtree",
    "netrw",
    "nvimtree",
    "neogit",
    "packer",
    "signify",
    "startify",
    "syntastic",
    "telescope",
    --"treesitter"
  },
  langs = {
    "c",
    "clojure",
    "coffeescript",
    "csharp",
    "css",
    "elixir",
    "golang",
    "haskell",
    "html",
    "java",
    "js",
    "json",
    "jsx",
    "lua",
    "markdown",
    "moonscript",
    "objc",
    "ocaml",
    "purescript",
    "python",
    "ruby",
    "rust",
    "scala",
    "typescript",
    "viml",
    "xml"
  }
}))
EOF

hi NonText ctermfg=64 guifg=#7A7912
hi SpecialKey ctermfg=64 guifg=#7A7912

highlight SignColumn ctermbg=8 guibg=#3E3D32
highlight GitGutterAdd  guifg=#009900 guibg=#3E3D32 ctermfg=2 ctermbg=8
highlight GitGutterChange guifg=#bbbb00 guibg=#3E3D32 ctermfg=3 ctermbg=8
highlight GitGutterDelete  guifg=#ff2222 guibg=#3E3D32 ctermfg=1 ctermbg=8


lua << EOF

vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = "*",
    callback = function()
        for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
            if vim.api.nvim_win_get_config(winid).zindex then
                return
            end
        end
        vim.diagnostic.open_float({
            scope = "cursor",
            focusable = false,
            close_events = {
                "CursorMoved",
                "CursorMovedI",
                "BufHidden",
                "InsertCharPre",
                "WinLeave",
            },
        })
    end
})

EOF

""""""""""""""""
" Key mappings "
""""""""""""""""

map <c-c> <esc>
nnoremap <expr> <CR> &buftype ==# '' ? ':nohlsearch<CR>' : "\<CR>"
"set pastetoggle=<F10>

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

map <Leader><tab> :set shiftwidth=4 expandtab<CR>

"""""""""""""""""
" Misc commands "
"""""""""""""""""

" Sudo write
cmap w!! w !sudo tee % > /dev/null

"""""""""""
" Tab key "
"""""""""""

set completeopt-=preview

au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino
let g:vim_arduino_ino_cmd = 'ano'

:set colorcolumn=80

set iskeyword+=-

lua << EOF

local coq = require "coq"
coq.setup()

vim.lsp.enable('gopls')
vim.lsp.enable('pyright')
vim.lsp.enable('ruff')

vim.keymap.set("n", ",v", "<cmd>VenvSelect<cr>", { desc = "Select Python venv" })
require("venv-selector").setup({ search = {}, options = {} })

require("conform").setup({
  formatters_by_ft = {
    python = { "ruff_fix", "ruff_format" },
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

EOF

nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fc <cmd>Telescope git_commits<cr>
nnoremap <leader>fd <cmd>Telescope lsp_definitions<cr>
nnoremap <leader>fr <cmd>Telescope lsp_references<cr>
nnoremap <leader>f<leader> <cmd>Telescope resume<cr>

highlight link DiagnosticError CodeschoolError
" set ambiwidth=double
