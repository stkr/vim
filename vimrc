language messages en

if has('win32') || has ('win64')
    let g:vim_home = $HOME."/vimfiles"
else
    let g:vim_home = $HOME."/.vim"
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

