-------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/special_settings.lua (archlinux @ 'silent')
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


---- source nvim config file init.vim
--keymap ('n', 'sv', ':source ~/.config/nvim/init.vim <cr>')
vim.cmd[[
    nnoremap sv :source ~/.config/nvim/init.vim <cr>
]]

-- paste
-- toggle paste unmodified (code)
set.pastetoggle = '<leader>p'

-- toggle spell checking
keymap ('n', '<leader>s', ':setlocal spell! spelllang=en_us,nl<cr>', opts)

-- time stamp
keymap ('i', '<leader>ts', '<c-r>=strftime("%a %d %b %Y %H:%M")<cr><cr>', opts)

---- double space over word to find and replace
--keymap ('n', '<space><space>', ':%s/\<<c-r>=expand("<cword>")<cr>\>/')
vim.cmd[[
    nnoremap <space><space> :%s/\<<c-r>=expand("<cword>")<cr>\>/
]]

---- search and replace all
--keymap ('n'. '<c-s>', ':%s//gI<Left><Left><Left>')
vim.cmd[[
    nnoremap <c-s> :%s//gI<left><left><left>
]]

---- write file if you forgot to give it sudo permission
--keymap ('c', 'w!!', 'w !sudo tee %')
vim.cmd[[
    cnoremap w!! w !sudo tee %
]]

---- diff since last save
--keymap ('n', '<leader>d', ':w !diff % -cr>')
vim.cmd[[
    nnoremap <leader>d :w !diff % -<cr>
]]

-- remove trailing white space
vim.cmd[[
    autocmd BufWritePre * %s/\s\+$//e
]]

-- return to last edit position at opening file
vim.cmd[[
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]]

-- markdown
-- set proper extension for markdown files (.md)
vim.cmd[[
    au BufRead,BufNewFile *.md set filetype=markdown
]]
-- set proper text width for markdown files
vim.cmd[[
    au BufRead,BufNewFile *.md setlocal textwidth=79
]]

-- python provider
vim.g['python_host_prog'] = '/usr/bin/python'
vim.g['python3_host_prog'] = '/usr/bin/python3'
-- perl provider
vim.g['loaded_perl_provider'] = 0

-- set my folding format
vim.cmd[[
    function! MyFoldText()
        let line = getline(v:foldstart)
        let folded_line_num = v:foldend - v:foldstart
        let line_text = substitute(line, '^["|#]{\+', '', 'g')
        let fillcharcount = &textwidth - 21 - len(line_text) - len(folded_line_num)
        return '+ '. repeat('-', 4) . line_text . ' ' . repeat('.', fillcharcount) . ' ' . folded_line_num . ' lines ---- +                                                                                                                                                                                                                                                                                  '
    endfunction
    set foldtext=MyFoldText()
]]

-- autoclosing brackets
vim.cmd[[
    function! ConditionalPairMap(open, close)
      let line = getline('.')
      let col = col('.')
      if col < col('$') || stridx(line, a:close, col + 1) != -1
        return a:open
      else
        return a:open . a:close . repeat("\<left>", len(a:close))
      endif
    endf
    inoremap <expr> ( ConditionalPairMap('(', ')')
    inoremap <expr> { ConditionalPairMap('{', '}')
    inoremap <expr> [ ConditionalPairMap('[', ']')
]]

