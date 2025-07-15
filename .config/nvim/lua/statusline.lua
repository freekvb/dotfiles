------------------------------------------------------------------------------
-- File:     ~/.config/nvim/lua/statusline.lua (archlinux @ 'silent')
-- Date:     Fri 14 Jul 2025 06:30
-- Update:   Mon 14 Jul 2025 10:59
-- Owner:    fvb - freekvb@gmail.com - https://freekvb.github.io/fvb/
-------------------------------------------------------------------------------

---- statusline ----

-- automatically leave insert mode
vim.cmd([[
    au CursorHoldI * stopinsert
]])
-- set inactive insert mode
vim.cmd([[
    au InsertEnter * let updaterestore=&updatetime | set updatetime=5000
    au InsertLeave * let &updatetime=updaterestore
]])

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

-- command bar messeges
-- hide mode
vim.opt.showmode = false
-- hide commands
vim.opt.showcmd = false
-- height of command bar
vim.opt.cmdheight = 1
-- prompt message options
vim.opt.shortmess = "atToOFc"
-- disable substitution preview
vim.opt.inccommand = ""

