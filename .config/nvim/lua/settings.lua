-------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/settings.lua (archlinux @ 'silent')
-- Date:     Sun 20 Nov 2022 14:23
-- Update:   Mon 28 Nov 2022 13:54
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


-- general settings
set.clipboard = 'unnamedplus' 					-- copy(y) paste(p) to/from system buffer
set.number = true                               -- numbers
set.relativenumber = true                     	-- relative number
set.numberwidth = 5                             -- width 'gutter' column numbering
set.scrolloff = 999                             -- keep cursor away from top and bottom
set.ttyfast = true                              -- faster scrolling
set.virtualedit = 'all'                         -- keep cursor from wobbling around ..
set.undolevels = 100                            -- number of undo levels
set.wildmode = 'longest,full'                   -- auto compleet like shell
set.foldmethod = 'marker'                       -- folding with markers (curly brackets)

-- disable backup and swap files
set.backup = false
set.writebackup = false
set.swapfile = false

-- format settings
set.expandtab = true                            -- convert tab to spaces
set.tabstop = 4                                 -- tab 4 spaces
set.softtabstop = 4                             -- tab 4 spaces
set.shiftwidth = 4                              -- auto indent spaces
set.smartindent = true                          -- indent the smart way
set.wrap = true                                 -- wrap lines
set.textwidth = 79                              -- line wrap (number of columns)
set.linebreak = true                            -- break line on word
set.breakindent = true                          -- keep indentation
set.breakindentopt = 'shift:2'                  -- emphasize broken lines by indenting them
set.fileformat = 'unix'                         -- just because linux
set.fileencoding = 'utf-8'                      -- the encoding written to file
vim.g['python_highlight_all'] = 1               -- all python syntax highlight features

-- search
set.ignorecase = true                           -- always case insensitive
set.smartcase = true                            -- enable smart case search
keymap('n', '<cr>', ':nohlsearch<cr>', opts)    -- clear highlighting from the search

-- fuzzy file finding
set.path:append '**'                            -- search sub folders and tab completion

-- complete
set.complete:append 'kspell'
set.completeopt = 'menuone,longest'

-- set filetype
vim.g.do_filetype_lua = 1

