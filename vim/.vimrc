execute pathogen#infect()
filetype plugin indent on

" Settings
set nu
syntax enable
highlight LineNr ctermfg=214

" Tab settings
set expandtab
set tabstop=4

autocmd FileType sml setlocal shiftwidth=2 tabstop=2


" Key bindings
" split switch
nnoremap <Leader>[ <C-W>w
map <F1> <C-W><C-H>
map <F2> <C-W><C-J>
map <F3> <C-W><C-K>
map <F4> <C-W><C-L>

set splitbelow
set splitright

