local util = require("util")

util.cowboy()
util.wezterm()

-- change word with <c-c>
vim.keymap.set({ "n", "x" }, "<C-c>", "<cmd>normal! ciw<cr>a")

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
-- =============================================
-- Custom Keybindings
-- =============================================

-- Set leader key to <Space>
-- vim.g.mapleader = ' '

-- Keybindings for common operations
local keymap = vim.api.nvim_set_keymap

-- Define options for keybindings
local opts = { noremap = true, silent = true }

-- Ctrl-A: Select All
keymap("n", "<C-A>", "ggVG", opts) -- Select all text in Normal mode
keymap("v", "<C-A>", "<Esc>ggVG", opts) -- Select all text in Visual mode

-- Ctrl-C: Copy (Yank)
keymap("v", "<C-C>", '"+y', opts) -- Copy selected text to system clipboard
keymap("n", "<C-C>", '"+yiw', opts) -- Copy current word to system clipboard

-- Ctrl-V: Paste
keymap("n", "<C-V>", '"+p', opts) -- Paste from system clipboard after cursor
keymap("i", "<C-V>", "<C-R>+", opts) -- Paste from system clipboard in Insert mode
keymap("v", "<C-V>", '"+p', opts) -- Paste from system clipboard in Visual mode

-- Ctrl-X: Cut
keymap("v", "<C-X>", '"+x', opts) -- Cut selected text to system clipboard
keymap("n", "<C-X>", '"+xiw', opts) -- Cut current word to system clipboard

-- Ctrl-Q: Quit
keymap("n", "<C-Q>", ":q<CR>", opts) -- Quit Neovim
keymap("v", "<C-Q>", "<Esc>:q<CR>", opts) -- Quit Neovim from Visual mode

-- Ctrl-S: Save
keymap("n", "<C-S>", ":w<CR>", opts) -- Save file
keymap("i", "<C-S>", "<Esc>:w<CR>a", opts) -- Save file in Insert mode

-- Ctrl-Z: Undo
keymap("n", "<C-Z>", "u", opts) -- Undo in Normal mode
keymap("i", "<C-Z>", "<Esc>ua", opts) -- Undo in Insert mode

-- Ctrl-Y: Redo
keymap("n", "<C-Y>", "<C-R>", opts) -- Redo in Normal mode
keymap("i", "<C-Y>", "<Esc><C-R>a", opts) -- Redo in Insert mode

-- Ctrl-F: Find
keymap("n", "<C-F>", "/", opts) -- Open search in Normal mode
keymap("i", "<C-F>", "<Esc>/", opts) -- Open search in Insert mode

-- Ctrl-N: New File
keymap("n", "<C-N>", ":enew<CR>", opts) -- Create a new file

-- Ctrl-O: Open File
keymap("n", "<C-O>", ":e ", opts) -- Open a file (you need to type the filename)

-- Ctrl-W: Close Window
keymap("n", "<C-W>", ":close<CR>", opts) -- Close the current window

-- Ctrl-T: New Tab
keymap("n", "<C-T>", ":tabnew<CR>", opts) -- Open a new tab

-- Navigation Keybindings
vim.api.nvim_set_keymap("n", "<Leader>h", "^", { noremap = true, silent = true }) -- Start of line
vim.api.nvim_set_keymap("n", "<Leader>l", "$", { noremap = true, silent = true }) -- End of line
vim.api.nvim_set_keymap("n", "<Leader>w", "w", { noremap = true, silent = true }) -- Next word
vim.api.nvim_set_keymap("n", "<Leader>b", "b", { noremap = true, silent = true }) -- Previous word
vim.api.nvim_set_keymap("n", "<Leader>gg", "gg", { noremap = true, silent = true }) -- Start of file
vim.api.nvim_set_keymap("n", "<Leader>G", "G", { noremap = true, silent = true }) -- End of file
vim.api.nvim_set_keymap("n", "<Leader>%", "%", { noremap = true, silent = true }) -- Jump to matching bracket

-- Move between code blocks with Tab and Shift+Tab
vim.keymap.set("n", "<Tab>", "}", opts) -- Move to the next code block
vim.keymap.set("n", "<S-Tab>", "{", opts) -- Move to the previous code block

-- Indent and unindent with Tab and Shift+Tab
vim.keymap.set("n", "<Leader><Tab>", ">>", opts) -- Indent line in Normal mode
vim.keymap.set("n", "<Leader><S-Tab>", "<<", opts) -- Unindent line in Normal mode
vim.keymap.set("v", "<Tab>", ">gv", opts) -- Indent selection in Visual mode
vim.keymap.set("v", "<S-Tab>", "<gv", opts) -- Unindent selection in Visual mode

-- Text Selection Keybindings
vim.api.nvim_set_keymap("n", "<Leader>vi{", "vi{", { noremap = true, silent = true }) -- Select inside {}
vim.api.nvim_set_keymap("n", "<Leader>vi(", "vi(", { noremap = true, silent = true }) -- Select inside ()
vim.api.nvim_set_keymap("n", "<Leader>vi[", "vi[", { noremap = true, silent = true }) -- Select inside []
vim.api.nvim_set_keymap("n", "<Leader>va{", "va{", { noremap = true, silent = true }) -- Select around {}
vim.api.nvim_set_keymap("n", "<Leader>va(", "va(", { noremap = true, silent = true }) -- Select around ()
vim.api.nvim_set_keymap("n", "<Leader>va[", "va[", { noremap = true, silent = true }) -- Select around []
vim.api.nvim_set_keymap("n", "<Leader>V", "V", { noremap = true, silent = true }) -- Select current line

-- Editing Keybindings
vim.api.nvim_set_keymap("n", "<Leader>dw", "dw", { noremap = true, silent = true }) -- Delete word
vim.api.nvim_set_keymap("n", "<Leader>diw", "diw", { noremap = true, silent = true }) -- Delete inner word
vim.api.nvim_set_keymap("n", "<Leader>dd", "dd", { noremap = true, silent = true }) -- Delete current line
vim.api.nvim_set_keymap("n", "<Leader>yy", "yy", { noremap = true, silent = true }) -- Yank (copy) current line
vim.api.nvim_set_keymap("n", "<Leader>p", "p", { noremap = true, silent = true }) -- Paste after cursor
vim.api.nvim_set_keymap("n", "<Leader>P", "P", { noremap = true, silent = true }) -- Paste before cursor
vim.api.nvim_set_keymap("n", "<Leader>ci{", "ci{", { noremap = true, silent = true }) -- Change inside {}
vim.api.nvim_set_keymap("n", "<Leader>ci(", "ci(", { noremap = true, silent = true }) -- Change inside ()
vim.api.nvim_set_keymap("n", "<Leader>ci[", "ci[", { noremap = true, silent = true }) -- Change inside []

-- Indentation Keybindings
vim.api.nvim_set_keymap("n", "<Leader>>", ">>", { noremap = true, silent = true }) -- Indent line
vim.api.nvim_set_keymap("n", "<Leader><", "<<", { noremap = true, silent = true }) -- Unindent line
vim.api.nvim_set_keymap("v", "<Leader>>", ">gv", { noremap = true, silent = true }) -- Indent selection
vim.api.nvim_set_keymap("v", "<Leader><", "<gv", { noremap = true, silent = true }) -- Unindent selection

-- Searching and Replacing Keybindings
vim.api.nvim_set_keymap("n", "<Leader>*", "*", { noremap = true, silent = true }) -- Search forward
vim.api.nvim_set_keymap("n", "<Leader>#", "#", { noremap = true, silent = true }) -- Search backward
vim.api.nvim_set_keymap("n", "<Leader>s", ":%s/\\<<C-r><C-w>\\>/", { noremap = true, silent = false }) -- Replace word under cursor
vim.api.nvim_set_keymap("n", "<Leader>S", ":%s/old/new/g", { noremap = true, silent = false }) -- Replace "old" with "new"

-- Advanced Text Manipulation Keybindings
vim.api.nvim_set_keymap("n", "<Leader>dl", "yyp", { noremap = true, silent = true }) -- Duplicate current line
vim.api.nvim_set_keymap("n", "<Leader>J", "J", { noremap = true, silent = true }) -- Join current line with next line
vim.api.nvim_set_keymap("n", "<Leader>~", "~", { noremap = true, silent = true }) -- Toggle case of character under cursor
vim.api.nvim_set_keymap("v", "<Leader>~", "~", { noremap = true, silent = true }) -- Toggle case of selected text

-- =============================================
-- Plugin-Specific Keybindings (Optional)
-- =============================================

-- Telescope: Fuzzy find files
vim.api.nvim_set_keymap("n", "<Leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true })

-- Treesitter: Jump to next/previous function
vim.api.nvim_set_keymap(
  "n",
  "<Leader>]]",
  ':lua require("nvim-treesitter.textobjects.move").goto_next_function()<CR>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<Leader>[[",
  ':lua require("nvim-treesitter.textobjects.move").goto_previous_function()<CR>',
  { noremap = true, silent = true }
)

-- LSP: Go to definition
vim.api.nvim_set_keymap("n", "<Leader>gd", ":lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

-- =============================================
-- Additional Settings
-- =============================================

-- Commenting Keybindings (Using /)
-- Install and configure Comment.nvim ("numToStr/Comment.nvim") for commenting
local comment = require("Comment")
comment.setup({

  -- Required fields
  padding = true, -- Add a space between the comment symbol and the line
  sticky = true, -- Keep the cursor position when commenting
  ignore = "^$", -- Ignore empty lines when commenting

  -- Toggler keybindings
  toggler = {
    line = "<Leader>/", -- Toggle line comment on current line
    block = "<Leader>*/", -- Toggle block comment on current line
  },

  -- Operator-pending keybindings
  opleader = {
    line = "<Leader>/", -- Toggle line comment on selected lines
    block = "<Leader>*/", -- Toggle block comment on selected lines
  },

  -- Extra keybindings (optional)
  extra = {
    above = "<Leader>O", -- Add comment on the line above
    below = "<Leader>o", -- Add comment on the line below
    eol = "<Leader>A", -- Add comment at the end of the line
  },

  -- Enable mappings (default is true)
  mappings = {
    basic = true, -- Enable basic mappings (e.g., `gcc` for line comment)
    extra = true, -- Enable extra mappings (e.g., `gcO` for comment above)
  },
})
