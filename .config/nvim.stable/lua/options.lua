-------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/options.lua (archlinux @ 'silent')
-- Date:     Fri 14 Jul 2025 06:30
-- Update:   Thu 31 Jul 2025 04:27
-- Owner:    fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/
-------------------------------------------------------------------------------

---- options ----

-- window title on
vim.o.title = true

-- copy(y) paste(p) to/from system buffer
vim.opt.clipboard:append("unnamed,unnamedplus")

-- numbers
vim.o.number = true
-- relative number
vim.o.relativenumber = true
-- keep cursor away from top and bottom
vim.o.scrolloff = 10
-- keep cursor from wobbling around
vim.o.virtualedit = "all"
-- delete fillshars (~)
vim.opt.fillchars = { eob = " "}

-- disable backup and swap files
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- convert tab to spaces
vim.o.expandtab = true
-- tab 4 spaces
vim.o.tabstop = 4
vim.o.softtabstop = 4
-- auto indent spaces
vim.o.shiftwidth = 4
-- wrap lines
vim.o.wrap = true
-- line wrap (number of columns)
vim.o.textwidth = 80
-- break line on word
vim.o.linebreak = true
-- keep indentation
vim.o.breakindent = true
-- emphasize broken lines by indenting them
vim.o.breakindentopt = "shift:2"

-- markdown highlighting
vim.cmd([[
    au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
]])

-- instant markdown
vim.g["instant_markdown_autostart"] = 0
vim.g["instant_markdown_browser"] = "qutebrowser --target window"

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
vim.opt.completeopt = "menu,menuone,noselect,popup,fuzzy"
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
    autocmd VimEnter * highlight CursorLine cterm=bold,italic ctermbg=234 ctermfg=NONE guibg=grey11 guifg=NONE
    autocmd InsertEnter * highlight CursorLine cterm=NONE ctermbg=0 ctermfg=NONE guibg=0 guifg=NONE
    autocmd InsertLeave * highlight CursorLine cterm=bold,italic ctermbg=234 ctermfg=NONE guibg=grey11 guifg=NONE
]])

-- cursorcolumn disabled in insert mode
vim.cmd([[
    autocmd VimEnter * highlight CursorColumn ctermbg=234 ctermfg=NONE guibg=grey11 guifg=NONE
    autocmd InsertEnter * highlight CursorColumn ctermbg=0 ctermfg=NONE guibg=0 guifg=NONE
    autocmd InsertLeave * highlight CursorColumn ctermbg=234 ctermfg=NONE guibg=grey11 guifg=NONE
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

-- highlights
vim.cmd([[
    hi DiffText gui=bold guibg=#506150  guifg=#ececec
    hi DiffAdd guibg=#615050 guifg=#ececec
    hi DiffChange guibg=#505061 guifg=#ececec
    hi DiffDelete guibg=#615950 guifg=#ececec
    hi EndOfBuffer ctermfg=0 guifg=black
    hi MatchParen guibg=gray35 guifg=fb
    hi Pmenu ctermbg=0 ctermfg=4 guibg=grey7 guifg=fb
    hi PmenuSel ctermbg=0 ctermfg=12 guibg=grey35 guifg=fb
    hi QuickfixLine guibg=#b29951 guifg=grey3
    hi Search guibg=gray15 guifg=fb gui=underline
    hi SpellBad cterm=underline gui=underline
    hi Visual guibg=#2f2f27 guifg=#ececec
]])

-- mode
vim.o.showmode = false
-- commands
vim.o.showcmd = false
-- command bar height
vim.o.cmdheight = 0
-- prompt message options
vim.opt.shortmess:append("acsSW")
-- disable substitution preview
vim.o.inccommand = ""

-- python provider
vim.g["python3_host_prog"] = "/usr/bin/python3"
-- perl provider
vim.g["loaded_perl_provider"] = 0
-- node.js provider
vim.g["loaded_node_provider"] = 0
-- ruby provider
vim.g["loaded_ruby_provider"] = 0

