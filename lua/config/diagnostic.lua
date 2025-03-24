local colors = require("tokyonight.colors").setup()

vim.diagnostic.config {
  signs = true,
  virtual_text = true, -- Отключить текст диагностики в самом коде
  float = { border = "rounded" }, -- Окно всплывающей подсказки с границей
  underline = true,
  update_in_insert = false,
}

local symbols = { Error = "󰅙", Info = "󰋼", Hint = "󰌵", Warn = "" }

for name, icon in pairs(symbols) do
  local hl = "DiagnosticSign" .. name
  vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

-- Настройка highlight групп для разных типов диагностики
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = colors.red })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline = true, sp = colors.orange })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underline = true, sp = colors.blue })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underline = true, sp = colors.green })

-- Настройка цветов для значков (signs)
vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = colors.red })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = colors.orange })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = colors.blue })
vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = colors.green })

-- Настройка цветов для всплывающих окон
vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { fg = colors.red })
vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { fg = colors.orange })
vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { fg = colors.blue })
vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { fg = colors.green })
