-------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/options.lua (archlinux @ 'silent')
-- Date:     Fri 14 Jul 2025 06:30
-- Update:   Sat 19 Jul 2025 15:29
-- Owner:    fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/
-------------------------------------------------------------------------------

---- options ----

-- window title on
vim.opt.title = true

-- copy(y) paste(p) to/from system buffer
vim.opt.clipboard:append("unnamed,unnamedplus")

-- numbers
vim.opt.number = true
-- relative number
vim.opt.relativenumber = true
-- keep cursor away from top and bottom
vim.opt.scrolloff = 10
-- keep cursor from wobbling around
vim.opt.virtualedit = "all"

-- convert tab to spaces
vim.opt.expandtab = true
-- tab 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
-- auto indent spaces
vim.opt.shiftwidth = 4
-- wrap lines
vim.opt.wrap = true
-- line wrap (number of columns)
vim.opt.textwidth = 80
-- break line on word
vim.opt.linebreak = true
-- keep indentation
vim.opt.breakindent = true
-- emphasize broken lines by indenting them
vim.opt.breakindentopt = "shift:2"

-- markdown inbedded code highlighting
vim.g["markdown_fenced_languages"] = { "bash=sh", "python", "vim", "lua", "c", "html" }

-- instant markdown
vim.g["instant_markdown_autostart"] = 0
vim.g["instant_markdown_browser"] = "qutebrowser --target window"

-- split buffers
vim.opt.splitright = true
vim.opt.splitbelow = true

-- search case insensitive
vim.opt.ignorecase = true
-- enable smart case search
vim.opt.smartcase = true

-- fuzzy file finding
vim.opt.path:append("**")
-- wildmenu
vim.opt.wildmenu = true
-- auto complete like shell
vim.opt.wildmode = "longest:full,full"
-- case insensitive
vim.opt.wildignorecase = true

-- dash is part of word
vim.opt.iskeyword:append("-")

-- completion
vim.opt.complete:append("kspell")
vim.opt.completeopt = "menu,menuone,noselect,popup"
vim.opt.completeopt:append("fuzzy")
vim.opt.pumheight = 15
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
vim.opt.foldmethod = "marker"

-- remove trailing white space
vim.cmd([[
    autocmd BufWritePre * %s/\s\+$//e
]])

-- return to last edit position at opening file
vim.cmd([[
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])

-- colorscheme
vim.cmd[[
    colorscheme wal
]]
-- make colorscheme work
vim.opt.termguicolors = false

-- cursorline
vim.opt.cursorline = true
-- cursorcolumn
vim.opt.cursorcolumn = true
-- colorcolumn
vim.opt.colorcolumn = '80'

-- cursorline disabled in insert mode
vim.cmd([[
    autocmd InsertEnter * highlight CursorLine cterm=NONE ctermbg=0 ctermfg=NONE
    autocmd InsertLeave * highlight CursorLine cterm=bold,italic ctermbg=234 ctermfg=NONE
]])
-- cursorcolumn disabled in insert mode
vim.cmd([[
    autocmd InsertEnter * highlight CursorColumn ctermbg=0 ctermfg=NONE
    autocmd InsertLeave * highlight CursorColumn ctermbg=234 ctermfg=NONE
]])

-- highlights
vim.cmd([[
    hi CursorLine cterm=bold,italic ctermbg=234 ctermfg=NONE
    hi CursorLineNR cterm=bold ctermfg=NONE ctermbg=234
    hi CursorColumn ctermfg=NONE ctermbg=234
    hi ColorColumn ctermfg=233 ctermbg=NONE
    hi Pmenu ctermbg=0 ctermfg=4
    hi PmenuSel ctermbg=0 ctermfg=12
    hi EndOfBuffer ctermfg=0
]])

-- statusline [lualine plugin]
-- automatically leave insert mode
vim.cmd([[
    au CursorHoldI * stopinsert
]])
-- insert mode inactive time
vim.cmd([[
    au InsertEnter * let updaterestore=&updatetime | set updatetime=5000
    au InsertLeave * let &updatetime=updaterestore
]])

-- command bar
-- mode
vim.opt.showmode = false
-- commands
vim.opt.showcmd = false
-- command bar height
vim.opt.cmdheight = 0
-- prompt message options
vim.opt.shortmess:append("acsSW")
-- disable substitution preview
vim.opt.inccommand = ""

-- providers
-- perl provider
vim.g["loaded_perl_provider"] = 0
-- node.js provider
vim.g["loaded_node_provider"] = 0
-- ruby provider
vim.g["loaded_ruby_provider"] = 0

