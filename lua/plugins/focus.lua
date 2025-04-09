return {
  "nvim-focus/focus.nvim",
  event = "VeryLazy",
  version = false,
  opts = {
    enable = true,
    commands = true,
    autoresize = {
      enable = false,
    },
    split = {
      bufnew = false,
      tmux = false,
    },
    ui = {
      number = false,
      relativenumber = false,
      hybridnumber = false,
      absolutenumber_unfocussed = false,

      cursorline = true,
      cursorcolumn = false,
      colorcolumn = {
        enable = false,
        list = "+1",
      },
      signcolumn = false,
      winhighlight = false,
    },
  },
}
