color desert
set visualbell

" Enable filetype plugins
filetype plugin on
filetype indent on
filetype indent plugin on

" However, in Git commit messages, let’s make it 72 characters
autocmd FileType gitcommit set textwidth=72
" Colour the 81st (or 73rd) column so that we don’t type over our limit
set colorcolumn=+1

" Enable mouse
set mouse=a
