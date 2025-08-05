------------------------------------------------------------------------------
-- File:    ~/.config/nvim/lua/netrw.lua (archlinux @ 'silent')
-- Date:    Fri 01 Aug 2025 21:30
-- Update:  Mon 04 Aug 2025 09:55
-- Owner:   fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/
-------------------------------------------------------------------------------

---- netrw ----

vim.g.netrw_keepdir = 0
vim.g.netrw_winsize = -62
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 4
vim.g.netrw_alto = 1
vim.g.netrw_altv = 1
vim.g.netrw_browse_split = 4
vim.g.netrw_use_errorwindow = 1
vim.g.netrw_bufsettings = "noma nomod nu rnu nobl nowrap ro"
vim.g.netrw_bookmark = 1

-- open splits the right way (brodie's hack)
-- open to the right
vim.cmd(
    [[
    function! OpenToRight()
        :normal v
        let g:path=expand('%:p')
        execute 'q!'
        execute 'belowright vnew' g:path
        :normal <c-w>l
    endfunction
]]
)
-- open below
vim.cmd(
    [[
    function! OpenBelow()
        :normal v
        let g:path=expand('%:p')
        execute 'q!'
        execute 'belowright new' g:path
        :normal <c-w>l
    endfunction
]]
)

-- keymapping function
vim.cmd(
    [[
    function! NetrwMappings()
        " Hack fix to make ctrl-l work properly
            noremap <buffer> <c-l> <c-w>l
            noremap <buffer> V :call OpenToRight()<cr>:vert resize 144<cr>
            noremap <buffer> S :call OpenBelow()<cr>
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
]]
)

-- close hidden buffer
vim.cmd(
    [[
    autocmd FileType netrw setl bufhidden=delete
]]
)

-- close netrw if it's the only buffer open
vim.cmd(
    [[
    autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), '&filetype') == 'netrw' || &buftype == 'quickfix' |q|endif
]]
)

-- no dubble netrw buffers
vim.cmd(
    [[
    let g:NetrwIsOpen=0
    function! ToggleNetrw()
        if g:NetrwIsOpen
            let i = bufnr('$')
            while (i >= 1)
                if (getbufvar(i, '&filetype') == 'netrw')
                    silent exe 'bwipeout ' . i
                endif
                let i-=1
            endwhile
            let g:NetrwIsOpen=0
        else
            let g:NetrwIsOpen=1
            silent Lexplore
        endif
    endfunction
]]
)

-- close after opening file
vim.cmd(
    [[
    let g:netrw_fastbrowse = 0
    autocmd FileType netrw setl bufhidden=wipe
    function! CloseNetrw() abort
        for bufn in range(1, bufnr('$'))
            if bufexists(bufn) && getbufvar(bufn, '&filetype') ==# 'netrw'
                silent! execute 'bwipeout ' . bufn
            if getline(2) =~# '^" Netrw '
                silent! bwipeout
            endif
                return
            endif
        endfor
    endfunction
augroup closeOnOpen
    autocmd!
    autocmd BufWinEnter * if getbufvar(winbufnr(winnr()), '&filetype') != 'netrw'|call CloseNetrw()|endif
augroup END
]]
)

