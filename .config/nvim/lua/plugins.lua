------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/plugins.lua (archlinux @ 'silent')
-- Date:     Fri 14 Jul 2025 06:30
-- Update:   Wed 23 Jul 2025 20:04
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
        lualine_b = { "branch", "diff" },
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
        lualine_y = { "filesize", "progress" },
        lualine_z = { "location" },
    },
})

-- mini starter
require('mini.starter').setup({
    autoopen = true,
    evaluate_single = false,
    items = nil,
    header = " ",
    footer = " ",
    content_hooks = nil,
    query_updaters = 'abcdefghijklmnopqrstuvwxyz0123456789_-.',
    silent = false,
})

-- smear cursor
require('smear_cursor').setup({
    smear_between_buffers = true,
    smear_between_neighbor_lines = true,
    scroll_buffer_space = true,
    legacy_computing_symbols_support = false,
    smear_insert_mode = true,
    -- options                            -- default  range
    stiffness = 0.8,                      -- 0.6      [0, 1]
    trailing_stiffness = 0.5,             -- 0.4      [0, 1]
    stiffness_insert_mode = 0.7,          -- 0.5      [0, 1]
    trailing_stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
    damping = 0.8,                        -- 0.65     [0, 1]
    damping_insert_mode = 0.8,            -- 0.7      [0, 1]
    distance_stop_animating = 0.5,        -- 0.1      > 0
})

-- render markdown
require('render-markdown').setup({
    enabled = true,
    render_modes = true,
})


-- pckr
local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"
  if not (vim.uv or vim.loop).fs_stat(pckr_path) then
    vim.fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path
    })
  end
  vim.opt.rtp:prepend(pckr_path)
end
bootstrap_pckr()
require('pckr').add{
    {'uZer/pywal16.nvim', as = 'pywal16'};
    '~/.fzf';
    'nvim-lualine/lualine.nvim';
    'echasnovski/mini.starter';
    'instant-markdown/vim-instant-markdown';
    'sphamba/smear-cursor.nvim';
    {'MeanderingProgrammer/render-markdown.nvim',
        requires = { 'echasnovski/mini.icons', opt = true }};
}

