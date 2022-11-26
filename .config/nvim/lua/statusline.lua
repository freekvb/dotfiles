-------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/keymaps.lua (archlinux @ 'silent')
-- Date:     Sun 20 Nov 2022 14:23
-- Update:   Tue 22 Nov 2022 03:20
-- Owner:    fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/
-------------------------------------------------------------------------------


local set = vim.opt

local opt = { noremap = true }

local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- shorten function name
local keymap = vim.api.nvim_set_keymap

-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',


-- automatically leave insert mode after 'update time' milliseconds of inaction
vim.cmd[[
au CursorHoldI * stopinsert
]]
-- set 'update time' to 5 seconds when in insert mode
vim.cmd[[
au InsertEnter * let updaterestore=&updatetime | set updatetime=5000
au InsertLeave * let &updatetime=updaterestore
]]

-- no statusline when using fzf
vim.cmd[[
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noruler
  \| autocmd BufLeave <buffer> set laststatus=2 ruler
]]

-- paste toggle indicator (,p)
vim.cmd[[
function! PasteForStatusline()
    let paste_status = &paste
    if paste_status == 1
        return " [paste]"
    else
        return ""
    endif
endfunction
]]

-- mode colors
vim.cmd[[
let g:mode_colors = {
        \ 'n'       :   'StatusLineSection',
        \ 'i'       :   'StatusLineSectionI',
        \ 'c'       :   'StatusLineSectionC',
        \ 'v'       :   'StatusLineSectionV',
        \ 'V'       :   'StatusLineSectionV',
        \ "\<C-V>"  :   'StatusLineSectionV',
        \ 'r'       :   'StatusLineSectionR'
        \ }
]]

-- active statusline
vim.cmd[[
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
]]

-- selected file
vim.cmd[[
fun! StatusLineFilename()
    if (&ft ==? 'netrw') | return '*' | endif
    return substitute(expand('%'), '^' . getcwd() . '/\?', '', 'i')
endfun
]]

-- statusline highlights colors
vim.cmd[[
fun! StatusLineHighlights()
    hi StatusLine         ctermbg=7  ctermfg=235
    hi StatusLineNC       ctermbg=5  ctermfg=233
    hi StatusLineSection  cterm=bold ctermbg=235 ctermfg=7
    hi StatusLineSectionI cterm=bold ctermbg=235 ctermfg=1
    hi StatusLineSectionC cterm=bold ctermbg=235 ctermfg=2
    hi StatusLineSectionV cterm=bold ctermbg=235 ctermfg=3
    hi StatusLineSectionR cterm=bold ctermbg=235 ctermfg=4
endfun

call StatusLineHighlights()
]]


-- inactive statusline
-- only set default statusline once on initial startup.
-- ignored on subsequent 'so $MYVIMRC' calls to prevent
-- active buffer statusline from being 'blurred'.
vim.cmd[[
if has('vim_starting')
    let &statusline = '   %{StatusLineFilename()} %=  %v  %l/%L  %p%%  [%n]  %y  '
endif
]]

-- selecting active or inactive statusline
vim.cmd[[
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
]]

set.laststatus = 2                                    -- local statusline
--set.laststatus = 3                                    -- global statusline

-- status bar
set.showmode = false                                  -- hide default mode text
set.showcmd = false                                   -- hide commands
set.cmdheight = 1                                     -- height of command bar
set.shortmess = 'atToOFc'                             -- prompt message options
set.inccommand = ''                                   -- disable substitution preview

