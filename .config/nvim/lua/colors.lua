-------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/colors.lua (archlinux @ 'silent')            --
-- Date:     Sun 20 Nov 2022 14:23                                           --
-- Update:   Tue 29 Nov 2022 23:24
-- Owner:    fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/        --
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
-- cursor column
set.cursorcolumn = true
keymap("n", "<leader>c", ":set cursorcolumn!<cr>", opts)
-- column
set.colorcolumn:append("79")

-- highlights
vim.cmd([[
    hi CursorLine cterm=bold ctermfg=NONE ctermbg=234
    hi CursorLineNR cterm=bold ctermfg=NONE ctermbg=234
    hi CursorColumn ctermfg=NONE ctermbg=234
    hi ColorColumn ctermfg=NONE ctermbg=234
    hi VertSplit ctermbg=233
    hi FzfBackground ctermbg=233
    hi FzfPreviewBackground ctermbg=234
    hi MatchParen ctermfg=0  ctermbg=1
    hi Error ctermfg=0  ctermbg=1
]])

