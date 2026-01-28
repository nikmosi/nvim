return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewRefresh",
    "DiffviewFileHistory",
  },
  keys = {
    { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
    { "<leader>gV", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview File History" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview Branch History" },
  },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    enhanced_diff_hl = true,
    use_icons = true, -- важный флаг для активации иконок
  },
}
