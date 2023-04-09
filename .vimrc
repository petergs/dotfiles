" prefs
" --------------------------------------------
" visual settings
syntax on
" highlight LineNr ctermfg=214 "
color default
" set background=dark
set t_Co=16 " base 16 colors
" highlight StatusLine ctermbg=15 ctermfg=4


set nu
set nocompatible " better safe than sorry
set autoread 
set splitright
set belloff=all
set showcmd
set showmatch
set ignorecase
set hlsearch
set incsearch
set linebreak
" set laststatus=2

" Tab settings
" set textwidth=79  " lines longer than 79 columns will be broken
set shiftwidth=4  " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4     " a hard TAB displays as 4 columns
set expandtab     " insert spaces when hitting TABs
set softtabstop=4 " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround    " round indent to multiple of 'shiftwidth'
set autoindent    " align the new line indent with the previous line

" indicate insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" netrw hide banner
let g:netrw_banner = 0

" maps / remaps
" --------------------------------------------
"unmap arrow keys
nnoremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" faster up and down
nnoremap <C-k> 5k 
nnoremap <C-j> 5j

" set Y to yank to end of line
" use yy for full line yank
nnoremap Y y$

" exit insert mode with jj
:imap jj <Esc>

" plugins
" --------------------------------------------
" vim-plug if not installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" add plugins
call plug#begin()
Plug 'fatih/vim-go'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'tmsvg/pear-tree'
Plug 'elkowar/yuck.vim'
Plug 'tpope/vim-surround'
" Plug 'vim-airline/vim-airline'
" Plug 'tpope/vim-sensible.vim'
call plug#end()

" commands
" --------------------------------------------
" run black on save
augroup black_on_save
    autocmd!
    autocmd BufWritePre *.py Black
augroup end

" turn off paren match in normal mode 
augroup insertMatch
    au!
    au BufReadPost * NoMatchParen
    au InsertEnter * DoMatchParen
    au InsertLeave * NoMatchParen
augroup END

" turn off autocomment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" reset cursor on start:
" augroup reset_cursor
" au!
" autocmd VimEnter * silent !echo -ne "\e[2 q"
" augroup END

":autocmd InsertEnter * set cul
":autocmd InsertLeave * set nocul
