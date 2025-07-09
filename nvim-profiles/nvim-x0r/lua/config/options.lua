-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- =============================================
-- General Settings
-- =============================================

-- Set leader key to <Space>
-- vim.g.mapleader = ' '
--
-- -- Enable line numbers and relative line numbers
-- vim.opt.number = true
-- vim.opt.relativenumber = true
--
-- -- Enable syntax highlighting
-- vim.cmd('syntax on')
--
-- -- Enable mouse support
-- vim.opt.mouse = 'a'
--
-- -- Set tab width to 4 spaces
-- vim.opt.tabstop = 4
-- vim.opt.shiftwidth = 4
-- vim.opt.expandtab = true
--
-- -- Enable auto-indentation
-- vim.opt.autoindent = true
-- vim.opt.smartindent = true
--
-- -- Enable persistent undo
-- vim.opt.undofile = true
--
-- -- Enable clipboard integration
-- vim.opt.clipboard = 'unnamedplus'
--
-- -- Enable true colors
-- vim.opt.termguicolors = true
--
-- -- Set colorscheme (replace with your preferred theme)
-- vim.cmd('colorscheme desert')
--
-- -- Enable filetype detection and plugins
-- vim.cmd('filetype plugin on')
--
-- -- Enable autocompletion
-- vim.opt.completeopt = 'menuone,noselect'
--
-- =============================================
-- Restore Terminal Cursor After Exiting Neovim
-- =============================================

-- Save the current terminal cursor shape
vim.o.guicursor = "n-v-c:block-blinkon1,i-ci-ve:ver25-blinkon1,r-cr:hor20-blinkon1,o:hor50-blinkon1"

vim.api.nvim_create_autocmd("VimLeave", {
  pattern = "*",
  callback = function()
    vim.o.guicursor = "a:hor20-blinkon1" -- Restore cursor to underline blink
  end,
})
-- =============================================
-- Fish Shell Optimizations
-- =============================================

-- Set Bash as the shell for Neovim's terminal
vim.o.shell = "/bin/bash"

-- Set Fish as the default shell
-- vim.opt.shell = '/usr/local/bin/fish'  -- Update path to your Fish shell

-- =============================================
-- GUI Font and Color Settings
-- =============================================

-- Set GUI font (for Neovim GUI clients like Neovide)
vim.opt.guifont = "FiraCode Nerd Font Mono:h12" -- Use FiraCode Nerd Font at size 12

-- Set GUI colors for better readability
-- vim.cmd([[
--   highlight Normal guibg=#1e1e2e guifg=#f8f8f2  -- Set background and foreground colors
--   highlight CursorLine guibg=#2a2b36           -- Highlight the current line
--   highlight Comment guifg=#6272a4              -- Set comment color
--   highlight Visual guibg=#73daca guifg=#1a1b26 -- Set visual selection colors
-- ]])

--
