" Settings
set nu
syntax on
highlight LineNr ctermfg=214

" Tab settings
set textwidth=79  " lines longer than 79 columns will be broken
set shiftwidth=4  " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4     " a hard TAB displays as 4 columns
set expandtab     " insert spaces when hitting TABs
set softtabstop=4 " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround    " round indent to multiple of 'shiftwidth'
set autoindent    " align the new line indent with the previous line

autocmd FileType sml setlocal shiftwidth=2 tabstop=2 softtabstop=2


" Key bindings
" split switch
nnoremap <Leader>[ <C-W>w
map <F1> <C-W><C-H>
map <F2> <C-W><C-J>
map <F3> <C-W><C-K>
map <F4> <C-W><C-L>

set splitright
set belloff=all

set showcmd
set showmatch
set ignorecase

" highlighting for rofi config
au BufNewFile,BufRead /*.rasi setf css

" base 16 colors
set t_Co=16

" asm to nasm syntax highlightinh
let g:asmsyntax = 'nasm'
