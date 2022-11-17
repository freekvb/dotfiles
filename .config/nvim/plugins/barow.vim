Plug 'doums/barow'


" add to plugin section init.vim
"source ~/.config/nvim/plugins/barow.vim             " status bar

" leave all this here
" automatically leave insert mode after 'update time' milliseconds of inaction
au CursorHoldI * stopinsert
 " set 'update time' to 7.5 seconds when in insert mode
au InsertEnter * let updaterestore=&updatetime | set updatetime=7500
au InsertLeave * let &updatetime=updaterestore

" status bar
set noshowmode                                      " hide default mode text
set noshowcmd                                       " hide commands
set cmdheight=1                                     " height of command bar
set shortmess=at                                    " abbreviation, truncate

set laststatus=3

