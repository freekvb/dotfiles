-------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/colors.lua (archlinux @ 'silent')
-- Date:     Sun 20 Nov 2022 14:23
-- Update:   Tue 22 Nov 2022 03:19
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


-- colorscheme - lua plugin
vim.cmd[[
    colorscheme wal
]]

-- set colored cursor line
vim.cmd[[
set cursorline
    hi CursorLine cterm=bold ctermfg=NONE ctermbg=234
    hi CursorLineNR cterm=bold ctermfg=NONE ctermbg=234
]]
--set cursor column
vim.cmd[[
set cursorcolumn
nnoremap <leader>c :set cursorcolumn!<cc>
    hi CursorColumn ctermfg=NONE ctermbg=234
]]
-- set colored column
vim.cmd[[
set colorcolumn=79
    hi ColorColumn ctermfg=NONE ctermbg=234
]]
-- set split separation color
vim.cmd[[
    hi VertSplit ctermbg=233
]]

