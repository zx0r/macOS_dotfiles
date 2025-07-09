return {
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false, -- Load immediately
    priority = 1000, -- Ensure it loads before other plugins
    config = function()
      require("cyberdream").setup({
        -- Enable transparent background
        transparent = true,

        -- Enable italics comments
        italic_comments = false,

        -- Replace all fillchars with ' ' for the ultimate clean look
        hide_fillchars = false,

        -- Modern borderless telescope theme - also applies to fzf-lua
        borderless_telescope = true,

        -- Set terminal colors used in `:terminal`
        terminal_colors = true,

        -- Improve start up time by caching highlights
        cache = false,

        -- Use default theme settings (no custom highlights or overrides)
        theme = {
          variant = "default", -- Use the default dark variant
          saturation = 1, -- Full color saturation
        },

        -- Enable or disable colorscheme extensions
        extensions = {
          telescope = true, -- Enable telescope theme
          notify = true, -- Enable notify theme
          mini = true, -- Enable mini.nvim theme
          -- Add other extensions as needed
        },
      })

      -- Apply the colorscheme
      vim.cmd("colorscheme cyberdream")
    end,
  },
}
