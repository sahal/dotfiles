"TODO: convert to init.lua format when I fully switch to nvim (famous last
"words)

" Arch wiki suggests using this conditional format for nvim/vim config diffs
" https://wiki.archlinux.org/title/Neovim
" although, it also says to symlink you vim config to nvim config :x
if has('nvim')
  " I can't figure out why TERM isn't working correctly with nvim (only in
  " GNU screen)
  " unintuitively, setting notermguicolors -- makes it work as expected
  " i.e. with full 256 color support (wtf?)
  set notermguicolors

  " https://neovim.io/doc/user/provider.html#python-virtualenv
  " the docs only mention how to use pyenv.  I'm not gonna be installing
  " multiple python versions on the regular (probably), so i'm just using
  " virtualenv
  " $ virtualenv neovim
  " $ source neovim/bin/activate
  " ### now, inside the virtual env
  " $ pip3 install --upgrade pip
  " $ pip3 install --upgrade pynvim
  " ### The following output is what python{3}_host_prog needs to be set to
  " $ command -v python3
  let g:python_host_prog = '/home/sahal/neovim/bin/python3'
  let g:python3_host_prog = '/home/sahal/neovim/bin/python3'
  let g:loaded_node_provider = 0
  let g:loaded_perl_provider = 0
  let g:loaded_ruby_provider = 0
else
  "Put regular vim stuff here that we also do not want in neovim

endif

" https://stackoverflow.com/questions/4642822/commands-executed-from-vim-are-not-recognizing-bash-command-aliases
let $BASH_ENV = "~/.bash_vim"

set number
syntax on

" Give me colors!
set t_Co=256

" auto reload changes to gruvbox
autocmd VimEnter * ++nested colorscheme gruvbox

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

" Remove all trailing whitespace
" Possibly controvercial? Nobody has rejected my PRs to date based on just
" this
autocmd BufWritePre * :%s/\s\+$//e
"|             |                  | |
"|             |                  | This part actually removes the whitespace
"|             |                  The command will run for all file types
"|             This command will run immediately after you save a file
"Creates a new autocommand

" Install vim-plug if we don't already have it
" Not sure I feel comfortable with this part -- run a random vim script...
""if empty(glob('~/.vim/autoload/plug.vim'))
""silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
""		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
""autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
""endif
" Use this instead: https://github.com/junegunn/vim-plug#unix

call plug#begin('~/.vim/plugged')


" In case you forget, (which you will) to install edit `.vimrc`, save it, reload
" it (`:source .vimrc`), and run `:PlugInstall`
" to uninstall/remove plugins use `:PlugClean` instead

Plug 'ctrlpvim/ctrlp.vim'
"Plug 'https://github.com/AndrewRadev/linediff.vim.git'
Plug 'scrooloose/nerdtree'
"powerline is wayy to complex for just my usecase; hence vim-airline
"Plug 'powerline/powerline'
Plug 'vim-airline/vim-airline'
"Plug 'zefei/vim-colortuner'
"Plug 'junegunn/vim-easy-align'
Plug 'michaeljsmith/vim-indent-object'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'morhetz/gruvbox'
Plug 'Yggdroot/indentLine'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'
"Plug 'thiagoalessio/rainbow_levels.vim'
"Plug 'vim-vdebug/vdebug'
"Plug 'mfussenegger/nvim-dap'

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

" Kyle (coworker@company hq across from mcds cyclecntr) says
" relative numbers are good
set relativenumber

" https://www.arthurkoziel.com/setting-up-vim-for-yaml/
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
let g:indentLine_char = '⦙'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_text_changed = 'never'

autocmd FilterWritePre * if &diff | setlocal wrap< | endif
" https://gist.github.com/sahal/d42b82a9f4aca488b0d330710800220d
if &diff
  colorscheme mycolorscheme
endif

" https://github.com/thiagoalessio/rainbow_levels.vim
map <leader>R :RainbowLevelsToggle<cr>

" https://vi.stackexchange.com/a/3363
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''

" some issue in vim-airline when displaying some symbols 🤷🏾
let g:airline_symbols.colnr = ' '

"https://vi.stackexchange.com/a/19974
let g:indentLine_setConceal = 2
" default ''.
" n for Normal mode
" v for Visual mode
" i for Insert mode
" c for Command line editing, for 'incsearch'
let g:indentLine_concealcursor = ""
