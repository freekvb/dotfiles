------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/plugins.lua (archlinux @ 'silent')
-- Date:     Fri 14 Jul 2025 06:30
-- Update:   Wed 16 Jul 2025 09:23
-- Owner:    fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/
-------------------------------------------------------------------------------

---- plugins ----

-- lualine
require("lualine").setup({
    options = {
        icons_enabled = false,
        theme = "pywal",
        component_separators = "",
        section_separators = "",
    },

    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { "filename" },
        lualine_x = {
            function()
                local encoding = vim.o.fileencoding
                if encoding == "" then
                    return vim.bo.fileformat .. " :: " .. vim.bo.filetype
                else
                    return encoding .. " :: " .. vim.bo.fileformat .. " :: " .. vim.bo.filetype
                end
            end,
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
})

-- mini starter
require('mini.starter').setup(
{
    autoopen = true,
    evaluate_single = false,
    items = nil,
    header = " ",
    footer = " ",
    content_hooks = nil,
    query_updaters = 'abcdefghijklmnopqrstuvwxyz0123456789_-.',
    silent = false,
}
)

-- packer
require("packer").startup(function()
    use("wbthomason/packer.nvim")

    use('dylanaraps/wal.vim')
    use('~/.fzf')
    use('nvim-lualine/lualine.nvim')
    use('echasnovski/mini.starter')
        --use('junegunn/fzf.vim')
        --use({ 'instant-markdown/vim-instant-markdown' })
        --use('nat-418/dbm.nvim')
        --use('vim-scripts/AutoComplPop')

    -- automatically run :PackerCompile whenever plugins.lua is updated
    vim.cmd([[
        augroup packer_user_config
            autocmd!
            autocmd BufWritePost plugins.lua source <afile> | PackerCompile
        augroup end
    ]])
end)

