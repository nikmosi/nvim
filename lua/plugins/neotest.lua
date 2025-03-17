vim.api.nvim_set_keymap("n", "<leader>tn", ':lua require("neotest").run.run()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tf", ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>',
  { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ts", ':lua require("neotest").summary.toggle()<CR>',
  { noremap = true, silent = true })

return {
  "nvim-neotest/neotest",
  event = "VeryLazy",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
  },
  config = function()
    require "neotest".setup {
      adapters = {
        require "neotest-python" {
          args = { "--verbose" },
          runner = "pytest",
        },
      },
    }
  end
}
