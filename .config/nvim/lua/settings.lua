-------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/settings.lua (archlinux @ 'silent')
-- Date:     Sun 20 Nov 2022 14:23
-- Update:   Tue 22 Nov 2022 03:20
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
set.clipboard = 'unnamedplus' 					 -- copy(y) paste(p) to/from system buffer
set.number = true                                -- numbers
set.relativenumber = true                     	 -- relative number
set.numberwidth = 5                              -- width 'gutter' column numbering
set.scrolloff = 999                              -- keep cursor away from top and bottom
set.ttyfast = true                               -- faster scrolling
set.virtualedit = 'all'                          -- keep cursor from wobbling around ..
set.undolevels = 100                             -- number of undo levels
set.wildmode = 'longest,full'                    -- auto compleet like shell
set.foldmethod = 'marker'                        -- folding with markers (curly brackets)

-- disable backup and swap files
set.backup = false
set.writebackup = false
set.swapfile = false

-- indentation (PEP8 Python)
set.expandtab = true                             -- convert tab to spaces
set.tabstop = 4                                  -- tab 4 spaces
set.shiftwidth = 4                               -- auto indent spaces
set.smartindent = true                           -- indent the smart way
set.wrap = true                                  -- wrap lines
set.textwidth = 79                               -- line wrap (number of columns)
set.linebreak = true                             -- break line on word
set.breakindent = true                           -- keep indentation
set.breakindentopt = 'shift:2'                   -- emphasize broken lines by indenting them
set.fileformat = 'unix'                          -- just because linux
set.fileencoding = 'utf-8'                       -- the encoding written to file
vim.g['python_highlight_all'] = 1                -- all python syntax highlight features

-- search
set.ignorecase = true                            -- always case insensitive
set.smartcase = true                             -- enable smart case search
keymap('n', '<cr>', ':nohlsearch<cr>', opts)     -- clear highlighting from the search


-- fuzzy file finding
--set.path:append('+') = '**'                      -- search sub folders and tab completion
--vim.cmd[[
--    set path+=**                                     -- search sub folders and tab completion
--]]

-- complete
--set.complete:append('+') = 'kspell'
vim.cmd[[
    set complete+=kspell
]]
set.completeopt = 'menuone,longest'

-- set.shortmess = 'ilmnrx'                  -- flags to shorten vim messages, see :help 'shortmess'
set.shortmess:append('c')                    -- don't give |ins-completion-menu| messages
set.iskeyword:append('-')                    -- hyphenated words recognized by searches
-- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode
set.formatoptions:remove({ 'c', 'r', 'o' })
-- separate vim plugins from neovim in case vim still in use
--set.runtimepath:remove('/usr/share/vim/vimfiles')

