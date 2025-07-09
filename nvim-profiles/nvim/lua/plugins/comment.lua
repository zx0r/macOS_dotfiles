-- lua/plugins/comment.lua
return {
  "numToStr/Comment.nvim",
  dependencies = {
    { "JoosepAlviste/nvim-ts-context-commentstring" },
  },
  event = "VeryLazy", -- Load the plugin lazily
  config = function()
    require("Comment").setup()
  end,
}
