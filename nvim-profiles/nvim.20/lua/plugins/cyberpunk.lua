-- ~/.config/nvim/lua/cyberpunk.lua
local M = {}

function M.setup()
  local Color = require("nightfox.lib.color")
  local palette = {
    cyberpunk = {
      -- Base Cyberpunk colors
      black = "#000000",
      red = "#ff357f",
      green = "#3eff9e",
      yellow = "#ffd300",
      blue = "#00b4ff",
      magenta = "#ff2f92",
      cyan = "#00ffff",
      white = "#ffffff",
      orange = "#ff8000",
      pink = "#ff007c",

      -- Custom Cyberpunk accents
      neon_blue = "#00f3ff",
      matrix_green = "#00ff00",
      hot_pink = "#ff0090",
      purple = "#b300ff",

      -- Backgrounds
      bg0 = "#0a0a12",
      bg1 = "#151521",
      bg2 = "#202030",
      bg3 = "#2a2a3f",
      bg4 = "#35354e",

      -- Foregrounds
      fg0 = "#ffffff",
      fg1 = "#e0e0ff",
      fg2 = "#c0c0ff",
      fg3 = "#a0a0ff",

      -- Special
      sel0 = "#3d3d5c",
      sel1 = "#4a4a6f",
      comment = "#696969",
    },
  }

  local specs = {
    cyberpunk = {
      syntax = {
        keyword = "hot_pink",
        -- function = "neon_blue",
        type = "purple",
        string = "matrix_green",
        number = "yellow",
        constant = "orange",
        operator = "magenta",
        punctuation = "fg1",
      },
      git = {
        add = "matrix_green",
        changed = "yellow",
        removed = "red",
      },
      diagnostic = {
        error = "red",
        warn = "yellow",
        info = "neon_blue",
        hint = "matrix_green",
      },
    },
  }

  local groups = {
    cyberpunk = {
      -- Base UI
      Normal = { bg = "bg0", fg = "fg0" },
      CursorLine = { bg = "bg1" },

      -- Tabby.nvim
      TabLine = { bg = "bg2", fg = "fg3" },
      TabLineSel = { bg = "hot_pink", fg = "black", style = "bold" },
      TabLineFill = { bg = "bg0" },

      -- Feline.nvim
      StatusLine = { bg = "bg1", fg = "fg1" },
      StatusLineNC = { bg = "bg0", fg = "fg3" },

      -- LSP and Diagnostics
      LspDiagnosticsError = { fg = "red" },
      LspDiagnosticsWarning = { fg = "yellow" },
      LspDiagnosticsInformation = { fg = "neon_blue" },
      LspDiagnosticsHint = { fg = "matrix_green" },

      -- Cyberpunk-specific enhancements
      CyberGlow = { fg = "neon_blue", bg = "bg1", style = "bold,underline" },
      CyberPulse = { fg = "hot_pink", style = "italic" },
    },
  }

  require("nightfox").setup({
    options = {
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = "italic",
        keywords = "bold",
        functions = "bold",
      },
      modules = {
        cmp = true,
        telescope = true,
        gitsigns = true,
        nvimtree = true,
        whichkey = true,
        indentline = true,
      },
    },
    palettes = palette,
    specs = specs,
    groups = groups,
  })

  vim.cmd("colorscheme nightfox")
end

return M
