return {
  "nikmosi/dummy",
  event = "VeryLazy",
  keys = {
    {
      "<leader>c",
      "V\"+yy",
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
      "\"+y",
      mode = "v",
      desc = "Copy visual selection to clipboard",
    },
  },
}
