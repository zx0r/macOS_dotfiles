return {
  {
    "mg979/vim-visual-multi",
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      options = { "buffers", "curdir", "tabpages", "winsize", "help", "blank", "terminal", "folds", "tabpages" },
    },
    keys = {
      {
        "<leader>ss",
        function()
          require("persistence").load()
        end,
        desc = "Restore Session",
      },
      {
        "<leader>sl",
        function()
          require("persistence").load({ last = true })
        end,
        desc = "Restore Last Session",
      },
      {
        "<leader>sd",
        function()
          require("persistence").stop()
        end,
        desc = "Don't Save Current Session",
      },
    },
  },

  {
    "HakonHarnes/img-clip.nvim",
    event = "BufEnter",
    opts = {
      -- add options here
      -- or leave it empty to use the default settings
    },
    keys = {
      -- suggested keymap
      { "<leader>mp", "<cmd>PasteImage<cr>", desc = "Paste clipboard image" },
    },
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    keys = {
      {
        "<leader>mP",
        function()
          vim.cmd([[MarkdownPreviewToggle]])
        end,
        desc = "Peek (Markdown Preview)",
      },
    },
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_theme = "light"
    end,
    ft = { "markdown" },
  },

  {
    "MeanderingProgrammer/markdown.nvim",
    ft = { "markdown" },
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    config = function()
      require("render-markdown").setup({})
    end,
  },

  {
    "danymat/neogen",
    config = true,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
    opts = {
      snippet_engine = "luasnip",
    },
    keys = {
      {
        "<leader>hnf",
        "<cmd>lua require('neogen').generate({ type = 'func' })<CR>",
        desc = "Generate annotation for current function",
      },
      {
        "<leader>hnc",
        "<cmd>lua require('neogen').generate({ type = 'class' })<CR>",
        desc = "Generate annotation for current class",
      },
      {
        "<leader>hnt",
        "<cmd>lua require('neogen').generate({ type = 'type' })<CR>",
        desc = "Generate annotation for current type",
      },
      {
        "<leader>hnF",
        "<cmd>lua require('neogen').generate({ type = 'file' })<CR>",
        desc = "Generate annotation for current file",
      },
    },
  },
}
