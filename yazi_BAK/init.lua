local cyberpunk_palette = {
  rosewater = "#ff00ff", -- Neon Pink
  flamingo = "#ff00cc", -- Neon Magenta
  pink = "#ff00aa", -- Neon Pink (darker)
  mauve = "#cc00ff", -- Neon Violet
  red = "#ff0055", -- Neon Red
  maroon = "#ff0066", -- Neon Red (brighter)
  peach = "#ff6600", -- Neon Orange
  yellow = "#ffff00", -- Neon Yellow
  green = "#00ff00", -- Neon Green
  teal = "#00ffcc", -- Neon Teal
  sky = "#00ccff", -- Neon Cyan
  sapphire = "#00aaff", -- Neon Blue (darker)
  blue = "#00ffff", -- Neon Blue
  lavender = "#cc00cc", -- Neon Purple
  text = "#ffffff", -- White text
  subtext1 = "#cccccc", -- Light gray subtext
  subtext0 = "#999999", -- Gray subtext
  overlay2 = "#666666", -- Dark gray overlay
  overlay1 = "#444444", -- Darker gray overlay
  overlay0 = "#222222", -- Very dark gray overlay
  surface2 = "#111111", -- Dark surface
  surface1 = "#0a0a0a", -- Darker surface
  surface0 = "#050505", -- Very dark surface
  base = "#000000", -- Black base
  mantle = "#020202", -- Slightly lighter black
  crust = "#010101", -- Almost black
}

-- Plugins
require("autosort"):setup()
require("autofilter"):setup()
require("git"):setup()
require("mime-preview"):setup()
require("full-border"):setup()
require("starship"):setup({ config_file = "$HOME/.config/starship/starship.toml" })
require("relative-motions"):setup({ show_numbers = "none", show_motion = true })

require("copy-file-contents"):setup({
  clipboard_cmd = "default",
  append_char = "\n",
  notification = true,
})

require("custom-shell"):setup({
  save_history = true,
  history_file = "default",
})

require("current-size"):setup({
  folder_size_ignore = { "~", "/", "/home" },
})

require("zoxide"):setup({
  update_db = true,
})

require("session"):setup({
  sync_yanked = true,
})

require("fg"):setup({
  default_action = "menu", -- nvim, jump
})

require("status-owner"):setup({
  color = "#d98a8a",
})

require("status-mtime"):setup({
  color = "#ba884a",
})

require("header-hidden"):setup({
  color = "#88c2f4",
})

require("header-host"):setup({
  color = "#8bca4b",
})

require("easyjump"):setup({
  icon_fg = "#fda1a1",
  first_key_fg = "#df6249",
})

require("keyjump"):setup({
  icon_fg = "#fda1a1",
  first_key_fg = "#df6249",
  go_table = { -- `g` to open go menu(only global mode)
    { on = { "w" }, run = "cd ~/文档/WeChat_Data/home", desc = "Go to weixin" },
    { on = { "n" }, run = "cd ~/_install", desc = "Go to _install" },
    { on = { "h" }, run = "cd ~", desc = "Go to home" },
    { on = { "c" }, run = "cd ~/.config", desc = "Go to config" },
    { on = { "u" }, run = "cd /media/UUI/", desc = "Go to Mobile disk" },
    { on = { "d" }, run = "cd ~/down", desc = "Go to downloads" },
    { on = { "t" }, run = "cd ~/tool/", desc = "Go to tool" },
    { on = { "o" }, run = "cd ~/video", desc = "Go to video" },
    { on = { "y" }, run = "cd ~/.config/yazi/", desc = "Go to video" },
    { on = { "i" }, run = "cd ~/Images", desc = "Go to image" },
    { on = { "r" }, run = "cd /", desc = "Go to /" },
    { on = { "j" }, run = "cd /home/wrq/deskenv/dev", desc = "Go to dev" },
    { on = { "k" }, run = "cd /home/wrq/deskenv/master", desc = "Go to master" },
  },
})

require("searchjump"):setup({
  unmatch_fg = cyberpunk_palette.overlay0,
  match_str_fg = cyberpunk_palette.peach,
  match_str_bg = cyberpunk_palette.base,
  first_match_str_fg = cyberpunk_palette.lavender,
  first_match_str_bg = cyberpunk_palette.base,
  lable_fg = cyberpunk_palette.green,
  lable_bg = cyberpunk_palette.base,
  only_current = false, -- only search the current window
  show_search_in_statusbar = false,
  auto_exit_when_unmatch = false,
  enable_capital_lable = false,
  search_patterns = { "hell[dk]d", "%d+.1080p", "第%d+集", "第%d+话", "%.E%d+", "S%d+E%d+" },
})

require("mactag"):setup({
  -- Keys used to add or remove tags
  keys = {
    r = "Red",
    o = "Orange",
    y = "Yellow",
    g = "Green",
    b = "Blue",
    p = "Purple",
  },
  -- Colors used to display tags
  colors = {
    Red = "#ee7b70",
    Orange = "#f5bd5c",
    Yellow = "#fbe764",
    Green = "#91fc87",
    Blue = "#5fa3f8",
    Purple = "#cb88f8",
  },
})

require("mime-ext"):setup({
  -- Expand the existing filename database (lowercase), for example:
  -- with_files = {
  -- 	makefile = "text/makefile",
  -- 	-- ...
  -- },

  -- Expand the existing extension database (lowercase), for example:
  with_exts = require("mime-preview"):get_mime_data(),

  -- If the mime-type is not in both filename and extension databases,
  -- then fallback to Yazi's preset `mime` plugin, which uses `file(1)`
  fallback_file1 = true,
})

require("yatline"):setup({
  section_separator = { open = "", close = "" },
  inverse_separator = { open = "", close = "" },
  part_separator = { open = "", close = "" },

  style_a = {
    fg = cyberpunk_palette.mantle,
    bg_mode = {
      normal = cyberpunk_palette.blue,
      select = cyberpunk_palette.mauve,
      un_set = cyberpunk_palette.red,
    },
  },
  style_b = { bg = cyberpunk_palette.surface0, fg = cyberpunk_palette.text },
  style_c = { bg = cyberpunk_palette.base, fg = cyberpunk_palette.text },

  permissions_t_fg = cyberpunk_palette.green,
  permissions_r_fg = cyberpunk_palette.yellow,
  permissions_w_fg = cyberpunk_palette.red,
  permissions_x_fg = cyberpunk_palette.sky,
  permissions_s_fg = cyberpunk_palette.lavender,

  selected = { icon = "󰻭 ", fg = cyberpunk_palette.yellow },
  copied = { icon = " ", fg = cyberpunk_palette.green },
  cut = { icon = " ", fg = cyberpunk_palette.red },

  total = { icon = "", fg = cyberpunk_palette.yellow },
  succ = { icon = "", fg = cyberpunk_palette.green },
  fail = { icon = "", fg = cyberpunk_palette.red },
  found = { icon = " ", fg = cyberpunk_palette.blue },
  processed = { icon = " ", fg = cyberpunk_palette.green },

  tab_width = 20,
  tab_use_inverse = true,

  show_background = false,

  display_header_line = true,
  display_status_line = true,

  header_line = {
    left = {
      section_a = {
        { type = "line", custom = false, name = "tabs", params = { "left" } },
      },
      section_b = {
        { type = "coloreds", custom = false, name = "githead" },
      },
      section_c = {},
    },
    right = {
      section_a = {
        { type = "string", custom = false, name = "tab_path" },
      },
      section_b = {
        { type = "coloreds", custom = false, name = "task_workload" },
      },
      section_c = {
        { type = "coloreds", custom = false, name = "task_states" },
      },
    },
  },

  status_line = {
    left = {
      section_a = {
        { type = "string", custom = false, name = "tab_mode" },
      },
      section_b = {
        { type = "string", custom = false, name = "hovered_size" },
      },
      section_c = {
        { type = "string", custom = false, name = "hovered_name" },
        { type = "coloreds", custom = false, name = "count" },
      },
    },
    right = {
      section_a = {
        { type = "string", custom = false, name = "cursor_position" },
      },
      section_b = {
        { type = "string", custom = false, name = "cursor_percentage" },
      },
      section_c = {
        { type = "string", custom = false, name = "hovered_file_extension", params = { true } },
        { type = "coloreds", custom = false, name = "permissions" },
      },
    },
  },
})

require("yatline-githead"):setup({
  show_branch = true,
  branch_prefix = "",
  branch_symbol = " ",
  branch_borders = "",

  commit_symbol = " ",

  show_behind_ahead = true,
  behind_symbol = " ",
  ahead_symbol = " ",

  show_stashes = true,
  stashes_symbol = " ",

  show_state = true,
  show_state_prefix = true,
  state_symbol = "󱅉 ",

  show_staged = true,
  staged_symbol = " ",

  show_unstaged = true,
  unstaged_symbol = " ",

  show_untracked = true,
  untracked_symbol = " ",

  prefix_color = cyberpunk_palette.pink,
  branch_color = cyberpunk_palette.pink,
  commit_color = cyberpunk_palette.mauve,
  stashes_color = cyberpunk_palette.teal,
  state_color = cyberpunk_palette.lavender,
  staged_color = cyberpunk_palette.green,
  unstaged_color = cyberpunk_palette.yellow,
  untracked_color = cyberpunk_palette.pink,
  ahead_color = cyberpunk_palette.green,
  behind_color = cyberpunk_palette.yellow,
})

-- You can abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZnfigure your bookmarks by lua language
local bookmarks = {}
require("yamb"):setup({
  -- Optional, the path ending with path seperator represents folder.
  bookmarks = bookmarks,
  jump_notify = false,
  -- Optional, the cli of fzf.
  cli = "fzf",
  -- Optional, a string used for randomly generating keys, where the preceding characters have higher priority.
  -- keys = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
  -- Optional, the path of bookmarks
  -- path = "$HOME/dotfiles/yazi/.config/yazi/plugins/yamb.yazi/bookmarks",
})

-- Status:name - Display the name of the hovered file, with a link if it exists
-- function Status:name()
--   local h = self._tab.current.hovered
--   if not h then
--     return ui.Line({})
--   end

--   local linked = h.link_to and (" -> " .. tostring(h.link_to)) or ""
--   return ui.Line(" " .. h.name .. linked)
-- end

-- -- Header:host - Display the username and hostname in the header
-- function Header:host()
--   if ya.target_family() ~= "unix" then
--     return ui.Line({})
--   end
--   return ui.Span(ya.user_name() .. "@yazi: "):fg("blue")
-- end

-- -- Add the host header to the left side of the header
-- Header:children_add(Header.host, 500, Header.LEFT)

-- -- Status:owner - Display the owner and group of the hovered file
-- function Status:owner()
--   local h = cx.active.current.hovered
--   if not h or ya.target_family() ~= "unix" then
--     return ui.Line({})
--   end

--   local uid = ya.user_name(h.cha.uid) or tostring(h.cha.uid)
--   local gid = ya.group_name(h.cha.gid) or tostring(h.cha.gid)

--   return ui.Line({
--     ui.Span(uid):fg("magenta"),
--     ui.Span(":"),
--     ui.Span(gid):fg("magenta"),
--     ui.Span(" "),
--   })
-- end

-- Add the owner status to the right side of the status bar
Status:children_add(Status.owner, 500, Status.RIGHT)

-- [Show username and hostname in header](https://yazi-rs.github.io/docs/tips/#username-hostname-in-header)
Header:children_add(function()
  if ya.target_family() ~= "unix" then
    return ui.Line({})
  end
  return ui.Span("[" .. ya.user_name() .. "@" .. ya.host_name() .. "]"):fg("green")
end, 500, Header.LEFT)

-- [Show symlink in status bar](https://yazi-rs.github.io/docs/tips/#symlink-in-status)
function Status:name()
  local h = self._tab.current.hovered
  if not h then
    return ui.Line({})
  end

  local linked = ""
  if h.link_to ~= nil then
    linked = " -> " .. tostring(h.link_to)
  end
  return ui.Line(" " .. h.name .. linked)
end
