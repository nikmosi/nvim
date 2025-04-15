local colors = require("tokyonight.colors").setup()

vim.diagnostic.config {
  virtual_text = true,
  float = { border = "rounded" },
  underline = true,
  update_in_insert = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅙",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "󰋼",
      [vim.diagnostic.severity.HINT] = "󰌵",
    },
  },
}

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
