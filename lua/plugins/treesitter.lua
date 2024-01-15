require'nvim-treesitter.configs'.setup {
  ensure_installed = { "python", "lua", "go" },

  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
}
