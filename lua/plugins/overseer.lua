return {
  "stevearc/overseer.nvim",
  cmd = { "OverseerRun", "OverseerToggle", "OverseerInfo" },
  keys = {
    { "<leader>or", vim.cmd.OverseerRun, desc = "Run task" },
    { "<leader>ot", vim.cmd.OverseerToggle, desc = "Toggle task list" },
    { "<leader>oi", vim.cmd.OverseerInfo, desc = "Task info" },
    { "<leader>ol", vim.cmd.OverseerLoadBundle, desc = "Load task bundle" },
    { "<leader>os", vim.cmd.OverseerSaveBundle, desc = "Save task bundle" },
    { "<leader>oc", vim.cmd.OverseerClearCache, desc = "Clear task cache" },
  },
  opts = {},
}
