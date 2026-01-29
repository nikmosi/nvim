return {
  "ph1losof/ecolog.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>ge", "<cmd>EcologPeek<cr>", desc = "Ecolog Peek" },
    { "<leader>gE", "<cmd>EcologGoto<cr>", desc = "Ecolog Goto" },
    { "<leader>gs", "<cmd>EcologSelect<cr>", desc = "Ecolog Select" },
  },
  opts = {
    integrations = {
      blink_cmp = true,
      nvim_lsp = true,
    },
    shelter = {
      enabled = true,
      modules = {
        snacks_previewer = true, -- Mask values in snacks previewer
        cmp = true, -- Mask in completion
        files = true,
      },
      configuration = {
        partial_mode = {
          show_start = 3, -- Show first 3 characters
          show_end = 3, -- Show last 3 characters
          min_mask = 3, -- Minimum masked characters
        },
        mask_char = "*", -- Character used for masking
        mask_length = nil, -- Optional: fixed length for masked portion (defaults to value length)
        skip_comments = false, -- Skip masking comment lines in environment files (default: false)
      },
      mask_char = "*",
    },
    interpolation = {
      enabled = true,
      features = {
        variables = true,
        defaults = true,
        alternates = true,
        commands = true,
        escapes = true,
      },
    },
    monorepo = {
      enabled = true,
      workspaces = true,
    },
  },
}
