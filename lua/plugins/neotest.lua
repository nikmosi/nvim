return {
  "nvim-neotest/neotest",
  ft = { "python" },
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
  },
  keys = {
    { "<leader>tn", function() require("neotest").run.run() end, desc = "Run tests" },
    {
      "<leader>tf",
      function() require("neotest").run.run(vim.fn.expand "%") end,
      desc = "Run tests for current file",
    },
    { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
  },
  config = function()
    require("neotest").setup {
      adapters = {
        require "neotest-python" {
          args = { "--verbose" },
          runner = "pytest",
        },
      },
    }
  end,
}
