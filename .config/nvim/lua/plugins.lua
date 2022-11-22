-------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/plugins.lua (archlinux @ 'silent')
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


-- plugin configuration

-- fzf.vim

-- find files by name in home directory
keymap ('n', '<leader>ff', ':Files ~/<cr>', opts)
-- find files by name in root directory
keymap ('n', '<leader>fr', ':Files /<cr>', opts)
-- find files by name in working directory
keymap ('n', '<leader>fd', ':Files .<cr>', opts)
-- find and switch buffers
keymap ('n', '<leader>fb', ':Buffers<cr>', opts)
-- find content in current file
keymap ('n', '<leader>f', ':BLines<cr>', opts)
-- find content in all buffers
keymap ('n', '<leader>fa', ':Lines<cr>', opts)
-- find git files in directory
keymap ('n', '<leader>fG', ':GLines<cr>', opts)
-- find content in all files
keymap ('n', '<leader>fg', ':Rg<cr>', opts)

-- customize fzf colors to match your color scheme
-- - fzf#wrap translates this to a set of `--color` options
vim.cmd[[
  let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Normal'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }
]]


-- glow.nvim

-- The script comes with the following defaults:

-- {
--   glow_path = "", -- will be filled automatically with your glow bin in $PATH, if any
--   install_path = "~/.local/bin", -- default path for installing glow binary
--   border = "shadow", -- floating window border config
--   style = "dark|light", -- filled automatically with your current editor background, you can override using glow json style
--   pager = false,
--   width = 80,
-- }

-- To override the custom configuration, call:
--
-- require('glow').setup({
--   -- your override config
-- })

-- Usage
--
-- Preview file
-- :Glow [path-to-md-file]
-- Preview current buffer
-- :Glow
keymap ('n', 'md', ':Glow', opt)
-- Close window
-- :Glow!
keymap ('n', 'mds', ':Glow!', opt)
-- You can also close the floating window using q or <Esc> keys


-- mini.starter

--require('mini.starter').setup(

local starter = require('mini.starter')
  starter.setup({
    evaluate_single = true,
    items = {
      starter.sections.builtin_actions(),
      starter.sections.recent_files(10, false),
      starter.sections.recent_files(10, true),
      -- Use this if you set up 'mini.sessions'
      --starter.sections.sessions(5, true)
    },
    content_hooks = {
      starter.gen_hook.adding_bullet(),
      starter.gen_hook.indexing('all', { 'Builtin actions' }),
      starter.gen_hook.padding(3, 2),
      starter.gen_hook.aligning('center', 'center'),
    },
  })

--)

-- -- No need to copy this inside `setup()`. Will be used automatically.
-- {
--   -- Whether to open starter buffer on VimEnter. Not opened if Neovim was
--   -- started with intent to show something else.
--   autoopen = true,
--
--   -- Whether to evaluate action of single active item
--   evaluate_single = false,
--
--   -- Items to be displayed. Should be an array with the following elements:
--   -- - Item: table with <action>, <name>, and <section> keys.
--   -- - Function: should return one of these three categories.
--   -- - Array: elements of these three types (i.e. item, array, function).
--   -- If `nil` (default), default items will be used (see |mini.starter|).
--   items = nil,
--
--   -- Header to be displayed before items. Converted to single string via
--   -- `tostring` (use `\n` to display several lines). If function, it is
--   -- evaluated first. If `nil` (default), polite greeting will be used.
--   header = nil,
--
--   -- Footer to be displayed after items. Converted to single string via
--   -- `tostring` (use `\n` to display several lines). If function, it is
--   -- evaluated first. If `nil` (default), default usage help will be shown.
--   footer = nil,
--
--   -- Array  of functions to be applied consecutively to initial content.
--   -- Each function should take and return content for 'Starter' buffer (see
--   -- |mini.starter| and |MiniStarter.content| for more details).
--   content_hooks = nil,
--
--   -- Characters to update query. Each character will have special buffer
--   -- mapping overriding your global ones. Be careful to not add `:` as it
--   -- allows you to go into command mode.
--   query_updaters = 'abcdefghijklmnopqrstuvwxyz0123456789_-.',
-- }


-- pywal

-- Active theme
-- To active the theme call this in your neovim config:
--
--   local pywal = require('pywal')
--
-- pywal.setup()
--
-- Or with vim script:
--
--   colorscheme pywal


-- packer

-- automatically run :PackerCompile whenever plugins.lua is updated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- packer, install like: {{
-- git clone --depth 1 https://github.com/wbthomason/packer.nvim \
--   ~/.config/nvim/pack/packer/start/packer.nvim
return require("packer").startup(function()

  use "wbthomason/packer.nvim"

  use 'junegunn/fzf.vim'
  use 'ellisonleao/glow.nvim'
  use {'echasnovski/mini.starter', branch = 'stable'}
  use 'dylanaraps/wal.vim'

end)
-- }}

