------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/options.lua (archlinux @ 'silent')
-- Date:     Fri 14 Jul 2025 06:30
-- Update:   Tue 15 Jul 2025 15:52
-- Owner:    fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/
-------------------------------------------------------------------------------

---- options ----

-- copy(y) paste(p) to/from system buffer
vim.opt.clipboard:append("unnamed,unnamedplus")
-- numbers
vim.opt.number = true
-- relative number
vim.opt.relativenumber = true
-- keep cursor away from top and bottom
vim.opt.scrolloff = 20
-- keep cursor from wobbling around
vim.opt.virtualedit = "all"
-- window title on
vim.opt.title = true
-- convert tab to spaces
vim.opt.expandtab = true
-- tab 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
-- auto indent spaces
vim.opt.shiftwidth = 4

-- split buffers
vim.opt.splitright = true
vim.opt.splitbelow = true

-- find
vim.opt.wildmenu = true
-- fuzzy file finding
vim.opt.path:append("**")
-- auto complete like shell
vim.opt.wildmode = "longest:full,full"
-- case insensitive
vim.opt.wildignorecase = true

-- completion
vim.opt.complete:append("kspell")
vim.opt.completeopt = "menu,menuone,popup"
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

-- cursor line
vim.opt.cursorline = true
-- cursor line disabled in insert mode
vim.cmd([[
    autocmd InsertEnter * highlight CursorLine cterm=NONE ctermbg=0 ctermfg=NONE
    autocmd InsertLeave * highlight CursorLine cterm=bold ctermbg=236 ctermfg=NONE
]])
-- cursor column
vim.opt.cursorcolumn = true
-- cursor column disabled in insert mode
vim.cmd([[
    autocmd InsertEnter * highlight CursorColumn ctermbg=0 ctermfg=NONE
    autocmd InsertLeave * highlight CursorColumn ctermbg=236 ctermfg=NONE
]])

-- colorscheme
vim.cmd[[
    colorscheme wal
]]
-- make colorscheme work
vim.opt.termguicolors = false
-- highlights
vim.cmd([[
    hi CursorLine cterm=bold,italic ctermfg=NONE ctermbg=236
    hi CursorLineNR cterm=bold ctermfg=NONE ctermbg=236
    hi CursorColumn ctermfg=NONE ctermbg=236
    hi EndOfBuffer ctermfg=0
]])

-- providers
-- perl provider
vim.g["loaded_perl_provider"] = 0
-- node.js provider
vim.g["loaded_node_provider"] = 0
-- ruby provider
vim.g["loaded_ruby_provider"] = 0
