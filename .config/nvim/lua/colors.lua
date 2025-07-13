-------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/colors.lua (archlinux @ 'silent')
-- Date:     Sun 20 Nov 2022 14:23
-- Update:   Sun 13 Jul 2025 22:23
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

-- colorscheme - lua plugin "dylanaraps/wal.vim"
vim.cmd[[
    colorscheme wal
]]

-- make colorscheme work
set.termguicolors = false

-- cursor line
set.cursorline = true
-- cursor line disabled in insert mode
vim.cmd([[
    autocmd InsertEnter * highlight CursorLine cterm=NONE ctermbg=0 ctermfg=NONE
    autocmd InsertLeave * highlight CursorLine cterm=bold ctermbg=236 ctermfg=NONE
]])

-- cursor column
set.cursorcolumn = true
-- cursor column disabled in insert mode
vim.cmd([[
    autocmd InsertEnter * highlight CursorColumn ctermbg=0 ctermfg=NONE
    autocmd InsertLeave * highlight CursorColumn ctermbg=236 ctermfg=NONE
]])

-- highlights
vim.cmd([[
    hi CursorLine cterm=bold,italic ctermfg=NONE ctermbg=236
    hi CursorLineNR cterm=bold ctermfg=NONE ctermbg=236
    hi CursorColumn ctermfg=NONE ctermbg=236
    hi ColorColumn ctermbg=NONE ctermfg=236
    hi FzfBackground ctermbg=0
    hi FzfPreviewBackground ctermbg=0
    hi VertSplit ctermbg=236
    hi MatchParen ctermfg=0 ctermbg=1
    hi Pmenu ctermfg=1 ctermbg=0
    hi PmenuSel ctermfg=4 ctermbg=0
    hi Error ctermfg=0 ctermbg=1
]])

