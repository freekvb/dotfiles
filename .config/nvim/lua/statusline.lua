------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/statusline.lua (archlinux @ 'silent')
-- Date:     Fri 14 Jul 2025 06:30
-- Update:   Mon 14 Jul 2025 10:59
-- Owner:    fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/
-------------------------------------------------------------------------------

---- statusline ----

-- automatically leave insert mode after 'update time' milliseconds of inaction
vim.cmd([[
    au CursorHoldI * stopinsert
]])
-- set 'update time' to 7.5 seconds when in insert mode
vim.cmd([[
    au InsertEnter * let updaterestore=&updatetime | set updatetime=7500
    au InsertLeave * let &updatetime=updaterestore
]])

-- active statusline
vim.cmd([[
fun! StatusLineRenderer()
    let hl = '%#' . get(g:mode_colors, tolower(mode()), g:mode_colors.n) . '#'
    return hl
        \ . '  [%n]'
        \ . (&modified ? ' [+]' : '    ')
        \ . ' %{StatusLineFilename()}'
        \ . ' %r '
        \ . ' %#StatusLine# '
        \ . ' %= '
        \ . hl
        \ . ' %v '
        \ . ' %l/%L '
        \ . ' %p%% '
        \ . ' %y '
        \ . ' '
endfun
]])
-- selected file
vim.cmd([[
fun! StatusLineFilename()
    if (&ft ==? 'netrw') | return '*' | endif
    return substitute(expand('%'), '^' . getcwd() . '/\?', '', 'i')
endfun
]])

-- inactive statusline
-- only set default statusline once on initial startup.
-- ignored on subsequent 'so $MYVIMRC' calls to prevent
-- active buffer statusline from being 'blurred'.
vim.cmd([[
if has('vim_starting')
    let &statusline = '[%n]   %{StatusLineFilename()} %=  %v  %l/%L  %p%%  %y  '
endif
]])

-- selecting active or inactive statusline
vim.cmd([[
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
]])

-- mode colors
vim.cmd([[
let g:mode_colors = {
        \ 'n'       :   'StatusLineSection',
        \ 'i'       :   'StatusLineSectionI',
        \ 'c'       :   'StatusLineSectionC',
        \ 'v'       :   'StatusLineSectionV',
        \ 'V'       :   'StatusLineSectionV',
        \ "\<C-V>"  :   'StatusLineSectionV',
        \ 'r'       :   'StatusLineSectionR'
        \ }
]])

-- statusline highlights colors
vim.cmd([[
fun! StatusLineHighlights()
    hi StatusLine           ctermbg=7     ctermfg=238
    hi StatusLineNC         ctermbg=240   ctermfg=236
    hi StatusLineSection    ctermbg=238   ctermfg=6    cterm=bold
    hi StatusLineSectionI   ctermbg=238   ctermfg=5    cterm=bold
    hi StatusLineSectionC   ctermbg=238   ctermfg=2    cterm=bold
    hi StatusLineSectionV   ctermbg=238   ctermfg=3    cterm=bold
    hi StatusLineSectionR   ctermbg=238   ctermfg=4    cterm=bold
endfun
call StatusLineHighlights()
]])

-- command bar messeges
-- hide default mode text
vim.opt.showmode = false
-- hide commands
vim.opt.showcmd = false
-- height of command bar
vim.opt.cmdheight = 1
-- prompt message options
vim.opt.shortmess = "atToOFc"
-- disable substitution preview
vim.opt.inccommand = ""

