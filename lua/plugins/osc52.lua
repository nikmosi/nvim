return {
  "ojroques/nvim-osc52",
  event = "VeryLazy",
  opt = { max_length = 0, trim = false, silent = true },
  keys = {
    {
      "<leader>c",
      function()
        vim.cmd "norm V"
        require("osc52").copy_visual()
      end,
      mode = "n",
      desc = "Copy operator to clipboard",
    },
    {
      "<leader>v",
      "\"+p",
      mode = "n",
      desc = "paste operator to clipboard",
    },
    {
      "<leader>p",
      "\"_dP",
      mode = "x",
      desc = "Delete to void",
    },
    {
      "<leader>c",
      function() require("osc52").copy_visual() end,
      mode = "v",
      desc = "Copy visual selection to clipboard",
    },
  },
}
