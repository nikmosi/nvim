return {
  "echasnovski/mini.splitjoin",
  version = "*",
  keys = {
    { "gS", mode = { "n", "x" }, desc = "Toggle split/join" },
    { "<leader>gsp", mode = { "n", "x" }, desc = "Split" },
    { "<leader>gsj", mode = { "n", "x" }, desc = "Join" },
  },
  opts = {
    mappings = {
      toggle = "gS",
      split = "<leader>gsp",
      join = "<leader>gsj",
    },
  },
}
