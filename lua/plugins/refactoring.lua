return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  lazy = true,
  event = "VeryLazy",
  opts = {},
  keys = {
    { "<leader>r", "", desc = "+refactor", mode = { "n", "v" } },
    {
      "<leader>rs",
      function() require("refactoring").select_refactor() end,
      mode = "v",
      desc = "Refactor",
    },
    {
      "<leader>ri",
      function() require("refactoring").refactor "Inline Variable" end,
      mode = { "n", "v" },
      desc = "Inline Variable",
    },
    {
      "<leader>rb",
      function() require("refactoring").refactor "Extract Block" end,
      desc = "Extract Block",
    },
    {
      "<leader>rf",
      function() require("refactoring").refactor "Extract Block To File" end,
      desc = "Extract Block To File",
    },
    {
      "<leader>rP",
      function() require("refactoring").debug.printf { below = false } end,
      desc = "Debug Print",
    },
    {
      "<leader>rp",
      function() require("refactoring").debug.print_var { normal = true } end,
      desc = "Debug Print Var",
    },
    {
      "<leader>rc",
      function() require("refactoring").debug.cleanup {} end,
      desc = "Debug Cleanup",
    },
  },
}
