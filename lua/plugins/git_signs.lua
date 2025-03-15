return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require "gitsigns".setup {
      signcolumn = true, -- Убираем знаки слева
      numhl = false,     -- Включаем подсветку номеров строк
    }
  end
}
