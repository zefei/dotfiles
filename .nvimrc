" Plugins
call plug#begin()
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'ervandew/supertab'
Plug 'jeetsukumaran/vim-markology'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'mitermayer/vim-prettier'
Plug 'mxw/vim-jsx'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'rhysd/clever-f.vim'
Plug 'steelsojka/deoplete-flow'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'vim-scripts/matchit.zip'
Plug 'w0rp/ale'
Plug 'wellle/targets.vim'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'zefei/cake16'
Plug 'zefei/deoplete-hack'
Plug 'zefei/vim-colortuner'
Plug 'zefei/vim-flow'
Plug 'zefei/vim-hack'
Plug 'zefei/vim-vcprompt'
Plug 'zefei/vim-wintabs'
Plug 'zefei/vim-wintabs-powerline'
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
let &fillchars="vert:\u2758,stl: ,stlnc: "
set hidden
set wildmenu
set wildmode=longest,full
set mouse=a
set mousemodel=extend
set autoread
set ttimeoutlen=10
let g:python3_host_prog = '/opt/homebrew/bin/python3'
" set clipboard+=unnamedplus

" UI
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
if has('termguicolors')
  set termguicolors
endif

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
let statusline_display = 'tabline'
let statusline = " %{StatuslineTag()} "
      \."\ue0b1 %<%f "
      \."%{&readonly ? \"\ue0a2 \" : &modified ? '+ ' : ''}"
      \."%=\ue0b3 %{&filetype == '' ? 'unknown' : &filetype} "
      \."\ue0b3 %l:%2c \ue0b3 %p%% "
      \."\ue0b3 %{ALEStatusline()} "

if statusline_display == 'tabline'
  let g:wintabs_display = 'statusline'
  set showtabline=2
  hi TabLineStatusLine guifg=bg guibg=#678797 ctermfg=bg ctermbg=12
  let &tabline = '%#TabLineStatusLine#'.statusline.'%##'
  augroup set_tabline
    autocmd!
    autocmd InsertEnter,InsertLeave,CursorMoved,CursorMovedI * :let &ro=&ro
  augroup END
  hi WildMenu guifg=bg guibg=#678797 ctermfg=bg ctermbg=12
else
  let g:wintabs_display = 'tabline'
  set laststatus=2
  let &statusline = statusline
  augroup set_tabline
    autocmd!
  augroup END
endif

augroup set_window_getcwd
  autocmd!
  autocmd BufWinEnter,WinEnter,VimEnter * let w:getcwd = getcwd()
augroup END

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
map <Leader>Q <Plug>(wintabs_undo)
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
map <Leader><F1> <Plug>(wintabs_move_left)
map <F2> <Plug>(wintabs_next)
imap <F2> <Esc><Plug>(wintabs_next)
map <Leader><F2> <Plug>(wintabs_move_right)
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

nnoremap [t :<C-U>tabprevious<CR>
nnoremap ]t :<C-U>tabnext<CR>

" auto commands
autocmd BufNewFile,BufRead *.json set filetype=javascript
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.hbs set filetype=html
autocmd FileType vim setlocal keywordprg=:help

" Commands
command! Ws w | source %
command! ProfileStart profile start profile.log | profile func * | profile file *
command! ProfileExit profile pause | noautocmd qall!
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
  nmap <buffer> s <Plug>(vimfiler_split_edit_file)
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

" fzf
noremap <Leader>f :<C-U>Files<CR>
noremap <Leader>r :<C-U>History<CR>

" Patching matchparen.vim
autocmd WinLeave * execute '3match none'

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_completion_start_length = 3

inoremap <expr><C-H> deolete#mappings#smart_close_popup()."\<C-H>"
inoremap <expr><BS> deolete#mappings#smart_close_popup()."\<C-H>"
inoremap <silent> <CR> <C-R>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return deoplete#mappings#close_popup()."\<CR>"
endfunction

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" supertab
let g:SuperTabDefaultCompletionType = "<C-N>"

" html5 syntax
let g:html5_event_handler_attributes_complete = 0
let g:html5_rdfa_attributes_complete = 0
let g:html5_microdata_attributes_complete = 0
let g:html5_aria_attributes_complete = 0

" javascript
let g:jsx_ext_required = 0

" vim sessions
let g:session_autoload = 'no'
let g:session_autosave = 'yes'
let g:session_default_to_last = 0
let g:session_persist_font = 0
let g:session_persist_colors = 0

" undotree
let g:undotree_SetFocusWhenToggle = 1
noremap <Leader>u :<C-U>UndotreeToggle<CR>

" Markology
let g:markology_textlower = "m "
let g:markology_textupper = "\t "
let markology_include = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
nmap mm <Plug>MarkologyPlaceMarkToggle
nmap mc <Plug>MarkologyClearAll
nmap M <Plug>MarkologyNextLocalMarkPos
highlight link MarkologyHLl SignColumn
highlight link MarkologyHLu SignColumn

" wintabs
let g:wintabs_autoclose_vimtab = 1
let g:wintabs_switchbuf = 'useopen'
let g:wintabs_powerline_higroup_empty = 'StatusLineNC'

" colortuner
let g:colortuner_preferred_schemes = ['cake16', 'ocean16']

" flow
let g:flow#autoclose = 1
let g:flow#enable = 0

" go to definition
noremap gd :<C-U>call <SID>go_to_definition()<CR>
function! s:go_to_definition()
  if &filetype =~ 'javascript'
    FlowJumpToDef
  elseif &filetype =~ 'php'
    HackGotoDef
  else
    normal! gd
  endif
endfunction

" get type info
noremap K :<C-U>call <SID>get_help()<CR>
function! s:get_help()
  if &filetype =~ 'javascript'
    FlowType
  elseif &filetype =~ 'php'
    HackType
  else
    normal! K
  endif
endfunction

" merge conflict motion, borrowed from tpope/vim-unimpaired
noremap [n :<C-U>call <SID>next_conflict(1)<CR>
noremap ]n :<C-U>call <SID>next_conflict(0)<CR>
function! s:next_conflict(reverse)
  call search('^\(@@ .* @@\|[<=>|]\{7}[<=>|]\@!\)', a:reverse ? 'bW' : 'W')
endfunction

" ale
let g:ale_javascript_flow_use_global = 1
let g:ale_lint_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', 'OK']
nmap [e <Plug>(ale_previous_wrap)
nmap ]e <Plug>(ale_next_wrap)

" copy-pasta from ale since it's deprecated
function! ALEStatusline()
  let [l:error_format, l:warning_format, l:no_errors] = g:ale_statusline_format
  let l:counts = ale#statusline#Count(bufnr('%'))

  " Build strings based on user formatting preferences.
  let l:errors = l:counts[0] ? printf(l:error_format, l:counts[0]) : ''
  let l:warnings = l:counts[1] ? printf(l:warning_format, l:counts[1]) : ''

  " Different formats based on the combination of errors and warnings.
  if empty(l:errors) && empty(l:warnings)
    let l:res = l:no_errors
  elseif !empty(l:errors) && !empty(l:warnings)
    let l:res = printf('%s %s', l:errors, l:warnings)
  else
    let l:res = empty(l:errors) ? l:warnings : l:errors
  endif

  return l:res
endfunction

function! s:set_eslint_rulesdir()
  if &filetype !~ 'javascript'
    return
  endif
  let rulesdir = finddir('js/eslint_rules', fnamemodify(expand('<afile>'), ':p').';')
  let g:ale_javascript_eslint_options = empty(rulesdir) ? '' : '--rulesdir '.rulesdir
endfunction
autocmd BufEnter,BufRead * call <SID>set_eslint_rulesdir()

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
    execute 'silent! OpenSession! '.branch
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
  execute 'OpenSession!'
endfunction

" fb specifics
let g:hack#enable = 0
let g:fb_default_opts = 0
try
  " Kill any trailing whitespace on save.
  if !exists("g:fb_kill_whitespace") | let g:fb_kill_whitespace = 1 | endif
  if g:fb_kill_whitespace
    fu! <SID>StripTrailingWhitespaces()
      let l = line(".")
      let c = col(".")
      %s/\s\+$//e
      call cursor(l, c)
    endfu
    au FileType c,cabal,cpp,haskell,javascript,php,python,ruby,readme,tex,text,thrift
      \ au BufWritePre <buffer>
      \ :call <SID>StripTrailingWhitespaces()
  endif

  " Automatically load svn-commit template.
  if !exists("g:fb_svn_template") | let g:fb_svn_template = 1 | endif
  if g:fb_svn_template
    if $SVN_COMMIT_TEMPLATE == ""
      let $SVN_COMMIT_TEMPLATE = "$ADMIN_SCRIPTS/templates/svn-commit-template.txt"
    endif
    autocmd BufNewFile,BufRead svn-commit.*tmp :0r $SVN_COMMIT_TEMPLATE
  endif
catch
endtry
