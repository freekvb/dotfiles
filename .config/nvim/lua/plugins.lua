------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/plugins.lua (archlinux @ 'silent')
-- Date:     Fri 14 Jul 2025 06:30
-- Update:   Mon 14 Jul 2025 10:59
-- Owner:    fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/
-------------------------------------------------------------------------------

---- packer ----

return require("packer").startup(function()
	use("wbthomason/packer.nvim")
    	use('dylanaraps/wal.vim')
	use('~/.fzf')
    	--use('junegunn/fzf.vim')
        --use({ 'instant-markdown/vim-instant-markdown' })
    	--use('nat-418/dbm.nvim')
 	    --use('echasnovski/mini.starter')
    	--use('vim-scripts/AutoComplPop')
    -- automatically run :PackerCompile whenever plugins.lua is updated
    vim.cmd([[
        augroup packer_user_config
            autocmd!
            autocmd BufWritePost plugins.lua source <afile> | PackerCompile
        augroup end
    ]])
end)

