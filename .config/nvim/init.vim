"-----------------------------------------------------------------------------"
" File:     ~/.config/nvim/init.vim (archlinux @ 'silent')
" Date:     Fri 01 May 2020 23:03
" Owner:    fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/
"-----------------------------------------------------------------------------"


" set <leader> key
let mapleader='/'


" general settings
set clipboard+=unnamedplus               " copy(y) paste(p) to/from systembuffer
set number relativenumber                " show line numbers relative
set numberwidth=5                        " width 'gutter' column numbering
set scrolloff=10                         " keep cursor away from top and bottom
set virtualedit=all                      " keep cursor from wobbeling around ..
set nostartofline                        " .. when scrolling up and down
set undolevels=100                       " number of undo levels
set hidden                               " allow switch to/from unsaved buffer
set wildmode=longest,full                " autocompleet like shell

" disable backup and swap files
set nobackup
set nowritebackup
set noswapfile

" indentation (PEP8 Python)
set expandtab                            " convert tab to spaces
set tabstop=4                            " tab 4 spaces
set softtabstop=4                        " spaces per tab
set shiftwidth=4                         " auto-indent spaces
set smartindent                          " indent the smart way
set wrap                                 " wrap lines
set nolist                               " make linebreak work
set textwidth=79                         " line wrap (number of colomns)
set linebreak                            " break line on word
set showbreak=>\ \ \                     " note trailing space at end of next line
set breakindent                          " keep indentation
set breakindentopt=shift:2               " emphasize broken lines by indenting them
set fileformat=unix                      " just because linux
let python_highlight_all = 1             " all python syntax highlight features

" search
set smartcase                            " enable smart-case search
set ignorecase                           " always case-insensitive
nnoremap <CR> :noh<CR><CR>               " clear highlighting from the search

" fuzzy file finding
set path+=**                             " search subfolders and tabcompletion

" complete
set complete+=kspell
set completeopt=menuone,longest


" switch colon to semicolon
nnoremap ; :
nnoremap : ;

" lazy write / quit
nnoremap w   :w<CR>
nnoremap q   :q<CR>
nnoremap wq  :wq<CR>
nnoremap W   :w!<CR>
nnoremap Q   :q!<CR>
nnoremap WQ  :wq!<CR>

" jump to start or end of line
nnoremap H ^
nnoremap L $

" no arrows, move the vim way
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" maintaining visual mode after shifting > and <
vnoremap > >gv
vnoremap < <gv


" split windows
set splitbelow                           " 'split' horizontal below
set splitright                           " 'vsplit' vertical on the right
" open split
nnoremap sp :split<CR>
nnoremap vs :vsplit<CR>
" navigate split windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" open terminal in split below
nnoremap <leader>st :sp<bar>resize15<bar>term<CR>
autocmd TermOpen * startinsert
tnoremap <Esc> <C-\><C-n>


" paste
" toggle paste unmodified (code)
set pastetoggle=<leader>p
set showmode

" paste yanked line without line breaks before/after cursor position
nnoremap gp a<CR><Esc>PkJxJx


" blog entry
nnoremap be :/#<CR><CR><CR>jO<C-R>=strftime("%a %d %b %Y %H:%M")<CR><CR><CR><Esc>2ko

" shebang
nnoremap sb i#!/bin/sh<CR><CR>

" notes
" save notes (nn in terminal to open new note)
nnoremap sn :saveas ~/Notes/
" save daily notes (timestamp)
nnoremap sd :saveas ~/Notes/daily/<C-R>=strftime("%d %b %Y %H:%M")<CR>.md<CR>
" save ict notes (timestamp)
nnoremap si :saveas ~/Notes/ict/<C-R>=strftime("%d %b %Y %H:%M")<CR>.md<CR>
" save trade notes (timestamp)
nnoremap st :saveas ~/Notes/trade/<C-R>=strftime("%d %b %Y %a %H:%M")<CR>.md<CR>
" paste screenshot in trade note (fern yy pic)
nnoremap pp gp0cw![<Esc>ldwy$$gp2Tgcw](./shots/<Esc>$cw)<CR><CR><Esc>


" markdown
" set proper extension for markdown files (.md)
au BufRead,BufNewFile *.md set filetype=markdown
" set proper text width for markdown files
au BufRead,BufNewFile *.md setlocal textwidth=79

let g:instant_markdown_browser = "qutebrowser --target window"
let g:instant_markdown_autostart = 0
nnoremap md :InstantMarkdownPreview<CR>
nnoremap mds :InstantMarkdownStop<CR>


" timestamp
inoremap <leader>ts <C-R>=strftime("%a %d %b %Y %H:%M")<CR><CR><CR><Esc>

" toggle spell checking
map <leader>s :setlocal spell! spelllang=en_us,nl<CR>

" remove trailing white space
autocmd BufWritePre * %s/\s\+$//e

" write file if you forgot to give it sudo permission
cnoremap w!! w !sudo tee %


" set python provider
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'


" plugins with vim-plug
call plug#begin()
" list of plugins
Plug 'doums/barow'                       " barow statusbar
Plug 'dylanaraps/wal.vim'                " colorscheme wal
Plug 'mhinz/vim-startify'                " startup screen
Plug 'junegunn/goyo.vim'                 " distraction free writing
" markdown
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'junegunn/fzf.vim'                  " fzf
Plug 'lambdalisue/fern.vim'              " fern file manager
" list ends here, initialize plugin system
call plug#end()


" colorscheme
colorscheme wal

" set colored curserline
set cursorline
hi CursorLine cterm=NONE ctermfg=NONE ctermbg=237
hi CursorLineNR cterm=bold ctermfg=NONE ctermbg=237
" set cursor column
set cursorcolumn
hi CursorColumn ctermbg=237
" set colored column
set colorcolumn=79
hi ColorColumn ctermbg=237


" startify ascii
let s:startify_ascii_header = [
            \'                                                    ',
            \'  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗',
            \'  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║',
            \'  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║',
            \'  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
            \'  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',
            \'  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
            \'',
            \]
let g:startify_custom_header = map(s:startify_ascii_header +
             \ startify#fortune#quote(), '"   ".v:val')
let g:startify_lists = [
            \ { 'type': 'files',     'header': ['   Files'] },
            \ { 'type': 'dir',       'header': ['   Directories '. getcwd()] },
            \ { 'type': 'sessions',  'header': ['   Sessions'] },
            \ { 'type': 'bookmarks', 'header': ['   Bookmarks'] },
            \ { 'type': 'commands',  'header': ['   Commands'] },
            \ ]
let g:startify_bookmarks = [
            \ { '~': '~/' },
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 'z': '~/.zshrc' },
            \ { 'c': '~/.config' },
            \ { 'n': '~/Notes' },
            \ { 's': '~/Scripts' },
            \ { 'w': '~/Websites/fvb' },
            \ ]
let g:startify_commands = [
            \ { 'h': ['neovim reference', 'h ref'] },
            \ { 'r': ['find file in /', 'Files /'] },
            \ { 'f': ['find file in /home', 'Files ~/'] },
            \ { '!': ['my magical function 😜', 'quit'] },
            \ ]


" toggle goyo
nnoremap <leader>g :Goyo<CR>
function! s:goyo_enter()
    set scrolloff=999
    set nocursorline
    set nocursorcolumn
    set colorcolumn=0
endfunction
function! s:goyo_leave()
    set scrolloff=10
    set cursorline
    hi CursorLine cterm=NONE ctermfg=NONE ctermbg=237
    hi CursorLineNR cterm=bold ctermfg=NONE ctermbg=237
    set cursorcolumn
    hi CursorColumn ctermbg=237
    set colorcolumn=79
    hi ColorColumn ctermbg=237
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()


" fzf
" find files by name in home directory
nnoremap <leader>f :Files ~/<CR>
" find files by name in root directory
nnoremap <leader>fr :Files /<CR>
" find files by name in working directory
nnoremap <leader>fd :Files .<CR>
" find and switch buffers
nnoremap <leader>fb :Buffers<CR>
" find content in current file
nnoremap <leader>fl :BLines<CR>
" find content in all files
nnoremap <leader>fg :Rg<CR>
" complete line
nnoremap <C-x><C-l> <plug> (fzf-complete-line)

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Normal'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


" fern
nnoremap <leader>t :Fern ~ -drawer -width=40 -toggle<CR><C-w>=
nnoremap <leader>td :Fern . -reveal=% -drawer -width=40 -toggle<CR><C-w>=
let g:fern#disable_default_mappings   = 1

 function! FernInit() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> l <Plug>(fern-action-open-or-expand)
  nmap <buffer> M <Plug>(fern-action-mark-toggle)
  nmap <buffer> n <Plug>(fern-action-new-file)
  nmap <buffer> d <Plug>(fern-action-new-dir)
  nmap <buffer> r <Plug>(fern-action-remove)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> s <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer> R <Plug>(fern-action-reload)
  nmap <buffer> <nowait> H <Plug>(fern-action-hidden:toggle)
  nmap <buffer> <nowait> h <Plug>(fern-action-leave)
endfunction

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup END


" statusbar
set laststatus=2
set noshowmode                           " hide default mode text
set noshowcmd                            " hide commands
set cmdheight=1                          " height of command bar
set shortmess=atF                        " abbreviation, truncate no file info

set secure

