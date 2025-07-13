-------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/statusline.lua (archlinux @ 'silent')
-- Date:     Sun 20 Nov 2022 14:23
-- Update:   Sun 13 Jul 2025 22:47
-- Owner:    fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/
-------------------------------------------------------------------------------

local set = vim.opt
local opt = { noremap = true }
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- shorten function name
local keymap = vim.api.nvim_set_keymap

-- modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

-------------------------------------------------------------------------------

-- automatically leave insert mode after 'update time' milliseconds of inaction
vim.cmd([[
    au CursorHoldI * stopinsert
]])
-- set 'update time' to 7.5 seconds when in insert mode
vim.cmd([[
    au InsertEnter * let updaterestore=&updatetime | set updatetime=7500
    au InsertLeave * let &updatetime=updaterestore
]])

-- paste toggle indicator (,p)
vim.cmd([[
function! PasteForStatusline()
    let paste_status = &paste
    if paste_status == 1
        return " [paste]"
    else
        return ""
    endif
endfunction
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

-- active statusline
vim.cmd([[
fun! StatusLineRenderer()
    let hl = '%#' . get(g:mode_colors, tolower(mode()), g:mode_colors.n) . '#'
    return hl
        \ . (&modified ? '  [+]' : '')
        \ . '  %{PasteForStatusline()}'
        \ . ' %{StatusLineFilename()}'
        \ . ' %r '
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
]])

-- selected file
vim.cmd([[
fun! StatusLineFilename()
    if (&ft ==? 'netrw') | return '*' | endif
    return substitute(expand('%'), '^' . getcwd() . '/\?', '', 'i')
endfun
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

-- inactive statusline
-- only set default statusline once on initial startup.
-- ignored on subsequent 'so $MYVIMRC' calls to prevent
-- active buffer statusline from being 'blurred'.
vim.cmd([[
if has('vim_starting')
    let &statusline = '   %{StatusLineFilename()} %=  %v  %l/%L  %p%%  [%n]  %y  '
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

-- status bar
-- hide default mode text
set.showmode = false
-- hide commands
set.showcmd = false
-- height of command bar
set.cmdheight = 1
-- prompt message options
set.shortmess = "atToOFcI"
-- disable substitution preview
set.inccommand = ""

