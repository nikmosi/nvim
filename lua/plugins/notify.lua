return {
  "rcarriga/nvim-notify",
  config = function()
    require "notify".setup {
      top_down = false,
      stages = "fade_in_slide_out",
    }
    vim.notify = require "notify"
  end
}
