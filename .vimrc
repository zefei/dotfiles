" Load Pathogen
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

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

" UI
syntax on
set ruler
set number
set numberwidth=5
set mouse=a
set noerrorbells
set visualbell t_vb=
au GUIEnter * set visualbell t_vb=
set so=5
set cursorline
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
set fo=tcroqwanmM
au FileType * setlocal fo-=t
au FileType markdown setlocal fo+=t
set ai
set si
set cindent
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
noremap <TAB> %
nnoremap <LEADER>w <C-W>
nnoremap <LEADER>f <C-F>
nnoremap <LEADER>b <C-B>
nnoremap <LEADER>u <C-U>
nnoremap <LEADER>d <C-D>
nnoremap <LEADER>r <C-R>
nnoremap <SPACE> za
inoremap <C-TAB> <C-X><C-O>
inoremap <C-O> <ESC>o
inoremap <C-A> <ESC>A
" <C-R><TAB>: (snipmate) list all snippets
imap <C-T> <C-R><TAB>
if !SystemIs('mac')
  vnoremap <C-C> y
  vnoremap <C-X> "0d
  vnoremap <C-V> "0p
  inoremap <C-V> <C-O>"0p
  nnoremap <C-Z> u
  inoremap <C-Z> <C-O>u
  nnoremap <C-Y> <C-R>
  inoremap <C-Y> <C-O><C-R>
endif
nnoremap <F1> :bp!<CR>
inoremap <F1> <ESC>:bp!<CR>
nnoremap <F2> :bn!<CR>
inoremap <F2> <ESC>:bn!<CR>
nnoremap <F3> :TagbarToggle<CR>
inoremap <F3> <ESC>:TagbarToggle<CR>
nnoremap <F4> :NERDTreeToggle<CR>
inoremap <F4> <ESC>:NERDTreeToggle<CR>
nnoremap <F5> :nohlsearch<CR>
inoremap <F5> <C-O>:nohlsearch<CR>
nnoremap <F6> :CtrlP<CR>
inoremap <F6> <ESC>:CtrlP<CR>
nnoremap <F8> :confirm bd<CR>
inoremap <F8> <ESC>:confirm bd<CR>
if SystemIs('win')
  nnoremap <F12> :confirm e ~/_vimrc<CR>
  inoremap <F12> <ESC>:confirm e ~/_vimrc<CR>
else
  nnoremap <F12> :confirm e ~/.vimrc<CR>
  inoremap <F12> <ESC>:confirm e ~/.vimrc<CR>
endif

" Commands
command W wa | call Buftabs_show(-1)
command G Gstatus

" NERDTree
let NERDTreeQuitOnOpen=1
let NERDTreeChDirMode=2
let NERDTreeWinSize=40

" SuperTab
let g:SuperTabMappingTabLiteral='<C-`>'

" buftabs
let g:buftabs_only_basename=1
let g:buftabs_in_statusline=1
let g:buftabs_marker_modified=" +"
let g:buftabs_show_number=0
let g:buftabs_blacklist = [ "^NERD_tree_[0-9]*$", "^__Tagbar__$" ]
set laststatus=2
set statusline=\ #{buftabs}%=\ \ Ln\ %-5.5l\ Col\ %-4.4v
let g:buftabs_other_components_length=20
if &t_Co == 256 || has('gui_running')
  let g:buftabs_active_highlight_group="TabLineSel"
endif
let g:buftabs_marker_start=' '
let g:buftabs_marker_end=' '

" Tagbar
let g:tagbar_left = 1
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_width = 40
hi link TagbarKind Directory

" delimitMate
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

" CtrlP
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|\.DS_Store$'

" Patching matchparen.vim
autocmd WinLeave * execute '3match none'
