local keys = {}

-- stylua: ignore start
for i = 1, 9 do
  table.insert(keys, { "<leader>b" .. i, "<cmd>BufferLineGoToBuffer " .. i .. "<cr>", desc = "Buffer " .. i })
end

table.insert(keys, { "<leader>.", "<Cmd>BufferLinePick<CR>", desc = "Pick Buffer" })

table.insert(keys, { "<leader>bS", "<Cmd>BufferLineSortByDirectory<CR>", desc = "Sort By Directory" })
table.insert(keys, { "<leader>bs", "<Cmd>BufferLineSortByExtension<CR>", desc = "Sort By Extensions" })

table.insert(keys, { "<space><", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" })
table.insert(keys, { "<space>>", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" })
-- stylua: ignore end

return {
  "akinsho/bufferline.nvim",
  keys = keys,
  opts = {
    options = {
      modified_icon = "",
      color_icons = true,
      separator_style = "slope",
    },
  },
}
