return {
  -- https://sourcegraph.com/github.com/icyphox/dotfiles/-/blob/nvim/colors/plain.lua?L384-388
  "EdenEast/nightfox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local colors = {
      -- Signature Cyberpunk 2077 neons
      white = "#FFFFFF",
      light_grey = "#dfdfdf",
      gray = "#808080",
      neon_pink = "#FF006C",
      neon_blue = "#00F6FF",
      neon_yellow = "#ffff00",
      neon_gold = "#FFD700",
      neon_green = "#00FF00",
      neon_aqua = "#00FF9F",
      neon_purple = "#FF00FF",
      neon_orange = "#FF5F1F",
      neon_red = "#FF0000",
      neon_rose = "#FF003C",
      neon_cyan = "#00FFFF",
      neon_sky = "#0051ff",
      purple = "#4300ff",
      cyan = "#00FFFF",

      -- Base colors
      fg1 = "#FFFFFF",
      fg2 = "#B4B4B4",
      fg3 = "#757575",
      bg = "NONE",
      bg_highlight = "#22222215",
      bg_statusline = "#11111110",
      border = "#FF006C15",
    }
    require("nightfox").setup({
      options = {
        compile_path = vim.fn.stdpath("cache") .. "/nightfox",
        compile_file_suffix = "_compiled",
        transparent = true,
        terminal_colors = true,
        dim_inactive = true,

        -- colorblind = {
        --   enable = false,
        --   simulate_only = false,
        --   severity = {
        --     protan = 0,
        --     deutan = 0,
        --     tritan = 0,
        --   },
        -- },
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
        -- inverse = {
        --   match_paren = false,
        --   visual = true,
        --   search = true,
        -- },
        module_default = true,
        --   modules = {
        --     alpha = true,
        --     cmp = true,
        --     dap_ui = true,
        --     diagnostic = true,
        --     gitgutter = true,
        --     gitsigns = true,
        --     illuminate = true,
        --     leap = true,
        --     lsp_semantic_tokens = true,
        --     lsp_trouble = true,
        --     mini = true,
        --     neogit = true,
        --     neotree = true,
        --     notify = true,
        --     nvimtree = true,
        --     telescope = true,
        --     treesitter = true,
        --     whichkey = true,

        --     native_lsp = {
        --       enable = true,
        --       background = false,
        --     },
        --   },
        -- },
        palettes = {
          carbonfox = {
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
          all = {
            syntax = {
              -- Enhanced syntax colors
              keyword = "colors.neon_pink",
              type = "cyan.bright",
              func = "colors.neon_aqua",
              string = "pink.bright",
              variable = "blue.bright",
              comment = "border",
              constant = "colors.neon_purple",
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
          all = {

            -- NeoTree File Explorer

            -- Core UI elements
            NeoTreeNormal = { fg = "fg1" },
            NeoTreeNormalNC = { fg = "fg2" },
            NeoTreeFloatNormal = { fg = colors.fg1, bg = colors.bg },
            NeoTreeFloatBorder = { fg = colors.neon_purple },
            NeoTreeFloatTitle = { fg = colors.neon_blue, style = "bold" },

            NeoTreeTitleBar = { fg = colors.neon_purple, style = "bold" },
            NeoTreeCursorLine = { bg = colors.bg_highlight },
            NeoTreeStatusLine = { fg = colors.neon_pink, bg = colors.bg_statusline },
            NeoTreeStatusLineNC = { fg = colors.fg2, bg = colors.bg_statusline },

            -- File indicators
            NeoTreeDirectoryIcon = { fg = colors.neon_blue },
            NeoTreeDirectoryName = { fg = colors.neon_blue },
            NeoTreeFileIcon = { fg = colors.neon_purple },
            NeoTreeFileName = { fg = colors.fg1 },
            NeoTreeFileNameOpened = { fg = colors.neon_pink, style = "bold" },
            NeoTreeRootName = { fg = colors.neon_orange, style = "bold" },

            -- Git status
            NeoTreeGitAdded = { fg = colors.neon_green },
            NeoTreeGitModified = { fg = colors.neon_yellow },
            NeoTreeGitDeleted = { fg = colors.neon_red },
            NeoTreeGitStaged = { fg = colors.neon_green },
            NeoTreeGitUnstaged = { fg = colors.neon_yellow },
            NeoTreeGitUntracked = { fg = colors.neon_orange },
            NeoTreeGitConflict = { fg = colors.neon_red },
            NeoTreeGitRenamed = { fg = colors.neon_purple },
            NeoTreeGitIgnored = { fg = colors.fg3 },

            -- UI components
            -- NeoTreeIndentMarker = { fg = colors.neon_blue },
            -- NeoTreeExpander = { fg = colors.neon_blue },
            -- NeoTreeTabActive = { fg = colors.neon_pink, bg = colors.bg_highlight },
            -- NeoTreeTabInactive = { fg = colors.fg2 },

            -- NeoTreeBufferNumber = { fg = colors.neon_blue },
            -- NeoTreeDimText = { fg = colors.fg3 },
            -- NeoTreeDotfile = { fg = colors.fg3 },
            -- NeoTreeFadeText1 = { fg = colors.fg2 },
            -- NeoTreeFadeText2 = { fg = colors.fg3 },
            -- NeoTreeFileStats = { fg = colors.neon_cyan },
            -- NeoTreeFileStatsHeader = { fg = colors.neon_blue, style = "bold" },
            -- NeoTreeFilterTerm = { fg = colors.neon_green },

            -- NeoTreeHiddenByName = { fg = colors.fg3 },
            -- NeoTreeMessage = { fg = colors.neon_cyan },
            -- NeoTreeModified = { fg = colors.neon_yellow },
            -- NeoTreeSignColumn = { fg = colors.fg1, bg = colors.bg },

            -- NeoTreeTabSeparatorActive = { fg = colors.neon_pink, bg = colors.bg_highlight },
            -- NeoTreeTabSeparatorInactive = { fg = colors.border },

            -- NeoTreeVertSplit = { fg = colors.border },
            -- NeoTreeWinSeparator = { fg = colors.border },
            -- NeoTreeEndOfBuffer = { fg = colors.bg },
            -- NeoTreeSymbolicLinkTarget = { fg = colors.neon_cyan },

            -- NeoTreeWindowsHidden = { fg = colors.fg3 },
            -- NeoTreePreview = { bg = colors.bg_highlight },

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

            -- statusline
            -- StatusLine = { fg = "cyan", bg = "#1a1a1a" },
            -- LinePrimaryBlock = { fg = black, bg = background },
            -- LineSecondaryBlock = { fg = blue, bg = background },
            -- LineError = { link = "DiagnosticError" },
            -- LineHint = { link = "DiagnosticHint" },
            -- LineInfo = { link = "DiagnosticInfo" },
            -- LineWarning = { link = "DiagnosticWarn" },

            -- Which Key
            WhichKey = { fg = "#00ffff", style = "bold" },
            WhichKeyGroup = { fg = "#ff00ff" },
            WhichKeyDesc = { fg = "#39ff14" },
            WhichKeySeperator = { fg = "#666666" },
            WhichKeyFloat = { bg = "#0d0d0d" },
            WhichKeyValue = { fg = "#ff3366" },

            -- NeoTreeIndentMarker = { fg = "cyan" },
            -- NeoTreeRootName = { fg = "magenta", style = "bold" },
            -- NeoTreeFileName = { fg = "fg1" },
            -- NeoTreeFileIcon = { fg = "blue" },
            -- NeoTreeModified = { fg = "yellow" },
            -- NeoTreeGitAdded = { fg = "green" },
            -- NeoTreeGitModified = { fg = "yellow" },
            -- NeoTreeGitDeleted = { fg = "red" },

            -- Telescope colors
            -- TelescopeNormal = {},
            -- TelescopeBorder = { fg = "cyan" },
            -- TelescopePromptPrefix = { fg = "magenta" },
            -- TelescopeSelection = { fg = "fg1" },
            -- TelescopeMatching = { fg = "green", style = "bold" },
            -- TelescopeSelectionCaret = { fg = "magenta" },
            -- TelescopeMultiSelection = { fg = "cyan" },
            -- TelescopePromptTitle = { fg = "bg0", bg = "magenta", style = "bold" },
            -- TelescopeResultsTitle = { fg = "bg0", bg = "blue", style = "bold" },
            -- TelescopePreviewTitle = { fg = "bg0", bg = "green", style = "bold" },

            -- Telescope
            -- TelescopeBorder = { fg = border },
            -- TelescopeMatching = { fg = dark_yellow, bold = true },
            -- TelescopePromptNormal = { fg = "#000000" },
            -- TelescopePromptBorder = { fg = border },
            -- TelescopePromptPrefix = { fg = black, bold = true },
            -- TelescopeSelection = { bg = light_grey, bold = true },
            -- TelescopeTitle = { fg = black, bold = true },
            -- TelescopeNormal = { fg = "#000000" },

            -- Treesitter
            -- TSEmphasis = { italic = true },
            -- TSField = {},
            -- TSStringEscape = { fg = green, bold = true },
            -- TSStrong = { bold = true },
            -- TSURI = { fg = blue, underline = true },
            -- TSUnderline = { underline = true },
            -- TSConstMacro = { link = "Macro" },
            -- TSDanger = { link = "Todo" },
            -- TSKeywordOperator = { link = "Keyword" },
            -- TSNamespace = { link = "Constant" },
            -- TSNote = { link = "Todo" },
            -- TSProperty = { link = "TSField" },
            -- TSStringRegex = { link = "Regexp" },
            -- TSSymbol = { link = "Symbol" },
            -- TSTypeBuiltin = { link = "Keyword" },
            -- TSWarning = { link = "Todo" },
            -- ["@markup.link"] = { fg = blue },
            -- ["@property.json"] = { bold = true },
            -- ["@text.emphasis"] = { italic = true },
            -- ["@text.reference"] = { fg = purple },
            -- ["@text.strong"] = { bold = true },
            -- ["@text.uri"] = { fg = blue },
            -- ["@variable.builtin"] = { bold = true },

            CursorLine = { bg = "#1a1a1a" },
            TabLineSel = { bg = "magenta", fg = "bg0" },
            NormalFloat = { bg = "bg0" },
            Pmenu = { fg = "fg1", bg = "bg0" },

            -- Neogit
            -- NeogitBranch = { fg = green, bold = true },
            -- NeogitBranchHead = { link = 'NeogitBranch' },
            -- NeogitCommitViewHeader = { fg = dark_yellow, bold = true },
            -- NeogitCursorLine = { bg = highlight },
            -- NeogitDiffAdd = { link = 'DiffAdd' },
            -- NeogitDiffAddHighlight = { link = 'NeogitDiffAdd' },
            -- NeogitDiffContext = { link = 'Normal' },
            -- NeogitDiffContextHighlight = { link = 'Normal' },
            -- NeogitDiffDelete = { link = 'DiffDelete' },
            -- NeogitDiffDeleteHighlight = { link = 'NeogitDiffDelete' },
            -- NeogitDiffHeader = { fg = black, bold = true },
            -- NeogitDiffHeaderHighlight = { link = 'NeogitDiffHeader' },
            -- NeogitFilePath = { fg = purple },
            -- NeogitGraphBlue = { fg = blue },
            -- NeogitGraphBoldBlue = { fg = blue, bold = true },
            -- NeogitGraphBoldCyan = { fg = cyan, bold = true },
            -- NeogitGraphBoldGray = { fg = grey, bold = true },
            -- NeogitGraphBoldGreen = { fg = green, bold = true },
            -- NeogitGraphBoldOrange = { fg = orange, bold = true },
            -- NeogitGraphBoldPurple = { fg = purple, bold = true },
            -- NeogitGraphBoldRed = { fg = red, bold = true },
            -- NeogitGraphBoldWhite = { fg = black, bold = true },
            -- NeogitGraphBoldYellow = { fg = dark_yellow, bold = true },
            -- NeogitGraphCyan = { fg = cyan },
            -- NeogitGraphGray = { fg = grey },
            -- NeogitGraphGreen = { fg = green },
            -- NeogitGraphOrange = { fg = orange },
            -- NeogitGraphPurple = { fg = purple },
            -- NeogitGraphRed = { fg = red },
            -- NeogitGraphWhite = { fg = black },
            -- NeogitGraphYellow = { fg = dark_yellow },
            -- NeogitHunkHeader = { fg = blue },
            -- NeogitHunkHeaderHighlight = { link = 'NeogitHunkHeader' },
            -- NeogitPopupActionKey = { link = 'NeogitPopupOptionKey' },
            -- NeogitPopupBranchName = { link = 'NeogitBranch' },
            -- NeogitPopupConfigEnabled = { link = 'NeogitPopupOptionEnabled' },
            -- NeogitPopupConfigKey = { link = 'NeogitPopupOptionKey' },
            -- NeogitPopupOptionEnabled = { bg = light_green, bold = true },
            -- NeogitPopupOptionKey = { bold = true },
            -- NeogitPopupSectionTitle = { link = 'Title' },
            -- NeogitPopupSwitchEnabled = { link = 'NeogitPopupOptionEnabled' },
            -- NeogitPopupSwitchKey = { link = 'NeogitPopupOptionKey' },
            -- NeogitRemote = { link = 'NeogitBranch' },
            --
            -- g.terminal_color_0 = black
            -- g.terminal_color_1 = red
            -- g.terminal_color_2 = green
            -- g.terminal_color_3 = dark_yellow
            -- g.terminal_color_4 = blue
            -- g.terminal_color_5 = purple
            -- g.terminal_color_6 = cyan
            -- g.terminal_color_7 = grey

            -- g.terminal_color_8 = black
            -- g.terminal_color_9 = red
            -- g.terminal_color_10 = green
            -- g.terminal_color_11 = dark_yellow
            -- g.terminal_color_12 = blue
            -- g.terminal_color_13 = purple
            -- g.terminal_color_14 = cyan
            -- g.terminal_color_15 = grey
          },
        },
      },
    })
    -- vim.cmd("colorscheme nightfox")
    vim.cmd("colorscheme carbonfox")
  end,
}
