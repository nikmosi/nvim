return {
  "ph1losof/ecolog.nvim",
  keys = {
    { "<leader>ge", "<cmd>EcologPeek<cr>", desc = "Ecolog Peek" },
  },
  opts = {
    integrations = {
      blink_cmp = true,
    },
    shelter = {
      modules = {
        snacks_previewer = true, -- Mask values in snacks previewer
      },
    },
  },
}
