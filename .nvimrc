" Plugins
call plug#begin()
" Plug 'mileszs/ack.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'rhysd/clever-f.vim'
" Plug 'kien/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'simnalamburt/vim-mundo'
Plug 'othree/html5.vim'
Plug 'matchit.zip'
if has('nvim')
  Plug 'Shougo/deoplete.nvim'
else
  Plug 'Shougo/neocomplete.vim'
endif
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'jeetsukumaran/vim-markology'
Plug 'Shougo/unite.vim'
" Plug 'kchmck/vim-coffee-script'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'flowtype/vim-flow'
" Plug 'tpope/vim-fugitive'
" Plug 'tikhomirov/vim-glsl'
" Plug 'digitaltoad/vim-jade'
" Plug 'groenewege/vim-less'
Plug 'xolox/vim-misc'
" Plug 'vim-ruby/vim-ruby'
Plug 'xolox/vim-session'
Plug 'tpope/vim-unimpaired'
Plug 'Shougo/vimfiler.vim'
Plug 'zefei/cake16'
" Plug 'zefei/vim-colortuner'
" Plug 'zefei/ocean16'
Plug 'zefei/vim-vcprompt'
Plug 'zefei/vim-wintabs'
call plug#end()

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
if !has('nvim')
  set nocompatible
  set encoding=utf-8
endif
filetype plugin indent on
set backspace=2
set nobackup
set nowritebackup
set noswapfile
set history=10000
set showcmd
set fileformats=unix,dos
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
set ttimeoutlen=10

" UI
if !has('nvim')
  set visualbell t_vb=
  autocmd GUIEnter * set visualbell t_vb=
  set t_Co=256
endif
syntax on
set ruler
set number
set numberwidth=5
set list listchars=tab:▸\ ,trail:⋅,nbsp:⋅
set noerrorbells
set scrolloff=5
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
    set guifont=Menlo:h14
    set guifont=Sauce\ Code\ Powerline:h14
  endif
  set antialias
  set guioptions-=m
  set guioptions-=T
  set lines=45
  set columns=100
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
let &statusline .= "%=\ue0b3 %{&filetype == '' ? 'unknown' : &filetype} "
let &statusline .= "\ue0b3 %l:%2c \ue0b3 %p%% "
function! StatuslineTag()
  let session = xolox#session#find_current_session()
  if empty(session) || session == 'default'
    return fnamemodify(getwinvar(0, 'getcwd', getcwd()), ':t')
  else
    return session
  endif
endfunction

" Mappings
let mapleader = ';'
map <TAB> %
noremap <SPACE> za
noremap Q <Nop>
noremap U <Nop>
noremap `` `.
noremap / /\v
noremap <C-P> <C-I>
noremap <C-J> g;
noremap <C-K> g,
noremap ZZ :xa<CR>
noremap ZQ :qa!<CR>
noremap <Leader>a :<C-U>e #<CR>
noremap <Leader>t <C-]>
nmap <Leader>c gcc
vmap <Leader>c gc

noremap H _
noremap L g_
noremap j gj
noremap k gk

noremap y "cy
nnoremap yy "cyy
noremap Y "cy$
noremap p "cp
noremap P "cP
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
inoremap <F4> <ESC>:call <SID>vimfiler_toggle()<CR>
noremap <F5> :<C-U>nohlsearch<CR>:diffoff!<CR>:cclose<CR>
inoremap <F5> <C-O>:nohlsearch<CR><C-O>:diffoff!<CR><C-O>:cclose<CR>
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
    execute 'WintabsClose'
  else
    execute 'VimFiler -toggle'
  endif
endfunction

function! s:vimfiler_settings()
  setlocal nobuflisted
  setlocal colorcolumn=

  nmap <buffer> q :<C-U>call <SID>vimfiler_toggle()<CR>
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
  nmap <buffer> cd :<C-U>VimFilerCurrentDir<CR>
  vmap <buffer> <Space> <Plug>(vimfiler_toggle_mark_selected_lines)
endfunction
autocmd FileType vimfiler call s:vimfiler_settings()

map <Leader>\ :<C-U>VimFiler -toggle -find<CR>

let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_enable_auto_cd = 0
let g:vimfiler_no_default_key_mappings = 1
let g:vimfiler_ignore_pattern = '\%(^\.\|\.pyc$\)'

" CtrlP
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|\.DS_Store$'
let g:ctrlp_switch_buffer = 0
" noremap <Leader>f :<C-U>CtrlP<CR>
" noremap <Leader>r :<C-U>CtrlPMRUFiles<CR>

" fzf
noremap <Leader>f :<C-U>FZF!<CR>
noremap <Leader>r :<C-U>call <SID>fzf_buffers_mru()<CR>

function! s:fzf_buffers_mru()
  let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val)')
  let files = map(buffers, 'bufname(v:val)')
  call extend(files, v:oldfiles)
  let reduced = map(files, 'fnamemodify(v:val, ":~:.")')
  let deduped = filter(copy(reduced), 'index(reduced, v:val) == v:key')
  call fzf#run({'source': deduped, 'sink': 'e', 'options': '+s'})
endfunction

" Patching matchparen.vim
autocmd WinLeave * execute '3match none'

" neocomplete & deoplete
if has('nvim')
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_smart_case = 1
  let g:deoplete#auto_completion_start_length = 3

  autocmd VimEnter * call <SID>deoplete_init()

  function! s:deoplete_init()
    call deoplete#initialize()
    let g:deoplete#sources._ = ['buffer', 'omni']
  endfunction

  inoremap <expr><C-H> deolete#mappings#smart_close_popup()."\<C-H>"
  inoremap <expr><BS> deolete#mappings#smart_close_popup()."\<C-H>"
  inoremap <silent> <CR> <C-R>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return deoplete#mappings#close_popup()."\<CR>"
  endfunction
else
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#min_keyword_length = 3
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#enable_refresh_always = 1

  inoremap <expr><C-H> neocomplete#smart_close_popup()."\<C-H>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-H>"
  inoremap <expr><C-Y>  neocomplete#close_popup()
  inoremap <silent> <CR> <C-R>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return neocomplete#close_popup() . "\<CR>"
  endfunction

  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  " let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
endif

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" autocmd FileType php setlocal omnifunc=hackcomplete#Complete

" html5 syntax
let g:html5_event_handler_attributes_complete = 0
let g:html5_rdfa_attributes_complete = 0
let g:html5_microdata_attributes_complete = 0
let g:html5_aria_attributes_complete = 0

" javascript
" let g:SimpleJsIndenter_BriefMode = 1
let g:jsx_ext_required = 0

" vim sessions
let g:session_autoload = 'no'
let g:session_autosave = 'yes'
let g:session_default_to_last = 0
let g:session_persist_font = 0
let g:session_persist_colors = 0

" Gundo
let g:gundo_help = 0
let g:gundo_close_on_revert = 1
noremap <Leader>u :<C-U>GundoToggle<CR>

" Markology
let g:markology_textlower="m "
let g:markology_textupper=" "
let g:markology_textother=" "
nmap mm <Plug>MarkologyPlaceMarkToggle
nmap mc <Plug>MarkologyClearAll
nmap M <Plug>MarkologyNextLocalMarkPos
highlight link MarkologyHLl SignColumn
highlight link MarkologyHLu Ignore
highlight link MarkologyHLo Ignore

" wintabs
let g:wintabs_ui_sep_leftmost = ' '
let g:wintabs_ui_sep_inbetween = '|'
let g:wintabs_ui_sep_rightmost = ' '
let g:wintabs_ui_active_left = ' '
let g:wintabs_ui_active_right = ' '

" colortuner
let g:colortuner_preferred_schemes = ['cake16', 'ocean16']

" flow
let g:flow#autoclose = 1
let g:flow#enable = 0

" lint
noremap <Leader>l :<C-U>call <SID>lint()<CR>

function! s:lint()
  let extension = expand('%:e')

  if index(['js', 'jsx'], extension) != -1
    FlowMake
  elseif index(['php', 'hhi', 'hh'], extension) != -1
    call hack#typecheck()
  endif
endfunction

" auto session
noremap <Leader>ss :<C-U>call <SID>session_switch_branch()<CR>
noremap <Leader>sc :<C-U>call <SID>session_close()<CR>
noremap <Leader>so :<C-U>call <SID>session_open()<CR>
noremap <Leader>sd :<C-U>DeleteSession<CR>

function! s:session_switch_branch()
  let session = xolox#session#find_current_session()
  let branch = vcprompt#format("%P@%b")

  if !empty(session)
    execute 'silent! SaveSession'
  endif

  if empty(branch) || branch == session
    return
  endif

  if index(xolox#session#get_names(0), branch) == -1
    execute 'silent! CloseSession'
    execute 'silent! SaveSession '.branch
  else
    execute 'silent! OpenSession '.branch
  endif
endfunction

function! s:session_close()
  if !empty(xolox#session#find_current_session())
    execute 'silent! SaveSession'
  endif
  execute 'silent! CloseSession'
endfunction

function! s:session_open()
  if !empty(xolox#session#find_current_session())
    execute 'silent! SaveSession'
  endif
  execute 'OpenSession'
endfunction