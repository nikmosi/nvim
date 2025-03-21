return {
  "mbbill/undotree",
  lazy = true,
  event = "VeryLazy",
  keys = { { "<F5>", vim.cmd.UndotreeToggle, mode = "n", desc = "Open undotree" } },
  config = function() end,
}
