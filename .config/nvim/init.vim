"-----------------------------------------------------------------------------"
" File:     ~/.config/nvim/init.vim (archlinux @ 'silent')
" Date:     Fri 01 May 2020 23:03
" Update:   Sat 19 Nov 2022 04:01
" Owner:    fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/
"-----------------------------------------------------------------------------"

"{{{ general settings

" general settings
set clipboard+=unnamedplus                          " copy(y) paste(p) to/from system buffer
set number                                          " numbers
set relativenumber                                  " relative number
set numberwidth=5                                   " width 'gutter' column numbering
set scrolloff=999                                   " keep cursor away from top and bottom
set ttyfast                                         " faster scrolling
set virtualedit=all                                 " keep cursor from wobbling around ..
set undolevels=100                                  " number of undo levels
set wildmode=longest,full                           " auto compleet like shell
set foldmethod=marker                               " folding with markers (curly brackets)

" disable backup and swap files
set nobackup
set nowritebackup
set noswapfile

" indentation (PEP8 Python)
set expandtab                                       " convert tab to spaces
set tabstop=4                                       " tab 4 spaces
set shiftwidth=4                                    " auto indent spaces
set smartindent                                     " indent the smart way
set wrap                                            " wrap lines
set textwidth=79                                    " line wrap (number of columns)
set linebreak                                       " break line on word
set breakindent                                     " keep indentation
set breakindentopt=shift:2                          " emphasize broken lines by indenting them
set fileformat=unix                                 " just because linux
let python_highlight_all = 1                        " all python syntax highlight features

" search
set ignorecase                                      " always case insensitive
set smartcase                                       " enable smart case search
nnoremap <CR> :nohlsearch<CR>                       " clear highlighting from the search

" fuzzy file finding
set path+=**                                        " search sub folders and tab completion

" complete
set complete+=kspell
set completeopt=menuone,longest

"}}}

"{{{ keybindings

" set <leader> key
let mapleader=','

" switch colon to semicolon
nnoremap ; :
nnoremap : ;

" no arrows, move the vim way
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>

" lazy write / quit
nnoremap <leader>w   :w<CR>
nnoremap <leader>q   :q<CR>
nnoremap <leader>wq  :wq<CR>
nnoremap <leader>W   :w!<CR>
nnoremap <leader>Q   :q!<CR>
nnoremap <leader>WQ  :wq!<CR>

" navigate properly when lines are wrapped
nnoremap j gj
nnoremap k gk

" jump 10 lines up or down
nnoremap J 10j
nnoremap K 10k

" jump to start or end of line
nnoremap H ^
nnoremap L $

" fix Y behaviour
nnoremap Y y$

" maintaining visual mode after shifting > and <
vnoremap > >gv
vnoremap < <gv

" switch last two buffers
nnoremap <space><space> <c-^>

" split windows
set splitbelow                                      " 'split' horizontal below
set splitright                                      " 'vsplit' vertical on the right
set fillchars+=vert:\                               " lose the separation
" open split
nnoremap sp :split<CR>
nnoremap vs :vsplit<CR>:vert resize 128<CR>         " 'vsplit' in dwm master stack ratio
" navigate split windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" terminal in split below, resize and start insert mode
nnoremap <leader>st :sp<bar>resize15<bar>term<CR>
autocmd TermOpen * startinsert
tnoremap <Esc> <C-\><C-n>

" scrolling command-line history
cnoremap <C-j> <C-n>
cnoremap <C-k> <C-p>

" easy folding
nnoremap z za<Space>0                               " toggle fold under cursor no jumping around

" toggle relativenumber
nnoremap <leader>r :set invrnu<CR>

" allow gf to open non-existent files
nnoremap gf :edit <cfile><cr>

" open the current file in the default program
nnoremap <leader>x :!xdg-open %<cr><cr>

" no ex mode for me
nnoremap Q <nop>

" prevent accidentally record functionality
nnoremap q <nop>
nnoremap qq q

"}}}

"{{{ special settings

" paste
" toggle paste unmodified (code)
set pastetoggle=<leader>p

" time stamp
inoremap <leader>ts <C-R>=strftime("%a %d %b %Y %H:%M")<CR><CR>

" toggle spell checking
noremap <leader>s :setlocal spell! spelllang=en_us,nl<CR>

" double space over word to find and replace
nnoremap <Space><Space> :%s/\<<C-r>=expand("<cword>")<CR>\>/

" search and replace all
nnoremap <C-s> :%s//gI<Left><Left><Left>

" markdown
" set proper extension for markdown files (.md)
au BufRead,BufNewFile *.md set filetype=markdown
" set proper text width for markdown files
au BufRead,BufNewFile *.md setlocal textwidth=79
let g:markdown_fenced_languages = ['javascript', 'ruby', 'sh', 'yaml', 'javascript', 'html', 'vim', 'json', 'diff']

" remove trailing white space
autocmd BufWritePre * %s/\s\+$//e

" write file if you forgot to give it sudo permission
cnoremap w!! w !sudo tee %

" return to last edit position at opening file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" source nvim config file init.vim
nnoremap sv :source ~/.config/nvim/init.vim <CR>

" diff since last save
nnoremap <leader>d :w !diff % -<CR>

" python provider
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'
" perl provider
let g:loaded_perl_provider = 0

" set my folding format
function! MyFoldText()
    let line = getline(v:foldstart)
    let folded_line_num = v:foldend - v:foldstart
    let line_text = substitute(line, '^["|#]{\+', '', 'g')
    let fillcharcount = &textwidth - 21 - len(line_text) - len(folded_line_num)
    return '+ '. repeat('-', 4) . line_text . ' ' . repeat('.', fillcharcount) . ' ' . folded_line_num . ' lines ---- +                                                                                                                                                                                                                                                                                  '
endfunction
set foldtext=MyFoldText()

"  autoclosing brackets
function! ConditionalPairMap(open, close)
  let line = getline('.')
  let col = col('.')
  if col < col('$') || stridx(line, a:close, col + 1) != -1
    return a:open
  else
    return a:open . a:close . repeat("\<left>", len(a:close))
  endif
endf
inoremap <expr> ( ConditionalPairMap('(', ')')
inoremap <expr> { ConditionalPairMap('{', '}')
inoremap <expr> [ ConditionalPairMap('[', ']')

"}}}

"{{{ personal settings

" header update
nnoremap <leader>h gg/Update<CR>2wc$<C-R>=strftime("%a %d %b %Y %H:%M")<CR><Esc>:nohlsearch<CR>

" shebang
nnoremap sb i#!/usr/bin/sh<CR><CR>

" notes - all notes in markdown (.md)
" new note 'nn' in terminal

" save note in $HOME/Notes/ (title)
nnoremap sn :saveas ~/Notes/

" trade notes ('nn' in terminal in '$HOME/Notes/trades' directory)
" save trade note (time stamp)
nnoremap st :saveas $HOME/Notes/trades/<C-R>=strftime("%d %b %Y %H:%M:%S")<CR>.md<CR>
" insert last trade screenshot in trade note with timestamp above screenshot
nnoremap tp :r!tp<CR>i######<Space><Esc>$3hDi<CR>[![trade](./tp/<Esc>:r!tp<CR>i<Backspace><Esc>$li)](./tp/<Esc>:r!tp<CR>i<Backspace><Esc>$li)<CR><CR><Esc>
" insert Calendar
nnoremap tc :r!trade_cal<CR>
" insert HTF
nnoremap th :r!trade_htf<CR>
" insert TTF
nnoremap tt :r!trade_ttf<CR>
" insert Execute
nnoremap te :r!trade_execute<CR>
" insert Result
nnoremap tr :r!trade_result<CR>

" zettel notes
" save zettel zettelkasten note (time stamp)
nnoremap sz :saveas $HOME/Notes/zet/<C-R>=strftime("%Y%m%d%H%M%S%z")<CR>.md<CR>

" blog entry
nnoremap <leader>be :/#<CR><CR><CR>jO<C-R>=strftime("%a %d %b %Y %H:%M")<CR><CR><CR><Esc>2ko

"}}}

"{{{ plugins

" Automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin() "(data_dir . '/plugins')

source ~/.config/nvim/plugins/color-wal.vim         " color scheme
source ~/.config/nvim/plugins/css-color.vim         " color codes
source ~/.config/nvim/plugins/fzf.vim               " fzf
source ~/.config/nvim/plugins/goyo.vim              " distraction free writing
source ~/.config/nvim/plugins/instant-markdown.vim  " markdown
source ~/.config/nvim/plugins/startify.vim          " startup screen

call plug#end()
doautocmd User PlugLoaded

"}}}

"{{{ startify

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
            \ { 'z': '~/.config/zsh/.zshrc' },
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

"}}}

"{{{ colors

" set colored cursor line
set cursorline
    hi CursorLine cterm=bold ctermfg=NONE ctermbg=235
    hi CursorLineNR cterm=bold ctermfg=NONE ctermbg=235
" set cursor column
set cursorcolumn
nnoremap <leader>c :set cursorcolumn!<CR>
    hi CursorColumn ctermbg=235
" set colored column
set colorcolumn=79
    hi ColorColumn ctermbg=233
" set split separation color
    hi VertSplit ctermbg=233

"}}}

"{{{ netrw

" config
let g:netrw_keepdir = 0
let g:netrw_winsize = -40
let g:netrw_banner = 0
let g:netrw_localcopydircmd = 'cp -r'
let g:netrw_liststyle = 0
let g:netrw_browse_split = 4
let g:netrw_use_errorwindow =1

" highlight marked files (as search matches)
hi! link netrwMarkFile Search

" better toggle Netrw
hi! link netrwMarkFile Search
nnoremap <leader>nd :Lexplore %:p:h<CR>
nnoremap <Leader>n :Lexplore<CR>

" open splits the right way (brodie's hack))
function! OpenToRight()
	:normal v
	let g:path=expand('%:p')
	execute 'q!'
	execute 'belowright vnew' g:path
	:normal <C-w>l
endfunction

function! OpenBelow()
	:normal v
	let g:path=expand('%:p')
	execute 'q!'
	execute 'belowright new' g:path
	:normal <C-w>l
endfunction

function! OpenTab()
	:normal v
	let g:path=expand('%:p')
	execute 'q!'
	execute 'tabedit' g:path
	:normal <C-w>l
endfunction

function! NetrwMappings()
    " Hack fix to make ctrl-l work properly
    noremap <buffer> <C-l> <C-w>l
    noremap <buffer> V :call OpenToRight()<cr>
    noremap <buffer> H :call OpenBelow()<cr>
    noremap <buffer> T :call OpenTab()<cr>
    " make h and l work as intended
    nmap <buffer> h u
    nmap <buffer> l <CR>
    " toggle marks and remove all marks
    nmap <buffer> <TAB> mf
    nmap <buffer> <S-TAB> mu
endfunction

augroup netrw_mappings
		autocmd!
		autocmd filetype netrw call NetrwMappings()
augroup END

" file managing
nmap <buffer> mf %:w<CR>:buffer #<CR>               " make file
nmap <buffer> md d                                  " make directory
nmap <buffer> fr R                                  " rename file
nmap <buffer> fc mc                                 " copy marked file(s)
nmap <buffer> fm mm                                 " move marked file(s)
nmap <buffer> fd md                                 " diff marked file(s)
nmap <buffer> fx mx                                 " run external command on marked file(s)


" Close Netrw if it's the only buffer open
autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif

"}}}

"{{{ statusline

" automatically leave insert mode after 'update time' milliseconds of inaction
au CursorHoldI * stopinsert
" set 'update time' to 5 seconds when in insert mode
au InsertEnter * let updaterestore=&updatetime | set updatetime=5000
au InsertLeave * let &updatetime=updaterestore

" no statusline when using fzf
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noruler
  \| autocmd BufLeave <buffer> set laststatus=2 ruler

" paste toggle indicator (,p)
function! PasteForStatusline()
    let paste_status = &paste
    if paste_status == 1
        return " [paste]"
    else
        return ""
    endif
endfunction

" mode colors
let g:mode_colors = {
        \ 'n'       :   'StatusLineSection',
        \ 'i'       :   'StatusLineSectionI',
        \ 'c'       :   'StatusLineSectionC',
        \ 'v'       :   'StatusLineSectionV',
        \ 'V'       :   'StatusLineSectionV',
        \ "\<C-V>"  :   'StatusLineSectionV',
        \ 'r'       :   'StatusLineSectionR'
        \ }

" active statusline
fun! StatusLineRenderer()
    let hl = '%#' . get(g:mode_colors, tolower(mode()), g:mode_colors.n) . '#'
    return hl
        \ . (&modified ? '  [+]' : '')
        \ . '  %{PasteForStatusline()}'
        \ . ' %{StatusLineFilename()}'
        \ . ' %#StatusLine# '
        \ . ' %= '
        \ . hl
        \ . ' %v '
        \ . ' %l/%L '
        \ . ' %p%% '
        \ . ' [%n] '
        \ . ' %y '
        \ . ' '
endfun

" selected file
fun! StatusLineFilename()
    if (&ft ==? 'netrw') | return '*' | endif
    return substitute(expand('%'), '^' . getcwd() . '/\?', '', 'i')
endfun

" statusline highlights colors
fun! <SID>StatusLineHighlights()
    hi StatusLine         ctermbg=7  ctermfg=235
    hi StatusLineNC       ctermbg=5  ctermfg=233
    hi StatusLineSection  cterm=bold ctermbg=235 ctermfg=7
    hi StatusLineSectionI cterm=bold ctermbg=235 ctermfg=1
    hi StatusLineSectionC cterm=bold ctermbg=235 ctermfg=2
    hi StatusLineSectionV cterm=bold ctermbg=235 ctermfg=3
    hi StatusLineSectionR cterm=bold ctermbg=235 ctermfg=4
endfun

call <SID>StatusLineHighlights()

" inactive statusline
" only set default statusline once on initial startup.
" ignored on subsequent 'so $MYVIMRC' calls to prevent
" active buffer statusline from being 'blurred'.
if has('vim_starting')
    let &statusline = '   %{StatusLineFilename()}%=  %v  %l/%L  %p%%  [%n]  %y  '
endif

" selecting active or inactive statusline
augroup vimrc
    au!
    " show focussed buffer statusline
    au FocusGained,VimEnter,WinEnter,BufWinEnter *
      \ setlocal statusline=%!StatusLineRenderer()
    " show blurred buffer statusline
    au FocusLost,VimLeave,WinLeave,BufWinLeave *
      \ setlocal statusline&
    " restore statusline highlights on colorscheme update
    au Colorscheme * call <SID>StatusLineHighlights()
augroup END

set laststatus=2                                    " local statusline
"set laststatus=3                                    " global statusline

" status bar
set noshowmode                                      " hide default mode text
set noshowcmd                                       " hide commands
set cmdheight=1                                     " height of command bar
set shortmess=acFt                                  " abbr, compl, file, truncate

"}}}

" prohibit insecure vim script
set secure

