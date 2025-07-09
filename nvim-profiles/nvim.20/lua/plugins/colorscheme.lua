return {
  "EdenEast/nightfox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("nightfox").setup({
      options = {
        compile_path = vim.fn.stdpath("cache") .. "/nightfox",
        compile_file_suffix = "_compiled",
        transparent = false,
        terminal_colors = true,
        dim_inactive = true,
        module_default = true,
        colorblind = {
          enable = false,
          simulate_only = false,
          severity = {
            protan = 0,
            deutan = 0,
            tritan = 0,
          },
        },
        styles = {
          comments = "italic",
          conditionals = "bold",
          constants = "bold,italic",
          functions = "bold",
          keywords = "bold,italic",
          numbers = "NONE",
          operators = "NONE",
          strings = "italic",
          types = "bold,italic",
          variables = "NONE",
        },
        inverse = {
          match_paren = true,
          visual = true,
          search = true,
        },
        modules = {
          alpha = true,
          cmp = true,
          diagnostic = {
            enable = true,
            background = true,
          },
          gitsigns = true,
          native_lsp = true,
          neotree = true,
          notify = true,
          symbol_outline = true,
          telescope = true,
          treesitter = true,
          whichkey = true,
        },
      },
      palettes = {
        nightfox = {
          red = "#ff3366",
          green = "#00ff9f",
          yellow = "#ffff00",
          blue = "#00ffff",
          magenta = "#ff00ff",
          cyan = "#00ffff",
          pink = "#ff1493",
          orange = "#ff8c00",
          bg1 = "#141414",
        },
      },
      specs = {
        nightfox = {
          syntax = {
            -- Enhanced syntax colors
            keyword = "magenta.bright",
            type = "cyan.bright",
            func = "green.bright",
            string = "pink.bright",
            variable = "blue.bright",
            comment = "magenta.dim",
            constant = "orange.bright",
            number = "yellow.bright",
            conditional = "purple.bright",
            operator = "red.bright",
          },
          git = {
            added = "green",
            changed = "orange",
            removed = "red",
          },
        },
      },
      groups = {
        nightfox = {
          -- Bufferline
          BufferLineBufferSelected = { fg = "#00ffff", bg = "#1a1a1a", style = "bold" },
          BufferLineBuffer = { fg = "#666666", bg = "#0d0d0d" },
          BufferLineModified = { fg = "#ff00ff" },
          BufferLineModifiedSelected = { fg = "#ff00ff", style = "bold" },
          BufferLineCloseButton = { fg = "#ff3366" },
          BufferLineIndicatorSelected = { fg = "#39ff14" },

          -- Lualine
          LualineNormal = { fg = "#00ffff", bg = "#1a1a1a" },
          LualineInsert = { fg = "#39ff14", bg = "#1a1a1a" },
          LualineVisual = { fg = "#ff00ff", bg = "#1a1a1a" },
          LualineReplace = { fg = "#ff3366", bg = "#1a1a1a" },
          LualineCommand = { fg = "#ffff00", bg = "#1a1a1a" },
          LualineInactive = { fg = "#666666", bg = "#0d0d0d" },

          -- Which Key
          WhichKey = { fg = "#00ffff", style = "bold" },
          WhichKeyGroup = { fg = "#ff00ff" },
          WhichKeyDesc = { fg = "#39ff14" },
          WhichKeySeperator = { fg = "#666666" },
          WhichKeyFloat = { bg = "#0d0d0d" },
          WhichKeyValue = { fg = "#ff3366" },

          -- Neo-tree colors
          NeoTreeNormal = { fg = "fg1", bg = "bg0" },
          NeoTreeNormalNC = { fg = "fg2", bg = "bg0" },
          NeoTreeIndentMarker = { fg = "cyan" },
          NeoTreeRootName = { fg = "magenta", style = "bold" },
          NeoTreeFileName = { fg = "fg1" },
          NeoTreeFileIcon = { fg = "blue" },
          NeoTreeModified = { fg = "yellow" },
          NeoTreeGitAdded = { fg = "green" },
          NeoTreeGitModified = { fg = "yellow" },
          NeoTreeGitDeleted = { fg = "red" },

          -- Telescope colors
          TelescopeNormal = { bg = "bg0" },
          TelescopeBorder = { fg = "cyan", bg = "bg0" },
          TelescopePromptPrefix = { fg = "magenta" },
          TelescopeSelection = { fg = "fg1", bg = "bg3" },
          TelescopeSelectionCaret = { fg = "magenta", bg = "bg3" },
          TelescopeMultiSelection = { fg = "cyan", bg = "bg3" },
          TelescopeMatching = { fg = "green", style = "bold" },
          TelescopePromptTitle = { fg = "bg0", bg = "magenta", style = "bold" },
          TelescopeResultsTitle = { fg = "bg0", bg = "blue", style = "bold" },
          TelescopePreviewTitle = { fg = "bg0", bg = "green", style = "bold" },

          CursorLine = { bg = "#1a1a1a" },
          StatusLine = { fg = "cyan", bg = "#1a1a1a" },
          TabLineSel = { bg = "magenta", fg = "bg0" },
          NormalFloat = { bg = "bg0" },
          Pmenu = { fg = "fg1", bg = "bg0" },
        },
      },
    })
    vim.cmd("colorscheme carbonfox")
  end,
}
