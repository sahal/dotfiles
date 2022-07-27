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
" set nofoldenable

set tw=79
set colorcolumn=-2

set wrap
set linebreak
set nolist  " list disables linebreak
set textwidth=0
set wrapmargin=0

highlight nonascii guibg=Red ctermbg=1 term=standout
au BufReadPost * syntax match nonascii "[^\u0000-\u007F]"

" Auto indent pasted text
 nnoremap p p=`]<C-o>
 nnoremap P P=`]<C-o>

if &diff
  colorscheme slate
endif


set nocompatible              " be iMproved, required
filetype off                  " required


autocmd BufWritePre * :%s/\s\+$//e
"|             |                  | |
"|             |                  | This part actually removes the whitespace
"|             |                  The command will run for all file types
"|             This command will run immediately after you save a file
"Creates a new autocommand

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'https://github.com/kien/ctrlp.vim.git'
Plugin 'https://github.com/AndrewRadev/linediff.vim.git'
Plugin 'scrooloose/nerdtree'
Plugin 'zefei/vim-colortuner'
"Plugin 'https://github.com/godlygeek/tabular.git'
Plugin 'vim-airline/vim-airline'
Plugin 'junegunn/vim-easy-align'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'martinda/Jenkinsfile-vim-syntax'
Plugin 'morhetz/gruvbox'
Plugin 'Yggdroot/indentLine'
Plugin 'dense-analysis/ale'
Plugin 'tpope/vim-fugitive'


" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
"Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

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

autocmd vimenter * ++nested colorscheme gruvbox

" https://www.arthurkoziel.com/setting-up-vim-for-yaml/
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
let g:indentLine_char = '⦙'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_text_changed = 'never'

if &diff
    colorscheme mycolorscheme
endif
