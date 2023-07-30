" https://stackoverflow.com/questions/4642822/commands-executed-from-vim-are-not-recognizing-bash-command-aliases
let $BASH_ENV = "~/.bash_vim"

set number
syntax on

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set diffopt+=iwhite

set foldmethod=indent
"set foldnestmax=1
"set nofoldenable

set tw=79
set colorcolumn=80

set wrap
set linebreak
set nolist  " list disables linebreak
set textwidth=0
set wrapmargin=0

" https://stackoverflow.com/a/26209681
highlight nonascii guibg=Red ctermbg=1 term=standout
au BufReadPost * syntax match nonascii "[^\u0000-\u007F]"

" Auto indent pasted text
 nnoremap p p=`]<C-o>
 nnoremap P P=`]<C-o>

set nocompatible              " be iMproved, required
filetype off                  " required

autocmd BufWritePre * :%s/\s\+$//e
"|             |                  | |
"|             |                  | This part actually removes the whitespace
"|             |                  The command will run for all file types
"|             This command will run immediately after you save a file
"Creates a new autocommand

" Install vim-plug if we don't already have it
" Not sure I feel comfortable with this part
""if empty(glob('~/.vim/autoload/plug.vim'))
""silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
""		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
""autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
""endif
" Use this instead: https://github.com/junegunn/vim-plug#unix

call plug#begin('~/.vim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'https://github.com/AndrewRadev/linediff.vim.git'
Plug 'scrooloose/nerdtree'
Plug 'zefei/vim-colortuner'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/vim-easy-align'
Plug 'jlanzarotta/bufexplorer'
Plug 'michaeljsmith/vim-indent-object'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'morhetz/gruvbox'
Plug 'Yggdroot/indentLine'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'
Plug 'thiagoalessio/rainbow_levels.vim'

call plug#end()

filetype plugin indent on    " required

" http://vim.wikia.com/wiki/Highlight_current_line
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" http://learnvimscriptthehardway.stevelosh.com/chapters/06.html
let mapleader = ','

" Buffers - explore/next/previous: Alt-F12, F12, Shift-F12.
" http://vim.wikia.com/wiki/Easier_buffer_switching
nnoremap <silent> <leader>l :bn<CR>
nnoremap <silent> <leader>h :bp<CR>

"nnoremap <silent> <leader>x :execute 'new | 0read ! interpreter' expand('%')<CR>
au BufNewFile,BufRead Jenkinsfile setf groovy

" Kyle says relative numbers are good
set relativenumber

" Give me colors!
set t_Co=256

autocmd VimEnter * ++nested colorscheme gruvbox

" https://www.arthurkoziel.com/setting-up-vim-for-yaml/
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
let g:indentLine_char = '⦙'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_text_changed = 'never'

" https://gist.github.com/sahal/d42b82a9f4aca488b0d330710800220d
if &diff
  colorscheme mycolorscheme
endif

" https://github.com/thiagoalessio/rainbow_levels.vim
map <leader>R :RainbowLevelsToggle<cr>

