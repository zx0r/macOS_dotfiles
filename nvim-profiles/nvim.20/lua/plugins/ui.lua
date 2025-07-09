return {
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.debug = false

      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })

      table.insert(opts.routes, 1, {
        filter = {
          ["not"] = {
            event = "lsp",
            kind = "progress",
          },
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })
    end,
  },

  -- auto-resize windows
  -- {
  --   "anuvyklack/windows.nvim",
  --   enabled = false,
  --   event = "WinNew",
  --   dependencies = {
  --     { "anuvyklack/middleclass" },
  --     { "anuvyklack/animation.nvim", enabled = false },
  --   },
  --   keys = { { "<leader>m", "<cmd>WindowsMaximize<cr>", desc = "Zoom" } },
  --   config = function()
  --     vim.o.winwidth = 5
  --     vim.o.equalalways = false
  --     require("windows").setup({
  --       animation = { enable = false, duration = 150 },
  --     })
  --   end,
  -- },

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          return require("util.dashboard").status()
        end,
      })

      ---@type table<string, {updated:number, total:number, enabled: boolean, status:string[]}>
      local mutagen = {}

      local function mutagen_status()
        local cwd = vim.uv.cwd() or "."
        mutagen[cwd] = mutagen[cwd]
          or {
            updated = 0,
            total = 0,
            enabled = vim.fs.find("mutagen.yml", { path = cwd, upward = true })[1] ~= nil,
            status = {},
          }
        local now = vim.uv.now() -- timestamp in milliseconds
        if mutagen[cwd].enabled and (mutagen[cwd].updated + 10000 < now) then
          ---@type {name:string, status:string, idle:boolean}[]
          local sessions = {}
          local lines = vim.fn.systemlist("mutagen project list")
          local status = {}
          local name = nil
          for _, line in ipairs(lines) do
            local n = line:match("^Name: (.*)")
            if n then
              name = n
            end
            local s = line:match("^Status: (.*)")
            if s then
              table.insert(sessions, {
                name = name,
                status = s,
                idle = s == "Watching for changes",
              })
            end
          end
          for _, session in ipairs(sessions) do
            if not session.idle then
              table.insert(status, session.name .. ": " .. session.status)
            end
          end
          mutagen[cwd].updated = now
          mutagen[cwd].total = #sessions
          mutagen[cwd].status = status
          if #sessions == 0 then
            vim.notify("Mutagen is not running", vim.log.levels.ERROR, { title = "Mutagen" })
          end
        end
        return mutagen[cwd]
      end

      local error_color = LazyVim.ui.fg("DiagnosticError")
      local ok_color = LazyVim.ui.fg("DiagnosticInfo")
      table.insert(opts.sections.lualine_x, {
        cond = function()
          return mutagen_status().enabled
        end,
        color = function()
          return (mutagen_status().total == 0 or mutagen_status().status[1]) and error_color or ok_color
        end,
        function()
          local s = mutagen_status()
          local msg = s.total
          if #s.status > 0 then
            msg = msg .. " | " .. table.concat(s.status, " | ")
          end
          return (s.total == 0 and "󰋘 " or "󰋙 ") .. msg
        end,
      })

      -- local keys = {}
      -- local in_mapping = false
      --
      -- vim.api.nvim_create_autocmd("SafeState", {
      --   callback = function()
      --     in_mapping = false
      --   end,
      -- })
      --
      -- vim.on_key(function(_, key)
      --   if not key then
      --     return
      --   end
      --   -- local unsafe = not vim.fn.state():find("S")
      --   local m = vim.fn.state():find("[moS]")
      --   -- if in_mapping and not m then
      --   --   in_mapping = false
      --   --   return
      --   -- end
      --   if m and not in_mapping then
      --     in_mapping = true
      --     keys = {}
      --   end
      --   if in_mapping then
      --     table.insert(keys, key)
      --     require("lualine").refresh()
      --     vim.cmd.redraw()
      --   end
      -- end)
      --
      -- table.insert(opts.sections.lualine_x, {
      --   function()
      --     return table.concat(keys, "")
      --   end,
      -- })

      -- local count = 0
      -- table.insert(opts.sections.lualine_x, {
      --   function()
      --     count = count + 1
      --     return tostring(count)
      --   end,
      -- })
    end,
  },

  "folke/twilight.nvim",
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },
}
