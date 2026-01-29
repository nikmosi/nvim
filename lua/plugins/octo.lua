return {
  "pwntester/octo.nvim",
  cmd = "Octo",
  event = { { event = "BufReadCmd", pattern = "octo://*" } },
  opts = {
    enable_builtin_local_commands = true,
    default_to_projects_v2 = true,
    default_merge_method = "squash",
    picker = "snacks", -- since you are using snacks.nvim
  },
  keys = {
    { "<leader>gi", "<cmd>Octo issue list<cr>", desc = "List Issues (Octo)" },
    { "<leader>gP", "<cmd>Octo pr list<cr>", desc = "List PRs (Octo)" },
    { "<leader>gm", "<cmd>Octo pr search is:pr author:@me is:open<cr>", desc = "My PRs (Octo)" },
  },
}
