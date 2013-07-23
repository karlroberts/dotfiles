" echom "entering vim-sbt plugin"
set errorformat=%E\ %#[error]\ %#%f:%l:\ %m,%-Z\ %#[error]\ %p^,%-C\ %#[error]\ %m
set errorformat+=,%W\ %#[warn]\ %#%f:%l:\ %m,%-Z\ %#[warn]\ %p^,%-C\ %#[warn]\ %m
set errorformat+=,%-G%.%#

" noremap <silent> <Leader>ff :cf /tmp/sbt.quickfix<CR>
noremap <silent> <leader>ff :echom "wanker"<cr>\|:cf target/quickfix/sbt.quickfix<CR>
noremap <silent> <Leader>fn :cn<CR>
