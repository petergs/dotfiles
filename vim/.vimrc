" Settings
set nu
syntax on
highlight LineNr ctermfg=214
set background=dark
color default

" Tab settings
" set textwidth=79  " lines longer than 79 columns will be broken
set shiftwidth=4  " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4     " a hard TAB displays as 4 columns
set expandtab     " insert spaces when hitting TABs
set softtabstop=4 " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround    " round indent to multiple of 'shiftwidth'
set autoindent    " align the new line indent with the previous line

" Key bindings
" split switch
"nnoremap <Leader>[ <C-W>w
" map <F1> <C-W><C-H>
" map <F2> <C-W><C-J>
" map <F3> <C-W><C-K>
" map <F4> <C-W><C-L>

set splitright
set belloff=all

set showcmd
set showmatch
set ignorecase

" base 16 colors
set t_Co=16

" indicate insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" reset cursor on start:
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

":autocmd InsertEnter * set cul
":autocmd InsertLeave * set nocul

"unmap arrow keys
nnoremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" faster up and down
nnoremap <C-k> 5k 
nnoremap <C-j> 5j

" exit insert mode with jj
:imap jj <Esc>

" netrw hide banner
let g:netrw_banner = 0

set hlsearch
set incsearch
set linebreak

" vim-plug if not installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
call plug#begin()
Plug 'fatih/vim-go'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'tmsvg/pear-tree'
call plug#end()

" prevent erasing closing string (breaks dot repeat)
let g:pear_tree_repeatable_expand = 0

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
