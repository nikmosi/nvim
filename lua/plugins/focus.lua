return {
  "nvim-focus/focus.nvim",
  version = false,
  config = function()
    require "focus".setup {
      enable = true,
      highlight = true,
      autoresize = { enable = false }
    }
  end
}
