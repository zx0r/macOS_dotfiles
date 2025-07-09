vim.keymap.set({ "n", "x" }, "]#", [[/^#\+ .*<CR>]], { desc = "Next Heading", buffer = true })
vim.keymap.set({ "n", "x" }, "[#", [[?^#\+ .*<CR>]], { desc = "Prev Heading", buffer = true })

-- stylua: ignore start
if LazyVim.has("markdowny.nvim") then
  vim.keymap.set("v", "<C-b>", function() require('markdowny').bold() end, { buffer = 0 })
  vim.keymap.set("v", "<C-i>", function() require('markdowny').italic() end, { buffer = 0 })
  vim.keymap.set("v", "<C-k>", function() require('markdowny').link() end, { buffer = 0 })
  vim.keymap.set("v", "<C-e>", function() require('markdowny').code() end, { buffer = 0 })
end
-- stylua: ignore end
