language messages en_US.UTF-8

" Use <,> as the leader key.
let mapleader=","

if has('win32') || has ('win64')
	let g:vim_home = $HOME."/vimfiles/"
else
	let g:vim_home = $HOME."/.vim/"
endif

set enc=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc

syntax on

set relativenumber
set number

set incsearch
set hlsearch
set showcmd

" Highlight the active line and the active column.
set cursorline
"set cursorcolumn

" Set the text width to and create a vertical bar.
set textwidth=100
set colorcolumn=101

" Set scroll offset so the active line stays towards the center.
set scrolloff=8

set laststatus=2

set wildmenu
set wildmode=longest:full,full

set ruler

let g:session_dir = g:vim_home."sessions"
exec 'nnoremap <Leader>ss :mks! ' . g:session_dir . '/'
exec 'nnoremap <Leader>sr :so ' . g:session_dir . '/'

if has('gui_running')
    set background=light
else
	set background=dark
endif 
let g:solarized_contrast="high"
" let g:solarized_termcolors=256
colorscheme solarized

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set ignorecase " use case insensitive search per default

if has("gui_running")
	" GUI is running or is about to start.
	" Maximize gvim window (for an alternative on Windows, see simalt below).
	set lines=50 columns=170
    set guioptions-=e
    set guioptions-=t 
    set guioptions-=T
	if has("gui_gtk2") || has("gui_gtk3")
        set guifont=Consolas 11 
    elseif has("gui_photon")
        set guifont=Consolas:s11
    elseif has("gui_kde")
        set guifont=Consolas/11/-1/5/50/0/0/0/1/0
    elseif has("x11")
        set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
    else
        set guifont=Consolas:h11:cDEFAULT
  endif
endif

let g:startify_session_autoload = 1
let g:startify_session_persistence = 1
let g:startify_change_to_dir = 1
let g:startify_change_to_vcs_root = 1


set autoread
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/149214
" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" make backspace work like most other programs
set backspace=indent,eol,start

" http://vim.wikia.com/wiki/Use_ijkl_to_move_the_cursor_and_h_to_insert
" map i <Up>
" map j <Left>
" map k <Down>
" noremap h i

" Avoid the escape key http://vim.wikia.com/wiki/Avoid_the_escape_key
inoremap jk <Esc>
inoremap kj <Esc>

" When invoked, unless a starting directory is specified, CtrlP will set its local working 
" directory according to this variable:
" 'c' - the directory of the current file.
" 'r' - the nearest ancestor that contains one of these directories or files: .git .hg .svn .bzr _darcs
" 'a' - like c, but only if the current working directory outside of CtrlP is not a direct ancestor of the directory of the current file.
let g:ctrlp_working_path_mode = 'ra'

let g:ctrlp_user_command = {
	\ 'types': {
		\ 1: ['.git', 'cd %s && git ls-files'],
		\ 2: ['.hg', 'hg --cwd %s locate -I .'],
		\ },
	\ 'fallback': 'find %s -type f'
	\ }

