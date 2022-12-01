-------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/special_settings.lua (archlinux @ 'silent')  --
-- Date:     Sun 20 Nov 2022 14:23                                           --
-- Update:   Tue 29 Nov 2022 23:25
-- Owner:    fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/        --
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

-------------------------------------------------------------------------------

-- source nvim config file init.lua
keymap("n", "sv", ":source ~/.config/nvim/init.lua<cr>", opts)

-- paste
-- toggle paste unmodified (code)
set.pastetoggle = "<leader>p"

-- toggle spell checking
keymap("n", "<leader>s", ":setlocal spell! spelllang=en_us,nl<cr>", opts)

-- time stamp
keymap("i", "<leader>ts", '<c-r>=strftime("%a %d %b %Y %H:%M")<cr><cr>', opts)

-- double space over word to find and replace
keymap("n", "<space><space>", [[:%s/\<<c-r>=expand("<cword>")<cr>\>/]], opt)

-- search and replace all
keymap("n", "<c-s>", [[:%s//gI<Left><Left><Left>]], opt)

-- write file if you forgot to give it sudo permission
keymap("c", "w!!", [[w !sudo tee %]], opt)

-- diff since last save
keymap("n", "<leader>d", [[:w !diff % -<cr>]], opt)

-- make diff better: https://vimways.org/2018/the-power-of-diff/
set.diffopt:append("iwhite", "algorithm:patience", "indent-heuristic", "linematch:60")

-- remove trailing white space
vim.cmd([[
    autocmd BufWritePre * %s/\s\+$//e
]])

-- return to last edit position at opening file
vim.cmd([[
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])

-- markdown
-- set proper extension for markdown files (.md)
vim.cmd([[
    au BufRead,BufNewFile *.md set filetype=markdown
]])
-- set proper text width for markdown files
vim.cmd([[
    au BufRead,BufNewFile *.md setlocal textwidth=79
]])
vim.g["markdown_fenced_languages"] = { "bash=sh", "python", "vim", "lua", "c", "html" }

-- python provider
vim.g["python_host_prog"] = "/usr/bin/python"
vim.g["python3_host_prog"] = "/usr/bin/python3"
-- perl provider
vim.g["loaded_perl_provider"] = 0

-- set my folding format
vim.cmd([[
    function! MyFoldText()
        let line = getline(v:foldstart)
        let folded_line_num = v:foldend - v:foldstart
        let line_text = substitute(line, '^["|#]{\+', '', 'g')
        let fillcharcount = &textwidth - 21 - len(line_text) - len(folded_line_num)
        return '+ '. repeat('-', 4) . line_text . ' ' . repeat('.', fillcharcount) . ' ' . folded_line_num . ' lines ---- +                                                                                                                                                                                                                                                                                  '
    endfunction
    set foldtext=MyFoldText()
]])
