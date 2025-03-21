vim.diagnostic.config {
  signs = true,
  virtual_text = true, -- Отключить текст диагностики в самом коде
  float = { border = "rounded" }, -- Окно всплывающей подсказки с границей
  underline = true,
  update_in_insert = false,
}

-- Настройка знаков диагностики
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
