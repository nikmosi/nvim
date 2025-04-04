return {
  "nvim-focus/focus.nvim",
  event = "VeryLazy",
  version = false,
  opts = {
    enable = true, -- Enable module
    commands = true, -- Create Focus commands
    autoresize = {
      enable = false, -- Enable or disable auto-resizing of splits
    },
    split = {
      bufnew = false, -- Create blank buffer for new split windows
      tmux = false, -- Create tmux splits instead of neovim splits
    },
    ui = {
      number = false, -- Display line numbers in the focussed window only
      relativenumber = false, -- Display relative line numbers in the focussed window only
      hybridnumber = false, -- Display hybrid line numbers in the focussed window only
      absolutenumber_unfocussed = false, -- Preserve absolute numbers in the unfocussed windows

      cursorline = true, -- Display a cursorline in the focussed window only
      cursorcolumn = false, -- Display cursorcolumn in the focussed window only
      colorcolumn = {
        enable = false, -- Display colorcolumn in the foccused window only
        list = "+1", -- Set the comma-saperated list for the colorcolumn
      },
      signcolumn = false, -- Display signcolumn in the focussed window only
      winhighlight = false, -- Auto highlighting for focussed/unfocussed windows
    },
  },
}
