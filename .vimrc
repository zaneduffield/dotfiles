syntax on

let mapleader=" "
nnoremap <Space> <NOP>

" perl style regex
" nnoremap / /\v

" show search matches as you type the expression
set incsearch

" case insensitive unless you type an uppercase character
set ignorecase smartcase

" numbered lines
set nu

" line wrap
set wrap

" tab settings
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Show a few lines of context around the cursor
set scrolloff=5

" prevent auto wrapping
set fo-=t fo-=c
" wrap lines at desired column (when using gq)
set textwidth=100

" A workaround for using Alt in terminals
" see https://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim/10216459#10216459
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

set timeout ttimeoutlen=25

" Move blocks up and down using alt-j/k
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Shortcut for copying to/from System Clipboard
" Copy (Yank)
vmap <Leader>y "+y
" Cut
vmap <Leader>d "+d
" Paste
nmap <Leader>P "+p

" Search for selected text, forwards or backwards.
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" change cursor
let &t_EI .= "\<Esc>[2 q"
let &t_SI .= "\<Esc>[6 q"
" 1 or 0 -> blinking block
" 3 -> blinking underscore
" Recent versions of xterm (282 or above) also support
" 5 -> blinking vertical bar
" 6 -> solid vertical bar
