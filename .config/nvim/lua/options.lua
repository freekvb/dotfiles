-------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/options.lua (archlinux @ 'silent')
-- Date:     Fri 01 Aug 2025 21:30
-- Update:   Sat 02 Aug 2025 01:47
-- Owner:    fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/
-------------------------------------------------------------------------------


---- options ----

vim.o.clipboard = 'unnamed,unnamedplus'

vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.swapfile = false
vim.o.scrolloff = 10
vim.o.virtualedit = "all"
vim.opt.fillchars = { eob = " "}

-- markdown
vim.cmd([[
    au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
]])

-- split buffers
vim.o.splitright = true
vim.o.splitbelow = true

-- search case insensitive
vim.o.ignorecase = true
-- enable smart case search
vim.o.smartcase = true

-- fuzzy file finding
vim.opt.path:append("**")
-- wildmenu
vim.o.wildmenu = true
-- auto complete like shell
vim.o.wildmode = "longest:full,full"
-- case insensitive
vim.o.wildignorecase = true
-- dash is part of word
vim.opt.iskeyword:append("-")

-- completion
vim.opt.complete:append("kspell")
vim.opt.completeopt = "menu,menuone,noselect,popup"
vim.opt.completeopt:append("fuzzy")
vim.o.pumheight = 15

-- tab completion
vim.cmd([[
function! CleverTab()
    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
        return "\<Tab>"
    else
        return "\<C-N>"
    endif
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>
]])

-- folding (curly brackets)
vim.o.foldmethod = "marker"

-- remove trailing white space
vim.cmd([[
    autocmd BufWritePre * %s/\s\+$//e
]])

-- return to last edit position at opening file
vim.cmd([[
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])

-- cursorline
vim.o.cursorline = true
-- cursorcolumn
vim.o.cursorcolumn = true

-- cursorline disabled in insert mode
vim.cmd([[
    autocmd VimEnter * highlight CursorLine gui=bold,italic guibg=grey3 guifg=NONE
    autocmd InsertEnter * highlight CursorLine guibg=0 guifg=NONE
    autocmd InsertLeave * highlight CursorLine gui=bold,italic guibg=grey3 guifg=NONE
]])

-- cursorcolumn disabled in insert mode
vim.cmd([[
    autocmd VimEnter * highlight CursorColumn guibg=grey3 guifg=NONE
    autocmd InsertEnter * highlight CursorColumn guibg=0 guifg=NONE
    autocmd InsertLeave * highlight CursorColumn guibg=grey3 guifg=NONE
]])

-- automatically leave insert mode
vim.cmd([[
    au CursorHoldI * stopinsert
]])

-- insert mode inactive time
vim.cmd([[
    au InsertEnter * let updaterestore=&updatetime | set updatetime=5000
    au InsertLeave * let &updatetime=updaterestore
]])

-- command line
vim.o.showmode = false
vim.o.showcmd = false
vim.o.cmdheight = 0
vim.opt.shortmess:append("acsSW")
vim.o.inccommand = ""

-- providers
vim.g["python3_host_prog"] = "/usr/bin/python3"
vim.g["loaded_perl_provider"] = 0
vim.g["loaded_node_provider"] = 0
vim.g["loaded_ruby_provider"] = 0

