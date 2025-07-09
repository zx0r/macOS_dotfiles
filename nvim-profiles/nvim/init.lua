if vim.env.VSCODE then
  vim.g.vscode = false
end

-- vim.loader = false
if vim.loader then
  vim.loader.enable()
end

_G.dd = function(...)
  require("util.debug").dump(...)
end
_G.bt = function(...)
  require("util.debug").bt(...)
end
vim.print = _G.dd

-- require("util.profiler").startup()

-- require("util.dashboard").setup()

pcall(require, "config.env")

require("config.lazy")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("util").version()
  end,
})
