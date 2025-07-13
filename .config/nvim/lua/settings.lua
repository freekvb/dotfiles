-------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/settings.lua (archlinux @ 'silent')
-- Date:     Sun 20 Nov 2022 14:23
-- Update:   Sun 13 Jul 2025 22:40
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

-- general settings
-- copy(y) paste(p) to/from system buffer
set.clipboard:append("unnamed,unnamedplus")
-- set numbers
set.number = true
-- relative number
set.relativenumber = true
-- width 'gutter' column numbering
set.numberwidth = 5
-- keep cursor away from top and bottom
set.scrolloff = 999
-- keep cursor away from the sides
set.sidescrolloff = 8
-- keep cursor from wobbling around
set.virtualedit = "all"
--faster scrolling
set.ttyfast = true
-- smooth scrolling
set.smoothscroll = true
-- number of undo levels
set.undolevels = 100
-- auto compleet like shell
set.wildmode = "longest,full"
-- folding with markers (curly brackets)
set.foldmethod = "marker"
-- set window title on
set.title = true
-- backspace
set.backspace = "indent,eol,start"
-- disable backup and swap files
set.backup = false
set.writebackup = false
set.swapfile = false

-- format settings
-- convert tab to spaces
set.expandtab = true
-- tab 4 spaces
set.tabstop = 4
set.softtabstop = 4
-- auto indent spaces
set.shiftwidth = 4
-- round indentation
set.shiftround = true
-- copy current indent
set.autoindent = true
-- indent the smart way
set.smartindent = true
-- wrap lines
set.wrap = true
-- line wrap (number of columns)
set.textwidth = 80
-- break line on word
set.linebreak = true
-- keep indentation
set.breakindent = true
-- emphasize broken lines by indenting them
set.breakindentopt = "shift:2"
-- just because linux
set.fileformat = "unix"
-- all python syntax highlight features
vim.g["python_highlight_all"] = 1

-- search
-- always case insensitive
set.ignorecase = true
-- enable smart case search
set.smartcase = true

-- fuzzy file finding
-- search sub folders and tab completion
set.path:append("**")

-- dash is part of word
set.iskeyword:append("-")

-- complete
set.complete:append("kspell")
set.completeopt =  { "menuone", "longest" }

-- syntax
set.syntax = on

-- set filetype
vim.g.do_filetype_lua = 1

-- set formatoptions
vim.opt.formatoptions = {
    ["1"] = true,
    ["2"] = true,   -- use indent from 2nd line of a paragraph
    q = true,       -- continue comments with gq"
    c = true,       -- auto-wrap comments using textwidth
    r = true,       -- continue comments when pressing Enter
    n = true,       -- recognize numbered lists
    t = false,      -- autowrap lines using text width value
    j = true,       -- remove a comment leader when joining lines
    -- only break if the line was not longer than 'textwidth' when the insert
    -- started and only at a white character that has been entered during the
    -- current insert command.
    l = true,
    v = true,
}

