return {
  settings = {
    Lua = {
      format = {
        enable = false,
      },
      diagnostics = {
        globals = { "vim", "awesome", "client", "screen", "root" },
      },
      workspace = {
        checkThirdParty = true,
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          -- [vim.env.AWESOME_LUA_LIB] = true,
        },
      },
      telemetry = { enable = false },
    },
  },
}
