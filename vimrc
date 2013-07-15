execute pathogen#infect()
set nocompatible "Not vi compativle (Vim is king)

"my leader
let mapleader = ","
let maplocalleader = "\\"

""""""""""""""""""""""""""""""""""
" Syntax and indent
""""""""""""""""""""""""""""""""""
syntax on " Turn on syntax highligthing
set showmatch  "Show matching bracets when text indicator is over them

colorscheme delek

" Switch on filetype detection and loads 
" indent file (indent.vim) for specific file types
filetype indent on
filetype on
set autoindent " Copy indent from the row above
set si " Smart indent

""""""""""""""""""""""""""""""""""
" Some other confy settings
""""""""""""""""""""""""""""""""""
" set nu " Number lines
set hls " highlight search
set lbr " linebreak
set rnu " relativenumber

" Use 2 space instead of tab during format
set expandtab
set shiftwidth=2
set softtabstop=2

"window navigation
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-l> :wincmd l<CR>
"nnoremap <C-J> <C-W>j<15C-W>_


"""""""""""""""""""""""""""""""""
" Taglist and ctags stuff """"""
"""""""""""""""""""""""""""""""
" set Tlist_Ctags_Cmd="/usr/bin/ctags"
"set Tlist_WinWidth=50
"set Tlist_Exit_OnlyWindow=1
set tags=tags,./tags,/home/robertk/tags/commontags

nnoremap <silent> <F2> :TlistToggle<CR>
nnoremap <F8> :TagbarToggle<CR>
" nnoremap <F8> :!/usr/bin/ctags -R --scala-kinds=+p --fields=+iaS --extra=+q .<CR>

" autocommand groups
augroup filetype_xml
  autocmd!
  " gg=G to format XML uses external xmllint to do it fast :-)
  autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
augroup END

augroup filetype_html
  autocmd!
  "autoformat  *.html files
  autocmd BufwritePre,BufRead *.html :normal gg=G
  autocmd BufwritePre,BufRead *.html setlocal nowrap
  "comment tag
  autocmd FileType html nnoremap <buffer> <localleader>c vat<esc>a --><esc>`<i<!-- <esc>
augroup END

augroup filetype_scala
  autocmd!
  " line based comment
  autocmd FileType scala nnoremap <buffer> <localleader>c I//<esc>
augroup END

augroup filetype_java
  autocmd!
  " comment line
  autocmd FileType java nnoremap <buffer> <localleader>c I//<esc>
augroup END

" move text up or down
"uppercase current or previous word in insert mode
inoremap <c-u> <esc>bveU<esc>ea
"uppercase word in normal mode
nnoremap <c-u> bveU<esc>
" make editing vimrc easier
nnoremap <leader>` :vsplit $MYVIMRC<cr>
" source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" typos
iabbrev adn and
iabbrev waht what
iabbrev tehn then
" common phrases
"iabbrev @@ karl.roberts@owtelse.com
" iabbrev ssig <cr>Karl Roberts<cr>karl.roberts@owtelse.com

"Operator mappings
" select in next parens
onoremap in( :<c-u>normal! f(vi(<cr>
" select in previous parens
onoremap il( :<c-u>normal! F)vi(<cr>
"select in next {
onoremap in{ :<c-u>normal! f{vi{<cr>
"movement in last {
onoremap il{ :<c-u>normal! F}vi{<cr>

" grep word under curser into quicklist
" nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>
" map quicklist :cnext :cprevious
nnoremap <leader>n :cnext
nnoremap <leader>p :cprevious


set hlsearch "highlight what was found
set incsearch "highlight what i'm finding
" very magic searching ie normal regex
nnoremap ? ?\v
nnoremap / /\v

"retrain fingers
" inoremap <esc> <nop>
" inoremap jk <esc>

nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>
