-------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/keymaps.lua (archlinux @ 'silent')
-- Date:     Sun 20 Nov 2022 14:23
-- Update:   Mon 08 Jul 2024 22:02
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

-- set comma as leader key
vim.g.mapleader = ","

-- switch colon to semicolon
keymap("n", ";", ":", opt)
keymap("n", ":", ";", opt)

-- no arrows, move the vim way
keymap("n", "<up>", "<nop>", opts)
keymap("n", "<down>", "<nop>", opts)
keymap("n", "<left>", "<nop>", opts)
keymap("n", "<right>", "<nop>", opts)
keymap("i", "<up>", "<nop>", opts)
keymap("i", "<down>", "<nop>", opts)
keymap("i", "<left>", "<nop>", opts)
keymap("i", "<right>", "<nop>", opts)

-- lazy write / quit
keymap("n", "<leader>w", ":w<cr>", opts)
keymap("n", "<leader>q", ":q<cr>", opts)
keymap("n", "<leader>wq", ":wq<cr>", opts)
keymap("n", "<leader>W", ":w!<cr>", opts)
keymap("n", "<leader>Q", ":q!<cr>", opts)
keymap("n", "<leader>WQ", ":wq!<cr>", opts)

-- goto the start of the first line
keymap("n", "gg", "gg0", opts)

-- navigate properly when lines are wrapped
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- toggle relativenumber
keymap("n", "<leader>r", ":set invrnu<cr>", opts)

-- easy folding
-- toggle fold under cursor no jumping around
keymap("n", "z", "za<space>0", opts)

-- maintaining visual mode after shifting > and <
keymap("v", ">", ">gv", opts)
keymap("v", "<", "<gv", opts)

-- move text up and down in visual block mode
keymap("x", "<s-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<s-k>", ":move '<-2<CR>gv-gv", opts)

-- navigate buffers
keymap("n", "<s-l>", ":bnext<cr>", opts)
keymap("n", "<s-h>", ":bprevious<cr>", opts)

-- scrolling command-line history
keymap("c", "<c-j>", "<c-n>", opts)
keymap("c", "<c-k>", "<c-p>", opts)

-- open the current file in the default program
keymap("n", "<leader>x", [[:!xdg-open %<cr><cr>]], opts)

-- no ex mode for me
keymap("n", "Q", "<nop>", opts)

-- prevent accidentally record functionality
keymap("n", "q", "<nop>", opts)
keymap("n", "qq", "q", opts)

-- redirect change operations to blackhole avoid spoiling 'y' register content
keymap("n", "c", '"_c', opts)
keymap("n", "C", '"_C', opts)

-- toggle cursorcolumn
keymap("n", "<leader>c", ":set cursorcolumn!<cr>", opts)

-- toggle netrw
keymap("n", "<leader>nd", ":Lexplore %:p:h<cr>", opts)
keymap("n", "<leader>n", ":Lexplore<cr>", opts)

-- clear highlighting from the search
keymap("n", "<esc>", ":nohlsearch<cr><esc>", opts)

-- toggle spell checking
keymap("n", "<leader>s", ":setlocal spell! spelllang=en_us,nl<cr>", opts)

-- date time stamp
keymap("n", "<leader>dt", [[i<c-r>=strftime("%a %d %Y %H:%M")<cr><space>]], opts)

-- double space over word to find and replace
keymap("n", "<space><space>", [[:%s/\<<c-r>=expand("<cword>")<cr>\>/]], opt)

-- search and replace all
keymap("n", "<s-s>", [[:%s//gI<Left><Left><Left>]], opt)

-- write file if you forgot to give it sudo permission
keymap("c", "w!!", [[w !sudo tee %]], opt)

-- diff since last save
keymap("n", "<leader>df", [[:w !diff % -<cr>]], opt)

