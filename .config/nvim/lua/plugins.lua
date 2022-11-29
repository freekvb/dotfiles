-------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/plugins.lua (archlinux @ 'silent')
-- Date:     Sun 20 Nov 2022 14:23
-- Update:   Mon 28 Nov 2022 14:41
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
keymap("n", "<leader>ff", ":Files ~/<cr>", opts)
-- find files by name in root directory
keymap("n", "<leader>fr", ":Files /<cr>", opts)
-- find files by name in working directory
keymap("n", "<leader>fd", ":Files<cr>", opts)
-- find and switch buffers
keymap("n", "<leader>fb", ":Buffers<cr>", opts)
-- find content in current file
keymap("n", "<leader>f", ":BLines<cr>", opts)
-- find content in all buffers
keymap("n", "<leader>fa", ":Lines<cr>", opts)
-- find content in all files
keymap("n", "<leader>fg", ":Rg<cr>", opts)

-- customize fzf colors to match your color scheme
-- fzf#wrap translates this to a set of `--color` options
vim.cmd([[
  let g:fzf_colors =
  \ { 'fg':         ['fg', 'Normal'],
    \ 'bg':         ['bg', 'FzfBackground'],
    \ 'preview-bg': ['preview-bg', 'FzfPreviewBackground'],
    \ 'hl':         ['fg', 'Comment'],
    \ 'fg+':        ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':        ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':        ['fg', 'Statement'],
    \ 'info':       ['fg', 'PreProc'],
    \ 'border':     ['fg', 'NonText'],
    \ 'prompt':     ['fg', 'Conditional'],
    \ 'pointer':    ['fg', 'Exception'],
    \ 'marker':     ['fg', 'Keyword'],
    \ 'spinner':    ['fg', 'Label'],
    \ 'header':     ['fg', 'Comment'] }
]])

-- vim.instant-markdown

-- minimal default configuration
--Uncomment to override defaults:
--vim.g.instant_markdown_slow = 1
vim.g.instant_markdown_autostart = 0
vim.g.instant_markdown_browser = "qutebrowser --target window"
--vim.g.instant_markdown_open_to_the_world = 1
--vim.g.instant_markdown_allow_unsafe_content = 1
--vim.g.instant_markdown_allow_external_content = 0
--vim.g.instant_markdown_mathjax = 1
--vim.g.instant_markdown_mermaid = 1
--vim.g.instant_markdown_logfile = '/tmp/instant_markdown.log'
--vim.g.instant_markdown_autoscroll = 0
--vim.g.instant_markdown_port = 8888
--vim.g.instant_markdown_python = 1f

-- keymaps
keymap("n", "md", ":InstantMarkdownPreview<cr>", opt)
keymap("n", "mds", ":InstantMarkdownStopKcr>", opt)

-- pywal

-- active theme
-- to active the theme call this in your nvim config (colors.lua):
--
--   local pywal = require('pywal')
-- pywal.setup()
--
-- or with vim script:
--
-- vim.cmd[[
--     colorscheme pywal
-- ]]

-- packer

-- packer, install like: {{
-- git clone --depth 1 https://github.com/wbthomason/packer.nvim \
--   ~/.config/nvim/pack/packer/start/packer.nvim
return require("packer").startup(function()
	use("wbthomason/packer.nvim")

	use("junegunn/fzf.vim")
	use({ "instant-markdown/vim-instant-markdown" })
	use("dylanaraps/wal.vim")

	-- automatically run :PackerCompile whenever plugins.lua is updated
	vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
end)
-- }}
