" Bootup
if has('vim_starting')
  set nocompatible               " Be iMproved
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Bundles
NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'honza/vim-snippets'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/unite-help'
NeoBundle 'Shougo/unite-session'

NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-fugitive'

NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'

NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'tomasr/molokai'
NeoBundle 'jeetsukumaran/vim-markology'
NeoBundle 'bling/vim-airline'
NeoBundle 'bling/vim-bufferline'
NeoBundle 'chrisbra/SudoEdit.vim'
NeoBundle 'jmcantrell/vim-virtualenv'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'justinmk/vim-sneak'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'nvie/vim-flake8'
NeoBundle 'rking/ag.vim'
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-unite-history'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'vim-scripts/ZoomWin'
NeoBundle 'vim-scripts/vimwiki'
NeoBundle 'voithos/vim-python-matchit'
NeoBundle 'gregsexton/MatchTag'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'godlygeek/tabular'
"NeoBundle 'tsaleh/vim-matchit'
NeoBundle 'vim-scripts/matchit.zip'
NeoBundle 'vim-scripts/bufkill.vim'
NeoBundleCheck

" Bufferline
let g:bufferline_echo = 0
autocmd VimEnter *
  \ let &statusline='%{bufferline#refresh_status()}'
  \ .bufferline#get_status_string()

" Indent Guides
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2

" UNITE
" Use ag for search
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

" Use the fuzzy matcher for everything
call unite#filters#matcher_default#use(['matcher_fuzzy'])
" Use the rank sorter for everything
call unite#filters#sorter_default#use(['sorter_rank'])

let g:unite_source_grep_max_candidates = 1000
" Set up some custom ignores
call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
  \ 'ignore_pattern', join([
  \ '\.git/',
  \ ], '\|'))

" Map space to the prefix for Unite
nmap <space> [unite]
" General fuzzy search
nnoremap <silent> [unite]<space> :<C-u>Unite -buffer-name=files buffer file_mru bookmark file_rec/async<CR>
" Quick registers
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
" Quick buffer 
nnoremap <silent> [unite]u :<C-u>Unite -buffer-name=buffers -quick-match buffer<CR>
" Quick yank history
nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<CR>
" Quick outline
nnoremap <silent> [unite]o :<C-u>Unite -buffer-name=outline -vertical outline<CR>
" Quick sessions (projects)
nnoremap <silent> [unite]p :<C-u>Unite -buffer-name=sessions session<CR>
" Quick sources
nnoremap <silent> [unite]a :<C-u>Unite -buffer-name=sources source<CR>
" Quick snippet
nnoremap <silent> [unite]s :<C-u>Unite -buffer-name=snippets neosnippet<CR>
" Quickly switch lcd
nnoremap <silent> [unite]d :<C-u>Unite -buffer-name=change-cwd -default-action=lcd directory_mru<CR>
" Quick file search
nnoremap <silent> [unite]f :<C-u>Unite -buffer-name=files file_rec/async<CR>
" Quick grep from cwd
nnoremap <silent> [unite]g :<C-u>Unite -buffer-name=grep grep:.<CR>
" Quick help
nnoremap <silent> [unite]h :<C-u>Unite -buffer-name=help help<CR>
" Quick line using the word under cursor
nnoremap <silent> [unite]l :<C-u>UniteWithCursorWord -buffer-name=search_file line<CR>
" Quick MRU search
nnoremap <silent> [unite]m :<C-u>Unite -buffer-name=mru file_mru<CR>
" Quick find
nnoremap <silent> [unite]n :<C-u>Unite -buffer-name=find find:.<CR>
" Quick commands
nnoremap <silent> [unite]c :<C-u>Unite -buffer-name=commands -quick-match command<CR>
" Quick bookmarks
nnoremap <silent> [unite]b :<C-u>Unite -buffer-name=bookmarks bookmark<CR>
" Fuzzy search from current buffer
" nnoremap <silent> [unite]b :<C-u>UniteWithBufferDir
" \ -buffer-name=files -prompt=%\ buffer file_mru bookmark file<CR>

" Quick commands
nnoremap <silent> [unite]; :<C-u>Unite -buffer-name=history -quick-match history/command command<CR>
" Custom Unite settings
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  nmap <buffer> <ESC> <Plug>(unite_exit)
  imap <buffer> <ESC> <Plug>(unite_exit)
  imap <buffer> jj <Plug>(unite_insert_leave)
  nmap <C-c> <Plug>(unite_exit)
  imap <buffer> <C-w> <Plug>(unite_delete_backward_word)
endfunction

" Start in insert mode
let g:unite_enable_start_insert = 1
" Enable history yank source
let g:unite_source_history_yank_enable = 1
" Open in bottom right
let g:unite_split_rule = "botright"
" Shorten the default update date of 500ms
let g:unite_update_time = 200
let g:unite_source_file_mru_limit = 1000

" Ctrl-e: Find (e)verything
" nmap <c-e> [unite]f
" Ctrl-r: Command history using Unite, this matches my muscle memory in zsh
" nmap <c-r> [unite];
" Ctrl-y: Yanks
" nmap <c-y> [unite]y
" Ctrl-p: Find MRU and buffers
" nmap <c-p> [unite]u
" Ctrl-\: Quick outline
" nmap <silent> <c-\> [unite]o

" Hide HLS
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Custom Mappings
" Set pastetoggle key
set pt=<F2>
" Pyclewn keys
map <F8> :Cfile expand('%:p') <Bar> Cbreak main <Bar> Crun <CR>
" Taglist
nmap <F3> :Tagbar<CR>
" Ergonomic ESCAPE
imap jj <Esc>
" Opposite of <S-j>
nmap <A-S-j> i<CR><Esc>
" Like o and O but stay in normal mode
nnoremap <A-S-o> m`O<Esc>``
nnoremap <A-o> m`o<Esc>``

" Alt Space for toggling/and creating folds
imap <C-Space> <C-O>za
nmap <C-Space> za
vmap <C-Space> zf
nmap <S-Space> zd
"
" one donw in insert
inoremap <C-j> <Down>

" Window and tab navigation:
nmap	<C-Tab>     :tabnext<CR>
nmap	<C-S-Tab>	:tabprevious<CR>
imap	<C-Tab>	    <C-o>:tabnext<CR>
imap	<C-S-Tab>	<C-o>:tabprevious<CR>

nmap	<M-l>	<C-w>l
nmap	<M-h>	<C-w>h
imap	<M-l>	<C-o><C-w>l<CR>
imap	<M-h>	<C-o><C-w>h<CR>
nmap	<M-j>	<C-w>j
nmap	<M-k>	<C-w>k
imap	<M-j>	<C-o><C-w>j
imap	<M-k>	<C-o><C-w>k

" Toggles and Switches
filetype plugin indent on
syntax enable
set cryptmethod=blowfish
set complete-=i
set showmatch
set smarttab
set nrformats-=octal
set shiftround
set ttimeout
set ttimeoutlen=50
set tabstop=4			" set tab to 4 spaces
set shiftwidth=2		" set shiftwidth to 4 spaces
set softtabstop=2		" set shiftwidth to 4 spaces
set expandtab
set background=dark	" set background to dark
set autowrite			" Automatically save before commands like :next and :make
set autoread
set laststatus=2
set wildmenu
set scrolloff=1
set sidescrolloff=5
set display+=lastline
set cursorline
set nocursorcolumn
set foldcolumn=3
" incsearch	show match for partly typed search command
set is
" ignorecase	ignore case when using a search pattern
set ic
" smartcase	override 'ignorecase' when pattern has upper case characters
set scs 
"wrap	long lines wrap
set nowrap
" hlsearch higlight all matches for the last used search pattern
set hls
" mouse	list of flags for using the mouse
set mouse=a
" showcmd	show (partial) command keys in the status line
set showcmd			" Show (partial) command in status line.
" ruler	show cursor position below each window
set ru
" visualbell	use a visual bell instead of beeping
set vb			
" autoindent	automatically set the indent of a new line
set ai
" smartindent	do clever autoindenting
set nosi
" backspace	specifies what <BS>, CTRL-W, etc. can do in Insert mode
set backspace=indent,eol,start
" Show line numbers by default
set nu

" Viminfo related
if &history < 1000
  set history=1000
endif

let s:dir = has('win32') ? '~/Application Data/Vim' : has('mac') ? '~/Library/Vim' : '~/.local/share/vim'
if isdirectory(expand(s:dir))
  if &directory =~# '^\.,'
    let &directory = expand(s:dir) . '/swap//,' . &directory
  endif
  if &viewdir =~# '^\.,'
    let &viewdir = expand(s:dir) . '/view//,' . &viewdir
  endif
  if &backupdir =~# '^\.,'
    let &backupdir = expand(s:dir) . '/backup//,' . &backupdir
  endif
  if exists('+undodir') && &undodir =~# '^\.\%(,\|$\)'
    let &undodir = expand(s:dir) . '/undo//,' . &undodir
  endif
endif

if exists('+undofile')
  set undofile
endif

au BufWinEnter * silent! loadview

" Misc
" Allow color schemes do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

if !exists('g:netrw_list_hide')
  let g:netrw_list_hide = '^\.,\~$,^tags$'
endif

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  if &termencoding ==# 'utf-8' || &encoding ==# 'utf-8'
    let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
  endif
endif
"
"if has("autocmd")
  "au InsertEnter * silent execute "!sed -i.bak -e 's/0000aaaa0000/aaaa00000000/' ~/.config/xfce4/terminal/terminalrc"                                                                                          
  "au InsertLeave * silent execute "!sed -i.bak -e 's/aaaa00000000/0000aaaa0000/' ~/.config/xfce4/terminal/terminalrc"                                                                                          
  "au VimLeave * silent execute "!sed -i.bak -e 's/aaaa00000000/0000aaaa0000/' ~/.config/xfce4/terminal/terminalrc"  
"endif

"Colors
"let					g:molokai_original = 1
colorscheme			molokai
"colorscheme solarized

"Markology Colors
highlight! link MarkologyHLl Special
highlight! link MarkologyHLu Special
highlight! link MarkologyHLLine Special
highlight! link MarkologyHLo LineNr

" NEOCOMPLETE
" Disable AutoComplPop. Comment out this line if AutoComplPop is not installed.
let g:acp_enableAtStartup = 0
" Launches neocomplcache automatically on vim startup.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Use camel case completion.
let g:neocomplete#enable_camel_case = 1
" Sets minimum char length of syntax keyword.
let g:neocomplete#min_syntax_length = 3
" buffer file name pattern that locks neocomplcache. e.g. ku.vim or fuzzyfinder 
" let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define file-type dependent dictionaries.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \}

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
let g:neocomplete#enable_auto_select = 0

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" NEOSNIPPET 
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
"let g:neosnippet#snippets_directory = $HOME.'/.vim/bundle/vim-snippets/snippets/'
" let g:neosnippet#snippets_directory = $HOME.'~/.vim/bundle/vim-snippets/snippets'
" Neosnippet Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

"Airline Speratators
let g:airline_left_sep=''
let g:airline_right_sep=''



" vim:set ft=vim et sw=2:
