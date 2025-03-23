return {
  "mbbill/undotree",
  event = "BufRead",
  keys = { { "<F5>", vim.cmd.UndotreeToggle, mode = "n", desc = "Open undotree" } },
  config = function() end,
}
