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
NeoBundle 'zefei/cake16'
NeoBundle 'zefei/ocean16'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'sjl/gundo.vim'
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
NeoBundle 'xolox/vim-misc'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'xolox/vim-session'
NeoBundle 'zefei/vim-wintabs'
NeoBundle 'tpope/vim-rsi'
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
function! s:system_is(sys)
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
set nowritebackup
set noswapfile
set history=10000
set showcmd
set fileformats=unix,dos
set encoding=utf-8
if s:system_is('win')
  set undodir=~/_vimundo
else
  set undodir=~/.vimundo
endif
set undofile
let &fillchars="vert:\u2758"
set hidden
set wildmenu
set wildmode=longest,full
set mousemodel=extend
set autoread

" UI
syntax on
set ruler
set number
set numberwidth=5
set list listchars=tab:▸\ ,trail:⋅,nbsp:⋅
set noerrorbells
set visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
set scrolloff=5
set t_Co=256
colorscheme cake16
set splitright splitbelow
autocmd VimEnter,WinEnter * call s:active_ui()
autocmd WinLeave * call s:inactive_ui()
function! s:active_ui()
  set cursorline
  set colorcolumn=+1
endfunction
function! s:inactive_ui()
  set nocursorline
  set colorcolumn=
endfunction

" GUI
if has('gui_running')
  if s:system_is('win')
    set guifont=Consolas:h12
  elseif s:system_is('linux')
    set guifont=Monospace\ 12
  elseif s:system_is('mac')
    set guifont=Menlo:h16
    set guifont=Menlo\ Regular\ for\ Powerline:h16
  endif
  set antialias
  set guioptions-=m
  set guioptions-=T
  set lines=45
  set columns=100
  set linespace=2
endif

" Searching
set ignorecase
set smartcase
set showmatch
set mat=0
set hlsearch
set incsearch
set gdefault

" Formatting
set formatoptions=crqwnmMj
autocmd FileType text,markdown,help setlocal formatoptions+=t
set autoindent
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set wrap
set linebreak
set textwidth=80
set showbreak=

" Folding
set foldenable
set foldmethod=indent
set foldlevelstart=99

" Statusline
set laststatus=2
autocmd BufWinEnter,WinEnter,VimEnter * let w:getcwd = getcwd()
let &statusline = " %{StatuslineTag()} "
let &statusline .= "\ue0b1 %<%f "
let &statusline .= "%{&readonly ? \"\ue0a2 \" : &modified ? '+ ' : ''}"
let &statusline .= "%=\u2571 %{&filetype == '' ? 'unknown' : &filetype} "
let &statusline .= "\u2571 %l:%2c \u2571 %p%% "
function! StatuslineTag()
  if exists('b:git_dir')
    let dir = fnamemodify(b:git_dir[:-6], ':t')
    return dir." \ue0a0 ".fugitive#head(7)
  else
    return fnamemodify(getwinvar(0, 'getcwd', getcwd()), ':t')
  endif
endfunction

" Mappings
let mapleader = ';'
map <TAB> %
noremap <SPACE> za
noremap Q <Nop>
noremap U <Nop>
noremap , ;
noremap m ,
noremap M m
noremap `` `.
noremap / /\v
noremap <C-P> <C-I>
noremap <C-J> g;
noremap <C-K> g,

noremap H g^
noremap L g$
noremap j gj
noremap k gk

noremap y "+y
nnoremap yy "+yy
noremap Y "+y$
noremap p "+p
noremap P "+P
noremap d "dd
nnoremap dd "ddd
noremap D "dD
noremap x "dx
noremap X "dX
noremap <Leader>p "dp
noremap <Leader>P "dP
inoremap <C-R> <C-R>"

noremap <Leader><Leader> <C-W>
map <Leader><Leader>c <Plug>(wintabs_close_window)
map <Leader><Leader>q <Plug>(wintabs_close_window)
map <Leader><Leader>o <Plug>(wintabs_only_window)
map <Leader><Leader>T <Plug>(wintabs_maximize)
map <Leader>q <Plug>(wintabs_close)
map <Leader>o <Plug>(wintabs_only)
noremap <Leader>a :<C-U>e #<CR>
noremap <Leader>s :<C-U>%s//
noremap <Leader>f :<C-U>CtrlP<CR>
noremap <Leader>b :<C-U>CtrlPBuffer<CR>
nmap <Leader>c gcc
vmap <Leader>c gc
noremap <Leader>u :<C-U>GundoToggle<CR>

map <Leader>1 <Plug>(wintabs_tab_1)
map <Leader>2 <Plug>(wintabs_tab_2)
map <Leader>3 <Plug>(wintabs_tab_3)
map <Leader>4 <Plug>(wintabs_tab_4)
map <Leader>5 <Plug>(wintabs_tab_5)
map <Leader>6 <Plug>(wintabs_tab_6)
map <Leader>7 <Plug>(wintabs_tab_7)
map <Leader>8 <Plug>(wintabs_tab_8)
map <Leader>9 <Plug>(wintabs_tab_9)

map <F1> <Plug>(wintabs_previous)
imap <F1> <Esc><Plug>(wintabs_previous)
map <C-F1> <Plug>(wintabs_move_left)
imap <C-F1> <C-O><Plug>(wintabs_move_left)
map <F2> <Plug>(wintabs_next)
imap <F2> <Esc><Plug>(wintabs_next)
map <C-F2> <Plug>(wintabs_move_right)
imap <C-F2> <C-O><Plug>(wintabs_move_right)
noremap <F3> :<C-U>Gstatus<CR>
inoremap <F3> <Esc>:Gstatus<CR>
noremap <F4> :<C-U>call <SID>vimfiler_toggle()<CR>
inoremap <F4> <Esc>:call <SID>vimfiler_toggle()<CR>
noremap <F5> :<C-U>nohlsearch<CR>:diffoff!<CR>
inoremap <F5> <C-O>:nohlsearch<CR><C-O>:diffoff!<CR>
nnoremap <F6> gggqG<C-O><C-O>
inoremap <F6> <ESC>gggqG<C-O><C-O>a

noremap <F11> :<C-U>echo "hi<"
      \ . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

if s:system_is('win')
  noremap <F12> :<C-U>e ~/_vimrc<CR>
  inoremap <F12> <Esc>:e ~/_vimrc<CR>
else
  noremap <F12> :<C-U>e ~/.vimrc<CR>
  inoremap <F12> <Esc>:e ~/.vimrc<CR>
endif

" auto commands
autocmd BufNewFile,BufRead *.json set filetype=javascript
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.hbs set filetype=html
autocmd FileType vim setlocal keywordprg=:help

" Commands
command! Ws w | source %
command! Single set columns=100
command! Double set columns=180
function! s:cabbrev(cmd, new_cmd)
  execute "cabbrev ".a:cmd." <C-R>=(getcmdtype()==':' && getcmdpos()==1 ? '".a:new_cmd."' : '".a:cmd."')<CR>"
endfunction
call s:cabbrev('ws', 'Ws')
call s:cabbrev('all', 'WintabsAll')
call s:cabbrev('tabc', 'WintabsCloseVimtab')
call s:cabbrev('tabo', 'WintabsOnlyVimtab')

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
  setlocal colorcolumn=

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
inoremap <expr><C-H> neocomplete#smart_close_popup()."\<C-H>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-H>"
inoremap <expr><C-Y>  neocomplete#close_popup()
inoremap <silent> <CR> <C-R>=<SID>my_cr_function()<CR>
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

" vim sessions
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'

" Gundo
let g:gundo_help = 0
let g:gundo_close_on_revert = 1

" wintabs
let g:wintabs_ui_sep_leftmost = ' '
let g:wintabs_ui_sep_inbetween = '|'
let g:wintabs_ui_sep_rightmost = ' '
let g:wintabs_ui_active_left = ' '
let g:wintabs_ui_active_right = ' '
