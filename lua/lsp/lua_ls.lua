return {
  settings = {
    Lua = {
      format = {
        enable = false, -- Enable Lua formatting
      },
      diagnostics = {
        globals = { "vim" }, -- Treat 'vim' as a global (for Neovim API)
      },
      workspace = {
        checkThirdParty = false, -- Disable third-party library checks
      },
    },
  },
}
