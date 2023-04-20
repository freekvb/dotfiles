-------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/personal_settings.lua (archlinux @ 'silent')
-- Date:     Sun 20 Nov 2022 14:23
-- Update:   Tue 17 Jan 2023 09:44
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

-- header update
keymap("n", "<leader>h", [[gg/Update<cr>2wc$<c-r>=strftime("%a %d %b %Y %H:%M")<cr><esc>03j:nohlsearch<cr>]], opts)

-- shebang
keymap("n", "sb", [[i#!/usr/bin/sh<cr><cr>]], opts)

-- notes - all notes in markdown (.md)
-- new note 'nn' in terminal
-- save note in $HOME/Notes/ (title)
keymap("n", "sn", ":saveas ~/Notes/", opt)

-- trade notes ('nn' in terminal in '$HOME/Notes/trades' directory)
-- save trade note (time stamp)
keymap("n", "st", [[:saveas $HOME/Notes/trades/<c-r>=strftime("%d %b %Y %H:%M:%S")<cr>.md<cr>]], opt)
-- insert last trade screenshot in trade note with timestamp above screenshot
keymap(
	"n",
	"tp",
	[[:r!tp<cr>i######<space><esc>$3hDi<cr>[![trade](./tp/<esc>:r!tp<cr>i<backspace><esc>$li)](./tp/<esc>:r!tp<cr>i<backspace><esc>$li)<cr><cr><esc>]],
	opts
)
-- insert Calendar
keymap("n", "tc", [[:r!trade_cal<cr>]], opts)
-- insert HTF
keymap("n", "th", [[:r!trade_htf<cr>]], opts)
-- insert TTF
keymap("n", "tt", [[:r!trade_ttf<cr>]], opts)
-- insert Narrative
keymap("n", "tn", [[:r!trade_narrative<cr>]], opts)
-- insert Execute
keymap("n", "te", [[:r!trade_execute<cr>]], opts)
-- insert Summarize
keymap("n", "ts", [[:r!trade_summarize<cr>]], opts)
-- insert Result
keymap("n", "tr", [[:r!trade_result<cr>]], opts)

-- zettel notes
-- save zettel zettelkasten note (time stamp)
keymap("n", "sz", [[:saveas $HOME/Notes/zet/<c-r>=strftime("%Y%m%d%H%M%S%z")<cr>.md<cr>]], opt)

-- blog entry
keymap("n", "<leader>be", [[:/#<cr><cr><cr>jO<c-r>=strftime("%a %d %b %Y %H:%M")<cr><cr><cr><esc>2ko]], opts)

