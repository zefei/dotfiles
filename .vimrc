" Plugins
call plug#begin()
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ervandew/supertab'
Plug 'hhvm/vim-hack'
Plug 'jeetsukumaran/vim-markology'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'mitermayer/vim-prettier'
Plug 'rhysd/clever-f.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'wellle/targets.vim'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'zefei/cake16'
Plug 'zefei/nerdtree'
Plug 'zefei/vim-colors-pencil'
Plug 'zefei/vim-colortuner'
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
set hidden
set wildmenu
set wildmode=longest,full
set mouse=
set mousemodel=extend
set autoread
set ttimeoutlen=10
set nostartofline

" UI
syntax on
set ruler
set number
set numberwidth=5
set list listchars=tab:▸\ ,trail:⋅,nbsp:⋅
set noerrorbells
set scrolloff=5
set background=light
colorscheme pencil
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
autocmd FileType yaml setlocal ts=4 sts=4 sw=4 expandtab
set autoindent
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set nowrap
set linebreak
set textwidth=80
set showbreak=

" Folding
set foldenable
set foldmethod=indent
set foldlevelstart=99

" Statusline
set laststatus=2
let &statusline = " %{StatuslineTag()} "
      \."\ue0b1 %<%f "
      \."%{&readonly ? \"\ue0a2 \" : &modified ? '+ ' : ''}"
      \."%=\ue0b3 %{&filetype == '' ? 'unknown' : &filetype} "
      \."\ue0b3 %l:%2c \ue0b3 %p%% "
      \."\ue0b3 %{LinterStatus()} "

let g:wintabs_statusline = "%!MyStatusline()"
function! MyStatusline()
  let vimtabs = wintabs#ui#get_vimtabs_fragment()
  if vimtabs != ''
    let vimtabs = "%#WintabsInactiveSepActive#"
          \.g:wintabs_powerline_sep_tab_transition
          \."%##"
          \.vimtabs
  endif
  return "%#StatusLine#"
        \." ".StatuslineTag()." "
        \."\ue0b1 %<%f "
        \."%{&readonly ? \"\ue0a2 \" : &modified ? '+ ' : ''}"
        \."%=\ue0b3 %{&filetype == '' ? 'unknown' : &filetype} "
        \."\ue0b3 %l:%2c \ue0b3 %p%% "
        \."\ue0b3 ".LinterStatus()." "
        \."%##"
        \.vimtabs
endfunction

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
map <Leader><Leader>H <Plug>(wintabs_move_to_window_left)
map <Leader><Leader>J <Plug>(wintabs_move_to_window_below)
map <Leader><Leader>K <Plug>(wintabs_move_to_window_above)
map <Leader><Leader>L <Plug>(wintabs_move_to_window_right)
map <Leader><Leader>W <Plug>(wintabs_move_to_window_next)
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
noremap <F4> :<C-U>NERDTreeToggle<CR>
inoremap <F4> <ESC>:NERDTreeToggle<CR>
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

" Python
let g:python3_host_prog = substitute(system('which python3'), '\n', '', '')
let g:python_host_prog = substitute(system('which python'), '\n', '', '')

" NERDTree
let g:NERDTreeUseCurrentWindow = 1
let g:NERDTreeCaseSensitiveSort = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMinimalUI = 1
noremap <Leader>\ :<C-U>NERDTreeFind<CR>

" fzf
function! s:find()
  if exists(':MYC')
    execute 'MYC'
  else
    execute 'Files'
  endif
endfunction
noremap <Leader>f :<C-U>call <SID>find()<CR>
noremap <Leader>r :<C-U>History<CR>

" Patching matchparen.vim
autocmd WinLeave * execute '3match none'

" deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
      \'smart_case': v:true,
      \'sources': {'_': ['ale', 'around', 'buffer', 'omni']},
      \})

inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#close_popup() . "\<CR>"
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
highlight! link MarkologyHLl SignColumn
highlight! link MarkologyHLu SignColumn

" wintabs
let g:wintabs_display = 'statusline'
let g:wintabs_autoclose_vimtab = 1
let g:wintabs_switchbuf = 'useopen'
highlight! WintabsInactiveNC ctermfg=243 ctermbg=253 guifg=#767676 guibg=#d9d9d9

" colortuner
let g:colortuner_preferred_schemes = ['cake16', 'ocean16']

" merge conflict motion, borrowed from tpope/vim-unimpaired
noremap [n :<C-U>call <SID>next_conflict(1)<CR>
noremap ]n :<C-U>call <SID>next_conflict(0)<CR>
function! s:next_conflict(reverse)
  call search('^\(@@ .* @@\|[<=>|]\{7}[<=>|]\@!\)', a:reverse ? 'bW' : 'W')
endfunction

" ale
let g:ale_linters = {'hack': ['hack', 'hhast']}
let g:ale_javascript_flow_use_global = 1
let g:ale_lint_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', 'OK']
let g:ale_fixers = { 'javascript': ['prettier'], 'php': ['hackfmt'], 'hack': ['hackfmt'] }
nmap [e <Plug>(ale_previous_wrap)
nmap ]e <Plug>(ale_next_wrap)
function! s:set_fix_on_save()
  if search('\(@format\|@hackfmt-beta\)$', 'nw')
    let b:ale_fix_on_save = 1
  else
    let b:ale_fix_on_save = 0
  endif
endfunction
autocmd BufEnter,BufRead * call <SID>set_fix_on_save()

function! s:lsp_with_fallback(lsp_cmd, fallback_cmd)
  if index(['javascript', 'php', 'hack'], &filetype) >= 0
    execute a:lsp_cmd
  else
    execute a:fallback_cmd
  endif
endfunction
noremap K :<C-U>call <SID>lsp_with_fallback('ALEHover', 'normal! K')<CR>
noremap gd :<C-U>call <SID>lsp_with_fallback('ALEGoToDefinition', 'normal! gd')<CR>

function! LinterStatus()
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? 'OK' : printf(
        \   '%dW %dE',
        \   all_non_errors,
        \   all_errors
        \)
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
set rtp+=/usr/local/share/myc/vim
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
    au FileType c,cabal,cpp,hack,haskell,javascript,php,python,ruby,readme,tex,text,thrift
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
