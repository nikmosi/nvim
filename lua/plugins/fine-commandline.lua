return {
  "VonHeikemen/fine-cmdline.nvim",
  keys = {
    {
      ":",
      function() require("fine-cmdline").open { default_value = "" } end,
      mode = "n",
      desc = "call fine cmd line",
      noremap = true,
    },
  },
  dependencies = {
    { "MunifTanjim/nui.nvim" },
  },
}
