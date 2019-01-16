language messages en_US.UTF-8

if has('win32') || has ('win64')
	let g:vim_home = $HOME."/vimfiles/"
else
	let g:vim_home = $HOME."/.vim/"
endif

syntax on

set number
set incsearch
set hlsearch
set showcmd

set laststatus=2

set wildmenu
set wildmode=longest:full,full

let g:session_dir = g:vim_home."sessions"
exec 'nnoremap <Leader>ss :mks! ' . g:session_dir . '/'
exec 'nnoremap <Leader>sr :so ' . g:session_dir . '/'

if has('gui_running')
	set background=light
else
	set background=dark
endif 
let g:solarized_contrast="high"
let g:solarized_termcolors=256
colorscheme solarized


set smarttab
set tabstop=4

if has("gui_running")
	" GUI is running or is about to start.
	" Maximize gvim window (for an alternative on Windows, see simalt below).
	set lines=50 columns=150
endif

let g:startify_session_autoload = 1
let g:startify_session_persistence = 1
let g:startify_change_to_dir = 1
let g:startify_change_to_vcs_root = 1

