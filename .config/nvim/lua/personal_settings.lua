-------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/personal_settings.lua (archlinux @ 'silent')
-- Date:     Sun 20 Nov 2022 14:23
-- Update:   Sat 26 Nov 2022 15:37
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


-- header update
vim.cmd[[
nnoremap <leader>h gg/Update<cr>2wc$<c-r>=strftime("%a %d %b %Y %H:%M")<cr><esc>:nohlsearch<cr>
]]

-- shebang
vim.cmd[[
nnoremap sb i#!/usr/bin/sh<cr><cr>
]]

-- notes - all notes in markdown (.md)
-- new note 'nn' in terminal

-- save note in $HOME/Notes/ (title)
keymap ('n', 'sn', ':saveas ~/Notes/', opt)

-- trade notes ('nn' in terminal in '$HOME/Notes/trades' directory)
-- save trade note (time stamp)
vim.cmd[[
nnoremap st :saveas $HOME/Notes/trades/<c-r>=strftime("%d %b %Y %H:%M:%S")<cr>.md<cr>
]]
-- insert last trade screenshot in trade note with timestamp above screenshot
vim.cmd[[
nnoremap tp :r!tp<cr>i######<space><esc>$3hDi<cr>[![trade](./tp/<esc>:r!tp<cr>i<backspace><esc>$li)](./tp/<esc>:r!tp<cr>i<backspace><esc>$li)<cr><cr><esc>
]]
-- insert Calendar
vim.cmd[[
nnoremap tc :r!trade_cal<cr>
]]
-- insert HTF
vim.cmd[[
nnoremap th :r!trade_htf<cr>
]]
-- insert TTF
vim.cmd[[
nnoremap tt :r!trade_ttf<cr>
]]
-- insert Execute
vim.cmd[[
nnoremap te :r!trade_execute<cr>
]]
-- insert Result
vim.cmd[[
nnoremap tr :r!trade_result<cr>
]]

-- zettel notes
-- save zettel zettelkasten note (time stamp)
vim.cmd[[
nnoremap sz :saveas $HOME/Notes/zet/<c-r>=strftime("%Y%m%d%H%M%S%z")<cr>.md<cr>
]]

-- blog entry
vim.cmd[[
nnoremap <leader>be :/#<cr><cr><cr>jO<c-r>=strftime("%a %d %b %Y %H:%M")<cr><cr><cr><esc>2ko
]]

