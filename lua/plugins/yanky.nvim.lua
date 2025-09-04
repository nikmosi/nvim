return {
  "gbprod/yanky.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    ring = { history_length = 100 },
  },
  keys = {
    {
      "<leader>C",
      function() Snacks.picker.yanky() end,
      mode = { "n", "x" },
      desc = "Open Yank History",
    },
  },
}
