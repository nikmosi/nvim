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

-- Use an autocmd to set highlights after the colorscheme loads
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- You can link to existing theme highlights or define your own safely
    -- Using links is often safer and more consistent
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { link = "DiagnosticUnderlineError" })
    -- If you want specific overrides, do them here, but check if the colors exist first
    -- For now, we'll trust the theme's defaults or just link them to ensure consistency
    -- if the theme defines them (Tokyonight does).

    -- If you absolutely need custom colors, define them here using vim.api.nvim_get_hl
    -- or hardcoded hex if you don't want to depend on the theme module.
  end,
})

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
