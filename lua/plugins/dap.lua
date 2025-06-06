return {
  {
    "mfussenegger/nvim-dap",
    dependencies = { "mfussenegger/nvim-dap-python" },
    keys = {

      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      {
        "<leader>dB",
        function() require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ") end,
        desc = "Breakpoint Condition",
      },
      { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      {
        "<leader>dg",
        function() require("dap").goto_(vim.fn.input "Line: ", false) end,
        desc = "Go to Line (No Execute)",
      },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },

      -- Normal mode: run test method
      { "<leader>dn", function() require("dap-python").test_method() end, mode = "n", desc = "Debug: test method" },

      -- Normal mode: run test class
      { "<leader>df", function() require("dap-python").test_class() end, mode = "n", desc = "Debug: test class" },

      -- Visual mode: debug selection
      {
        "<leader>ds",
        function()
          vim.cmd "normal! <Esc>" -- Ensure visual mode exits cleanly
          require("dap-python").debug_selection()
        end,
        mode = "v",
        desc = "Debug: selection",
      },
    },
    config = function()
      require("dap-python").setup "uv"
      require("dap-python").test_runner = "pytest"
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    keys = {
      { "<leader>de", function() require("dapui").eval() end, mode = { "n", "v" }, desc = "Eval" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Dap UI" },
    },
    opts = {},
  },
}
