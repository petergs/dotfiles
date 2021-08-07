" Settings
set nu
syntax on
highlight LineNr ctermfg=214
set background=dark
color default

" Tab settings
set textwidth=79  " lines longer than 79 columns will be broken
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

" asm to nasm syntax highlighting
let g:asmsyntax = 'nasm'

" indicate insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" optional reset cursor on start:
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

" bracket pairs 
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
" overwrite second set
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"

" netrw hide banner
let g:netrw_banner = 0
