------------------------------------------------------------------------------
-- File:    ~/.config/nvim/lua/plugins.lua (archlinux @ 'silent')
-- Date:    Fri 01 Aug 2025 21:30
-- Update:  Mon 04 Aug 2025 09:56
-- Owner:   fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/
-------------------------------------------------------------------------------

---- plugins ----

vim.pack.add(
    {
        { src = "file:///home/fvb/.fzf" },
        --{ src = "https://github.com/metalelf0/black-metal-theme-neovim" },
        { src = "https://github.com/uZer/pywal16.nvim", as = "pywal16" },
        { src = "https://github.com/nvim-lualine/lualine.nvim" },
        { src = "https://github.com/echasnovski/mini.starter" },
        { src = "https://github.com/instant-markdown/vim-instant-markdown" },
        { src = "https://github.com/sphamba/smear-cursor.nvim" }
    }
)

---- plugin options ----

---- black metal colortheme
--require("black-metal").setup(
--    {
--        -- theme: bathory | black-metal-day | burzum | dark-funeral | darkthrone | emperor | gorgoroth | immortal | impaled-nazarene | khold | marduk | mayhem | nile | taake | thyrfing | venom | windir
--        theme = "mayhem"
--    }
--)
--require("black-metal").load()
--vim.cmd(":hi statusline guibg=grey3")

-- pywal16
local pywal16 = require('pywal16')
pywal16.setup()

-- lualine
require("lualine").setup(
    {
        options = {
            icons_enabled = false,
            theme = "pywal16-nvim",
            component_separators = "",
            section_separators = " "
        },
        sections = {
            lualine_a = {"mode"},
            lualine_b = {"branch", "diff"},
            lualine_c = {"filename"},
            lualine_x = {
                function()
                    local encoding = vim.o.fileencoding
                    if encoding == "" then
                        return vim.bo.fileformat .. " :: " .. vim.bo.filetype
                    else
                        return encoding .. " :: " .. vim.bo.fileformat .. " :: " .. vim.bo.filetype
                    end
                end
            },
            lualine_y = {"filesize", "progress"},
            lualine_z = {"location"}
        }
    }
)

-- mini starter
require("mini.starter").setup(
    {
        autoopen = true,
        evaluate_single = false,
        items = nil,
        header = " ",
        footer = " ",
        content_hooks = nil,
        query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_-.",
        silent = false
    }
)

-- smear cursor
require("smear_cursor").setup(
    {
        smear_between_buffers = true,
        smear_between_neighbor_lines = true,
        scroll_buffer_space = true,
        legacy_computing_symbols_support = false,
        smear_insert_mode = true,
        -- options                            -- default  range
        stiffness = 0.8, -- 0.6      [0, 1]
        trailing_stiffness = 0.5, -- 0.4      [0, 1]
        stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
        trailing_stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
        damping = 0.8, -- 0.65     [0, 1]
        damping_insert_mode = 0.8, -- 0.7      [0, 1]
        distance_stop_animating = 0.5 -- 0.1      > 0
    }
)

