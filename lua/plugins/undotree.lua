return {
  'mbbill/undotree',
  lazy = true,
  cmd = "UndotreeToggle",
  keys = { "<F5>" },
  opts = {},
  config =
      function()
        vim.keymap.set('n', '<F5>', vim.cmd.UndotreeToggle)
      end
}
