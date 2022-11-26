-------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/netrw.lua (archlinux @ 'silent')
-- Date:     Sun 20 Nov 2022 14:23
-- Update:   Tue 22 Nov 2022 03:19
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

-- delete the hidden buffer
vim.cmd([[
autocmd FileType netrw setl bufhidden=delete
]])

-- configuration
vim.g.netrw_keepdir = 0
vim.g.netrw_winsize = -42
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_use_errorwindow = 1
vim.g.netrw_localcopydircmd = 'cp -r'
vim.g.netrw_bufsettings = 'noma nu nowrap ro'

-- highlight marked files (as search matches)
vim.cmd[[
    hi! link netrwMarkFile Search
]]

-- better toggle Netrw
keymap ('n', '<leader>nd', ':Lexplore %:p:h<cr>', opts)
keymap ('n', '<leader>n', ':Lexplore<cr>', opts)

-- open splits the right way (brodie's hack)
-- open to the right
vim.cmd[[
function! OpenToRight()
	:normal v
	let g:path=expand('%:p')
	execute 'q!'
	execute 'belowright vnew' g:path
	:normal <c-w>l
endfunction
]]
-- open below
vim.cmd[[
function! OpenBelow()
	:normal v
	let g:path=expand('%:p')
	execute 'q!'
	execute 'belowright new' g:path
	:normal <c-w>l
endfunction
]]

-- mapping fun
vim.cmd[[
function! NetrwMappings()
    " Hack fix to make ctrl-l work properly
    noremap <buffer> <c-l> <c-w>l
    noremap <buffer> V :call OpenToRight()<cr>
    noremap <buffer> H :call OpenBelow()<cr>
    " make h and l work as intended
    nmap <buffer> h u
    nmap <buffer> l <cr>
    " toggle marks and remove all marks
    nmap <buffer> <tab> mf
    nmap <buffer> <s-tab> mu
endfunction

augroup netrw_mappings
	autocmd!
	autocmd filetype netrw call NetrwMappings()
augroup END
]]

-- close hidden buffer
vim.cmd[[
    autocmd FileType netrw setl bufhidden=delete
]]

-- close netrw if it's the only buffer open
vim.cmd[[
    autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif
]]


