local map = vim.keymap.set
local o = vim.opt

local lazy = require("lazy")

-- Search current word
local searching_brave = function()
  vim.fn.system({ "xdg-open", "https://search.brave.com/search?q=" .. vim.fn.expand("<cword>") })
end
map("n", "<leader>?", searching_brave, { noremap = true, silent = true, desc = "Search Current Word on Brave Search" })

-- Lazy options
map("n", "<leader>l", "<Nop>")
map("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy" })
-- stylua: ignore start
map("n", "<leader>ld", function() vim.fn.system({ "xdg-open", "https://lazyvim.org" }) end, { desc = "LazyVim Docs" })
map("n", "<leader>lr", function() vim.fn.system({ "xdg-open", "https://github.com/LazyVim/LazyVim" }) end, { desc = "LazyVim Repo" })
map("n", "<leader>lx", "<cmd>LazyExtras<cr>", { desc = "Extras" })
map("n", "<leader>lc", function() LazyVim.news.changelog() end, { desc = "LazyVim Changelog" })

map("n", "<leader>lu", function() lazy.update() end, { desc = "Lazy Update" })
map("n", "<leader>lC", function() lazy.check() end, { desc = "Lazy Check" })
map("n", "<leader>ls", function() lazy.sync() end, { desc = "Lazy Sync" })
-- stylua: ignore end

-- Disable LazyVim bindings
map("n", "<leader>L", "<Nop>")
map("n", "<leader>fT", "<Nop>")

-- Identation
map("n", "<", "<<", { desc = "Deindent" })
map("n", ">", ">>", { desc = "Indent" })

-- Save without formatting
map("n", "<A-s>", "<cmd>noautocmd w<CR>", { desc = "Save Without Formatting" })

-- Cursor navigation on insert mode
map("i", "<M-h>", "<left>", { desc = "Move Cursor Left" })
map("i", "<M-l>", "<right>", { desc = "Move Cursor Left" })
map("i", "<M-j>", "<down>", { desc = "Move Cursor Left" })
map("i", "<M-k>", "<up>", { desc = "Move Cursor Left" })

-- End of the word backwards
map("n", "E", "ge")

-- Increment/decrement
map("n", "+", "<C-a>")
map("n", "-", "<C-x>")

-- Tabs
map("n", "]<tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "[<tab>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<s-tab>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
for i = 1, 9 do
  map("n", "<leader><tab>" .. i, "<cmd>tabn " .. i .. "<cr>", { desc = "Tab " .. i })
end
map("n", "<leader>f<tab>", function()
  vim.ui.select(vim.api.nvim_list_tabpages(), {
    prompt = "Select Tab:",
    format_item = function(tabid)
      local wins = vim.api.nvim_tabpage_list_wins(tabid)
      local not_floating_win = function(winid)
        return vim.api.nvim_win_get_config(winid).relative == ""
      end
      wins = vim.tbl_filter(not_floating_win, wins)
      local bufs = {}
      for _, win in ipairs(wins) do
        local buf = vim.api.nvim_win_get_buf(win)
        local buftype = vim.api.nvim_get_option_value("buftype", { buf = buf })
        if buftype ~= "nofile" then
          local fname = vim.api.nvim_buf_get_name(buf)
          table.insert(bufs, vim.fn.fnamemodify(fname, ":t"))
        end
      end
      local tabnr = vim.api.nvim_tabpage_get_number(tabid)
      local cwd = string.format(" %8s: ", vim.fn.fnamemodify(vim.fn.getcwd(-1, tabnr), ":t"))
      local is_current = vim.api.nvim_tabpage_get_number(0) == tabnr and "✸" or " "
      return tabnr .. is_current .. cwd .. table.concat(bufs, ", ")
    end,
  }, function(tabid)
    if tabid ~= nil then
      vim.cmd(tabid .. "tabnext")
    end
  end)
end, { desc = "Tabs" })

-- Buffers
map("n", "<leader>bf", "<cmd>bfirst<cr>", { desc = "First Buffer" })
map("n", "<leader>ba", "<cmd>blast<cr>", { desc = "Last Buffer" })
map("n", "<leader>b<tab>", "<cmd>tabnew %<cr>", { desc = "Current Buffer in New Tab" })

-- Toggle statusline
map("n", "<leader>uS", function()
  if o.laststatus:get() == 0 then
    o.laststatus = 3
  else
    o.laststatus = 0
  end
end, { desc = "Toggle Statusline" })

-- Comment box
map("n", "]/", "/\\S\\zs\\s*╭<CR>zt", { desc = "Next Block Comment" })
map("n", "[/", "?\\S\\zs\\s*╭<CR>zt", { desc = "Prev Block Comment" })

-- Plugin Info
map("n", "<leader>cif", "<cmd>LazyFormatInfo<cr>", { desc = "Formatting" })
map("n", "<leader>cic", "<cmd>ConformInfo<cr>", { desc = "Conform" })
local linters = function()
  local linters_attached = require("lint").linters_by_ft[vim.bo.filetype]
  local buf_linters = {}

  if not linters_attached then
    LazyVim.warn("No linters attached", { title = "Linter" })
    return
  end

  for _, linter in pairs(linters_attached) do
    table.insert(buf_linters, linter)
  end

  local unique_client_names = table.concat(buf_linters, ", ")
  local linters = string.format("%s", unique_client_names)

  LazyVim.notify(linters, { title = "Linter" })
end
map("n", "<leader>ciL", linters, { desc = "Lint" })
map("n", "<leader>cir", "<cmd>LazyRoot<cr>", { desc = "Root" })

-- U for redo
map("n", "U", "<C-r>", { desc = "Redo" })

-- Copy whole text to clipboard
map("n", "<C-c>", ":%y+<CR>", { desc = "Copy Whole Text to Clipboard", silent = true })

-- Motion
map("c", "<C-a>", "<C-b>", { desc = "Start Of Line" })
map("i", "<C-a>", "<Home>", { desc = "Start Of Line" })
map("i", "<C-e>", "<End>", { desc = "End Of Line" })

-- Select all text
map("n", "<C-e>", "gg<S-V>G", { desc = "Select all Text", silent = true, noremap = true })

-- Paste options
map("i", "<C-v>", '<C-r>"', { desc = "Paste on Insert Mode" })
map("v", "p", '"_dP', { desc = "Paste Without Overwriting" })

-- Delete and change without yanking
map({ "n", "x" }, "<A-d>", '"_d', { desc = "Delete Without Yanking" })
map({ "n", "x" }, "<A-c>", '"_c', { desc = "Change Without Yanking" })

-- Deleting without yanking empty line
map("n", "dd", function()
  local is_empty_line = vim.api.nvim_get_current_line():match("^%s*$")
  if is_empty_line then
    return '"_dd'
  else
    return "dd"
  end
end, { noremap = true, expr = true, desc = "Don't Yank Empty Line to Clipboard" })

-- Search inside visually highlighted text
map("x", "g/", "<esc>/\\%V", { silent = false, desc = "Search Inside Visual Selection" })

-- Search visually selected text (slightly better than builtins in Neovim>=0.8)
map("x", "*", [[y/\V<C-R>=escape(@", '/\')<CR><CR>]], { desc = "Search Selected Text", silent = true })
map("x", "#", [[y?\V<C-R>=escape(@", '?\')<CR><CR>]], { desc = "Search Selected Text (Backwards)", silent = true })

-- Dashboard
map("n", "<leader>fd", function()
  if LazyVim.has("snacks.nvim") then
    Snacks.dashboard()
  elseif LazyVim.has("alpha-nvim") then
    require("alpha").start(true)
  elseif LazyVim.has("dashboard-nvim") then
    vim.cmd("Dashboard")
  end
end, { desc = "Dashboard" })

-- Spelling
map("n", "<leader>!", "zg", { desc = "Add Word to Dictionary" })
map("n", "<leader>@", "zug", { desc = "Remove Word from Dictionary" })

-- Terminal Stuff
if not LazyVim.has("floaterm.nvim") or not LazyVim.has("toggleterm.nvim") then
  local lazyterm = function()
    Snacks.terminal(nil, { size = { width = 0.8, height = 0.8 }, cwd = LazyVim.root() })
  end
  map("n", "<leader>ft", lazyterm, { desc = "Terminal (Root Dir)" })
  map("n", "<leader>fT", function()
    Snacks.terminal(nil, { size = { width = 0.8, height = 0.8 }, cwd = vim.fn.getcwd() })
  end, { desc = "Terminal (cwd)" })
  map("n", [[<c-\>]], lazyterm, { desc = "Terminal (Root Dir)" })
  map("t", [[<c-\>]], "<cmd>close<cr>", { desc = "Hide Terminal" })
end

-- Marks
map("n", "dm", function()
  local cur_line = vim.fn.line(".")
  -- Delete buffer local mark
  for _, mark in ipairs(vim.fn.getmarklist("%")) do
    if mark.pos[2] == cur_line and mark.mark:match("[a-zA-Z]") then
      vim.api.nvim_buf_del_mark(0, string.sub(mark.mark, 2, #mark.mark))
      return
    end
  end
  -- Delete global marks
  local cur_buf = vim.api.nvim_win_get_buf(vim.api.nvim_get_current_win())
  for _, mark in ipairs(vim.fn.getmarklist()) do
    if mark.pos[1] == cur_buf and mark.pos[2] == cur_line and mark.mark:match("[a-zA-Z]") then
      vim.api.nvim_buf_del_mark(0, string.sub(mark.mark, 2, #mark.mark))
      return
    end
  end
end, { noremap = true, desc = "Mark on Current Line" })

-- Empty Line
map("n", "gO", "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>", { desc = "Empty Line Above" })
map("n", "go", "<Cmd>call append(line('.'), repeat([''], v:count1))<CR>", { desc = "Empty Line Below" })

-- Insert Mode
map({ "c", "i", "t" }, "<M-BS>", "<C-w>", { desc = "Delete Word" })

-- Git
map("n", "<leader>ghb", Snacks.git.blame_line, { desc = "Blame Line" })

-- Windows Split
map("n", "<leader>_", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>\\", "<C-W>v", { desc = "Split Window Right", remap = true })

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
