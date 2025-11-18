return {
  "echasnovski/mini.icons",
  lazy = false,
  priority = 1000, -- гарантируем загрузку раньше других
  config = function()
    require("mini.icons").setup()
    MiniIcons.mock_nvim_web_devicons()
  end,
}
