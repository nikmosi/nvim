return {
  "tzachar/highlight-undo.nvim",
  event = "VeryLazy",
  config = function()
    require("highlight-undo").setup {
      -- your configuration here
      -- e.g. delay, duration, theme
    }
  end,
}
