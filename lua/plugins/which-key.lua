return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    delay = 500,
  },
  keys = {
    {
      "<leader>?",
      function() require("which-key").show { global = false } end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  spec = {
    { "<leader>c", group = "code" },
    { "<leader>f", group = "file" },
    { "<leader>g", group = "git" },
    { "<leader>h", group = "gitsigns" },
    { "<leader>l", group = "lsp" },
    { "<leader>r", group = "refactor" },
    { "<leader>s", group = "search" },
    { "<leader>u", group = "ui" },
    { "<leader>t", group = "toggle/test" },
    { "<leader>x", group = "trouble" },
    { "<leader>y", group = "yank" },
  },
}
