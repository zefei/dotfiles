" Setup Vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Bundles
Bundle 'gmarik/vundle'
Bundle 'Auto-Pairs'
Bundle 'zefei/buftabs'
Bundle 'kien/ctrlp.vim'
Bundle 'othree/html5.vim'
Bundle 'matchit.zip'
Bundle 'Shougo/neocomplcache'
Bundle 'scrooloose/nerdtree'
Bundle 'zefei/simple-dark'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'groenewege/vim-less'
Bundle 'tpope/vim-rails'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-unimpaired'

" Functions
function! SystemIs(sys)
  if a:sys == 'win'
    return has('win32')
  elseif a:sys == 'linux'
    return has('unix') && matchstr(system('uname'), 'Darwin') != 'Darwin'
  elseif a:sys == 'mac'
    return has('unix') && matchstr(system('uname'), 'Darwin') == 'Darwin'
  endif
endfunction

" General
set nocompatible
filetype plugin indent on
set backspace=2
set clipboard=unnamed
set nobackup
set nowb
set noswapfile
set history=50
set showcmd
set ffs=unix,dos
set encoding=utf-8
if SystemIs('win')
  set undodir=~/_vimundo
else
  set undodir=~/.vimundo
endif
set undofile
set fillchars=vert:\ 
set hidden

" UI
syntax on
set ruler
set number
set numberwidth=5
set mouse=a
set list listchars=tab:▸\ ,trail:⋅,nbsp:⋅
set noerrorbells
set visualbell t_vb=
au GUIEnter * set visualbell t_vb=
set so=5
set cursorline
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif
colorscheme simple-dark

" Searching
set ignorecase
set smartcase
set showmatch
set mat=0
set hlsearch
set incsearch
set gdefault

" Formatting
set fo=croqwanmM
au FileType text,markdown setlocal fo+=t
set ai
set si
set cindent
au FileType text,markdown set nocindent
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set wrap
set linebreak
set textwidth=80
set showbreak=>>>\ 
set cc=+1

" Folding
set foldenable
set foldmethod=indent
set foldnestmax=5
set foldlevel=5

" Mappings
let mapleader = ';'
noremap j gj
noremap k gk
noremap / /\v
nnoremap Y y$
map <TAB> %
noremap <LEADER>w <C-W>
noremap <LEADER>j <C-F>
noremap <LEADER>k <C-B>
noremap <LEADER>h ^
noremap <LEADER>l $
nnoremap <LEADER>f :CtrlP<CR>
nnoremap <LEADER>b :CtrlPBuffer<CR>
nnoremap <LEADER>q :confirm bd<CR>
nnoremap <LEADER>a :b #<CR>
nnoremap <SPACE> za
inoremap <C-TAB> <C-X><C-O>
nnoremap <F1> :bp<CR>
inoremap <F1> <ESC>:bp<CR>
nnoremap <F2> :bn<CR>
inoremap <F2> <ESC>:bn<CR>
nnoremap <F3> :Gstatus<CR>
inoremap <F3> <ESC>:Gstatus<CR>
nnoremap <F4> :NERDTreeToggle<CR>
inoremap <F4> <ESC>:NERDTreeToggle<CR>
nnoremap <F5> :nohlsearch<CR>:diffoff!<CR> 
inoremap <F5> <C-O>:nohlsearch<CR><C-O>:diffoff!<CR>
nnoremap <F8> :confirm bd<CR>
inoremap <F8> <ESC>:confirm bd<CR>

nnoremap <F11> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

if SystemIs('win')
  nnoremap <F12> :e ~/_vimrc<CR>
  inoremap <F12> <ESC>:e ~/_vimrc<CR>
else
  nnoremap <F12> :e ~/.vimrc<CR>
  inoremap <F12> <ESC>:e ~/.vimrc<CR>
endif

" auto commands
autocmd BufNewFile,BufRead *.json set filetype=javascript
autocmd BufNewFile,BufRead *.md set filetype=markdown

" Commands
command W wa | call Buftabs_show(-1)
command G Gstatus

" NERDTree
let NERDTreeQuitOnOpen=1
let NERDTreeChDirMode=2
let NERDTreeWinSize=40

" buftabs
let g:buftabs_only_basename=1
let g:buftabs_marker_modified=" +"
let g:buftabs_show_number=0
let g:buftabs_blacklist = ["^NERD_tree_[0-9]*$", "^__Tagbar__$"]
set laststatus=2
set statusline=\ #{buftabs}%=\ \ Ln\ %-5.5l\ Col\ %-4.4v
let g:buftabs_other_components_length=20
if &t_Co == 256 || has('gui_running')
  let g:buftabs_active_highlight_group="TabLineSel"
  let g:buftabs_marker_start=' '
  let g:buftabs_marker_end=' '
endif

" CtrlP
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|\.DS_Store$'

" Patching matchparen.vim
autocmd WinLeave * execute '3match none'

" neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" html5 syntax
let g:html5_event_handler_attributes_complete = 0
let g:html5_rdfa_attributes_complete = 0
let g:html5_microdata_attributes_complete = 0
let g:html5_aria_attributes_complete = 0
