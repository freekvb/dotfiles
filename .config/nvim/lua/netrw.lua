------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/netrw.lua (archlinux @ 'silent')
-- Date:     Fri 14 Jul 2025 06:30
-- Update:   Wed 16 Jul 2025 09:22
-- Owner:    fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/
-------------------------------------------------------------------------------

---- netrw ----

-- setttings
vim.g.netrw_keepdir = 0
vim.g.netrw_winsize = -44
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 4
vim.g.netrw_browse_split = 4
vim.g.netrw_use_errorwindow = 1
vim.g.netrw_bufsettings = "noma nu nowrap ro"
vim.g.netrw_bookmark = 1

-- open splits the right way (brodie's hack)
-- open to the right
vim.cmd([[
function! OpenToRight()
	:normal v
	let g:path=expand('%:p')
	execute 'q!'
	execute 'belowright vnew' g:path
	:normal <c-w>l
endfunction
]])
-- open below
vim.cmd([[
function! OpenBelow()
	:normal v
	let g:path=expand('%:p')
	execute 'q!'
	execute 'belowright new' g:path
	:normal <c-w>l
endfunction
]])

-- keymapping function
vim.cmd([[
function! NetrwMappings()
    " Hack fix to make ctrl-l work properly
    noremap <buffer> <c-l> <c-w>l
    " make h and l work as intended
    nmap <buffer> h u
    nmap <buffer> l <cr>
    " close netrw
    nmap <buffer> <Leader>dd :Lexplore<CR>
endfunction
augroup netrw_mappings
	autocmd!
	autocmd filetype netrw call NetrwMappings()
augroup END
]])

-- close hidden buffer
vim.cmd([[
    autocmd FileType netrw setl bufhidden=delete
]])
-- close netrw if it's the only buffer open
vim.cmd([[
    autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif
]])

