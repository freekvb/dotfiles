-------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/colors.lua (archlinux @ 'silent')
-- Date:     Sun 20 Nov 2022 14:23
-- Update:   Sat 09 Dec 2023 05:42
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

-------------------------------------------------------------------------------

-- colorscheme - lua plugin
vim.cmd([[
    colorscheme wal
]])

-- cursor line
set.cursorline = true
-- cursor line disabled in insert mode
vim.cmd([[
    autocmd InsertEnter * highlight CursorLine cterm=NONE ctermbg=0 ctermfg=NONE
    autocmd InsertLeave * highlight CursorLine cterm=bold ctermbg=233 ctermfg=NONE
]])
-- cursor column
set.cursorcolumn = true
-- cursor column disabled in insert mode
vim.cmd([[
    autocmd InsertEnter * highlight CursorColumn ctermbg=0 ctermfg=NONE
    autocmd InsertLeave * highlight CursorColumn ctermbg=233 ctermfg=NONE
]])
keymap("n", "<leader>c", ":set cursorcolumn!<cr>", opts)
-- column
set.colorcolumn:append("79")

-- highlights
vim.cmd([[
    hi CursorLine cterm=bold,italic ctermfg=NONE ctermbg=233
    hi CursorLineNR cterm=bold ctermfg=NONE ctermbg=233
    hi CursorColumn ctermfg=NONE ctermbg=233
    hi ColorColumn ctermfg=NONE ctermbg=233
    hi VertSplit ctermbg=234
    hi FzfBackground ctermbg=233
    hi FzfPreviewBackground ctermbg=234
    hi MatchParen ctermfg=0 ctermbg=1
    hi Pmenu ctermfg=7 ctermbg=4
    hi Error ctermfg=0 ctermbg=1
]])

