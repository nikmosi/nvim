return {
  "sindrets/diffview.nvim",
  event = "BufRead",
  config = function()
    require("mini.icons").setup()
    MiniIcons.mock_nvim_web_devicons()
  end,
}
