-------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/personal_settings.lua (archlinux @ 'silent')
-- Date:     Sun 20 Nov 2022 14:23
-- Update:   Wed 12 Jun 2024 08:44
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
keymap("n", "sb", [[i#!/bin/sh<cr><cr>]], opts)

-- notes - all notes in markdown (.md)
-- new note 'nn' in terminal [$HOME/Notes/.new_note.md]
-- save (and quit) finished note in $HOME/Notes [title]
keymap("n", "sn", [[:w<cr>:!save_note<cr>:q<cr>]], opt)
-- save (and quit) note as gnote in $HOME/Notes/.gnotes [time stamp title] and on github
keymap("n", "sg", [[:w<cr>:!save_gnote<cr>:q<cr>]], opt)
-- save (and quit) modified gnote in $HOME/Notes/.gnotes [time stamp title] and on github
keymap("n", "sm", [[:w<cr>:!save_gnote_modified<cr>:q<cr>]], opt)

-- set cursor just under the title
keymap("n", "gt", [[gg0jj]], opts)

-- some markdown shortkeys
-- set note title and go write some content
keymap("n", "mt", [[o<cr>####<space>]], opt)
-- insert some code
keymap("n", "mc", [[o```<cr>```<esc>kli]], opt)
-- add last lynx bookmark(s)
keymap("n", "ml", [[:r!lxa<cr>]], opt)
-- insert last qutebrowser quickmark(s)
keymap("n", "mq", [[:r!qma<cr>]], opt)

-- trade notes ('nt' in terminal in '$HOME/Notes/trades' directory)
-- save trade note [time stamp]
keymap("n", "st", [[:saveas $HOME/Notes/trades/<c-r>=strftime("%d %b %Y %H:%M:%S")<cr>.md<cr>]], opt)
-- insert last trade screenshot in trade note with timestamp above screenshot
keymap(
	"n",
	"tp",
	[[:r!tp<cr>i######<space><esc>$3hDi<cr>[![trade](./tp/<esc>:r!tp<cr>i<backspace><esc>$li)](./tp/<esc>:r!tp<cr>i<backspace><esc>$li)<cr><cr><esc>]],
	opts
)

-- insert title time stamp
keymap("n", "<leader>t", [[:r!dt<cr>kddo---<cr><esc>]], opts)
-- insert Agenda
keymap("n", "tc", [[:r!trade_calendar<cr>]], opts)
-- insert Narratief
keymap("n", "tn", [[:r!trade_narrative<cr>]], opts)
-- insert Executie
keymap("n", "te", [[:r!trade_execution<cr>34k]], opts)
-- insert Checklijst
keymap("n", "tl", [[:r!trade_list<cr>13kdd11k12li]], opts)
-- insert Samenvatting
keymap("n", "ts", [[:r!trade_summarize<cr>]], opts)
-- insert Resultaat
keymap("n", "tr", [[:r!trade_result<cr>]], opts)

-- blog entry
keymap("n", "<leader>be", [[:/#<cr><cr><cr>jO<c-r>=strftime("%a %d %b %Y %H:%M")<cr><cr><cr><esc>2ko]], opts)

