vim.g.mapleader = " "

vim.opt.backup = true
vim.opt.cmdheight = 0
vim.opt.backupdir = vim.fn.stdpath("state") .. "/backup"
vim.opt.mousescroll = "ver:2,hor:6"

if vim.g.neovide then
  vim.o.guifont = "Fira Code,Symbols Nerd Font Mono:h34"
  vim.g.neovide_scale_factor = 0.3
end

-- vim.g.node_host_prog = "/Users/folke/.pnpm-global/5/node_modules/neovim/bin/cli.js"
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- make all keymaps silent by default
local keymap_set = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return keymap_set(mode, lhs, rhs, opts)
end

vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.lazyvim_python_ruff = "ruff"

if vim.fn.has("win32") == 1 then
  LazyVim.terminal.setup("pwsh")
end

-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- =============================================
-- General Settings
-- =============================================

-- Using Lua 5.4 features
local opt = vim.opt

-- Modern options
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 3
opt.confirm = true
opt.formatoptions = "jcroqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true
opt.inccommand = "nosplit"
opt.laststatus = 3
opt.list = true
opt.mouse = "a"
opt.pumblend = 10
opt.pumheight = 10
opt.showmode = false
opt.signcolumn = "yes"
opt.smartcase = true
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.wildmode = "longest:full,full"
opt.winminwidth = 5
opt.wrap = false

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
-- vim.o.guifont = "Fira Code,Symbols Nerd Font Mono:h12"
vim.o.guifont = "FiraCode Nerd Font:h12"
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
