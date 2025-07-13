-------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/personal_settings.lua (archlinux @ 'silent')
-- Date:     Sun 20 Nov 2022 14:23
-- Update:   Sun 13 Jul 2025 22:27
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

-- header update
keymap("n", "<leader>h", [[gg/Update<cr>2wc$<c-r>=strftime("%a %d %b %Y %H:%M")<cr><esc>03j:nohlsearch<cr>]], opts)

-- shebang
keymap("n", "sb", [[i#!/bin/sh<cr><cr>]], opts)

-- set cursor just under the title
keymap("n", "gt", [[gg0jj]], opts)

-- blog entry
keymap("n", "<leader>be", [[:/#<cr><cr><cr>jO<c-r>=strftime("%a %d %b %Y %H:%M")<cr><cr><cr><esc>2ko]], opts)

-- notes - all notes in markdown (.md)
-- new note 'nn' in terminal [$HOME/Notes/.new_note.md]
-- save (and quit) finished note in $HOME/Notes [title]
keymap("n", "sn", [[:w<cr>:!save_note<cr>:q<cr>]], opt)
-- save (and quit) note as gnote in $HOME/Notes/.gnotes [time stamp title] and on github
keymap("n", "sg", [[:w<cr>:!save_gnote<cr>:q<cr>]], opt)
-- save (and quit) modified gnote in $HOME/Notes/.gnotes [time stamp title] and on github
keymap("n", "sm", [[:w<cr>:!save_gnote_modified<cr>:q<cr>]], opt)

-- some markdown shortkeys
-- set note title and go write some content
keymap("n", "mt", [[o<cr>####<space>]], opt)
-- insert some code
keymap("n", "mc", [[o```<cr>```<esc>kli]], opt)
-- add last lynx bookmark(s)
keymap("n", "ml", [[:r!lxa<cr>]], opt)
-- insert last qutebrowser quickmark(s)
keymap("n", "mq", [[:r!qma<cr>]], opt)

