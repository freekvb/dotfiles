-------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/keymaps.lua (archlinux @ 'silent')           --
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

-- split windows
-- 'split' horizontal below
set.splitbelow = true
-- 'vsplit' vertical on the right
set.splitright = true
-- open split
keymap("n", "sp", ":split<cr>", opts)
-- 'vsplit' in dwm master stack ratio
keymap("n", "vs", ":vsplit<cr>:vert resize 128<cr>", opts)
-- navigate split windows
keymap("n", "<c-h>", "<c-w>h", opts)
keymap("n", "<c-j>", "<c-w>j", opts)
keymap("n", "<c-k>", "<c-w>k", opts)
keymap("n", "<c-l>", "<c-w>l", opts)

-- terminal in split below, resize and start insert mode
keymap("n", "<leader>st", ":sp<bar>resize15<bar>term<cr>", opts)
vim.cmd([[
	autocmd TermOpen * startinsert
]])
keymap("t", "<esc>", "<c-\\><c-n>", {})

-- navigate buffers
keymap("n", "<s-l>", ":bnext<cr>", opts)
keymap("n", "<s-h>", ":bprevious<cr>", opts)

-- scrolling command-line history
keymap("c", "<c-j>", "<c-n>", opts)
keymap("c", "<c-k>", "<c-p>", opts)

-- allow gf to open non-existent files
keymap("n", "gf", [[:edit <cfile><cr>]], opts)

-- open the current file in the default program
keymap("n", "<leader>x", [[:!xdg-open %<cr><cr>]], opts)

-- no ex mode for me
keymap("n", "Q", "<nop>", opts)

-- prevent accidentally record functionality
keymap("n", "q", "<nop>", opts)
keymap("n", "qq", "q", opts)
