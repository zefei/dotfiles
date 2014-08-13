" Setup NeoBundle
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Bundles
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'zefei/buftabs'
NeoBundle 'zefei/cake16'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'othree/html5.vim'
NeoBundle 'matchit.zip'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'zefei/simple-javascript-indenter'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'b4winckler/vim-angry'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tikhomirov/vim-glsl'
NeoBundle 'michaeljsmith/vim-indent-object'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'groenewege/vim-less'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
call neobundle#end()

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
set wildmenu

" UI
syntax on
set ruler
set number
set numberwidth=5
set list listchars=tab:▸\ ,trail:⋅,nbsp:⋅
set noerrorbells
set visualbell t_vb=
au GUIEnter * set visualbell t_vb=
set so=5
set cursorline
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif
colorscheme cake16

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
set autoindent
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
set foldlevelstart=99

" Mappings
let mapleader = ';'
noremap Q <Nop>
noremap H g^
noremap L g$
noremap j gj
noremap k gk
inoremap <C-A> <C-O>g^
inoremap <C-E> <C-O>g$
noremap U <C-R>
noremap , ;
noremap m ,
noremap M m
noremap `` `.
noremap / /\v
noremap y "+y
nnoremap yy "+yy
noremap Y "+y$
noremap x "+d
nnoremap xx "+dd
noremap X "+D
noremap p "+p
noremap P "+P
inoremap <C-R> <C-R>"
map <TAB> %
noremap <LEADER><LEADER> <C-W>
noremap <LEADER>h ^
noremap <LEADER>l $
noremap <LEADER>q :<C-U>confirm bd<CR>
noremap <LEADER>a :<C-U>b #<CR>
noremap <LEADER>f :<C-U>CtrlP<CR>
nmap <LEADER>c gcc
vmap <LEADER>c gc
noremap <SPACE> za
noremap <F1> :<C-U>bp<CR>
inoremap <F1> <ESC>:bp<CR>
noremap <F2> :<C-U>bn<CR>
inoremap <F2> <ESC>:bn<CR>
noremap <F3> :<C-U>Gstatus<CR>
inoremap <F3> <ESC>:Gstatus<CR>
noremap <F4> :<C-U>call <SID>vimfiler_toggle()<CR>
inoremap <F4> <ESC>:call <SID>vimfiler_toggle()<CR>
noremap <F5> :<C-U>nohlsearch<CR>:diffoff!<CR>
inoremap <F5> <C-O>:nohlsearch<CR><C-O>:diffoff!<CR>

noremap <F11> :<C-U>echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

if SystemIs('win')
  noremap <F12> :<C-U>e ~/_vimrc<CR>
  inoremap <F12> <ESC>:e ~/_vimrc<CR>
else
  noremap <F12> :<C-U>e ~/.vimrc<CR>
  inoremap <F12> <ESC>:e ~/.vimrc<CR>
endif

" auto commands
autocmd BufNewFile,BufRead *.json set filetype=javascript
autocmd BufNewFile,BufRead *.md set filetype=markdown

" Commands
command! W wa | call Buftabs_show(-1)
let ws = 'w | source %'
cabbrev ws <C-R>=(getcmdtype()==':' && getcmdpos()==1 ? ws : 'ws')<CR>

" vimfiler
function! s:vimfiler_toggle()
  if &filetype == 'vimfiler'
    execute 'silent! buffer #'
    if &filetype == 'vimfiler'
      execute 'enew'
    endif
  elseif exists('t:vimfiler_buffer') && bufexists(t:vimfiler_buffer)
    execute 'buffer ' . t:vimfiler_buffer
  else
    execute 'VimFilerCreate'
    let t:vimfiler_buffer = @%
  endif
endfunction

function! s:vimfiler_settings()
  setlocal nobuflisted

  nmap <buffer> q :call <SID>vimfiler_toggle()<CR>
  nmap <buffer> <ENTER> o
  nmap <buffer> <expr> o vimfiler#smart_cursor_map("\<Plug>(vimfiler_expand_tree)", "\<Plug>(vimfiler_edit_file)")
  nmap <buffer> <expr> C vimfiler#smart_cursor_map("\<Plug>(vimfiler_cd_file)", "")
  nmap <buffer> j <Plug>(vimfiler_loop_cursor_down)
  nmap <buffer> k <Plug>(vimfiler_loop_cursor_up)
  nmap <buffer> gg <Plug>(vimfiler_cursor_top)
  nmap <buffer> R <Plug>(vimfiler_redraw_screen)
  nmap <buffer> <SPACE> <Plug>(vimfiler_toggle_mark_current_line)
  nmap <buffer> U <Plug>(vimfiler_clear_mark_all_lines)
  nmap <buffer> cp <Plug>(vimfiler_copy_file)
  nmap <buffer> mv <Plug>(vimfiler_move_file)
  nmap <buffer> rm <Plug>(vimfiler_delete_file)
  nmap <buffer> mk <Plug>(vimfiler_make_directory)
  nmap <buffer> e <Plug>(vimfiler_new_file)
  nmap <buffer> u <Plug>(vimfiler_switch_to_parent_directory)
  nmap <buffer> . <Plug>(vimfiler_toggle_visible_ignore_files)
  nmap <buffer> I <Plug>(vimfiler_toggle_visible_ignore_files)
  nmap <buffer> yy <Plug>(vimfiler_yank_full_path)
  nmap <buffer> cd <Plug>(vimfiler_cd_vim_current_dir)
  vmap <buffer> <Space> <Plug>(vimfiler_toggle_mark_selected_lines)
endfunction
autocmd FileType vimfiler call s:vimfiler_settings()

let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_enable_auto_cd = 1
let g:vimfiler_no_default_key_mappings = 1

" buftabs
let g:buftabs_only_basename=1
let g:buftabs_marker_modified=" +"
let g:buftabs_show_number=0
set laststatus=2
set statusline=\ #{buftabs}%=\ \ Ln\ %-5.5l\ Col\ %-4.4v
let g:buftabs_other_components_length=20
let g:buftabs_active_highlight_group="TabLineSel"
let g:buftabs_marker_start=' '
let g:buftabs_marker_end=' '

" CtrlP
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|\.DS_Store$'

" Patching matchparen.vim
autocmd WinLeave * execute '3match none'

" neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#min_keyword_length = 3
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#enable_refresh_always = 1

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
endfunction

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

" javascript indent
let g:SimpleJsIndenter_BriefMode = 1
