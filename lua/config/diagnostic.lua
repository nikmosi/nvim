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

-- Define DAP signs with JetBrains Mono Nerd icons
vim.fn.sign_define("DapBreakpoint", {
  text = "",
  texthl = "DapBreakpoint",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapBreakpointCondition", {
  text = "",
  texthl = "DapBreakpointCondition",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapLogPoint", {
  text = "󰎤",
  texthl = "DapLogPoint",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapStopped", {
  text = "",
  texthl = "DapStopped",
  linehl = "DapStoppedLine",
  numhl = "",
})

vim.fn.sign_define("DapBreakpointRejected", {
  text = "",
  texthl = "DapBreakpointRejected",
  linehl = "",
  numhl = "",
})

-- Define highlight groups (tuned to match tokyonight-night)
vim.api.nvim_set_hl(0, "DapBreakpoint", {
  fg = "#f7768e", -- pinkish red
  bg = "NONE",
  bold = true,
})

vim.api.nvim_set_hl(0, "DapBreakpointCondition", {
  fg = "#e0af68", -- warm yellow
  bg = "NONE",
  italic = true,
})

vim.api.nvim_set_hl(0, "DapLogPoint", {
  fg = "#7dcfff", -- bright cyan
  bg = "NONE",
})

vim.api.nvim_set_hl(0, "DapStopped", {
  fg = "#9ece6a", -- soft green
  bg = "#2c3043", -- slightly lighter bg for contrast
  bold = true,
})

vim.api.nvim_set_hl(0, "DapStoppedLine", {
  bg = "#2c3043", -- background highlight for stopped line
})

vim.api.nvim_set_hl(0, "DapBreakpointRejected", {
  fg = "#ff9e64", -- orange (invalid breakpoint)
  bg = "NONE",
  italic = true,
})
